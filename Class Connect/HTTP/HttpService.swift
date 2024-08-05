import Foundation

enum NetworkError: Error {
    case badURL
    case requestFailed
    case unknown
}

class NetworkService {
    let baseUrl:String = "http://10.0.0.143:1337";
    static let shared = NetworkService()
    
    private init() {}
    
    func request<T: Decodable>(
        urlString: String,
        method: HTTPMethod,
        parameters: [String: Any]? = nil,
        headers: [String: String]? = nil,
        as type: T.Type,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        let url: String = baseUrl + urlString
        guard var urlComponents = URLComponents(string: url) else {
            completion(.failure(.badURL))
            return
        }
        
        if method == .get, let parameters = parameters {
            urlComponents.queryItems = parameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        }
        
        guard let url = urlComponents.url else {
            completion(.failure(.badURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if let headers = headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        if method != .get, let parameters = parameters {
            do {
                print(parameters)
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            } catch {
                completion(.failure(.unknown))
                return
            }
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let _ = error {
                completion(.failure(.requestFailed))
                return
            }
            
            guard let data = data else {
                completion(.failure(.unknown))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(.unknown))
            }
        }.resume()
    }
}
