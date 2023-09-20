//
//  TextViewController.swift
//  SectionSelectTable
//
//  Created by Sergey Markin on 17.08.2018.
//  Copyright © 2018 Profi.RU. All rights reserved.
//

import Photos
import UIKit

final class BarViewController: UIViewController {
    
    @IBOutlet private var toolbar: UIToolbar!
    @IBOutlet private var field: UITextField!
    @IBOutlet private var label: UILabel!
    
    private let initialCountDown = 5
    
    private var count = 0
    private var actionTitle: String?

    private var interactor: Interactor!
    
    override var canBecomeFirstResponder: Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        actionTitle = toolbar.items?.first?.title
        interactor = Interactor()
        interactor.subscribe()
    }
    
    override func didMove(toParentViewController parent: UIViewController?) {
        super.didMove(toParentViewController: parent)
        
        if parent == nil {
            print(self, #function, "REMOVED FROM PARENT")
        }
    }

    @IBAction func textDidChange() {
        label.text = field.text
    }
    
    @IBAction func countDownToClear() {
        guard count == 0 else { return }
        
        count = initialCountDown
        performCountDown()
    }
    
    @IBAction func close() {
        dismiss(animated: true)
    }
    
    private func clearSelection() {
        let text = field.text
        field.text = nil
        field.text = text
    }
    
    private func performCountDown() {
        toolbar.items?.first?.title = "\(count)"
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.processCountDown()
        }
    }
    
    private func processCountDown() {
        count -= 1
        guard count == 0 else { return performCountDown() }
        
        clearSelection()
        toolbar.items?.first?.title = actionTitle
    }

}

fileprivate final class Interactor: NSObject, PHPhotoLibraryChangeObserver {

    deinit {
        PHPhotoLibrary.shared().unregisterChangeObserver(self)
        print(self, "DEINIT")
    }

    func subscribe() {
        PHPhotoLibrary.shared().register(self)
    }

    func photoLibraryDidChange(_ changeInstance: PHChange) {
        print("CH-CH-CH-CHANGES!", changeInstance)
    }

}
