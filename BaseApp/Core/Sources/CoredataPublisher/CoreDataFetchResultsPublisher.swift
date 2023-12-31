//
//  CoreDataFetchResultsPublisher.swift
//  AnnualDiary
//
//  Created by dev team on 2023/03/28.
//
import Combine
import CoreData

public struct CoreDataFetchResultsPublisher<Entity>: Publisher where Entity: NSManagedObject {
    public typealias Output = [Entity]
    public typealias Failure = NSError
    
    private let request: NSFetchRequest<Entity>
    private let context: NSManagedObjectContext
    
    public init(request: NSFetchRequest<Entity>, context: NSManagedObjectContext) {
        self.request = request
        self.context = context
    }
    
    public func receive<S>(subscriber: S) where S : Subscriber, Self.Failure == S.Failure, Self.Output == S.Input {
        let subscription = Subscription(subscriber: subscriber, context: context, request: request)
        subscriber.receive(subscription: subscription)
    }
}

public extension CoreDataFetchResultsPublisher {
    class Subscription<S> where S : Subscriber, Failure == S.Failure, Output == S.Input {
        private var subscriber: S?
        private var request: NSFetchRequest<Entity>
        private var context: NSManagedObjectContext
        
        init(subscriber: S, context: NSManagedObjectContext, request: NSFetchRequest<Entity>) {
            self.subscriber = subscriber
            self.context = context
            self.request = request
        }
    }
}

extension CoreDataFetchResultsPublisher.Subscription: Subscription {
    public func request(_ demand: Subscribers.Demand) {
        var demand = demand
        guard let subscriber = subscriber, demand > 0 else { return }
        do {
            demand -= 1
            let items = try context.fetch(request)
            demand += subscriber.receive(items)
        } catch {
            subscriber.receive(completion: .failure(error as NSError))
        }
    }
}

extension CoreDataFetchResultsPublisher.Subscription: Cancellable {
    public func cancel() {
        subscriber = nil
    }
}
