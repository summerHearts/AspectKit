//
//  ASKCocoaRuntimeTests.swift
//  AspectKit
//
//  Created by Hiromi Motodera on 2015/09/17.
//  Copyright (c) 2015 Hiromi Motodera. All rights reserved.
//

import XCTest
@testable import AspectKit

// MARK: - Define Test Object

class TestNSObject: NSObject {
    
    var property: String = "property"
    public var publicProperty: String = "publicProperty"
    private var privateProperty: String = "privateProperty"
    @objc var objcProperty: String = "objcProperty"
    @objc public var publicObjcProperty: String = "publicObjcProperty"
    @objc private var privateObjcProperty: String = "privateObjcProperty"
    dynamic var dynamicProperty: String = "dynamicProperty"
    dynamic public var publicDynamicProperty: String = "publicDynamicProperty"
    dynamic private var privateDynamicProperty: String = "privateDynamicProperty"
    
    func method() {}
    class func method() {}
    @objc func objcMethod() {}
    @objc class func objcMethod() {}
    dynamic func dynamicMethod() {}
    dynamic class func dynamicMethod() {}
}

public class TestPublicNSObject: NSObject {
    
    var property: String = "property"
    public var publicProperty: String = "publicProperty"
    private var privateProperty: String = "privateProperty"
    @objc var objcProperty: String = "objcProperty"
    @objc public var publicObjcProperty: String = "publicObjcProperty"
    @objc private var privateObjcProperty: String = "privateObjcProperty"
    dynamic var dynamicProperty: String = "dynamicProperty"
    dynamic public var publicDynamicProperty: String = "publicDynamicProperty"
    dynamic private var privateDynamicProperty: String = "privateDynamicProperty"
    
    func method() {}
    class func method() {}
    @objc func objcMethod() {}
    @objc class func objcMethod() {}
    dynamic func dynamicMethod() {}
    dynamic class func dynamicMethod() {}
}

private class TestPrivateNSObject: NSObject {
    
    var property: String = "property"
    public var publicProperty: String = "publicProperty"
    private var privateProperty: String = "privateProperty"
    @objc var objcProperty: String = "objcProperty"
    @objc public var publicObjcProperty: String = "publicObjcProperty"
    @objc private var privateObjcProperty: String = "privateObjcProperty"
    dynamic var dynamicProperty: String = "dynamicProperty"
    dynamic public var publicDynamicProperty: String = "publicDynamicProperty"
    dynamic private var privateDynamicProperty: String = "privateDynamicProperty"
    
    func method() {}
    class func method() {}
    @objc func objcMethod() {}
    @objc class func objcMethod() {}
    dynamic func dynamicMethod() {}
    dynamic class func dynamicMethod() {}
}

class TestSwiftObject {
    
    var property: String = "property"
    public var publicProperty: String = "publicProperty"
    private var privateProperty: String = "privateProperty"
    @objc var objcProperty: String = "objcProperty"
    @objc public var publicObjcProperty: String = "publicObjcProperty"
    @objc private var privateObjcProperty: String = "privateObjcProperty"
    dynamic var dynamicProperty: String = "dynamicProperty"
    dynamic public var publicDynamicProperty: String = "publicDynamicProperty"
    dynamic private var privateDynamicProperty: String = "privateDynamicProperty"
    
    func method() {}
    class func method() {}
    @objc func objcMethod() {}
    @objc class func objcMethod() {}
    dynamic func dynamicMethod() {}
    dynamic class func dynamicMethod() {}
}

public class TestPublicSwiftObject {
    
    var property: String = "property"
    public var publicProperty: String = "publicProperty"
    private var privateProperty: String = "privateProperty"
    @objc var objcProperty: String = "objcProperty"
    @objc public var publicObjcProperty: String = "publicObjcProperty"
    @objc private var privateObjcProperty: String = "privateObjcProperty"
    dynamic var dynamicProperty: String = "dynamicProperty"
    dynamic public var publicDynamicProperty: String = "publicDynamicProperty"
    dynamic private var privateDynamicProperty: String = "privateDynamicProperty"
    
    func method() {}
    class func method() {}
    @objc func objcMethod() {}
    @objc class func objcMethod() {}
    dynamic func dynamicMethod() {}
    dynamic class func dynamicMethod() {}
}

private class TestPrivateSwiftObject {
    
    var property: String = "property"
    public var publicProperty: String = "publicProperty"
    private var privateProperty: String = "privateProperty"
    @objc var objcProperty: String = "objcProperty"
    @objc public var publicObjcProperty: String = "publicObjcProperty"
    @objc private var privateObjcProperty: String = "privateObjcProperty"
    dynamic var dynamicProperty: String = "dynamicProperty"
    dynamic public var publicDynamicProperty: String = "publicDynamicProperty"
    dynamic private var privateDynamicProperty: String = "privateDynamicProperty"
    
    func method() {}
    class func method() {}
    @objc func objcMethod() {}
    @objc class func objcMethod() {}
    dynamic func dynamicMethod() {}
    dynamic class func dynamicMethod() {}
}

class ASKCocoaRuntimeTests: XCTestCase {
    
    // MARK: - Property
    
    // MARK: Pure Objective-C Object
    
    private let pureNSObject = NSObject()
    
    // MARK: Objective-C Subclass Object
    
    private let testNSObject = TestNSObject()
    private let testPublicNSObject = TestPublicNSObject()
    private let testPrivateNSObject = TestPrivateNSObject()
    private let testPrivateNSObjectClassName = "_TtC14AspectKitTestsP33_0416FFE131765324BF1E1EF21FBCF06A19TestPrivateNSObject"
    
    // MARK: Pure Swift Object
    
    private let testSwiftObject = TestSwiftObject()
    private let testPublicSwiftObject = TestPublicSwiftObject()
    private let testPrivateSwiftObject = TestPrivateSwiftObject()
    private let testPrivateSwiftObjectClassName = "_TtC14AspectKitTestsP33_0416FFE131765324BF1E1EF21FBCF06A22TestPrivateSwiftObject"
    
    // MARK: - TestCase
    
    func testClassFromString() {
        // compare class
        XCTAssert(ASKCocoaRuntime.classFromString("NSObject") == NSObject.self)
        XCTAssert(ASKCocoaRuntime.classFromString("AspectKitTests.TestNSObject") == TestNSObject.self)
        XCTAssert(ASKCocoaRuntime.classFromString("AspectKitTests.TestPublicNSObject") == TestPublicNSObject.self)
        XCTAssertFalse(ASKCocoaRuntime.classFromString("AspectKitTests.TestPrivateNSObject") == TestPrivateNSObject.self)
        XCTAssert(ASKCocoaRuntime.classFromString(self.testPrivateNSObjectClassName) == TestPrivateNSObject.self)
        XCTAssert(ASKCocoaRuntime.classFromString("AspectKitTests.TestSwiftObject") == TestSwiftObject.self)
        XCTAssert(ASKCocoaRuntime.classFromString("AspectKitTests.TestPublicSwiftObject") == TestPublicSwiftObject.self)
        XCTAssertFalse(ASKCocoaRuntime.classFromString("AspectKitTests.TestPrivateSwiftObject") == TestPrivateSwiftObject.self)
        XCTAssert(ASKCocoaRuntime.classFromString(self.testPrivateSwiftObjectClassName) == TestPrivateSwiftObject.self)
        
        // compare instance
        XCTAssert(ASKCocoaRuntime.classFromString("NSObject") == self.pureNSObject.dynamicType)
        XCTAssert(ASKCocoaRuntime.classFromString("AspectKitTests.TestNSObject") == self.testNSObject.dynamicType)
        XCTAssert(ASKCocoaRuntime.classFromString("AspectKitTests.TestPublicNSObject") == self.testPublicNSObject.dynamicType)
        XCTAssertFalse(ASKCocoaRuntime.classFromString("AspectKitTests.TestPrivateNSObject") == self.testPrivateNSObject.dynamicType)
        XCTAssert(ASKCocoaRuntime.classFromString("AspectKitTests.TestSwiftObject") == self.testSwiftObject.dynamicType)
        XCTAssert(ASKCocoaRuntime.classFromString("AspectKitTests.TestPublicSwiftObject") == self.testPublicSwiftObject.dynamicType)
        XCTAssertFalse(ASKCocoaRuntime.classFromString("AspectKitTests.TestPrivateSwiftObject") == self.testPrivateSwiftObject.dynamicType)
    }
    
    func testStringFromClass() {
        // compare class
        XCTAssert(ASKCocoaRuntime.stringFromClass(NSObject.self) == "NSObject")
        XCTAssert(ASKCocoaRuntime.stringFromClass(TestNSObject.self) == "AspectKitTests.TestNSObject")
        XCTAssert(ASKCocoaRuntime.stringFromClass(TestPublicNSObject.self) == "AspectKitTests.TestPublicNSObject")
        XCTAssertFalse(ASKCocoaRuntime.stringFromClass(TestPrivateNSObject.self) == "AspectKitTests.TestPrivateNSObject")
        XCTAssert(ASKCocoaRuntime.stringFromClass(TestPrivateNSObject.self) == self.testPrivateNSObjectClassName)
        XCTAssert(ASKCocoaRuntime.stringFromClass(TestSwiftObject.self) == "AspectKitTests.TestSwiftObject")
        XCTAssert(ASKCocoaRuntime.stringFromClass(TestPublicSwiftObject.self) == "AspectKitTests.TestPublicSwiftObject")
        XCTAssertFalse(ASKCocoaRuntime.stringFromClass(TestPrivateSwiftObject.self) == "AspectKitTests.TestPrivateSwiftObject")
        XCTAssert(ASKCocoaRuntime.stringFromClass(TestPrivateSwiftObject.self) == self.testPrivateSwiftObjectClassName)
        
        // compare instance
        XCTAssert(ASKCocoaRuntime.stringFromClass(self.pureNSObject.dynamicType) == "NSObject")
        XCTAssert(ASKCocoaRuntime.stringFromClass(self.testNSObject.dynamicType) == "AspectKitTests.TestNSObject")
        XCTAssert(ASKCocoaRuntime.stringFromClass(self.testPublicNSObject.dynamicType) == "AspectKitTests.TestPublicNSObject")
        XCTAssertFalse(ASKCocoaRuntime.stringFromClass(self.testPrivateNSObject.dynamicType) == "AspectKitTests.TestPrivateNSObject")
        XCTAssert(ASKCocoaRuntime.stringFromClass(self.testPrivateNSObject.dynamicType) == self.testPrivateNSObjectClassName)
        XCTAssert(ASKCocoaRuntime.stringFromClass(self.testSwiftObject.dynamicType) == "AspectKitTests.TestSwiftObject")
        XCTAssert(ASKCocoaRuntime.stringFromClass(self.testPublicSwiftObject.dynamicType) == "AspectKitTests.TestPublicSwiftObject")
        XCTAssertFalse(ASKCocoaRuntime.stringFromClass(self.testPrivateSwiftObject.dynamicType) ==  "AspectKitTests.TestPrivateSwiftObject")
        XCTAssert(ASKCocoaRuntime.stringFromClass(self.testPrivateSwiftObject.dynamicType) == self.testPrivateSwiftObjectClassName)
    }
    
    func testAllClassNames() {
        let allClassNames = ASKCocoaRuntime.allClassNames()
        XCTAssert(allClassNames.count > 0)
        XCTAssert(allClassNames.contains(ASKCocoaRuntime.stringFromClass(NSObject.self)))
        XCTAssert(allClassNames.contains(ASKCocoaRuntime.stringFromClass(TestNSObject.self)))
        XCTAssert(allClassNames.contains(ASKCocoaRuntime.stringFromClass(TestPublicNSObject.self)))
        XCTAssert(allClassNames.contains(ASKCocoaRuntime.stringFromClass(TestPrivateNSObject.self)))
        XCTAssert(allClassNames.contains(ASKCocoaRuntime.stringFromClass(TestSwiftObject.self)))
        XCTAssert(allClassNames.contains(ASKCocoaRuntime.stringFromClass(TestPublicSwiftObject.self)))
        XCTAssert(allClassNames.contains(ASKCocoaRuntime.stringFromClass(TestPrivateSwiftObject.self)))
    }
    
    func testAllClassNamesWithFiltered() {
        XCTAssert(ASKCocoaRuntime.allClassNamesWithFiltered(nil).count > 0)
        XCTAssert(ASKCocoaRuntime.allClassNamesWithFiltered { (className: String) -> Bool in
            return true
        }.count > 0)
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
        let testNSObjectProperties = ASKCocoaRuntime.propertyNamesWithClass(TestNSObject.self)
        XCTAssertFalse(testNSObjectProperties.count == 9)
        XCTAssert(testNSObjectProperties.count == 8)
        XCTAssert(testNSObjectProperties.contains("property"))
        XCTAssert(testNSObjectProperties.contains("publicProperty"))
        XCTAssertFalse(testNSObjectProperties.contains("privateProperty"))
        XCTAssert(testNSObjectProperties.contains("objcProperty"))
        XCTAssert(testNSObjectProperties.contains("publicObjcProperty"))
        XCTAssert(testNSObjectProperties.contains("privateObjcProperty"))
        XCTAssert(testNSObjectProperties.contains("dynamicProperty"))
        XCTAssert(testNSObjectProperties.contains("publicDynamicProperty"))
        XCTAssert(testNSObjectProperties.contains("privateDynamicProperty"))
        
        let testPublicNSObjectProperties = ASKCocoaRuntime.propertyNamesWithClass(TestPublicNSObject.self)
        XCTAssertFalse(testPublicNSObjectProperties.count == 9)
        XCTAssert(testPublicNSObjectProperties.count == 8)
        XCTAssert(testPublicNSObjectProperties.contains("property"))
        XCTAssert(testPublicNSObjectProperties.contains("publicProperty"))
        XCTAssertFalse(testPublicNSObjectProperties.contains("privateProperty"))
        XCTAssert(testPublicNSObjectProperties.contains("objcProperty"))
        XCTAssert(testPublicNSObjectProperties.contains("publicObjcProperty"))
        XCTAssert(testPublicNSObjectProperties.contains("privateObjcProperty"))
        XCTAssert(testPublicNSObjectProperties.contains("dynamicProperty"))
        XCTAssert(testPublicNSObjectProperties.contains("publicDynamicProperty"))
        XCTAssert(testPublicNSObjectProperties.contains("privateDynamicProperty"))
        
        let testPrivateNSObjectProperties = ASKCocoaRuntime.propertyNamesWithClass(TestPrivateNSObject.self)
        XCTAssertFalse(testPrivateNSObjectProperties.count == 9)
        XCTAssert(testPrivateNSObjectProperties.count == 7)
        XCTAssertFalse(testPrivateNSObjectProperties.contains("property"))
        XCTAssert(testPrivateNSObjectProperties.contains("publicProperty"))
        XCTAssertFalse(testPrivateNSObjectProperties.contains("privateProperty"))
        XCTAssert(testPrivateNSObjectProperties.contains("objcProperty"))
        XCTAssert(testPrivateNSObjectProperties.contains("publicObjcProperty"))
        XCTAssert(testPrivateNSObjectProperties.contains("privateObjcProperty"))
        XCTAssert(testPrivateNSObjectProperties.contains("dynamicProperty"))
        XCTAssert(testPrivateNSObjectProperties.contains("publicDynamicProperty"))
        XCTAssert(testPrivateNSObjectProperties.contains("privateDynamicProperty"))
        
        let testSwiftObjectProperties = ASKCocoaRuntime.propertyNamesWithClass(TestSwiftObject.self)
        XCTAssertFalse(testSwiftObjectProperties.count == 9)
        XCTAssert(testSwiftObjectProperties.count == 6)
        XCTAssertFalse(testSwiftObjectProperties.contains("property"))
        XCTAssertFalse(testSwiftObjectProperties.contains("publicProperty"))
        XCTAssertFalse(testSwiftObjectProperties.contains("privateProperty"))
        XCTAssert(testSwiftObjectProperties.contains("objcProperty"))
        XCTAssert(testSwiftObjectProperties.contains("publicObjcProperty"))
        XCTAssert(testSwiftObjectProperties.contains("privateObjcProperty"))
        XCTAssert(testSwiftObjectProperties.contains("dynamicProperty"))
        XCTAssert(testSwiftObjectProperties.contains("publicDynamicProperty"))
        XCTAssert(testSwiftObjectProperties.contains("privateDynamicProperty"))
        
        let testPublicSwiftObjectProperties = ASKCocoaRuntime.propertyNamesWithClass(TestPublicSwiftObject.self)
        XCTAssertFalse(testPublicSwiftObjectProperties.count == 9)
        XCTAssert(testPublicSwiftObjectProperties.count == 6)
        XCTAssertFalse(testPublicSwiftObjectProperties.contains("property"))
        XCTAssertFalse(testPublicSwiftObjectProperties.contains("publicProperty"))
        XCTAssertFalse(testPublicSwiftObjectProperties.contains("privateProperty"))
        XCTAssert(testPublicSwiftObjectProperties.contains("objcProperty"))
        XCTAssert(testPublicSwiftObjectProperties.contains("publicObjcProperty"))
        XCTAssert(testPublicSwiftObjectProperties.contains("privateObjcProperty"))
        XCTAssert(testPublicSwiftObjectProperties.contains("dynamicProperty"))
        XCTAssert(testPublicSwiftObjectProperties.contains("publicDynamicProperty"))
        XCTAssert(testPublicSwiftObjectProperties.contains("privateDynamicProperty"))
        
        let testPrivateSwiftObjectProperties = ASKCocoaRuntime.propertyNamesWithClass(TestPrivateSwiftObject.self)
        XCTAssertFalse(testPrivateSwiftObjectProperties.count == 9)
        XCTAssert(testPrivateSwiftObjectProperties.count == 6)
        XCTAssertFalse(testPrivateSwiftObjectProperties.contains("property"))
        XCTAssertFalse(testPrivateSwiftObjectProperties.contains("publicProperty"))
        XCTAssertFalse(testPrivateSwiftObjectProperties.contains("privateProperty"))
        XCTAssert(testPrivateSwiftObjectProperties.contains("objcProperty"))
        XCTAssert(testPrivateSwiftObjectProperties.contains("publicObjcProperty"))
        XCTAssert(testPrivateSwiftObjectProperties.contains("privateObjcProperty"))
        XCTAssert(testPrivateSwiftObjectProperties.contains("dynamicProperty"))
        XCTAssert(testPrivateSwiftObjectProperties.contains("publicDynamicProperty"))
        XCTAssert(testPrivateSwiftObjectProperties.contains("privateDynamicProperty"))
    }
    
    func testSelectorWithSelectorPrefix() {
        let prefixSelector = ASKCocoaRuntime.selectorWithSelector("test", prefix: "ask")
        XCTAssert(prefixSelector == "asktest")
    }
    
    func testSelectorIsEqualToSelector() {
        let selector1: Selector = "selector"
        let selector2: Selector = "selector"
        XCTAssert(ASKCocoaRuntime.selector(selector1, isEqualToSelector: selector2))
    }
    
    func testObjcTypeEncodingWithClass() {
        let voidToVoidMethodEncoding = "v16@0:8"
        XCTAssert(ASKCocoaRuntime.objcTypeEncodingWithClass(TestNSObject.self, selector: "method", method: .Instance) == voidToVoidMethodEncoding)
        XCTAssert(ASKCocoaRuntime.objcTypeEncodingWithClass(TestNSObject.self, selector: "method", method: .Class) == voidToVoidMethodEncoding)
        XCTAssert(ASKCocoaRuntime.objcTypeEncodingWithClass(TestNSObject.self, selector: "objcMethod", method: .Instance) == voidToVoidMethodEncoding)
        XCTAssert(ASKCocoaRuntime.objcTypeEncodingWithClass(TestNSObject.self, selector: "objcMethod", method: .Class) == voidToVoidMethodEncoding)
        XCTAssert(ASKCocoaRuntime.objcTypeEncodingWithClass(TestNSObject.self, selector: "dynamicMethod", method: .Instance) == voidToVoidMethodEncoding)
        XCTAssert(ASKCocoaRuntime.objcTypeEncodingWithClass(TestNSObject.self, selector: "dynamicMethod", method: .Class) == voidToVoidMethodEncoding)
        
        XCTAssert(ASKCocoaRuntime.objcTypeEncodingWithClass(TestPublicNSObject.self, selector: "method", method: .Instance) == voidToVoidMethodEncoding)
        XCTAssert(ASKCocoaRuntime.objcTypeEncodingWithClass(TestPublicNSObject.self, selector: "method", method: .Class) == voidToVoidMethodEncoding)
        XCTAssert(ASKCocoaRuntime.objcTypeEncodingWithClass(TestPublicNSObject.self, selector: "objcMethod", method: .Instance) == voidToVoidMethodEncoding)
        XCTAssert(ASKCocoaRuntime.objcTypeEncodingWithClass(TestPublicNSObject.self, selector: "objcMethod", method: .Class) == voidToVoidMethodEncoding)
        XCTAssert(ASKCocoaRuntime.objcTypeEncodingWithClass(TestPublicNSObject.self, selector: "dynamicMethod", method: .Instance) == voidToVoidMethodEncoding)
        XCTAssert(ASKCocoaRuntime.objcTypeEncodingWithClass(TestPublicNSObject.self, selector: "dynamicMethod", method: .Class) == voidToVoidMethodEncoding)
        
        XCTAssertNil(ASKCocoaRuntime.objcTypeEncodingWithClass(TestPrivateNSObject.self, selector: "method", method: .Instance))
        XCTAssertNil(ASKCocoaRuntime.objcTypeEncodingWithClass(TestPrivateNSObject.self, selector: "method", method: .Class))
        XCTAssert(ASKCocoaRuntime.objcTypeEncodingWithClass(TestPrivateNSObject.self, selector: "objcMethod", method: .Instance) == voidToVoidMethodEncoding)
        XCTAssert(ASKCocoaRuntime.objcTypeEncodingWithClass(TestPrivateNSObject.self, selector: "objcMethod", method: .Class) == voidToVoidMethodEncoding)
        XCTAssert(ASKCocoaRuntime.objcTypeEncodingWithClass(TestPrivateNSObject.self, selector: "dynamicMethod", method: .Instance) == voidToVoidMethodEncoding)
        XCTAssert(ASKCocoaRuntime.objcTypeEncodingWithClass(TestPrivateNSObject.self, selector: "dynamicMethod", method: .Class) == voidToVoidMethodEncoding)
        
        XCTAssertNil(ASKCocoaRuntime.objcTypeEncodingWithClass(TestSwiftObject.self, selector: "method", method: .Instance))
        XCTAssertNil(ASKCocoaRuntime.objcTypeEncodingWithClass(TestSwiftObject.self, selector: "method", method: .Class))
        XCTAssert(ASKCocoaRuntime.objcTypeEncodingWithClass(TestSwiftObject.self, selector: "objcMethod", method: .Instance) == voidToVoidMethodEncoding)
        XCTAssert(ASKCocoaRuntime.objcTypeEncodingWithClass(TestSwiftObject.self, selector: "objcMethod", method: .Class) == voidToVoidMethodEncoding)
        XCTAssert(ASKCocoaRuntime.objcTypeEncodingWithClass(TestSwiftObject.self, selector: "dynamicMethod", method: .Instance) == voidToVoidMethodEncoding)
        XCTAssert(ASKCocoaRuntime.objcTypeEncodingWithClass(TestSwiftObject.self, selector: "dynamicMethod", method: .Class) == voidToVoidMethodEncoding)
        
        XCTAssertNil(ASKCocoaRuntime.objcTypeEncodingWithClass(TestPublicSwiftObject.self, selector: "method", method: .Instance))
        XCTAssertNil(ASKCocoaRuntime.objcTypeEncodingWithClass(TestPublicSwiftObject.self, selector: "method", method: .Class))
        XCTAssert(ASKCocoaRuntime.objcTypeEncodingWithClass(TestPublicSwiftObject.self, selector: "objcMethod", method: .Instance) == voidToVoidMethodEncoding)
        XCTAssert(ASKCocoaRuntime.objcTypeEncodingWithClass(TestPublicSwiftObject.self, selector: "objcMethod", method: .Class) == voidToVoidMethodEncoding)
        XCTAssert(ASKCocoaRuntime.objcTypeEncodingWithClass(TestPublicSwiftObject.self, selector: "dynamicMethod", method: .Instance) == voidToVoidMethodEncoding)
        XCTAssert(ASKCocoaRuntime.objcTypeEncodingWithClass(TestPublicSwiftObject.self, selector: "dynamicMethod", method: .Class) == voidToVoidMethodEncoding)
        
        XCTAssertNil(ASKCocoaRuntime.objcTypeEncodingWithClass(TestPrivateSwiftObject.self, selector: "method", method: .Instance))
        XCTAssertNil(ASKCocoaRuntime.objcTypeEncodingWithClass(TestPrivateSwiftObject.self, selector: "method", method: .Class))
        XCTAssert(ASKCocoaRuntime.objcTypeEncodingWithClass(TestPrivateSwiftObject.self, selector: "objcMethod", method: .Instance) == voidToVoidMethodEncoding)
        XCTAssert(ASKCocoaRuntime.objcTypeEncodingWithClass(TestPrivateSwiftObject.self, selector: "objcMethod", method: .Class) == voidToVoidMethodEncoding)
        XCTAssert(ASKCocoaRuntime.objcTypeEncodingWithClass(TestPrivateSwiftObject.self, selector: "dynamicMethod", method: .Instance) == voidToVoidMethodEncoding)
        XCTAssert(ASKCocoaRuntime.objcTypeEncodingWithClass(TestPrivateSwiftObject.self, selector: "dynamicMethod", method: .Class) == voidToVoidMethodEncoding)
    }
    
    func testRootResponseClassWithClass() {
        XCTAssert(ASKCocoaRuntime.rootResponseClassWithClass(NSObject.self, selector: "methodForSelector:", method: .Instance) == NSObject.self)
        XCTAssert(ASKCocoaRuntime.rootResponseClassWithClass(TestNSObject.self, selector: "methodForSelector:", method: .Instance) == NSObject.self)
        XCTAssert(ASKCocoaRuntime.rootResponseClassWithClass(TestPublicNSObject.self, selector: "methodForSelector:", method: .Instance) == NSObject.self)
        XCTAssert(ASKCocoaRuntime.rootResponseClassWithClass(TestPrivateNSObject.self, selector: "methodForSelector:", method: .Instance) == NSObject.self)
        
        XCTAssert(ASKCocoaRuntime.rootResponseClassWithClass(NSString.self, selector: "methodForSelector:", method: .Instance) == NSObject.self)
        
        XCTAssertNil(ASKCocoaRuntime.rootResponseClassWithClass(TestSwiftObject.self, selector: "method", method: .Instance))
        XCTAssert(ASKCocoaRuntime.rootResponseClassWithClass(TestSwiftObject.self, selector: "objcMethod", method: .Instance) == TestSwiftObject.self)
        XCTAssert(ASKCocoaRuntime.rootResponseClassWithClass(TestSwiftObject.self, selector: "dynamicMethod", method: .Instance) == TestSwiftObject.self)
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
