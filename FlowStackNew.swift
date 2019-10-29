//
//  FlowStack.swift
//
//  Created by John Susek on 6/25/19.
//  Copyright © 2019 John Susek. All rights reserved.
//
//  refactored by Alexander Voelz on 10/29/19
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
	var alignment = HorizontalAlignment.leading
	
	public let content: (Int, CGFloat) -> Content
	
	private func width(for size: CGSize)-> CGFloat {
		return size.width/CGFloat(self.columns)
	}
	
	private func index(forRow row: Int, column: Int) -> Int {
		return (row * self.columns) + column
	}
	
	private var lastRowColumns : Int { get { return numItems % columns }	}
	
	private var rows : Int { get { return numItems / columns } }
	
	public init(
		columns: Int,
		numItems: Int,
		alignment: HorizontalAlignment? = HorizontalAlignment.leading,
		@ViewBuilder content: @escaping (Int, CGFloat) -> Content) {
		self.content = content
		self.columns = columns
		self.numItems = numItems
		self.alignment = alignment ?? HorizontalAlignment.leading
	}
	
	public var body : some View {
		// A GeometryReader is required to size items in the scroll view
		GeometryReader { geometry in
			
			// VStacks are our rows
			VStack(alignment: self.alignment, spacing: 0) {
				ForEach(0 ..< self.rows ) { row in
					
					// HStacks are our columns
					HStack(spacing: 0) {
						ForEach(0 ..< self.columns) { column in
							self.content(
								// Pass the index to the content
								self.index(forRow: row, column: column),
								// Pass the column width to the content
								self.width(for: geometry.size)
							)
								// Size the content to frame to fill the column
								.frame(width: self.width(for: geometry.size))
						}
					}
				}
				
				// Last row
				// HStacks are our columns
				HStack(spacing: 0) {
					ForEach(0 ..< self.lastRowColumns) { column in
						self.content(
							// Pass the index to the content
							self.index(forRow: self.rows, column: column),
							// Pass the column width to the content
							self.width(for: geometry.size)
						)
							// Size the content to frame to fill the column
							.frame(width: self.width(for: geometry.size))
					}
				}
			}
		}
	}
}
