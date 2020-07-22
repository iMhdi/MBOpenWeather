//
//  MBRequestWrapper.swift
//  MBOpenWeather
//
//  Created by El Mahdi Boukhris on 21/07/2020.
//  Copyright © 2020 El Mahdi Boukhris. All rights reserved.
//

import Foundation

class MBRequestWrapper: NSObject {
    
    class func requestAPI<T:Codable>(withURL apiUrl: String?, method: String!, andParameters parameters: [String: String]?, success:@escaping (T) -> Void, failure:@escaping (NSError) -> Void) {
        guard let urlString = apiUrl else {
            DispatchQueue.main.async {
                return failure(NSError(domain:"INVALID_URL", code:-1, userInfo:nil))
            }
            return
        }
        
        switch method {
        case "GET":
            MBRequestWrapper.makeGetApiCall(withURL: urlString, parameters: parameters, success: success, failure: failure)
            break;
        case "POST":
            MBRequestWrapper.makePostApiCall(withURL: urlString, parameters: parameters, success: success, failure: failure)
            break;
        default:
            DispatchQueue.main.async {
                return failure(NSError(domain:"UNSUPPORTED_METHOD", code:-2, userInfo:nil))
            }
            return
        }
    }
}

extension MBRequestWrapper {
    
    // MARK: GET Request Definition
    private class func makeGetApiCall<T:Codable>(withURL urlString: String!, parameters: [String: String]?, success:@escaping (T) -> Void, failure:@escaping (NSError) -> Void) {
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        
        var components = URLComponents(string: urlString)!
        
        if let queryParams = parameters {
            components.queryItems = queryParams.map { (key, value) -> URLQueryItem in
                URLQueryItem(name: key, value: value)
            }
            components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        }
        
        let request = URLRequest(url: components.url!)
        let dataTask = session.dataTask(with: request) { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse, let receivedData = data else {
                print("ERROR: not a valid http response")
                DispatchQueue.main.async {
                    failure(NSError(domain:"INVALID_RESPONSE", code:-3, userInfo:nil))
                }
                return
            }
            
            switch (httpResponse.statusCode) {
            case 200:
                do {
                    let successResponse = try JSONDecoder().decode(T.self, from: receivedData)
                    DispatchQueue.main.async {
                        success(successResponse)
                    }
                    return
                } catch {
                    print("error serializing JSON: \(error)")
                    DispatchQueue.main.async {
                        failure(error as NSError)
                    }
                    return
                }
            default:
                print("GET request got response code \(httpResponse.statusCode)")
                DispatchQueue.main.async {
                    failure(NSError(domain:"INVALID_RESPONSE_CODE", code:-4, userInfo:nil))
                }
                return
            }
        }
        dataTask.resume()
    }
    
    // MARK: POST Request Definition
    private class func makePostApiCall<T:Codable>(withURL urlString: String!, parameters: [String: String]?, success:@escaping (T) -> Void, failure:@escaping (NSError) -> Void) {
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        if let params = parameters {
            request.httpBody = params.percentEncoded()
        }
        
        let task = session.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse, let receivedData = data else {
                print("ERROR: not a valid http response")
                DispatchQueue.main.async {
                    return failure(NSError(domain:"INVALID_RESPONSE", code:-3, userInfo:nil))
                }
                return
            }
            
            switch (httpResponse.statusCode) {
            case 200:
                do {
                    let successResponse = try JSONDecoder().decode(T.self, from: receivedData)
                    DispatchQueue.main.async {
                        success(successResponse)
                    }
                    return
                } catch {
                    print("error serializing JSON: \(error)")
                    DispatchQueue.main.async {
                        return failure(error as NSError)
                    }
                    return
                }
            default:
                print("POST request got response code \(httpResponse.statusCode)")
                DispatchQueue.main.async {
                    return failure(NSError(domain:"INVALID_RESPONSE_CODE", code:-4, userInfo:nil))
                }
                return
            }
        }
        
        task.resume()
    }
}
