//
//  NetworkManager.swift
//  DailyCalories
//
//  Created by Udrea Alexandru-Iulian-Alberto on 29.12.2022.
//
/*
import Foundation

func createUser(user: User, completion: @escaping (Result<User, Error>) -> Void) {
    let encoder = JSONEncoder()
    encoder.keyEncodingStrategy = .convertToSnakeCase
    guard let data = try? encoder.encode(user) else {
        completion(.failure(NSError()))
        return
    }
    
    guard let url = URL(string: "http://localhost:3001/users/create") else { return }
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.httpBody = data
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            completion(.failure(error))
            return
        }
        
        // Check the HTTP status code and response data
        if let httpResponse = response as? HTTPURLResponse {
            print(httpResponse.statusCode)
            if let data = data {
                print(String(data: data, encoding: .utf8)!)
            }
        }
        guard let data = data else {
            completion(.failure(NSError()))
            return
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let user = try decoder.decode(User.self, from: data)
            print(user)
            completion(.success(user))
        } catch {
            completion(.failure(error))
        }
    }
    
    task.resume()
}


/*func sendPostRequest(id: String, food: Food, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
 let url = URL(string: "http://localhost:3001/food/\(id)")!
 var request = URLRequest(url: url)
 request.httpMethod = "POST"
 request.addValue("application/json", forHTTPHeaderField: "Content-Type")
 
 let encoder = JSONEncoder()
 request.httpBody = try! encoder.encode(food)
 
 let task = URLSession.shared.dataTask(with: request, completionHandler: completion)
 task.resume()
 }*/


func addFood(food: Food , completion: @escaping (Result<Food, Error>) -> Void) {
    let encoder = JSONEncoder()
    encoder.keyEncodingStrategy = .convertToSnakeCase
    guard let data = try? encoder.encode(food) else {
        completion(.failure(NSError()))
        return
    }
    
    guard let url = URL(string: "http://localhost:3001/food/add") else { return }
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.httpBody = data
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            completion(.failure(error))
            return
        }
        
        // Check the HTTP status code and response data
        if let httpResponse = response as? HTTPURLResponse {
            print(httpResponse.statusCode)
            if let data = data {
                print(String(data: data, encoding: .utf8)!)
            }
        }
        guard let data = data else {
            completion(.failure(NSError()))
            return
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let food = try decoder.decode(Food.self, from: data)
            print(food)
            completion(.success(food))
        } catch {
            completion(.failure(error))
        }
    }
    
    task.resume()
}

func getFoods(forUserWithId id: String, completion: @escaping ([Food]?, Error?) -> Void) {
    let url = URL(string: "http://localhost:3001/food/\(id)")!
    
    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        if let error = error {
            // Pass the error to the completion handler
            completion(nil, error)
            return
        }
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            // Pass an error to the completion handler
            let error = NSError(domain: "FoodServiceErrorDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid response"])
            completion(nil, error)
            return
        }
        
        if let data = data {
            // Use JSONDecoder to decode the data into an array of Food objects
            let decoder = JSONDecoder()
            do {
                let foods = try decoder.decode([Food].self, from: data)
                // Pass the decoded array to the completion handler
                completion(foods, nil)
            } catch {
                // Pass the error to the completion handler
                completion(nil, error)
            }
        }
    }
    
    task.resume()
}
*/
