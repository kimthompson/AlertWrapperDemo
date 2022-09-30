//
//  AlertWrapper.swift
//  AlertWrapperDemo
//
//  Created by Kimberly Thompson on 9/30/22.
//

import SwiftUI
import UIKit

struct AlertWrapper<Content: View>: UIViewControllerRepresentable {
    @Binding var isPresented: Bool
    let alert: UIAlertController
    let content: Content
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<AlertWrapper>) -> UIHostingController<Content> {
        UIHostingController(rootView: content)
    }
    
    final class Coordinator {
        var alertController: UIAlertController?
        init(_ controller: UIAlertController? = nil) {
            self.alertController = controller
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    
    func updateUIViewController(_ uiViewController: UIHostingController<Content>, context: UIViewControllerRepresentableContext<AlertWrapper>) {
        uiViewController.rootView = content
        
        if isPresented && uiViewController.presentedViewController == nil {
            context.coordinator.alertController = alert
            uiViewController.present(context.coordinator.alertController!, animated: true)
        }
        
        if !isPresented && uiViewController.presentedViewController == context.coordinator.alertController {
            uiViewController.dismiss(animated: true)
        }
    }
}

extension View {
    public func alert(isPresented: Binding<Bool>, alert: UIAlertController) -> some View {
        AlertWrapper(isPresented: isPresented, alert: alert, content: self)
    }
}
