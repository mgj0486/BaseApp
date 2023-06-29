//
//  TempViewModel.swift
//  BaseApp
//
//  Created by dev team on 2023/03/28.
//

import Foundation
import Combine
import Core

final class TempViewModel: ObservableObject {
    @Published private(set) var state = State.idle
    private var bag = Set<AnyCancellable>()
    private let input = PassthroughSubject<Event, Never>()
    
    init() {
        Publishers.system(
            initial: state,
            reduce: Self.reduce,
            scheduler: RunLoop.main,
            feedbacks: [
                Self.whenLoading(),
                Self.userInput(input: input.eraseToAnyPublisher())
            ]
        )
        .assign(to: \.state, on: self)
        .store(in: &bag)
    }
    
    deinit {
        bag.removeAll()
    }
    
    func send(event: Event) {
        input.send(event)
    }
}

extension TempViewModel {
    static func reduce(_ state: State, _ event: Event) -> State {
        switch state {
        case .idle:
            switch event {
            case .onAppear:
                return .loading
            default:
                return state
            }
        case .loading:
            switch event {
            case .onFailedToLoadDatas(let error):
                return .error(error)
            case .onDatasLoaded(let diarys):
                return .loaded(diarys)
            default:
                return state
            }
        case .loaded:
            switch event {
            case .dataReload:
                return .loading
            default:
                return state
            }
        case .error:
            return state
        }
    }
    
    static func userInput(input: AnyPublisher<Event, Never>) -> Feedback<State, Event> {
        Feedback { _ in input }
    }
    
    static func whenLoading() -> Feedback<State, Event> {
        Feedback { (state: State) -> AnyPublisher<Event, Never> in
            guard case .loading = state else { return Empty().eraseToAnyPublisher() }
            //MARK: Load(Coredata, API, etc...)
            return CoreDataFetchResultsPublisher(request: BaseData.fetchRequest(), context: PersistenceManager.shared.getContainer().viewContext)
                .map { $0.map(ListItem.init) }
                .map(Event.onDatasLoaded)
                .catch { Just(Event.onFailedToLoadDatas($0)) }
                .eraseToAnyPublisher()
        }
    }
}

extension TempViewModel {
    enum State {
        case idle
        case loading
        case loaded([ListItem])
        case error(Error)
    }

    enum Event {
        case onAppear
        case dataReload
        case onDatasLoaded([ListItem])
        case onFailedToLoadDatas(Error)
    }
}

extension TempViewModel {
    public struct ListItem: Identifiable, Hashable {
        let id = UUID()
        let tempString: String?
        
        public init(data: BaseData) {
            tempString = data.tempString
        }
        
        public init() {
            tempString = ""
        }
    }
}
