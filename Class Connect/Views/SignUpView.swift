import SwiftUI

struct SignUpView: View {
    @Environment(\.presentationMode) var presentationMode
    @AppStorage("userId") private var userId: String?
    @AppStorage("userName") private var userName: String?
    @AppStorage("token") private var token: String?
    @StateObject private var viewModel = SignUpViewModel()
    @State private var signUpSuccessAlert = false
    @State private var signUpForm: SignUpRequest = SignUpRequest(
        email: "",
        firstName: "",
        lastName: "",
        contactNumber: "",
        password: "",
        confirmPassword: ""
    )
    @State private var errorMessage: String? = nil

    func handleSignUp() {
        // Reset the error message
        errorMessage = nil

        // Check for empty fields
        if signUpForm.email.isEmpty {
            errorMessage = "Email address is required"
        } else if signUpForm.firstName.isEmpty {
            errorMessage = "First name is required"
        } else if signUpForm.lastName.isEmpty {
            errorMessage = "Last name is required"
        } else if signUpForm.contactNumber.isEmpty {
            errorMessage = "Contact number is required"
        } else if signUpForm.password.isEmpty {
            errorMessage = "Password is required"
        } else if signUpForm.confirmPassword.isEmpty {
            errorMessage = "Confirm password is required"
        } else if signUpForm.password != signUpForm.confirmPassword {
            errorMessage = "Passwords do not match"
        }

        // If there's an error, return early
        if let errorMessage = errorMessage {
            print(errorMessage)
            return
        }

        // Proceed with sign up if all fields are valid
        viewModel.handleSignUp(payload: signUpForm)
    }
    func onSignUpSuccess() {
        print("SignUp Success")
        signUpSuccessAlert = true
    }

    var body: some View {
        VStack {
            Spacer()
                    
            Text("Sign Up")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 40)
            
            Group {
                TextField("Email address", text: $signUpForm.email)
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)
                    .keyboardType(.emailAddress)
                
                TextField("First name", text: $signUpForm.firstName)
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)
                
                TextField("Last name", text: $signUpForm.lastName)
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)
                
                TextField("Contact", text: $signUpForm.contactNumber)
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)
                    .keyboardType(UIKeyboardType.numberPad)
                
                SecureField("Password", text: $signUpForm.password)
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)
                
                SecureField("Confirm Password", text: $signUpForm.confirmPassword)
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)
            }
            .padding(.horizontal, 30)
            
            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding(.bottom, 20)
            }
            if let _ = viewModel.errorMessage {
                Text(viewModel.errorMessage ?? "")
                    .foregroundColor(.red)
                    .padding(.bottom, 20)
            }
            
            Button(action: {
                // Action for sign up
                handleSignUp()
            }) {
                Text("Sign Up")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10.0)
                    .padding(.horizontal, 30)
            }
            .alert(isPresented: $signUpSuccessAlert) {
                Alert(
                    title: Text("Success"),
                    message: Text("Congratulation! Your account has been created"),
                    dismissButton: .default(Text("OK")){
                        self.presentationMode.wrappedValue.dismiss()
                    }
                )
            }
            .onReceive(viewModel.$data, perform: { newValue in
                if let newValue = newValue {
                    self.userName = (newValue.data?.firstName ?? "") + " " + (newValue.data?.lastName ?? "")
                    self.token = newValue.data?.token
                    self.userId = newValue.data?.id
                    onSignUpSuccess()
                }
            })
            Spacer()
        }
        .padding()
    }
}

#Preview {
    SignUpView()
}
