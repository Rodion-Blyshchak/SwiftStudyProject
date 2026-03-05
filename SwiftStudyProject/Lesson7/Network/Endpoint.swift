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
			return "/v3/b/698f838cae596e708f28a522"
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
