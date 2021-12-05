//
//  ErrorView.swift
//  FlickerSample
//
//  Created by Ugur Unlu on 12/5/21.
//

import SwiftUI

struct ErrorView: View {
    @Binding var isShowing: Bool
    let message: String
    var body: some View {
        if isShowing {
            Group{
                Text(message)
                    .font(.footnote)
                    .frame(maxWidth: .infinity)
                    .modifier(BoxModifier(foregroundColor: .black, lineWidth: 2, backgroundColor: Color.gray.opacity(0.3), strokeColor: .red))
            }
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(isShowing: .constant(true), message: "An error occured")
    }
}
