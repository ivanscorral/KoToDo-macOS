//
//  BindingExtensions.swift
//  KoToDo
//
//  Created by Ivan Sanchez on 10/11/23.
//

import Foundation
import SwiftUI

extension Binding where Value == String {
    /**
     Extends the functionality of a `Binding` whose `Value` type is `String` by limiting the maximum number of characters to the specified `limit`.

     - Parameter limit: The maximum number of characters allowed for the `String` value.
     - Returns: The same `Binding` instance, ensuring that any updates to the `String` value do not exceed the specified `limit`.

     Usage:
     When you have a `Binding<String>` and you want to ensure that the string does not exceed a certain number of characters, you can use this function to enforce the maximum length. Any attempt to set the string to a value longer than `limit` will result in the excess characters being dropped.

     Example:
     
         @State private var text: String = "" var body: some View { TextField("Enter text", text: $text.max(10)) }
     
     In this example, the `TextField` will not allow the user to input more than 10 characters.
     
     It can also be used to limit the number of characters that can be entered in a `TextField` or a `SecureField`:
     
         TextField("Enter text", text: $text.max(10))
         SecureField("Enter password", text: $password.max(10))

     */
    func max(_ limit: Int) -> Self {
        if self.wrappedValue.count > limit {
            DispatchQueue.main.async {
                self.wrappedValue = String(self.wrappedValue.dropLast())
            }
        }
        return self
    }
}
