//
//  Swift2KotlinGenerator+KotlinBindingsPrinting.swift
//  swift-java
//
//  Created by Tanish Azad on 02/04/26.
//

import CodePrinting

extension Swift2KotlinGenerator {
  /// Print the calling body that forwards all the parameters to the `methodName`,
  package func printKotlinBindingPlaceholder(
    _ printer: inout CodePrinter,
    _ decl: ImportedFunc,
  ) {
    // let translated = self.translatedDecl(for: decl)!
    let methodName = decl.name
    
    // let translatedSignature = translated.translatedSignature
    let returnTy = decl.functionSignature.result.type.asNominalTypeDeclaration?.name ?? "Unit"

    // var annotationsStr = translatedSignature.annotations.map({ $0.render() }).joined(separator: "\n")
    // if !annotationsStr.isEmpty { annotationsStr += "\n" }

    let paramDecls = decl.functionSignature.parameters.map { param in
      (param.parameterName ?? "name") + ": " + (param.type.asNominalTypeDeclaration?.name ?? "Unit")
    }
    
    var documentation = SwiftDocumentationParser.parse(decl.swiftDecl)
    
    TranslatedDocumentation.printDocumentation(
      documentation,
      syntax: decl.swiftDecl,
      in: &printer,
    )
    printer.printBraceBlock(
      """
      fun \(methodName)(\(paramDecls.joined(separator: ", "))): \(returnTy)
      """
    ) { printer in
      printer.print("TODO(\"Not implemented\")")
    }
  }
}
