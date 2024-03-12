
import Foundation
import Combine

//MARK: Extended Requestable to provide request dispatcher
extension Requestable  {
    
    /// Dispatches  request and returns Response publisher
    /// - Parameter body: RequestBody
    /// - Returns: AnyPublisher<Response, NetworkError>
    public static func load(withRequestBody body: RequestType? = nil) -> AnyPublisher<ResponseType, NetworkError>{
        guard let request = makeRequest(body) else {
            return Fail(error: .invalidRequest).eraseToAnyPublisher()
        }
        return session
            .response(request: request)
            .tryMap { (data, response)  in
                guard let urlResponse = response as? HTTPURLResponse else {
                    throw httpError(0)
                }
                if !(200..<300).contains(urlResponse.statusCode)  {
                    throw httpError(urlResponse.statusCode)
                }
                return data
            }
            .decode(type: ResponseType.self, decoder: JSONDecoder())
            .mapError { error in
               handleError(error)
            }
            .eraseToAnyPublisher()
    }
    
    /// Creates request to dispatch and returns URLRequest
    /// - Parameter body: RequestBody
    /// - Returns: URLRequest
    private static func makeRequest(_ body: RequestType?) -> URLRequest? {
        guard var url = URL(string: host.baseUrl+path) else { return nil }
        url.addQueryItems(queryParams: queryParams)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.timeoutInterval = 60
        urlRequest.addBody(body)
        return urlRequest
    }
}
