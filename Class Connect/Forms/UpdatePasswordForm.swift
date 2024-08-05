import SwiftUI

struct UpdatePasswordForm: View {
    @AppStorage("resetPasswordEmail") private var resetPasswordEmail: String?
    @StateObject private var viewModel = UpdatePasswordViewModel()
    @State private var upf: UpdatePassword = UpdatePassword(
        otp: "", newPassword: "", confirmPassword: ""
    )
    @State private var otpError: String?
    @State private var newPasswordError: String?
    @State private var confirmPasswordError: String?
    @State private var showAlert = false
    
    var onUpdatePassword: () -> Void
    
    func handleUpdatePassword() {
        otpError = validateOtp(upf.otp)
        newPasswordError = validatePassword(upf.newPassword)
        confirmPasswordError = validateConfirmPassword(upf.confirmPassword, newPassword: upf.newPassword)
        
        if otpError == nil && newPasswordError == nil && confirmPasswordError == nil {
            let updatePasswordForm: UpdatePasswordRequest = UpdatePasswordRequest(
                otp: upf.otp,
                email: resetPasswordEmail ?? "",
                password: upf.newPassword
            )
            viewModel.handleUpdatePassword(payload: updatePasswordForm)
        } else {
            showAlert = true
        }
    }
    
    func validateOtp(_ otp: String) -> String? {
        if otp.isEmpty {
            return "OTP is required."
        }
        return nil
    }
    
    func validatePassword(_ password: String) -> String? {
        if password.isEmpty {
            return "New password is required."
        } else if password.count < 6 {
            return "Password must be at least 6 characters long."
        }
        return nil
    }
    
    func validateConfirmPassword(_ confirmPassword: String, newPassword: String) -> String? {
        if confirmPassword.isEmpty {
            return "Confirm password is required."
        } else if confirmPassword != newPassword {
            return "Passwords do not match."
        }
        return nil
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Update Password")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            VStack(alignment: .leading, spacing: 5) {
                TextField("One Time Password", text: $upf.otp)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(5.0)
                    .padding(.horizontal, 20)
                
                if let otpError = otpError {
                    Text(otpError)
                        .foregroundColor(.red)
                        .font(.caption)
                        .padding(.horizontal, 20)
                }
            }
            
            VStack(alignment: .leading, spacing: 5) {
                SecureField("New Password", text: $upf.newPassword)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(5.0)
                    .padding(.horizontal, 20)
                
                if let newPasswordError = newPasswordError {
                    Text(newPasswordError)
                        .foregroundColor(.red)
                        .font(.caption)
                        .padding(.horizontal, 20)
                }
            }
            
            VStack(alignment: .leading, spacing: 5) {
                SecureField("Confirm Password", text: $upf.confirmPassword)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(5.0)
                    .padding(.horizontal, 20)
                
                if let confirmPasswordError = confirmPasswordError {
                    Text(confirmPasswordError)
                        .foregroundColor(.red)
                        .font(.caption)
                        .padding(.horizontal, 20)
                }
            }
            
            Button(action: {
                handleUpdatePassword()
            }) {
                Text("Update Password")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(5.0)
            }
            .padding(.horizontal, 20)
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Failed"), message: Text("Please fix the errors before submitting."), dismissButton: .default(Text("OK")))
            }
        }
        .onReceive(viewModel.$data, perform: { newData in
            if newData != nil {
                onUpdatePassword()
            }
        })
        .onReceive(viewModel.$errorMessage, perform: { error in
            if error != nil {
                showAlert = true
            }
        })
    }
}

#Preview {
    UpdatePasswordForm(onUpdatePassword: {
        print("Update Password Pressed")
    })
}
