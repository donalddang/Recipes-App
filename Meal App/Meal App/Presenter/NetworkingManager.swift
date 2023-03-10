//
//  NetworkingManager.swift
//  Meal App
//
//  Created by Donald Dang on 3/5/23.
//

import Foundation

class NetworkingManager {
    //I opted to use a generic for this case because I'm making 2 seperate API Calls. This also will help if you have seperate screens with the same API call with different parameters to pass in
    func parseData<T: Codable>(from urlString: String, resultType: T.Type, completed: @escaping ([T]?) -> Void) {
        guard let url = URL(string: urlString) else {
            print("There was an error fetching your URL! Try again.")
            completed(nil)
            return
        }
        //launch session
        let session = URLSession(configuration: .default)
        //launch task
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                print("There was an error! Try again.")
                completed(nil)
                return
            }
            
            guard let data = data else {
                print("No data received")
                completed(nil)
                return
            }
            //decode json response
            do {
                let decodedData = try JSONDecoder().decode(Returned<T>.self, from: data)
                var resultArray = decodedData.meals
                completed(resultArray)
            } catch {
                print("There was an error decoding the JSON! Check your structs to ensure proper formatting.")
                completed(nil)
            }
        }
        
        task.resume()
    }

}
