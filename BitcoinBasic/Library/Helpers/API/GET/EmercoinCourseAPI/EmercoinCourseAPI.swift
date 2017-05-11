//
//  EmercoinCourseAPI.swift
//  EmercoinBasic
//


import UIKit

class EmercoinCourseAPI {
    
    public func startRequest(completion:@escaping (_ data: AnyObject?,_ error:NSError?) -> Void) {
        
        let baseUrl = Constants.API.EmercoinCourse
    
        guard let url = URL(string:baseUrl) else {return}
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let session = URLSession.init(configuration: .default)
        
        var jsonObject:[[String:Any]]?
        
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            
            if let httpResponse = response as? HTTPURLResponse {
                
                let statusCode = httpResponse.statusCode
                
                if statusCode == 200 {
                    
                    jsonObject = self.getJsonObject(data: data!)
                    if jsonObject != nil {
                        if let priceUSD = jsonObject?.first?["price_usd"] {
                            completion(priceUSD as AnyObject, nil)
                        }
                    }
                }
            }
        }
        dataTask.resume()
    }
    
    private func getJsonObject(data:Data) -> [[String:Any]]? {
        var jsonObject:[[String:Any]] = []
        do {
            jsonObject = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as! [[String:Any]]
        } catch {
            return nil
        }
        
        return jsonObject
    }
    
}
