//
//  KotlinType.swift
//  swift-java
//
//  Created by Tanish Azad on 17/04/26.
//

enum KotlinType {
  case nominal(name: String, isNullable: Bool = false)
  indirect case generic(name: String, genericTypes: [KotlinType], isNullable: Bool = false)
  indirect case function(resultType: KotlinType, parameters: [KotlinType], variadic: Bool, isNullable: Bool = false)
  
  var description: String {
    switch self {
    case .nominal(let name, let isNullable):
      return name + (isNullable ? "?" : "")
      
    case .generic(let name, let genericTypes, let isNullable):
      let genericList = genericTypes.map{ $0.description }.joined(separator: ", ")
      return "\(name)<\(genericList)>\(isNullable ? "?" : "")"
      
    case .function(let resultType, let parameters, let variadic, let isNullable):
      if isNullable {
        return "((\(parameters.map { $0.description }.joined(separator: ", "))) -> \(resultType.description))?"
      }
      
      return "(\(parameters.map { $0.description }.joined(separator: ", "))) -> \(resultType.description)"
    }
  }
}
