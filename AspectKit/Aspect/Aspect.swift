//
//  Aspect.swift
//  AspectKit
//
//  Created by Hiromi Motodera on 9/23/15.
//  Copyright (c) 2015 Hiromi Motodera. All rights reserved.
//

import Foundation

public struct Aspect {
    
    public static func register(advice advice: Advice, pointcut: Pointcut) {
        
    }
    
    public static func weaver() {
        
    }
}

public func before(pointcut pointcut: Pointcut, priorityOrdered: Int = 100, action: AdviceAction) {
    let advice = Advice(type: .Before, priorityOrdered: priorityOrdered, action: action)
    Aspect.register(advice: advice, pointcut: pointcut)
    Aspect.weaver()
}

public func after(pointcut pointcut: Pointcut, priorityOrdered: Int = 100, action: AdviceAction) {
    let advice = Advice(type: .After, priorityOrdered: priorityOrdered, action: action)
    Aspect.register(advice: advice, pointcut: pointcut)
    Aspect.weaver()
}

public func around(pointcut pointcut: Pointcut, priorityOrdered: Int = 100, action: AdviceAction) {
    let advice = Advice(type: .Around, priorityOrdered: priorityOrdered, action: action)
    Aspect.register(advice: advice, pointcut: pointcut)
    Aspect.weaver()
}
