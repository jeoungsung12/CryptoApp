//
//  ViewControllerRepresentable.swift
//  CryptoApp
//
//  Created by 정성윤 on 3/7/25.
//

import SwiftUI

struct ViewControllerRepresentable<T:UIViewController>: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> T {
        return T()
    }
    
    func updateUIViewController(_ uiViewController: T, context: Context) {}
}
