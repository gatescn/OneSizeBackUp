import Foundation

class OneSizeRestApi {
    private static let baseUrlString = "http://192.168.1.219:3000"
    
    static let instance = OneSizeRestApi()
    
    enum Method {
        case get, post
    }
    
    func methodString(method: Method) -> String {
        switch(method) {
        case .get: return "GET"
        case .post: return "POST"
        }
    }
    
    func registerProfile(
            request: RegistrationRequest,
            completion: @escaping (Profile?) -> Void) {
        
        sendRequest(url: "/auth/user", method: .post, data: request) {
            data, response, error in
                
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            
            let responseJSON = try? JSONSerialization.jsonObject(with: data,
                                                                 options: [])
            var profile: Profile?
            if let responseJSON = responseJSON as? [String: Any] {
                profile = Profile(
                    firstName: responseJSON["firstName"] as! String,
                    lastName: responseJSON["lastName"] as! String)
            }
            completion(profile)
        }
    }
    
    func login(
            request: LoginRequest,
            completion: @escaping (Profile?) -> Void) {
        
        sendRequest(url: "/auth/login", method: .post, data: request) {
            data, response, error in
            
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            
            let responseJSON = try? JSONSerialization.jsonObject(with: data,
                                                                 options: [])
            var profile: Profile?
            if let responseJSON = responseJSON as? [String: Any] {
                profile = Profile(
                    firstName: responseJSON["firstName"] as! String,
                    lastName: responseJSON["lastName"] as! String)
            }
            completion(profile)
        }
    }
    
    func sendRequest<T: Encodable> (
            url: String,
            method: Method,
            data: T?,
            completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        
        let urlString = "\(OneSizeRestApi.baseUrlString)\(url)"
        let url = URLComponents(string: urlString)!.url!
        
        var request = URLRequest(url: url)
        request.httpMethod = methodString(method: method)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONEncoder().encode(data!)
    
        let task = URLSession.shared.dataTask(with: request,
                                              completionHandler: completion)
        
        task.resume()
    }
}
