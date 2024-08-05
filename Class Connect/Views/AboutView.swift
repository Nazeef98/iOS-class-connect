//
//  AboutView.swift
//  Class Connect
//
//  Created by user on 01/08/24.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("About Our App")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top)

            Text("Version 1.0")
                .font(.headline)
                .padding(.bottom, 5)

            Text("This app is designed to provide users with the best experience in ClassConnect. Our goal is to make this app best connection option for the students who are coming to Canada as an international students.")
                .font(.body)
                .padding(.bottom)

            Text("Developer Information")
                .font(.headline)
                .padding(.bottom, 5)

            Text("")
                .font(.body)

            Spacer()
        }
        .padding()
    }
}

#Preview {
    AboutView()
}
