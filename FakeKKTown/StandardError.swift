//
//  StandardError.swift
//  FakeKKTown
//
//  Created by Calvin on 6/16/16.
//  Copyright © 2016 CapsLock. All rights reserved.
//

import Foundation

enum StandardError: Int {
    case configError
    
    func toError() -> NSError {
        return NSError(domain: "Standard Error", code: self.rawValue, userInfo: nil)
    }
}
