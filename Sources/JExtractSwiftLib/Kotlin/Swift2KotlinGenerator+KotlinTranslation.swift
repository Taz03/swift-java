//
//  Swift2KotlinGenerator+KotlinTranslation.swift
//  swift-java
//
//  Created by Tanish Azad on 12/04/26.
//

extension Swift2KotlinGenerator {
  enum OverflowCheckType {
    case none
    case signedInt // Int: -2147483648 to 2147483647
    case unsignedInt // UInt: 0 to 4294967295
  }
  
  func translateType(swiftType: SwiftType, isNullable: Bool) -> KotlinType {
    switch swiftType {
    case .nominal(let nominalSwiftType):
      if let swiftKnownType = nominalSwiftType.asKnownType {
        switch swiftKnownType {
        case .bool:
          return .nominal(name: "Boolean", isNullable: false)
        case .int:
          return .nominal(name: "Int", isNullable: isNullable)
        case .uint:
          return .nominal(name: "UInt", isNullable: isNullable)
        case .int8:
          return .nominal(name: "Byte", isNullable: isNullable)
        case .uint8:
          return .nominal(name: "UByte", isNullable: isNullable)
        case .int16:
          return .nominal(name: "Short", isNullable: isNullable)
        case .uint16:
          return .nominal(name: "UShort", isNullable: isNullable)
        case .int32:
          return .nominal(name: "Int", isNullable: isNullable)
        case .uint32:
          return .nominal(name: "UInt", isNullable: isNullable)
        case .int64:
          return .nominal(name: "Long", isNullable: isNullable)
        case .uint64:
          return .nominal(name: "ULong", isNullable: isNullable)
        case .float:
          return .nominal(name: "Float", isNullable: isNullable)
        case .double:
          return .nominal(name: "Double", isNullable: isNullable)
       case .optional(let inner):
          return translateType(swiftType: inner, isNullable: true)
        case .void:
          return .nominal(name: "Unit", isNullable: isNullable)
        case .string:
          return .nominal(name: "String", isNullable: isNullable)
        case .array(let elementsType):
          return .generic(
            name: "Array",
            genericTypes: [
              translateType(swiftType: elementsType, isNullable: false)
            ],
            isNullable: isNullable
          )
        case .dictionary(let keyType, let valueType):
          return .generic(
            name: "Map",
            genericTypes: [
              translateType(swiftType: keyType, isNullable: false),
              translateType(swiftType: valueType, isNullable: false)
            ],
            isNullable: isNullable
          )
        case .set(let elementsType):
          return .generic(
            name: "Set",
            genericTypes: [
              translateType(swiftType: elementsType, isNullable: false)
            ],
            isNullable: isNullable
          )
        default:
          break
       }
      }
    case .function(let functionType):
      let resultTy = translateType(swiftType: functionType.resultType, isNullable: false)
      let parameters = functionType.parameters.map { translateType(swiftType: $0.type, isNullable: false) }
      
      return .function(
        resultType: resultTy,
        parameters: parameters,
        variadic: false,
        isNullable: isNullable
      )
    default:
      break
    }
    
    return .nominal(name: "Any", isNullable: false)
  }
}
