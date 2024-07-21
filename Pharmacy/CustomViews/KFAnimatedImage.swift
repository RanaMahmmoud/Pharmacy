//
//  KFAnimatedImage.swift
//  Pharmacy
//
//  Created by Rana Mahmoud on 20/07/2024.
//

import SwiftUI
import Kingfisher

class KFAnimatedViewController: UIViewController, AnimatedImageViewDelegate {
    
    let animatedImageView = AnimatedImageView()
    var onFinish: (() -> Void)?
    override func loadView() {
        super.loadView()
        self.view = animatedImageView
        animatedImageView.delegate = self
    }
    
    func animatedImageView(_ imageView: AnimatedImageView, didPlayAnimationLoops count: UInt) {
        if (count == 1) {
            onFinish!()
        }
    }
}

struct KFAnimatedImage: UIViewControllerRepresentable {
    var resource: Resource?
    var repeatOnce: Bool
    var onFinish: (() -> Void)?
    
    func makeUIViewController(context: Context) -> KFAnimatedViewController {
        let uiViewController = KFAnimatedViewController()
        uiViewController.onFinish = onFinish
        return uiViewController
    }
    
    func updateUIViewController(_ uiView: KFAnimatedViewController, context: Context) {
        uiView.animatedImageView.kf.setImage(with: resource)
        uiView.animatedImageView.contentMode = .scaleAspectFit
        if (repeatOnce) {
            uiView.animatedImageView.repeatCount = AnimatedImageView.RepeatCount.once
        } else {
            uiView.animatedImageView.repeatCount = AnimatedImageView.RepeatCount.infinite
        }
    }
    
    func makeCoordinator() -> KFAnimatedImageViewCoordinator {
        return KFAnimatedImageViewCoordinator(self)
    }
    
    final class KFAnimatedImageViewCoordinator: NSObject {
        var kfAnimatedImage: KFAnimatedImage
        
        init(_ kfAnimatedImage: KFAnimatedImage) {
            self.kfAnimatedImage = kfAnimatedImage
        }
    }
}

