//
//  CarModel.swift
//  SwiftStudyProject
//
//  Created by Rodion Blyshchak on 20.12.2025.
//

import UIKit

struct CarModel: Codable {
	let id: Int
	let image: String?
	let name: String
	let team: String
	let description: String? = nil
	let maxSpeed: Int
	let acceleration: Float
	let weight: Int
	var isInFavorite: Bool = false
	
	enum CodingKeys: String, CodingKey {
		case id
		case image
		case name
		case team = "teamName"
		case maxSpeed
		case acceleration
		case weight
	}
}



/*
  {
	"book title": "1984",
	"author_name": "George Orwell",
	"publication_year": 1949
  }
  
  struct Book: Codable {
	  var title: String
	  var author: String
	  var publicationYear: Int

	  enum CodingKeys: String, CodingKey {
		  case title = "book title"
		  case author = "author_name"
		  case publicationYear = "publication_year"
	  }
  }
*/
