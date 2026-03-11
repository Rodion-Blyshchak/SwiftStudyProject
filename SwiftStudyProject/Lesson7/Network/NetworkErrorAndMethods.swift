

import Foundation

enum APIError: Error {
	case invalidURL
	case requestFailed(String)
	case decodingFailed
}

enum HttpMethod: String {
	case get = "GET"
	case post = "POST"
	case put = "PUT"
	case delete = "DELETE"
}
