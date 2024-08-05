import SwiftUI

struct LoginForm: View {
    @StateObject private var viewModel = SignInViewModel()
    @State private var credentials: LoginRequest = LoginRequest(email: "", password: "")
    @State private var showAlert = false
    @State private var emailError: String?
    @State private var passwordError: String?
    @AppStorage("userId") private var userId: String?
    @AppStorage("userName") private var userName: String?
    @AppStorage("token") private var token: String?
    @State var showInvalidCredAlert = false
    
    var onForgetPassword: () -> Void
    var onSignUp: () -> Void
    var onLogin: () -> Void
    
    func handleLogin() {
        emailError = validateEmail(credentials.email)
        passwordError = validatePassword(credentials.password)
        
        if emailError == nil && passwordError == nil {
            credentials.email = credentials.email.lowercased()
            viewModel.handleSignIn(payload: credentials)
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
    
    func validatePassword(_ password: String) -> String? {
        if password.isEmpty {
            return "Password is required."
        }
        return nil
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: email)
    }
    
    var body: some View {
        // Login form
        VStack(spacing: 20) {
            Text("Login")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            VStack(alignment: .leading, spacing: 5) {
                TextField("Email Address", text: $credentials.email)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(5.0)
                    .padding(.horizontal, 20)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                
                if let emailError = emailError {
                    Text(emailError)
                        .foregroundColor(.red)
                        .font(.caption)
                        .padding(.horizontal, 20)
                }
            }
            
            VStack(alignment: .leading, spacing: 5) {
                SecureField("Password", text: $credentials.password)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(5.0)
                    .padding(.horizontal, 20)
                
                if let passwordError = passwordError {
                    Text(passwordError)
                        .foregroundColor(.red)
                        .font(.caption)
                        .padding(.horizontal, 20)
                }
            }
            if viewModel.errorMessage != nil {
                Text(viewModel.errorMessage!)
                    .foregroundColor(.red)
                    .font(.caption)
                    .padding(.horizontal, 20)
            }
            
            Button(action: {
                // Perform login action
                handleLogin()
            }) {
                Text(viewModel.isLoading ? "Logging in..." : "Login")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(5.0)
            }
            .padding(.horizontal, 20)
        }
        .onReceive(viewModel.$data, perform: { newValue in
            if let newValue = newValue {
                self.userName = (newValue.data?.firstName ?? "") + " " + (newValue.data?.lastName ?? "")
                self.token = newValue.data?.token
                self.userId = newValue.data?.id
                onLogin()
            }
        })
        
       
        
        // SignUp and Forgot Password links
        HStack {
            Text("Don't have an account?")
            Button(action: {
                // Perform SignUp action
                onSignUp()
            }) {
                Text("SignUp")
                    .foregroundColor(.blue)
            }
        }
        .padding(.top, 10)
        
        Button(action: {
            // Perform Forgot Password action
            onForgetPassword()
        }) {
            Text("Forgot Password?")
                .foregroundColor(.blue)
        }
        .padding(.bottom, 20)
    }
}

#Preview {
    LoginForm(onForgetPassword: {
        print("Forget pressed");
    }, onSignUp: {
        print("Signing Up");
    }, onLogin: {
        print("Logging In");
    })
}
