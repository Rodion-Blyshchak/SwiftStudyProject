//
//  Endpoint.swift
//  SwiftStudyProject
//
//  Created by Rodion Blyshchak on 05.03.2026.
//

import Foundation

enum Endpoint {
	case getCars
	
	var path: String {
		switch self {
		case .getCars:
			return "/v3/b/69a49813d0ea881f40e5601f"
		}
	}
	
	var httpMethod: HttpMethod {
		switch self {
		case .getCars:
			return .get
		}
	}
}

enum APIEnvironment {
	case development
	case staging
	case production
	
	var baseURL: String {
		switch self {
		case .development, .staging, .production:
			return "https://api.jsonbin.io"
		}
	}
}
