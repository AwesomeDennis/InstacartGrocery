//
//  IGUtil.swift
//  InstacartGrocery
//
//  Created by DingXiao on 2017/8/18.
//  Copyright © 2017年 AwesomeDennis. All rights reserved.
//

import UIKit


public func IGLog<T>(_ message: T, file: String = #file, method: String = #function,line: Int = #line) {
    #if DEBUG
        print("\((file as NSString).lastPathComponent)[line:\(line)], \(method): \(message)")
    #endif
}

extension Float {
    func format(_ f: String) -> String {
        return NSString(format: "%0.1f", self) as String
    }
}

