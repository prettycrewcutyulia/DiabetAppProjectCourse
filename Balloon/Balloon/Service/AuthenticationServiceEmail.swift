//
//  AuthenticationService.swift
//  Balloon
//
//  Created by Юлия Гудошникова on 01.12.2023.
//

import FirebaseAuth

class AuthenticationServiceEmail {
    static let shared = AuthenticationServiceEmail()
    
    // гарантия, что у нас будет только один экземпляр во всем приложении
    private init(){}
    
    private let auth = Auth.auth()
    
    var currentUser : User? {
        return auth.currentUser
    }
    
    func signIn(email: String, password: String, completion: @escaping (Error?) -> Void) {
        auth.signIn(withEmail: email, password: password) { authResult, error in
            completion(error)
        }
    }
    
    func signUp(email: String, password: String, completion: @escaping (Error?) -> Void) {
        auth.createUser(withEmail: email, password: password) { authResult, error in
            completion(error)
        }
    }
    
    func resetPassword(email: String, completion: @escaping (Error?) -> Void) {
        auth.sendPasswordReset (withEmail: email) { error in
            completion(error)
        }
    }
}
