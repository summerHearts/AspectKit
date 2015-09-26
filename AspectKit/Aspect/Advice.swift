//
//  Advice.swift
//  AspectKit
//
//  Created by Hiromi Motodera on 9/17/15.
//  Copyright (c) 2015 Hiromi Motodera. All rights reserved.
//

import Foundation

public enum AdviceType {
    case Before
    case After
    case Around
}

public typealias AdviceAction = (JoinPoint -> Void)

public class Advice {
    
    var priorityOrdered: Int
    
    var type: AdviceType
    
    var action: AdviceAction
    
    init(type: AdviceType, priorityOrdered: Int = 100, action: AdviceAction) {
        self.priorityOrdered = priorityOrdered
        self.type = type
        self.action = action
    }
}
