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
        XCTAssert(ASKCocoaRuntime.classFromString("NSObject")! == NSObject.self)
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
    
    func testSuperClassWithClass() {
        let stringClazz: AnyClass = NSString.self
        let stringSuperClazz: AnyClass = ASKCocoaRuntime.superClassWithClass(stringClazz)!
        XCTAssertFalse(stringClazz == stringSuperClazz)
        XCTAssert(ASKCocoaRuntime.stringFromClass(stringSuperClazz) == "NSObject")
        let objectSuperClazz: AnyClass? = ASKCocoaRuntime.superClassWithClass(NSObject.self)
        XCTAssert(objectSuperClazz == nil)
    }
    
    func testMetaClassWithClass() {
        let clazz: AnyClass = NSObject.self
        let metaClazz: AnyClass = ASKCocoaRuntime.metaClassWithClass(clazz)
        XCTAssertFalse(clazz == metaClazz)
        XCTAssert(ASKCocoaRuntime.stringFromClass(clazz) == ASKCocoaRuntime.stringFromClass(metaClazz))
    }
    
    func testRespondsClassToSelector() {
        XCTAssert(ASKCocoaRuntime.respondsClass(NSString.self, toSelector: "characterAtIndex:", method: .Instance))
        XCTAssertFalse(ASKCocoaRuntime.respondsClass(NSString.self, toSelector: "characterAtIndex:", method: .Class))
        XCTAssert(ASKCocoaRuntime.respondsClass(NSString.self, toSelector: "availableStringEncodings", method: .Class))
        XCTAssertFalse(ASKCocoaRuntime.respondsClass(NSString.self, toSelector: "availableStringEncodings", method: .Instance))
    }
    
    func testPropertyNamesWithClass() {
        XCTFail()
    }
    
    func testSelectorWithSelector() {
        XCTFail()
    }
    
    func testSelectorIsEqualToSelector() {
        XCTFail()
    }
    
    func testObjcTypeEncodingWithClass() {
        XCTFail()
    }
    
    func testRootResponseClassWithClass() {
        XCTFail()
    }
    
    func testMethodSignatureWithClass() {
        XCTFail()
    }
    
    func testOverwriteForClass() {
        XCTFail()
    }
    
    func testOverwriteMessageForwardForClass() {
        XCTFail()
    }
    
    func testCopyMethodForClass() {
        XCTFail()
    }
    
    func testExchangeImplementationsForClass() {
        XCTFail()
    }
    
    func testAddMethodForClass() {
        XCTFail()
    }
}
