//
//  AuthManager.swift
//  AnnualDiary
//
//  Created by dev team on 2023/03/16.
//

import SwiftUI
import PhotosUI

public class AuthManager {
    public static let shared = AuthManager()
    
    public func requestAuthorization(withCompletion completion: @escaping (_ status: PHAuthorizationStatus) -> Void) {
        PHPhotoLibrary.requestAuthorization(for: .addOnly) { [weak self] (status: PHAuthorizationStatus) in
            guard let self = self else {
                return
            }
            DispatchQueue.main.async {
                completion(status)
            }
        }
    }
    
}
