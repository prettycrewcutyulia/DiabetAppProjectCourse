//
//  AuthenticationService.swift
//  Balloon
//
//  Created by Юлия Гудошникова on 01.12.2023.
//

import Foundation

// Сервис Авторизации
class AuthenticationServiceEmail {
    static let shared = AuthenticationServiceEmail()
    
    // гарантия, что у нас будет только один экземпляр во всем приложении
    private init(){}
    
    func signIn(email: String, password: String, completion: @escaping (Error?) -> Void) {
        guard let url = URL(string: "http://localhost:5166/api/auth/login") else {
            print("Invalid URL")
            completion(NSError(domain: "Invalid URL", code: 0, userInfo: nil))
            return
        }
        
        let parameters = [
            "email": email,
            "password": password
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print("Error serializing parameters: \(error.localizedDescription)")
            completion(error)
            return
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                if (error as NSError).code == NSURLErrorNotConnectedToInternet {
                                let customError = NSError(domain: "Connection Error", code: 1001, userInfo: [NSLocalizedDescriptionKey: "Could not connect to the server. Check your Internet connection"])
                    DispatchQueue.main.async {
                        completion(customError)
                    }
                            } else {
                                let customError = NSError(domain: "Other Error", code: 1002, userInfo: [NSLocalizedDescriptionKey: "Something went wrong. Check the entered data and your Internet connection."])
                                DispatchQueue.main.async {
                                    completion(customError)
                                }
                            }
                            return
            }
            
            // Handle response data here if needed
            if let data = data {
                let responseString = String(data: data, encoding: .utf8)
                print("Response: \(responseString ?? "")")
                UserDefaults.standard.set(responseString, forKey: "idUser")
            }
            DispatchQueue.main.async {
                completion(nil)
            }
        }.resume()
    }

    
    func signUp(email: String, password: String, completion: @escaping (Error?) -> Void) {
        guard let url = URL(string: "http://localhost:5166/api/auth/register") else {
            print("Invalid URL")
            completion(NSError(domain: "Invalid URL", code: 0, userInfo: nil))
            return
        }
        
        let parameters = [
            "email": email,
            "password": password
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print("Error serializing parameters: \(error.localizedDescription)")
            completion(error)
            return
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                if (error as NSError).code == NSURLErrorNotConnectedToInternet {
                                let customError = NSError(domain: "Connection Error", code: 1001, userInfo: [NSLocalizedDescriptionKey: "Could not connect to the server. Check your Internet connection"])
                    DispatchQueue.main.async {
                        completion(customError)
                    }
                            } else {
                                let customError = NSError(domain: "Other Error", code: 1002, userInfo: [NSLocalizedDescriptionKey: "Something went wrong. Check the entered data and your Internet connection."])
                                DispatchQueue.main.async {
                                    completion(customError)
                                }
                            }
                            return
            }
            
            // Handle response data here if needed
            if let data = data {
                let responseString = String(data: data, encoding: .utf8)
                print("Response: \(responseString ?? "")")
                UserDefaults.standard.set(responseString, forKey: "idUser")
            }
            
            completion(nil)
        }.resume()
    }
    
    func resetPassword(email: String, completion: @escaping (Error?) -> Void) {
        guard let url = URL(string: "http://localhost:5166/api/auth/reset-password") else {
            print("Invalid URL")
            completion(NSError(domain: "Invalid URL", code: 0, userInfo: nil))
            return
        }
        
        let parameters = [
            "email": email,
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print("Error serializing parameters: \(error.localizedDescription)")
            completion(error)
            return
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                if (error as NSError).code == NSURLErrorNotConnectedToInternet {
                                let customError = NSError(domain: "Connection Error", code: 1001, userInfo: [NSLocalizedDescriptionKey: "Could not connect to the server. Check your Internet connection"])
                    DispatchQueue.main.async {
                        completion(customError)
                    }
                            } else {
                                let customError = NSError(domain: "Other Error", code: 1002, userInfo: [NSLocalizedDescriptionKey: "Something went wrong. Check the entered data and your Internet connection."])
                                DispatchQueue.main.async {
                                    completion(customError)
                                }
                            }
                            return
            }
            
            // Handle response data here if needed
            if let data = data {
                let responseString = String(data: data, encoding: .utf8)
                print("Response: \(responseString ?? "")")
                UserDefaults.standard.set(responseString, forKey: "idUser")
            }
            
            completion(nil)
        }.resume()
    }
}
