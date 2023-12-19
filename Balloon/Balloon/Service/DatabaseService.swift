//
//  DatabaseService.swift
//  Balloon
//
//  Created by Юлия Гудошникова on 08.12.2023.
//

import Foundation

// Сервис для работы с данными пользователя
class DatabaseService {
    static let shared = DatabaseService()
    
    private init(){}
    
    func addUser(user: UserGeneralInfo, completion: @escaping (Error?) -> Void) {
        guard let url = URL(string: "http://localhost:5166/api/db/addUser") else {
            let invalidURLError = NSError(domain: "Invalid URL", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
            print("Invalid URL")
            completion(invalidURLError)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        // Convert birthDate to string with specific date format
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let dateString = dateFormatter.string(from: user.birthDate)
            
            // Create a new object to send with the formatted date
            let userToSend = UserGeneralInfoToSend(
                id: user.id,
                name: user.name,
                birthDate: dateString,
                typeDiabet: user.typeDiabet,
                height: user.height,
                weight: user.weight,
                male: user.male
            )
        do {
            let jsonData = try JSONEncoder().encode(userToSend)
            request.httpBody = jsonData
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    if let nsError = error as NSError? {
                        if nsError.code == NSURLErrorNotConnectedToInternet {
                            let connectionError = NSError(domain: "Connection Error", code: 1001, userInfo: [NSLocalizedDescriptionKey: "Could not connect to the server. Check your Internet connection"])
                            completion(connectionError)
                        } else {
                            let otherError = NSError(domain: "Other Error", code: 1002, userInfo: [NSLocalizedDescriptionKey: "Something went wrong. Check the entered data and your Internet connection."])
                            completion(otherError)
                        }
                    } else {
                        completion(error)
                    }
                    return
                }
                
                // Handle response data here if needed
                if let data = data {
                    let responseString = String(data: data, encoding: .utf8)
                    print("Response: \(responseString ?? "")")
                }
                
                completion(nil)
            }
            
            task.resume()
        } catch {
            print("Error serializing parameters: \(error.localizedDescription)")
            completion(error)
        }
    }
    
    func updateUser(user: UserGeneralInfo, completion: @escaping (Error?) -> Void) {
        let urlString = "http://localhost:5166/api/db/updateUser/\(user.id)"
            guard let url = URL(string: urlString) else {
                let invalidURLError = NSError(domain: "Invalid URL", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
                print("Invalid URL")
                completion(invalidURLError)
                return
            }
        print(user.id)
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        // Convert birthDate to string with specific date format
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let dateString = dateFormatter.string(from: user.birthDate)
            
            // Create a new object to send with the formatted date
            let userToSend = UserGeneralInfoToSend(
                id: user.id,
                name: user.name,
                birthDate: dateString,
                typeDiabet: user.typeDiabet,
                height: user.height,
                weight: user.weight,
                male: user.male
            )
        do {
            let jsonData = try JSONEncoder().encode(userToSend)
            request.httpBody = jsonData
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    if let nsError = error as NSError? {
                        if nsError.code == NSURLErrorNotConnectedToInternet {
                            let connectionError = NSError(domain: "Connection Error", code: 1001, userInfo: [NSLocalizedDescriptionKey: "Could not connect to the server. Check your Internet connection"])
                            completion(connectionError)
                        } else {
                            let otherError = NSError(domain: "Other Error", code: 1002, userInfo: [NSLocalizedDescriptionKey: "Something went wrong. Check the entered data and your Internet connection."])
                            completion(otherError)
                        }
                    } else {
                        completion(error)
                    }
                    return
                }
                
                // Handle response data here if needed
                if let data = data {
                    let responseString = String(data: data, encoding: .utf8)
                    print("Response: \(responseString ?? "")")
                }
                
                completion(nil)
            }
            
            task.resume()
        } catch {
            print("Error serializing parameters: \(error.localizedDescription)")
            completion(error)
        }
    }
    
    func getUser(userID: String, completion: @escaping (Result<UserGeneralInfo, Error>) -> Void) {
        let urlString = "http://localhost:5166/api/db/getUser/\(userID)"
        guard let url = URL(string: urlString) else {
            let invalidURLError = NSError(domain: "Invalid URL", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
            print("Invalid URL")
            completion(.failure(invalidURLError))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                if let nsError = error as NSError? {
                    if nsError.code == NSURLErrorNotConnectedToInternet {
                        let connectionError = NSError(domain: "Connection Error", code: 1001, userInfo: [NSLocalizedDescriptionKey: "Could not connect to the server. Check your Internet connection"])
                        completion(.failure(connectionError))
                    } else {
                        let otherError = NSError(domain: "Other Error", code: 1002, userInfo: [NSLocalizedDescriptionKey: "Something went wrong. Check the entered data and your Internet connection."])
                        completion(.failure(otherError))
                    }
                } else {
                    completion(.failure(error))
                }
                return
            }
            
            // Handle response data here if needed
            if let data = data {
                do {
                    let user = try JSONDecoder().decode(UserGeneralInfo.self, from: data)
                    completion(.success(user))
                } catch {
                    print("Error decoding user data: \(error.localizedDescription)")
                    completion(.failure(error))
                }
            } else {
                let noDataError = NSError(domain: "No Data", code: 1003, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                completion(.failure(noDataError))
            }
        }
        
        task.resume()
    }

}
struct UserGeneralInfoToSend: Codable {
    var id : String
    var name: String
    var birthDate: String // Отправляйте дату в строковом формате, который может быть преобразован на сервере в DateTime
    var typeDiabet: String
    var height: Int
    var weight: Int
    var male: String
}
