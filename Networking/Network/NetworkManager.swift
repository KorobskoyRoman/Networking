//
//  File.swift
//  Networking
//
//  Created by Roman Korobskoy on 20.11.2021.
//

import UIKit

class NetworkManager {
    
    static func getRequest(url: String) {
        
        // "https://jsonplaceholder.typicode.com/posts"
        guard let url = URL(string: url) else { return }
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            
            guard
                let response = response,
                let data = data
                else { return }
            
            print(response)
            print(data)
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
            } catch {
                print(error.localizedDescription)
            }
        } .resume()
    }
    
    static func postRequest(url: String) {
        guard let url = URL(string: url) else { return }
        
        let userData = ["Course": "Networking", "Lesson" : "GET/POST reqests"]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: userData, options: []) else { return }
        request.httpBody = httpBody
        request.addValue("applciation/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            guard let response = response,
            let data = data else {return}
            print(response)
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    static func downloadImage(url: String, completion: @escaping (_ image: UIImage) -> ()) {
        guard let url = URL(string: url) else { return }
        
        let session = URLSession.shared
        
        session.dataTask(with: url) { (data, response, error) in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    completion(image) //берем изображение по ссылке
                }
            }
        }
        .resume()
    }
    
    static func fetchData(url: String, completion: @escaping (_ courses: [Course]) -> ()) {
        
        guard let url = URL(string: url) else {return}
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else {return}
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let courses = try decoder.decode([Course].self, from: data)
                completion(courses)
            } catch let error{
                print(error.localizedDescription)
            }
        }.resume()
    }
}