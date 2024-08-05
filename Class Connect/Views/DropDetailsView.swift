//
//  DropDetailsView.swift
//  Class Connect
//
//  Created by user on 01/08/24.
//

import SwiftUI

struct DropDetailsView: View {
    @AppStorage("courseCode") private var cCode: String?
    @AppStorage("userId") private var userId: String?
    @State private var firstRun = true
    @State private var dataSaved = false
    @StateObject private var viewModel = DropDetailsViewModel()
    @State private var dropDetailsForm: DropDetailsRequest = DropDetailsRequest(
        id: "", name: "", phone: "", address: "", city: "", email: "", state: "", zip: "", country: "", courseCode: "", accommodation: false, user: "")
    
    @State private var nameError: String?
    @State private var phoneError: String?
    @State private var emailError: String?
    @State private var addressError: String?
    @State private var cityError: String?
    @State private var stateError: String?
    @State private var zipError: String?
    @State private var countryError: String?
    
    func onLogout() {
        // Logout logic
    }
    
    func createOrUpdateProfile() {
        dropDetailsForm.courseCode = cCode!
        dropDetailsForm.user = userId!
        print("Starting validation");
        if validateForm() {
            print("Done validation");
            if dropDetailsForm.id == "" {
                viewModel.createPublicProfile(payload: dropDetailsForm)
            } else {
                viewModel.updatePublicProfile(payload: dropDetailsForm)
            }
        } else {
            print("EEEE");
        }
    }
    
    func validateForm() -> Bool {
        var isValid = true
        
        if dropDetailsForm.name.isEmpty {
            nameError = "Name cannot be empty"
            isValid = false
        } else {
            nameError = nil
        }
        
        if dropDetailsForm.phone.isEmpty || !isValidPhone(dropDetailsForm.phone) {
            phoneError = "Invalid phone number"
            isValid = false
        } else {
            phoneError = nil
        }
        
        if dropDetailsForm.email.isEmpty || !isValidEmail(dropDetailsForm.email) {
            emailError = "Invalid email address"
            isValid = false
        } else {
            emailError = nil
        }
        
        if dropDetailsForm.address.isEmpty {
            addressError = "Address cannot be empty"
            isValid = false
        } else {
            addressError = nil
        }
        
        if dropDetailsForm.city.isEmpty {
            cityError = "City cannot be empty"
            isValid = false
        } else {
            cityError = nil
        }
        
        if dropDetailsForm.state.isEmpty {
            stateError = "State cannot be empty"
            isValid = false
        } else {
            stateError = nil
        }
        
        if dropDetailsForm.zip.isEmpty {
            zipError = "ZIP code cannot be empty"
            isValid = false
        } else {
            zipError = nil
        }
        
        if dropDetailsForm.country.isEmpty {
            countryError = "Country cannot be empty"
            isValid = false
        } else {
            countryError = nil
        }
        
        return isValid
    }
    
    func isValidPhone(_ phone: String) -> Bool {
        // Add phone validation logic here
        return phone.count >= 10
    }
    
    func isValidEmail(_ email: String) -> Bool {
        // Add email validation logic here
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
    
    var body: some View {
        VStack {
            Text("Drop Details")
                .font(.title)
                .padding(.top)
            
            Toggle(isOn: $dropDetailsForm.accommodation) {
                Text("Accommodation")
                    .font(.headline)
            }
            .padding()
            
            Group {
                VStack(alignment: .leading) {
                    TextField("Name", text: $dropDetailsForm.name)
                    if let nameError = nameError {
                        Text(nameError).foregroundColor(.red).font(.caption)
                    }
                }
                
                VStack(alignment: .leading) {
                    TextField("Phone", text: $dropDetailsForm.phone)
                        .keyboardType(UIKeyboardType.numberPad)
                    if let phoneError = phoneError {
                        Text(phoneError).foregroundColor(.red).font(.caption)
                    }
                }
                
                VStack(alignment: .leading) {
                    TextField("Email", text: $dropDetailsForm.email)
                        .keyboardType(UIKeyboardType.emailAddress)
                        .textInputAutocapitalization(.never)
                    if let emailError = emailError {
                        Text(emailError).foregroundColor(.red).font(.caption)
                    }
                }
                
                VStack(alignment: .leading) {
                    TextField("Address", text: $dropDetailsForm.address)
                    if let addressError = addressError {
                        Text(addressError).foregroundColor(.red).font(.caption)
                    }
                }
                
                VStack(alignment: .leading) {
                    TextField("City", text: $dropDetailsForm.city)
                    if let cityError = cityError {
                        Text(cityError).foregroundColor(.red).font(.caption)
                    }
                }
                
                VStack(alignment: .leading) {
                    TextField("State", text: $dropDetailsForm.state)
                    if let stateError = stateError {
                        Text(stateError).foregroundColor(.red).font(.caption)
                    }
                }
                
                VStack(alignment: .leading) {
                    TextField("ZIP", text: $dropDetailsForm.zip)
                    if let zipError = zipError {
                        Text(zipError).foregroundColor(.red).font(.caption)
                    }
                }
                
                VStack(alignment: .leading) {
                    TextField("Country", text: $dropDetailsForm.country)
                    if let countryError = countryError {
                        Text(countryError).foregroundColor(.red).font(.caption)
                    }
                }
            }
            .padding()
            .background(Color(.secondarySystemBackground))
            .cornerRadius(8)
            
            Spacer()
            
            Button(action: {
                createOrUpdateProfile()
            }) {
                Text("Save")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 40, height: 50)
                    .background(Color.purple)
                    .cornerRadius(10)
            }
            .padding()
        }
        .alert(isPresented: $dataSaved) {
            Alert(
                title: Text("Success"),
                message: Text("Your details has been saved!"),
                dismissButton: .default(Text("OK"))
            )
        }
        .onAppear {
            viewModel.getPublicProfile(id: userId!)
        }
        .onReceive(viewModel.$data, perform: { newValue in
            guard let data = newValue else {
                return
            }
            dropDetailsForm = DropDetailsRequest(
                id: newValue?.data?.id ?? "",
                name: newValue?.data?.name ?? "",
                phone: newValue?.data?.phone ?? "",
                address: newValue?.data?.address ?? "",
                city: newValue?.data?.city ?? "",
                email: newValue?.data?.email ?? "",
                state: newValue?.data?.state ?? "",
                zip: newValue?.data?.zip ?? "",
                country: newValue?.data?.country ?? "",
                courseCode: cCode!,
                accommodation: newValue?.data?.accommodation ?? false,
                user: userId!
            )
            if firstRun == true {
                firstRun = false
            } else {
                dataSaved = true;
            }
        })
    }
}

#Preview {
    DropDetailsView()
}
