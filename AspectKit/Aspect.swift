//
//  Aspect.swift
//  AspectKit
//
//  Created by Hiromi Motodera on 9/23/15.
//  Copyright (c) 2015 Hiromi Motodera. All rights reserved.
//

import Foundation

public struct Aspect {
    
    public static func weaver(advice advice: Advice, pointcut: Pointcut) {
        
    }
}

public func before(pointcut: Pointcut, priorityOrdered: Int = 100, action: AdviceAction) {
    let advice = Advice(type: .Before, priorityOrdered: priorityOrdered, action: action)
    Aspect.weaver(advice: advice, pointcut: pointcut)
}

public func after(pointcut: Pointcut, priorityOrdered: Int = 100, action: AdviceAction) {
    let advice = Advice(type: .After, priorityOrdered: priorityOrdered, action: action)
    Aspect.weaver(advice: advice, pointcut: pointcut)
}

public func around(pointcut: Pointcut, priorityOrdered: Int = 100, action: AdviceAction) {
    let advice = Advice(type: .Around, priorityOrdered: priorityOrdered, action: action)
    Aspect.weaver(advice: advice, pointcut: pointcut)
}
