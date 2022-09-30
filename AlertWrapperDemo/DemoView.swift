//
//  DemoView.swift
//  AlertWrapperDemo
//
//  Created by Kimberly Thompson on 9/30/22.
//

import SwiftUI

struct DemoView: View {
    
    // MARK: State
    @State var isShowingAlert = false
    @State var alert = UIAlertController(title: "Default", message: "Placeholder", preferredStyle: .alert)
    
    // MARK: SwiftUI
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(spacing: 16) {
                    SwiftUI.Button {
                        DispatchQueue.main.async {
                            alert = buildPasswordAlert()
                            isShowingAlert = true
                        }
                    } label: {
                        Text("Password Alert")
                    }
                    
                    SwiftUI.Button {
                        DispatchQueue.main.async {
                            alert = buildOtherAlert()
                            isShowingAlert = true
                        }
                    } label: {
                        Text("Other Alert")
                    }
                }
                .padding()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .alert(isPresented: $isShowingAlert, alert: alert)
    }
    
    // MARK: Alerts
    private func buildPasswordAlert() -> UIAlertController {
        let alert = UIAlertController(title: "Password", message: "Please enter your password.", preferredStyle: .alert)
        
        alert.addTextField { field in
            field.placeholder = "Password"
            field.returnKeyType = .next
            field.isSecureTextEntry = true
        }
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            print("Cancelled")
            isShowingAlert = false
        })
        let enterAction: UIAlertAction = UIAlertAction(title: "Enter", style: .default, handler: { _ in
            guard let fields = alert.textFields, fields.count == 1 else { return }
            let passwordField = fields[0]
            if let passwordFieldText = passwordField.text {
                // In reality you would check this password against a backend or something and either act or refuse to act, but I'm just going to print out the password entered
                print("Entered \(passwordFieldText)")
            }
            isShowingAlert = false
        })
        
        alert.addAction(cancelAction)
        alert.addAction(enterAction)
        
        return alert
    }
    
    private func buildOtherAlert() -> UIAlertController {
        let alert = UIAlertController(title: "Are You Sure?", message: nil, preferredStyle: .alert)
        
        let yesAction: UIAlertAction = UIAlertAction(title: "Yes", style: .default, handler: { _ in
            print("Yes")
            isShowingAlert = false
        })
        let noAction: UIAlertAction = UIAlertAction(title: "No", style: .default, handler: { _ in
            print("No")
            isShowingAlert = false
        })
        
        alert.addAction(yesAction)
        alert.addAction(noAction)
        
        return alert
    }
}

// MARK: Previews
struct DemoView_Previews: PreviewProvider {
    static var previews: some View {
        DemoView()
    }
}
