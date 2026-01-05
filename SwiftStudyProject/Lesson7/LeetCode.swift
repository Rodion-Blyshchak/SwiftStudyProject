//
//  LeetCode.swift
//  SwiftStudyProject
//
//  Created by Rodion Blyshchak on 01.01.2026.
//

class Solution {
	func plusOne(_ digits: [Int]) -> [Int] {
		let digitsString = digits.map { String($0) }.joined()
		
		let incrementedValue = (Int(digitsString) ?? 0) + 1
		
		let resultDigits = String(incrementedValue).compactMap { $0.wholeNumberValue }
		
		return resultDigits
	}
}


//Input: digits = [1,2,3]
//Output: [1,2,4]
//Explanation: The array represents the integer 123.
//Incrementing by one gives 123 + 1 = 124.
//Thus, the result should be [1,2,4].


class Solution2 {
	func isPalindrome(_ x: Int) -> Bool {
		let string = String(x)
		return String(string.reversed()) == string
	}
}

//Input: x = 121
//Output: true
//Explanation: 121 reads as 121 from left to right and from right to left.
