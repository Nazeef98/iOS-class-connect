import SwiftUI

struct CoursePopup: View {
    @AppStorage("courseCode") private var cCode: String?
    @StateObject private var viewModel = VerifyCourseViewModel()
    @State private var varifyCourseForm: VerifyCourseRequest = VerifyCourseRequest(
        id: "", code: ""
    )
    var course: Course?
    @Binding var showPopup: Bool
    @State private var courseCode = ""
    @State private var codeError: String?
    @State private var showAlert = false
    var onCodeVerification: () -> Void

    func onSubmit () {
        viewModel.errorMessage = ""
        codeError = validateCode(varifyCourseForm.code)
        if codeError == nil {
            varifyCourseForm.id = course?.id ?? ""
            print(varifyCourseForm)
            viewModel.handleVerifyCourse(payload: varifyCourseForm)
        }
    }
    
    func validateCode(_ code: String) -> String? {
        if code.isEmpty {
            return "Course code is required."
        } else if code.count < 4 {
            return "Course code must be at least 4 characters long."
        }
        return nil
    }

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    self.showPopup = false
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                        .padding()
                }
            }
            .background(Color.white)
            
            if let course = course {
                Image("Course")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 150)
                    .padding()
                
                Text(course.title ?? "Title")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom, 10)
                
                Text(course.description ?? "Description")
                    .font(.body)
                    .padding([.leading, .trailing], 20)
                
                VStack(alignment: .leading, spacing: 5) {
                    TextField("Enter course code", text: $varifyCourseForm.code)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .textInputAutocapitalization(.characters)
                    
                    if let codeError = codeError {
                        Text(codeError)
                            .foregroundColor(.red)
                            .font(.caption)
                            .padding(.horizontal, 20)
                    }
                    if let codeError = viewModel.errorMessage {
                        Text(viewModel.errorMessage ?? "")
                            .foregroundColor(.red)
                            .font(.caption)
                            .padding(.horizontal, 20)
                    }
                }

                Button(action: {
                    // Handle submit action
                    onSubmit()
                }) {
                    Text("Submit")
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                }
                .padding(.bottom, 10)
            }
            
            Spacer()
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 10)
        .onReceive(viewModel.$data, perform: { newData in
            if let newData = newData {
                self.cCode = varifyCourseForm.code
                showAlert = true
            }
        })
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Success"),
                message: Text("Code verified Successfully"),
                dismissButton: .default(Text("OK")) {
                    onCodeVerification()
                }
            )
        }
    }
}

#Preview {
    CoursePopup(course: Course(
        createdAt: 1721245086525,
        updatedAt: 1721245086525,
        id: "66981d9e398358c9a51b917c",
        title: "Acupunctur",
        description: "Acupuncture is a form of alternative medicine and a component of traditional Chinese medicine in which thin needles are inserted into the body. Acupuncture is a pseudoscience; the theories and practices of TCM are not based on scientific knowledge, and it has been characterized as quackery"
    ), showPopup: .constant(false), onCodeVerification: {
        print("Code Verified")
    })
}
