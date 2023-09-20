//
//  RotatableViews.swift
//  SectionSelectTable
//
//  Created by Sergey Markin on 03.11.2022.
//  Copyright © 2022 Profi.RU. All rights reserved.
//

import UIKit

class RotatableView: UIView {

    private(set) var isRotating = false

    func makeContentView() -> UIView? {
        return nil
    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()

        guard superview != nil,
              subviews.isEmpty,
              let subview = makeContentView()
        else { return }

        subview.frame = bounds
        addSubview(subview)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        subviews.first?.frame = bounds
    }

    func rotate() {
        guard let subview = subviews.first else { return }

        isRotating = true

        UIView.animate(withDuration: 1.5, delay: .zero, options: [.repeat, .autoreverse, .curveEaseInOut]) {
            subview.transform = CGAffineTransform(rotationAngle: .pi)
        }
    }

    func stopRotating() {
        isRotating = false
        subviews.first?.layer.removeAllAnimations()
        subviews.first?.transform = .identity
    }

}

final class FooView: RotatableView {
    override func makeContentView() -> UIView? {
        let img = UIImageView()
        img.image = UIImage(named: "someicon")
        img.contentMode = .center
        return img
    }
}

final class BarView: RotatableView {
    override func makeContentView() -> UIView? {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.textColor = .black
        lbl.text = ">>> TEST <<<"
        return lbl
    }
}
