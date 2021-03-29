//
//  Question.swift
//  multiChoice2021
//
//  Created by Betty Pan on 2021/3/28.
//

import Foundation
import UIKit

struct Question {
    var animalImage:UIImage?
    var animal:Option
}

enum Option:String {
    case Fox, Giraffe, Horse, Koala, Monkey,Lion, Mouse, Pig, Rhino, Tiger, Zebra
}
