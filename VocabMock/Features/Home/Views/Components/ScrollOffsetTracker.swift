//
//  ScrollOffsetTracker.swift
//  TestCursor
//

import SwiftUI
import UIKit

struct ScrollOffsetReader: UIViewRepresentable {
    let onChange: (CGFloat) -> Void
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        DispatchQueue.main.async {
            if let scrollView = view.findScrollView() {
                scrollView.delegate = context.coordinator
                context.coordinator.scrollView = scrollView
                onChange(scrollView.contentOffset.y)
            }
        }
        return view
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(onChange: onChange)
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
    
    class Coordinator: NSObject, UIScrollViewDelegate {
        let onChange: (CGFloat) -> Void
        weak var scrollView: UIScrollView?
        
        init(onChange: @escaping (CGFloat) -> Void) {
            self.onChange = onChange
        }
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            onChange(scrollView.contentOffset.y)
        }
    }
}

extension UIView {
    func findScrollView() -> UIScrollView? {
        if let scroll = superview as? UIScrollView { return scroll }
        return superview?.findScrollView()
    }
}
