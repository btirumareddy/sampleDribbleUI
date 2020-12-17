//
//  NSObject+Helper.swift
//  Freshservice
//
//  Created by Bhanuja Tirumareddr on 17 /02/19.
//  Copyright © 2019 Freshdesk. All rights reserved.
//

import Foundation

public extension NSObject {
    public class var nameOfClass: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
    
    public var nameOfClass: String {
        return NSStringFromClass(type(of: self)).components(separatedBy: ".").last!
    }
}
