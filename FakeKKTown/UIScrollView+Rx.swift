//
//  UIScrollView+Rx.swift
//  CarouselPratice
//
//  Created by Calvin on 6/15/16.
//  Copyright © 2016 CapsLock. All rights reserved.
//

import RxSwift
import RxCocoa

extension UIScrollView {
    public var rx_scrollViewDidEndDragging: Observable<(UIScrollView, Bool)> {
        return rx_delegate.observe(#selector(UIScrollViewDelegate.scrollViewDidEndDragging(_:willDecelerate:)))
            .map {
                return ($0[0] as! UIScrollView, $0[1] as! Bool)
            }
    }
    public var rx_scrollViewDidEndDecelerating: Observable<UIScrollView> {
        return rx_delegate.observe(#selector(UIScrollViewDelegate.scrollViewDidEndDecelerating(_:)))
            .map {
                return $0[0] as! UIScrollView
            }
    }
}
