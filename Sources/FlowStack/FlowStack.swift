//
//  FlowStack.swift
//
//  Created by John Susek on 6/25/19.
//  Copyright © 2019 John Susek. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public struct FlowStack<Content>: View where Content: View {
  // The number of columns we want to display
  var columns: Int
  // The total number of items in the stack
  var numItems: Int
  // The alignment of our columns in the last row
  // when they don't fill all the column slots
  var alignment: HorizontalAlignment

  public let content: (Int, CGFloat) -> Content

  public init(
    columns: Int,
    numItems: Int,
    alignment: HorizontalAlignment?,
    @ViewBuilder content: @escaping (Int, CGFloat) -> Content) {
    self.content = content
    self.columns = columns
    self.numItems = numItems
    self.alignment = alignment ?? HorizontalAlignment.leading
  }

  public var body : some View {
    // A GeometryReader is required to size items in the scroll view
    GeometryReader { geometry in

      // Assume a vertical scrolling orientation for the grid
      ScrollView(alwaysBounceHorizontal: false, alwaysBounceVertical: true) {

        // VStacks are our rows
        VStack(alignment: self.alignment, spacing: 0) {
          ForEach(0 ..< (self.numItems / self.columns)) { row in

            // HStacks are our columns
            HStack(spacing: 0) {
              ForEach(0 ... (self.columns - 1)) { column in
                self.content(
                  // Pass the index to the content
                  (row * self.columns) + column,
                  // Pass the column width to the content
                  (geometry.size.width/CGFloat(self.columns))
                )
                // Size the content to frame to fill the column
                .frame(width: geometry.size.width/CGFloat(self.columns))
              }
            }
          }

          // Last row
          // HStacks are our columns
          HStack(spacing: 0) {
            ForEach(0 ..< (self.numItems % self.columns)) { column in
              self.content(
                // Pass the index to the content
                ((self.numItems / self.columns) * self.columns) + column,
                // Pass the column width to the content
                (geometry.size.width/CGFloat(self.columns))
              )
              // Size the content to frame to fill the column
              .frame(width: geometry.size.width/CGFloat(self.columns))
            }
          }
        }
      }
    }
  }
}
