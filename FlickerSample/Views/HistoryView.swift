//
//  HistoryView.swift
//  FlickerSample
//
//  Created by Ugur Unlu on 12/5/21.
//

import SwiftUI

struct HistoryView: View {
    let items: [String]
    @Binding var searchText: String
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("Search History")
                    .font(.title)
                Divider()
                ForEach(items, id:\.self) { item in
                    Text(item)
                        .onTapGesture(perform: {
                            searchText =  item
                            presentationMode.wrappedValue.dismiss()
                        })
                }
                Spacer()
            }
        }
        .padding()
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView(items: ["amsterdam", "utrecht", "haag"], searchText: .constant("haag"))
    }
}
