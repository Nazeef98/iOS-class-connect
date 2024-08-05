import SwiftUI

struct LoginView: View {
    @State private var mode = 0
    @State private var isSignUpViewActive = false
    @State private var showPaswordUpdatedAlert = false
    var onLogin: () -> Void

    func handleForgetPassword(){
        mode = 1
    }
    func handleResetLogin() {
        mode = 0
    }
    func handleSendOtp() {
        mode = 2
    }
    func handlePasswordUpdated() {
        print("Password updated")
        showPaswordUpdatedAlert = true
        mode = 0
    }
    func onSignUp () {
        isSignUpViewActive = true
    }
    
    var body: some View {
        NavigationStack{
            VStack {
                // Top image
                Image("LoginPoster")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 200)
                    .padding(.top, 50)
                Spacer()
                if mode == 0 {
                    LoginForm(
                        onForgetPassword: handleForgetPassword,
                        onSignUp: onSignUp,
                        onLogin: onLogin
                    )
                } else if mode == 1 {
                    ResetPasswordForm(onGoBack: handleResetLogin, onSendOtp: handleSendOtp)
                } else if mode == 2 {
                    UpdatePasswordForm(onUpdatePassword: handlePasswordUpdated)
                }
                NavigationLink(destination: SignUpView(), isActive: $isSignUpViewActive) {
                    EmptyView()
                }
            }
            .alert(isPresented: $showPaswordUpdatedAlert) {
                Alert(
                    title: Text("Password Updated"),
                    message: Text("Your password has been updated successfully.\n Use new password to login"),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
}

#Preview {
    LoginView(onLogin: {
        print("Logging In")
    })
}
