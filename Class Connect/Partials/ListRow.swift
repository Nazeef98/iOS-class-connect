//
//  ListRow.swift
//  Class Connect
//
//  Created by user on 22/07/24.
//

import SwiftUI

struct ListRow: View {
    var index: Int
    var user: Profile
    var body: some View {
        HStack{
            Text("\(index+1)")
                .frame(maxWidth: 50)
            Text(user.name!)
            Spacer()
            Text(user.country!)
        }
//        .padding()
//        .border(.purple)
    }
}

#Preview {
    ListRow(index: 1, user: Profile(
        createdAt: 1,
        updatedAt: 1,
        id: "1",
        name: "Nazeef",
        phone: "98798798790",
        email: "nazeef@gmail.com",
        address: "",
        city: "",
        state: "",
        zip: "",
        country: "India",
        accommodation: true,
        courseCode: "ACPT",
        user: ""
    ))
}
