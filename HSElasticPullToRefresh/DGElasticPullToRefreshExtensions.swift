/*

The MIT License (MIT)

Copyright (c) 2019 Hiromasa Suzuki

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

*/

import UIKit
import ObjectiveC

// MARK: -
// MARK: (NSObject) Extension

public extension NSObject {
    
    // MARK: -
    // MARK: Vars
    
    fileprivate struct hs_associatedKeys {
        static var observersArray = "observers"
    }
    
    fileprivate var hs_observers: [[String : NSObject]] {
        get {
            if let observers = objc_getAssociatedObject(self, &hs_associatedKeys.observersArray) as? [[String : NSObject]] {
                return observers
            } else {
                let observers = [[String : NSObject]]()
                self.hs_observers = observers
                return observers
            }
        } set {
            objc_setAssociatedObject(self, &hs_associatedKeys.observersArray, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    // MARK: -
    // MARK: Methods
    
    func hs_addObserver(_ observer: NSObject, forKeyPath keyPath: String) {
        let observerInfo = [keyPath : observer]
        
        if hs_observers.firstIndex(where: { $0 == observerInfo }) == nil {
            hs_observers.append(observerInfo)
            addObserver(observer, forKeyPath: keyPath, options: .new, context: nil)
        }
    }
    
    func hs_removeObserver(_ observer: NSObject, forKeyPath keyPath: String) {
        let observerInfo = [keyPath : observer]
        
        if let index = hs_observers.firstIndex(where: { $0 == observerInfo}) {
            hs_observers.remove(at: index)
            removeObserver(observer, forKeyPath: keyPath)
        }
    }
    
}

// MARK: -
// MARK: (UIScrollView) Extension

public extension UIScrollView {
    
    // MARK: - Vars

    fileprivate struct hs_associatedKeys {
        static var pullToRefreshView = "pullToRefreshView"
    }

    fileprivate var pullToRefreshView: HSElasticPullToRefreshView? {
        get {
            return objc_getAssociatedObject(self, &hs_associatedKeys.pullToRefreshView) as? HSElasticPullToRefreshView
        }

        set {
            objc_setAssociatedObject(self, &hs_associatedKeys.pullToRefreshView, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    // MARK: - Methods (Public)
    
    func hs_addPullToRefreshWithActionHandler(_ actionHandler: @escaping () -> Void, loadingView: HSElasticPullToRefreshLoadingView?) {
        isMultipleTouchEnabled = false
        panGestureRecognizer.maximumNumberOfTouches = 1

        let pullToRefreshView = HSElasticPullToRefreshView()
        self.pullToRefreshView = pullToRefreshView
        pullToRefreshView.actionHandler = actionHandler
        pullToRefreshView.loadingView = loadingView
        addSubview(pullToRefreshView)

        pullToRefreshView.observing = true
    }
    
    func hs_removePullToRefresh() {
        pullToRefreshView?.disassociateDisplayLink()
        pullToRefreshView?.observing = false
        pullToRefreshView?.removeFromSuperview()
    }
    
    func hs_setPullToRefreshBackgroundColor(_ color: UIColor) {
        pullToRefreshView?.backgroundColor = color
    }
    
    func hs_setPullToRefreshFillColor(_ color: UIColor) {
        pullToRefreshView?.fillColor = color
    }
    
    func hs_stopLoading() {
        pullToRefreshView?.stopLoading()
    }
}

// MARK: -
// MARK: (UIView) Extension

public extension UIView {
    func hs_center(_ usePresentationLayerIfPossible: Bool) -> CGPoint {
        if usePresentationLayerIfPossible, let presentationLayer = layer.presentation() {
            // Position can be used as a center, because anchorPoint is (0.5, 0.5)
            return presentationLayer.position
        }
        return center
    }
}

// MARK: -
// MARK: (UIPanGestureRecognizer) Extension

public extension UIPanGestureRecognizer {
    func hs_resign() {
        isEnabled = false
        isEnabled = true
    }
}

// MARK: -
// MARK: (UIGestureRecognizerState) Extension

public extension UIGestureRecognizer.State {
    func hs_isAnyOf(_ values: [UIGestureRecognizer.State]) -> Bool {
        return values.contains(where: { $0 == self })
    }
}
