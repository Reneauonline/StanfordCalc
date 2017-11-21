//
//  CalculatorBrain.swift
//  StanfordCalc
//
//  Created by Robert Reneau on 11/18/17.
//  Copyright © 2017 Robert Reneau. All rights reserved.
//

import Foundation

func changeSign(Operand: Double)-> Double{
    return -Operand
}



struct CalculatorBrain {
    
    private var accumulator: Double?
    private var events :String = ""
    private var resultIsPending :Bool = false
    
    private enum Operation{
        case constant (Double)
        case unaryOperation((Double) ->Double)
        case binaryOperation ((Double,Double) -> Double)
       case equals
    }
    
    private var operations : Dictionary <String,Operation> = [
        "π": Operation.constant(Double.pi),
        "e": Operation.constant(M_E),
        
        "√": Operation.unaryOperation(sqrt),
        "cos": Operation.unaryOperation(cos),
        "±" : Operation.unaryOperation(changeSign),
        
        "×": Operation.binaryOperation({$0 * $1}),
        "+": Operation.binaryOperation({$0 + $1}),
        "−": Operation.binaryOperation({$0 - $1}),
        "÷": Operation.binaryOperation({$0 / $1}),
        "=" : Operation.equals
    
    ]
    
    private var pbo : PendingBinaryOperation?
    
    mutating func performOperation(_ symbol: String){
        if let operation = operations[symbol]{
            
            switch operation {
            case .constant (let value):
                accumulator = value
            case .unaryOperation (let function):
                if accumulator != nil {
                    accumulator=function(accumulator!)
                }
            case .binaryOperation(let function):
                if accumulator != nil{
                pbo = PendingBinaryOperation(function: function, firstOperand: accumulator!)
                accumulator = nil
                    
                    if symbol != "equals"{ events += symbol+" "
                    }
                    
                    
                }
            case .equals:
                performPPendingBinaryOperation()
            }
        }
    }
    
    private mutating func performPPendingBinaryOperation(){
        if pbo != nil && accumulator != nil {
            accumulator = pbo!.perform(with: accumulator!)
            pbo = nil
        }
    }
    
private struct PendingBinaryOperation {
        let function : (Double,Double) ->Double
        let firstOperand : Double
        
        func perform(with secondOperand : Double)-> Double{
            return function(firstOperand,secondOperand)
        }
    }
    
    
    mutating func setOperand (_ operand: Double){
        
        accumulator = operand
        events=events + String(operand)
        
    }
    
    
    
    var result: Double?  {
        get {
            var RoundAccumulator :Double?  = nil
            if accumulator != nil { RoundAccumulator = Double(round(10000 * accumulator!)/10000)}
          //  return accumulator
          return RoundAccumulator
        }
    }
    
    
    
}
