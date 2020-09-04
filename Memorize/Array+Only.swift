//
//  Array+Only.swift
//  Memorize
//
//  Created by Manpreet Sokhi on 9/3/20.
//  Copyright © 2020 Manpreet Sokhi. All rights reserved.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
