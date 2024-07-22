//
//  MainViewController.swift
//  vk-techno-test
//
//  Created by Marina Kolbina on 22/07/2024.
//

import UIKit

class MainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private var collectionView: UICollectionView!
    private var pageViewController: UIPageViewController!
    private var previousSelectedTag: Int
    
    private let weatherConditions: [WeatherCondition] = [.rain, .snow, .sun, .cloudy, .lightning]
    private var weatherViewControllers: [WeatherViewController] = []
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.previousSelectedTag = Int.random(in: 1...5)
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        initializeWeatherViewControllers()
    }
    
    required init?(coder: NSCoder) {
        self.previousSelectedTag = Int.random(in: 1...5)
        super.init(coder: coder)
        initializeWeatherViewControllers()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(previousSelectedTag)
        
        view.backgroundColor = .white
        setupCollectionView()
        setupPageViewController()
        
        view.bringSubviewToFront(collectionView)
    }
    
    private func initializeWeatherViewControllers() {
        weatherViewControllers = weatherConditions.map { condition in
            let weatherVC = WeatherViewController()
            weatherVC.weatherCondition = condition
            return weatherVC
        }
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.minimumLineSpacing = 20
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.backgroundColor = .clear
        
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    private func setupPageViewController() {
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageViewController.dataSource = self
        pageViewController.delegate = self
        
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pageViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            pageViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pageViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        if let initialVC = viewControllerAtIndex(previousSelectedTag - 1) {
            pageViewController.setViewControllers([initialVC], direction: .forward, animated: true, completion: nil)
        }
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherConditions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as? CustomCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let cells = [("Rain", "rainIcon"),
                     ("Snow", "snowIcon"),
                     ("Sun", "sunIcon"),
                     ("Cloud", "cloudIcon"),
                     ("Lightning", "lightningIcon")]
        
        let chosedCell = cells[indexPath.item]
        
        if indexPath.item < cells.count {
            let titleKey = cells[indexPath.item].0
            let localizedTitle = NSLocalizedString(titleKey, comment: "")
            cell.configure(with: localizedTitle, tag: indexPath.item + 1, imageName: chosedCell.1)
            cell.setButtonTarget(target: self, action: #selector(showWeatherScene(_:)))
        } else {
            cell.configure(with: nil, tag: nil, imageName: chosedCell.0)
        }
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 80)
    }
    
    @objc func showWeatherScene(_ sender: UIButton) {
        if sender.tag == previousSelectedTag {
            return
        }
        
        guard let weatherVC = viewControllerAtIndex(sender.tag - 1) else { return }
        
        let direction: UIPageViewController.NavigationDirection = sender.tag > previousSelectedTag ? .forward : .reverse
        
        pageViewController.setViewControllers([weatherVC], direction: direction, animated: true, completion: nil)
        
        previousSelectedTag = sender.tag
    }
    
    private func viewControllerAtIndex(_ index: Int) -> WeatherViewController? {
        guard index >= 0 && index < weatherConditions.count else { return nil }
        
        let weatherVC = WeatherViewController()
        weatherVC.weatherCondition = weatherConditions[index]
        return weatherVC
    }
}

// MARK: - UIPageViewControllerDataSource

extension MainViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentVC = viewController as? WeatherViewController,
              let currentCondition = currentVC.weatherCondition,
              let currentIndex = weatherConditions.firstIndex(of: currentCondition),
              currentIndex > 0 else { return nil }
        
        return viewControllerAtIndex(currentIndex - 1)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentVC = viewController as? WeatherViewController,
              let currentCondition = currentVC.weatherCondition,
              let currentIndex = weatherConditions.firstIndex(of: currentCondition),
              currentIndex < weatherConditions.count - 1 else { return nil }
        
        return viewControllerAtIndex(currentIndex + 1)
    }
    
}

// MARK: - UIPageViewControllerDelegate

extension MainViewController: UIPageViewControllerDelegate {
    
}

