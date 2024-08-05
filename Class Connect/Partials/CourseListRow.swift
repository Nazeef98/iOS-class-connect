//
//  CourseListRow.swift
//  Class Connect
//
//  Created by user on 23/07/24.
//

import Foundation
import SwiftUI

struct CourseListRow: View {
    var onListItemTap: (Course) -> Void
    var data: Course
    var body: some View {
        HStack {
            Image("Cicon")
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundColor(.blue)
            VStack(alignment: .leading) {
                Text(data.title ?? "Title")
                    .font(.headline)
                Text(data.description ?? "Description")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(1)
            }
        }
        .padding(.vertical, 5)
        .onTapGesture {
            onListItemTap(data)
        }
    }
}

#Preview {
    CourseListRow(onListItemTap: { course in
        print("Course tapped: \(course.title)")
    },data: Course(
        createdAt: 1721245086525,
        updatedAt: 1721245086525,
        id: "66981d9e398358c9a51b917c",
        title: "Acupuncture",
        description: "Students develop the in-depth theoretical and practical knowledge necessary for acupuncture."
    ))
}
