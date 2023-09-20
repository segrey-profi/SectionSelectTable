//
//  AnimationViewController.swift
//  SectionSelectTable
//
//  Created by Sergey Markin on 24.10.2022.
//  Copyright © 2022 Profi.RU. All rights reserved.
//

import UIKit

struct Dots {

    private static let fractionCount = 7
    private static let fractionDuration: TimeInterval = 0.35

    static let dotSteps = [0, 1, 2, 4, 5, 6]

    static let timeFractions = TimeInterval(fractionCount)
    static let totalDuration = timeFractions * fractionDuration

    private static let halfFractions = timeFractions / 2

    static let halfOffset = halfFractions == halfFractions.rounded() ? 0 : 1
    static let halfCount = fractionCount / 2 + halfOffset

}

final class AnimationViewController: UIViewController {

    @IBOutlet var rotatorStacks: [UIView]!
    @IBOutlet var fooView: FooView!
    @IBOutlet var barView: BarView!

    @IBOutlet var dot1: UIView!
    @IBOutlet var dot2: UIView!
    @IBOutlet var dot3: UIView!
    @IBOutlet var dotButton: UIButton!

    private lazy var dots: [UIView] = [dot1, dot2, dot3]

    private var isDotAnimating = false

    override func viewDidLoad() {
        super.viewDidLoad()

        rotatorStacks.forEach { $0.isHidden = true }

        dots.forEach { $0.isHidden = true }
    }

    @IBAction func didTapFoo() {
        fooView.isRotating ? fooView.stopRotating() : fooView.rotate()
    }

    @IBAction func didTapBar() {
        barView.isRotating ? barView.stopRotating() : barView.rotate()
    }

    @IBAction func didTapDotsButton() {
        if isDotAnimating {
            dotButton.setTitle("Start dots", for: .normal)
            dots.forEach {
                $0.layer.removeAllAnimations()
                $0.isHidden = true
            }
        } else {
            dotButton.setTitle("Stop dots", for: .normal)
            dots.forEach {
                $0.layer.removeAllAnimations()
                $0.alpha = .zero
                $0.isHidden = false
            }
            animateDots()
        }
        isDotAnimating = !isDotAnimating
    }

    private func animateDots() {
        UIView.animateKeyframes(withDuration: Dots.totalDuration, delay: .zero) {
            Dots.dotSteps.forEach(self.addDotKeyframe)
        } completion: { [weak self] finished in
            guard finished,
                  let self = self,
                  self.isDotAnimating
            else { return }

            self.dots.forEach { $0.alpha = 0.1 }
            self.animateDots()
        }
    }

    private func addDotKeyframe(step: Int) {
        let stepIndex = step % Dots.halfCount
        let fraction = TimeInterval(step) / Dots.timeFractions
        let duration = TimeInterval(Dots.halfCount - Dots.halfOffset - stepIndex) / Dots.timeFractions
        let dot = dots[stepIndex]

        UIView.addKeyframe(withRelativeStartTime: fraction, relativeDuration: duration) {
            dot.alpha = step < Dots.halfCount ? 1.0 : 0.1
        }
    }

}
