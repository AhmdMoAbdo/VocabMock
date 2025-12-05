//
//  FlowLayout.swift
//  TestCursor
//
//  Created by Ahmed Abdo on 01/12/2025.
//

import SwiftUI

struct FlowLayout: Layout {
    struct Row {
        var items: [Int] = []
        var width: CGFloat = 0
        var height: CGFloat = 0
    }
    
    var spacing: CGFloat = 8
    var rowSpacing: CGFloat = 8
    var alignment: HorizontalAlignment = .leading
    
    func makeCache(subviews: Subviews) -> [CGSize] {
        subviews.map { $0.sizeThatFits(.unspecified) }
    }
    
    func sizeThatFits(
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout [CGSize]
    ) -> CGSize {
        
        let maxWidth = proposal.width ?? .infinity
        var rows: [Row] = [Row()]
        
        for (i, size) in cache.enumerated() {
            let itemWidth = size.width
            
            if rows.last!.width + itemWidth > maxWidth {
                rows.append(Row())
            }
            
            rows[rows.count - 1].items.append(i)
            rows[rows.count - 1].width += itemWidth + spacing
            rows[rows.count - 1].height = max(rows.last!.height, size.height)
        }
        
        let totalHeight = rows.reduce(0) { $0 + $1.height } +
                          CGFloat(rows.count - 1) * rowSpacing
        
        return CGSize(width: maxWidth, height: totalHeight)
    }
    
    func placeSubviews(
        in bounds: CGRect,
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout [CGSize]
    ) {
        
        let maxWidth = bounds.width        
        var rows: [Row] = [Row()]
        
        for (i, size) in cache.enumerated() {
            let itemWidth = size.width
            
            if rows.last!.width + itemWidth > maxWidth {
                rows.append(Row())
            }
            
            rows[rows.count - 1].items.append(i)
            rows[rows.count - 1].width += itemWidth + spacing
            rows[rows.count - 1].height = max(rows.last!.height, size.height)
        }
        
        var y = bounds.minY
        
        for row in rows {
            let rowWidthWithoutTrailingSpacing =
                row.width - spacing
            
            let xOffset: CGFloat
            switch alignment {
            case .leading:
                xOffset = bounds.minX
            case .center:
                xOffset = bounds.minX + (maxWidth - rowWidthWithoutTrailingSpacing) / 2
            case .trailing:
                xOffset = bounds.minX + (maxWidth - rowWidthWithoutTrailingSpacing)
            default:
                xOffset = bounds.minX
            }
            
            var x = xOffset
            
            for index in row.items {
                let size = cache[index]
                subviews[index].place(
                    at: CGPoint(x: x, y: y),
                    proposal: ProposedViewSize(size)
                )
                x += size.width + spacing
            }
            
            y += row.height + rowSpacing
        }
    }
}
