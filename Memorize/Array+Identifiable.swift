//
//  Array+Identifiable.swift
//  Memorize
//
//  Created by Manpreet Sokhi on 9/1/20.
//  Copyright © 2020 Manpreet Sokhi. All rights reserved.
//

import Foundation

extension Array where Element: Identifiable {
    func firstIndex(matching: Element) -> Int? { // return type is now an optional and will allow us to return nil if not found
        for index in 0..<self.count {
            if self[index].id == matching.id {
                return index
            }
        }
        return nil
    }
    
}
