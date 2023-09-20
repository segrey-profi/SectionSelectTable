//
//  FooViewController.swift
//  SectionSelectTable
//
//  Created by Sergey Markin on 20/02/2019.
//  Copyright © 2019 Profi.RU. All rights reserved.
//

import UIKit

final class FooViewController: UIViewController {
    
    @IBOutlet var collection: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if isMovingFromParentViewController {
            print("\(self) IS MOVING FROM PARENT")
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if isMovingFromParentViewController {
            print("\(self) HAS MOVED FROM PARENT")
        }
    }
    
    override func didMove(toParentViewController parent: UIViewController?) {
        super.didMove(toParentViewController: parent)
        
        if parent == nil {
            print("NOW \(self) HAS REALLY MOVED FROM PARENT")
        }
    }
    
}

extension FooViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let sView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "footer", for: indexPath)
        sView.backgroundColor = nil
        return sView
    }
    
}

extension FooViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let bar = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BarViewController")
        let nav = UINavigationController(rootViewController: bar)
        present(nav, animated: true)
    }
    
}
