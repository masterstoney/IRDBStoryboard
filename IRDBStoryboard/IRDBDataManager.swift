//
//  IRDBDataManager.swift
//  IRDBStoryboard
//
//  Created by Tendaishe Gwini on 20/03/2019.
//  Copyright © 2019 Tendaishe Gwini. All rights reserved.
//

import UIKit

class IRDBDataManager {
    
    /** Fetches all the movie data from our fake repo */
    func fetchData(completion: @escaping (_ data: IRDBDataModel, _ error: Error?) -> Void) {
        
        var irdbData = IRDBDataModel()
        let urlString = "https://api.myjson.com/bins/1e5uji"
        let url = URL(string: urlString)
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { (data, response, error) in
            
            if error != nil {
                completion(irdbData,error)
                return
            }
            
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    irdbData = try decoder.decode(IRDBDataModel.self, from: data)
                } catch {
                    completion(irdbData,error)
                    return
                }
            }
            completion(irdbData,error)
        }
        task.resume()
        
    }
    
    
}
