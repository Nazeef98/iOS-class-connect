import SwiftUI

struct ResetPasswordForm: View {
    @AppStorage("resetPasswordEmail") private var resetPasswordEmail: String?
    @StateObject private var viewModel = ResetPasswordViewModel()
    @State private var showAlert = false
    @State private var emailError: String?
    @State private var resetPasswordForm: ResetPasswordRequest = ResetPasswordRequest(
        email: ""
    )
    
    var onGoBack: () -> Void
    var onSendOtp: () -> Void
    
    func handleSendOtp() {
        emailError = validateEmail(resetPasswordForm.email)
        if emailError == nil {
            resetPasswordForm.email = resetPasswordForm.email.lowercased()
            viewModel.handleResetPassword(payload: resetPasswordForm)
        }
    }
    
    func validateEmail(_ email: String) -> String? {
        if email.isEmpty {
            return "Email is required."
        } else if !isValidEmail(email) {
            return "Invalid email address."
        }
        return nil
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: email)
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Reset Password")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            VStack(alignment: .leading, spacing: 5) {
                TextField("Email Address", text: $resetPasswordForm.email)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(5.0)
                    .padding(.horizontal, 20)
                
                if let emailError = emailError {
                    Text(emailError)
                        .foregroundColor(.red)
                        .font(.caption)
                        .padding(.horizontal, 20)
                }
            }
            
            Button(action: {
                // Perform send OTP action
                handleSendOtp()
            }) {
                Text(viewModel.isLoading ? "Sending..." : "Send OTP")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(5.0)
            }
            .padding(.horizontal, 20)
            Button(action: {
                onGoBack()
            }) {
                Text("Back")
                    .foregroundColor(.blue)
            }
            .padding(.top, 10)
        }
        .padding(.bottom, 20)
        .onReceive(viewModel.$errorMessage, perform: { error in
            if let error = error {
                showAlert = true
            }
        })
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Failed"),
                message: Text(viewModel.errorMessage!),
                dismissButton: .default(Text("OK")) {
                }
            )
        }
        .onReceive(viewModel.$data, perform: { newData in
            if let newData = newData {
                self.resetPasswordEmail = resetPasswordForm.email
                onSendOtp()
            }
        })
    }
}

#Preview {
    ResetPasswordForm(onGoBack: {
        print("Go Back")
    }, onSendOtp: {
        print("Send Otp")
    })
}
