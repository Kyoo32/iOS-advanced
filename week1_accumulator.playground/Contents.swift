//: Playground - noun: a place where people can play

import UIKit

func makeAccumulator(initialNum : Double) -> ((Double) -> Double)  {
    var sum  = initialNum
    
    func addNum(number: Double) -> Double
    {
        sum += number
        return sum
    }
    return addNum
}


let x = makeAccumulator(1)
x(5)
x(2.3)

