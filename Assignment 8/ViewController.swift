//
//  ViewController.swift
//  Assignment 8
//
//  Created by 桑染 on 2020-05-24.
//  Copyright © 2020 Rick. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate {
    
    let stuffedSquid = Restaurant(image: UIImage(named: "filipino-food"), name: "Stuffed Squid", category: .Philippines)
    let phoGa = Restaurant(image: UIImage(named: "vietnamese-pho-ga"), name: "Pho Ga", category: .Vietnam)
    let huarache = Restaurant(image: UIImage(named: "mexico-huaraches"), name: "Huarache", category: .Mexico)
    let pizza = Restaurant(image: UIImage(named: "pizza-italy"), name: "Pizza", category: .Italy)
    let snails = Restaurant(image: UIImage(named: "french-food-snails2"), name: "Snails", category: .France)
    let sushi = Restaurant(image: UIImage(named: "japanese-sushi"), name: "Sushi", category: .Japan)
    let pasteldeNata = Restaurant(image: UIImage(named: "Portugal"), name: "Pastel de Nata", category: .Portugal)
    let ramen = Restaurant(image: UIImage(named: "Ramen"), name: "Ramen", category: .Japan)
    let tempura = Restaurant(image: UIImage(named: "tempura"), name: "Tempura", category: .Japan)
    let sukiyaki = Restaurant(image: UIImage(named: "sukiyaki"), name: "Sukiyaki", category: .Japan)

    var restaurants = [Restaurant]()
    var filterdRestaurants: [Restaurant] = []
    var categories = [Restaurant.Category]()

    private var isFiltering: Bool {
        return isSelected[0] != true
    }
    private var isSelected: [Bool] = [true, false, false, false, false, false, false, false, false, false]
    
    var collectionView: UICollectionView!
    var filterCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "My Restaurant"
        
        restaurants.append(contentsOf: [stuffedSquid, phoGa, huarache, pizza, snails, sushi, pasteldeNata, ramen, tempura, sukiyaki])
        
        let filterLayout = UICollectionViewFlowLayout()
        filterLayout.scrollDirection = .horizontal
        filterLayout.minimumInteritemSpacing = 8
        filterCollectionView = UICollectionView(frame: CGRect(x: 0, y: 44, width: self.view.frame.size.width, height: 100), collectionViewLayout: filterLayout)
        filterCollectionView.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: "FilterCell")
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 144, width: self.view.frame.size.width, height: self.view.frame.size.height - 144), collectionViewLayout: layout)
        collectionView.register(RestaurantCollectionViewCell.self, forCellWithReuseIdentifier: "CellId")
        
        view.addSubview(filterCollectionView)
        view.addSubview(collectionView)
        
        filterCollectionView.backgroundColor = .lightGray
        filterCollectionView.delegate = self
        filterCollectionView.dataSource = self
        collectionView.backgroundColor = .lightGray
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func filterFor(categories: [Restaurant.Category?]) {
        filterdRestaurants = restaurants.filter { (restaurant) in
            categories.contains(restaurant.category)
        }
        collectionView.reloadData()
    }
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.filterCollectionView {
            return Restaurant.Category.allCases.count
        } else {
            return isFiltering ? filterdRestaurants.count : restaurants.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.filterCollectionView {
            let myCell = filterCollectionView.dequeueReusableCell(withReuseIdentifier: "FilterCell", for: indexPath) as! FilterCollectionViewCell
            myCell.filterLabel.text = Restaurant.Category.allCases[indexPath.row].rawValue
            if isSelected[indexPath.row] == false {
                myCell.filterLabel.backgroundColor = .white
                myCell.filterLabel.textColor = .systemBlue
            } else {
                myCell.filterLabel.backgroundColor = .systemBlue
                myCell.filterLabel.textColor = .white
            }
            return myCell
        } else {
            let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellId", for: indexPath) as! RestaurantCollectionViewCell
            let restaurant = isFiltering ? filterdRestaurants[indexPath.row] : restaurants[indexPath.row]
            myCell.imageView.image = restaurant.image
            myCell.nameLabel.text = restaurant.name
            myCell.detailLabel.text = restaurant.category.rawValue
            myCell.backgroundColor = .white
            return myCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        filterCollectionView.allowsMultipleSelection = true
        if collectionView == self.filterCollectionView {
            if isSelected[indexPath.row] == false && indexPath.row != 0 {
                isSelected[0] = false
                isSelected[indexPath.row] = true
                let cell = filterCollectionView.cellForItem(at: indexPath) as! FilterCollectionViewCell
                let category = Restaurant.Category(rawValue: cell.filterLabel.text!)
                categories.append(category!)
                filterFor(categories: categories)
                filterCollectionView.reloadData()
            } else if isSelected[indexPath.row] == false && indexPath.row == 0 {
                isSelected[0] = true
                for i in 1...9 {
                    isSelected[i] = false
                }
                categories = [Restaurant.Category]()
                filterFor(categories: Restaurant.Category.allCases)
                filterCollectionView.reloadData()
            } else if isSelected[indexPath.row] == true && indexPath.row != 0 {
                isSelected[indexPath.row] = false
                if isSelected.contains(true) {
                    let cell = filterCollectionView.cellForItem(at: indexPath) as! FilterCollectionViewCell
                    let category = Restaurant.Category(rawValue: cell.filterLabel.text!)
                    categories.append(category!)
                    categories = categories.filter { $0 != category }
                    filterFor(categories: categories)
                    filterCollectionView.reloadData()
                } else {
                    isSelected[0] = true
                    categories = [Restaurant.Category]()
                    filterFor(categories: Restaurant.Category.allCases)
                    filterCollectionView.reloadData()
                }
            }
        }
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == filterCollectionView {
            return CGSize(width: 100, height: 30)
        } else {
            let size = (collectionView.frame.width - 3 * 14) / 2.0
            return CGSize(width: size, height: size)
        }
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == self.filterCollectionView {
            return .init(top: 8, left: 8, bottom: 8, right: 8)
        } else {
            return .init(top: 0, left: 16, bottom: 0, right: 16)
        }
    }
}



