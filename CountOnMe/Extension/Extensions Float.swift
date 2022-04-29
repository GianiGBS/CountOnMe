//
//  Extensions Float.swift
//  CountOnMe
//
//  Created by Giovanni Gabriel on 26/04/2022.
//  Copyright © 2022 Vincent Saluzzo. All rights reserved.
//

extension Float {
    var clean: String {
       return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
