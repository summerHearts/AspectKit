//
//  ASKCocoaRuntimeTests.swift
//  AspectKit
//
//  Created by Hiromi Motodera on 2015/09/17.
//  Copyright (c) 2015 Hiromi Motodera. All rights reserved.
//

import XCTest
@testable import AspectKit

class ASKCocoaRuntimeTests: XCTestCase {
    
    func testClassFromString() {
        XCTAssert(ASKCocoaRuntime.classFromString("NSObject") == NSObject.self)
    }
    
    func testStringFromClass() {
        XCTAssert(ASKCocoaRuntime.stringFromClass(NSString.self) == "NSString")
    }
    
    func testAllClassNames() {
        XCTAssert(ASKCocoaRuntime.allClassNames().count > 4000)
    }
    
    func testAllClassNamesWithFiltered() {
        XCTAssert(ASKCocoaRuntime.allClassNamesWithFiltered(nil).count > 4000)
        XCTAssert(ASKCocoaRuntime.allClassNamesWithFiltered { (className: String) -> Bool in
            return true
        }.count > 4000)
        XCTAssert(ASKCocoaRuntime.allClassNamesWithFiltered { (className: String) -> Bool in
            return false
        }.count == 0)
    }
    
    func testMetaClassWithClass() {
        let clazz = NSString.self
        XCTAssert(ASKCocoaRuntime.metaClassWithClass(clazz) != clazz)
    }
    
    func testRespondsClassToSelector() {
        XCTAssert(ASKCocoaRuntime.respondsClass(NSString.self, toSelector: "characterAtIndex:", method: .Instance))
        XCTAssert(ASKCocoaRuntime.respondsClass(NSString.self, toSelector: "availableStringEncodings", method: .Class))
        XCTAssertFalse(ASKCocoaRuntime.respondsClass(NSString.self, toSelector: "characterAtIndex:", method: .Class))
        XCTAssertFalse(ASKCocoaRuntime.respondsClass(NSString.self, toSelector: "availableStringEncodings", method: .Instance))
    }
}
