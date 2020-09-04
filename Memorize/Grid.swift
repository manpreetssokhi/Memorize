//
//  Grid.swift
//  Memorize
//
//  Created by Manpreet Sokhi on 9/1/20.
//  Copyright © 2020 Manpreet Sokhi. All rights reserved.
//

import SwiftUI

// constrains and gains using generics with protocols to constrain don't cares to work
struct Grid<Item, ItemView>: View where Item: Identifiable, ItemView: View {
    // Both are "don't care"
    var items: [Item]
    var viewForItem: (Item) -> ItemView
    
    // @escaping allows function to escape from init without being called
    init(_ items: [Item], viewForItem: @escaping (Item) -> ItemView) {
        self.items = items
        self.viewForItem = viewForItem
    }
    
    var body: some View {
        // figure out space that is allocated to Grid using GeometryReader
        GeometryReader { geometry in
            self.body(for: GridLayout(itemCount: self.items.count, in: geometry.size))
        }
    }
    
    func body(for layout: GridLayout) -> some View {
        ForEach(items) { item in
            self.body(for: item, in: layout)
        }
    }
    
    func body(for item: Item, in layout: GridLayout) -> some View {
        let index = items.firstIndex(matching: item)
        return viewForItem(item)
            .frame(width: layout.itemSize.width, height: layout.itemSize.height)
            .position(layout.location(ofItemAt: index))
    }
    
//    // Hmm this is the exactly same code as in model - can use extension because this is an array thing
//    func index(of item: Item) -> Int {
//        for index in 0..<items.count {
//            if items[index].id == item.id { // just returns the first index of the item
//                return index
//            }
//        }
//        return 0 // TODO: bogus!
//    }
}
