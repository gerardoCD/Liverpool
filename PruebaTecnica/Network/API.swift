import UIKit

class API {
    
    static let shared = API()
    
    private init(){}
    
    
    func getProduct( searchString: String , completion: @escaping (_ productModel: ProductModel?, _ error:  String?) -> Void){        /* Configure session, choose between:
           * defaultSessionConfiguration
           * ephemeralSessionConfiguration
           * backgroundSessionConfigurationWithIdentifier:
         And set session-wide properties, such as: HTTPAdditionalHeaders,
         HTTPCookieAcceptPolicy, requestCachePolicy or timeoutIntervalForRequest.
         */
        let sessionConfig = URLSessionConfiguration.default

        /* Create session, and optionally set a URLSessionDelegate. */
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)

        /* Create the Request:
           Request (2) (GET https://shoppapp.liverpool.com.mx/appclienteservices/services/v3/plp)
         
         */
        
//        searchString == "" ? "computadora" : searchString

        guard var URL = URL(string: "https://shoppapp.liverpool.com.mx/appclienteservices/services/v3/plp") else {return}
        let URLParams = [
            "force-plp": "true",
            "search-string": searchString,
            "page-number": "1",
            "number-of-items-per-page": "25",
        ]
        URL = URL.appendingQueryParameters(URLParams)
        var request = URLRequest(url: URL)
        request.httpMethod = "GET"

        /* Start a new Task */
        let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            if (error == nil) {
                // Success
                let statusCode = (response as! HTTPURLResponse).statusCode
                
                print("URL Session Task Succeeded: HTTP \(statusCode)")
                
//                let productModel = try? newJSONDecoder().decode(ProductModel.self, from: jsonData)
                
                let infoObject = try! JSONDecoder().decode(ProductModel.self, from: data!)
                print(infoObject)
//                completion(true,infoObject,nil)
                
                completion(infoObject, nil)
            }
            else {
                completion(nil,error!.localizedDescription )
                // Failure
                print("URL Session Task Failed: %@", error!.localizedDescription);
            }
        })
        task.resume()
        session.finishTasksAndInvalidate()
    }
}








protocol URLQueryParameterStringConvertible {
    var queryParameters: String {get}
}

extension Dictionary : URLQueryParameterStringConvertible {
    var queryParameters: String {
        var parts: [String] = []
        for (key, value) in self {
            let part = String(format: "%@=%@",
                String(describing: key).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!,
                String(describing: value).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
            parts.append(part as String)
        }
        return parts.joined(separator: "&")
    }
    
}

extension URL {
    func appendingQueryParameters(_ parametersDictionary : Dictionary<String, String>) -> URL {
        let URLString : String = String(format: "%@?%@", self.absoluteString, parametersDictionary.queryParameters)
        return URL(string: URLString)!
    }
}

