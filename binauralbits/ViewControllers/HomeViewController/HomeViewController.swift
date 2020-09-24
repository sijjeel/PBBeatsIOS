//
//  HomeViewController.swift
//  binauralbits
//
//  Created by Byron Chavarría on 2/22/20.
//  Copyright © 2020 Powerbraintuner. All rights reserved.
//

import UIKit
import RxSwift
import RealmSwift
import Reachability
import SwiftKeychainWrapper

final class HomeViewController: UIViewController {
    
    // MARK: - Components
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var firstStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 24
        return stackView
    }()
    
    lazy var secondStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 24
        stackView.backgroundColor = .red
        return stackView
    }()
    
    lazy var first: ImageWithPlayView = {
        let view = ImageWithPlayView()
        view.button.tag = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var second: ImageWithPlayView = {
        let view = ImageWithPlayView()
        view.button.tag = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        view.imageView.image = R.Images.fifthImage.image
        return view
    }()
    
    lazy var third: ImageWithPlayView = {
        let view = ImageWithPlayView()
        view.button.tag = 3
        view.translatesAutoresizingMaskIntoConstraints = false
        view.imageView.image = R.Images.thirdSong.image
        return view
    }()
    
    lazy var fourth: ImageWithPlayView = {
        let view = ImageWithPlayView()
        view.button.tag = 4
        view.translatesAutoresizingMaskIntoConstraints = false
        view.imageView.image = R.Images.fourthImage.image
        return view
    }()
    
    lazy var fifth: ImageWithPlayView = {
        let view = ImageWithPlayView()
        view.button.tag = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        view.imageView.image = R.Images.secondSong.image
        return view
    }()
    
    lazy var logoImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = R.Base.logo.image
        image.tintColor = R.Colors.logoColor.color
        return image
    }()
    
    lazy var powerbrainLogoImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = R.Base.powerbrainLogo.image
        return image
    }()
    
    lazy var gradientView: CAGradientLayer = {
        let gradientView = CAGradientLayer()
        gradientView.colors = [R.Colors.colorTop.color.cgColor,
                               R.Colors.colorBottom.color.cgColor]
        return gradientView
    }()
    
    lazy var infoButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(R.Base.infoImage.image, for: .normal)
        return button
    }()
    
    lazy var footerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    // MARK: - Attributes
    
    var viewModel: HomeViewModel!
    var disposeBag = DisposeBag()
    let reachability = try! Reachability()
    weak var delegate: HomeViewControllerDelegate?
    let realm = try! Realm()
    var canDownload: Bool = false
    var receiptData: String = ""
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gradientView.frame = view.bounds
        view.layer.insertSublayer(gradientView, at: 0)
        setupLayout()
        setupActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        do{
            try reachability.startNotifier()
        }catch{
            print("could not start reachability notifier")
        }
    }
    
    @objc func reachabilityChanged(note: Notification) {
        let reachability = note.object as! Reachability
        let songs = realm.objects(SongModel.self).count
        switch reachability.connection {
        case .wifi:
            print("Reachable via WiFi")
            verifyRecipt()
            if songs == 0 {
                bindViewModel()
                canDownload = true
            }
        case .cellular:
            print("Reachable via Cellular")
            verifyRecipt()
            if songs == 0 {
                bindViewModel()
                canDownload = true
            }
        case .unavailable:
            print("Network not reachable")
//            UserDefaults.standard.set(true, forKey: K.premiumUserKey)
            KeychainWrapper.standard.set(true, forKey: K.premiumUserKey)
            reachability.stopNotifier()
            NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: reachability)
        case .none:
            print("Non entry")
//            UserDefaults.standard.set(true, forKey: K.premiumUserKey)
            KeychainWrapper.standard.set(true, forKey: K.premiumUserKey)
            reachability.stopNotifier()
            NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: reachability)
        }
    }
    
    private func setupActions() {
        first.button.addTarget(self, action: #selector(reproduceAudio(_:)), for: .touchUpInside)
        first.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(showMenu(_:))))
        
        second.button.addTarget(self, action: #selector(reproduceAudio(_:)), for: .touchUpInside)
        second.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(showMenu1(_:))))
        
        third.button.addTarget(self, action: #selector(reproduceAudio(_:)), for: .touchUpInside)
        third.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(showMen2(_:))))
        
        fourth.button.addTarget(self, action: #selector(reproduceAudio(_:)), for: .touchUpInside)
        fourth.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(showMen3(_:))))
        
        fifth.button.addTarget(self, action: #selector(reproduceAudio(_:)), for: .touchUpInside)
        fifth.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(showMen4(_:))))
        
        infoButton.addTarget(self, action: #selector(handleSettingsSelection(_:)), for: .touchUpInside)
    }
    
    @objc private func handleSettingsSelection(_ sender: UIButton) {
        delegate?.homeViewControllerDidSelectSettingsPage()
    }
    
    @objc private func showMenu(_ gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .began {
            delegate?.homeViewControllerDidSelectInfoPage(with: L10n.sleepBetterTitle, and: L10n.sleepBetterInfo, and: 1)
        }
    }
    
    @objc private func showMenu1(_ gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .began {
            delegate?.homeViewControllerDidSelectInfoPage(with: L10n.wellnessTitle, and: L10n.wellnessInfo, and: 2)
        }
    }
    
    @objc private func showMen2(_ gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .began {
            delegate?.homeViewControllerDidSelectInfoPage(with: L10n.creativityTitle, and: L10n.creativityInfo, and: 3)
        }
    }
    
    @objc private func showMen3(_ gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .began {
            delegate?.homeViewControllerDidSelectInfoPage(with: L10n.fastLearningTitle, and: L10n.fastLearningInfo, and: 4)
        }
    }
    
    @objc private func showMen4(_ gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .began {
            delegate?.homeViewControllerDidSelectInfoPage(with: L10n.maximunConcentrationTitle, and: L10n.maximunConcentrationInfo, and: 5)
        }
    }
    
    @objc private func reproduceAudio(_ sender: ImageWithPlayView) {
        let song: SongModel = realm.objects(SongModel.self).filter("songId == \(sender.tag)").first ?? SongModel()
         
        let url = song.value(forKey: "songUrl") as! String
        var songName = ""
        var image: UIImage
        switch sender.tag {
        case 1:
            songName = "Regeneración"
            image = R.Images.firstPlayerImage.image
        case 2:
            songName = "Bienestar"
            image = R.Images.fifthPlayerImage.image
        case 3:
            songName = "Creatividad"
            image = R.Images.thirdPlayerImage.image
        case 4:
            songName = "Aprendizaje"
            image = R.Images.fourthPlayerImage.image
        case 5:
            songName = "Concentración"
            image = R.Images.secondPlayerImage.image
        default:
            songName = ""
            image = R.Images.fifthPlayerImage.image
        }
        delegate?.homeViewControllerDidSelectPlayer(with: url, and: songName, also: image, finally: sender.tag)
    }
    
    // MARK: - Helpers
    
    func verifyRecipt() {
        showLoading()
        if let appStoreReceiptURL = Bundle.main.appStoreReceiptURL,
            FileManager.default.fileExists(atPath: appStoreReceiptURL.path) {

            do {
                let receiptData = try Data(contentsOf: appStoreReceiptURL, options: .alwaysMapped)
                print(receiptData)

                let receiptString = receiptData.base64EncodedString(options: [])
                self.receiptData = receiptString

                bindReceiptData()
            }
            catch {
                print("Couldn't read receipt data with error: " + error.localizedDescription)
                
            }
        } else {
            dismiss(animated: true, completion: {
                KeychainWrapper.standard.set(false, forKey: K.premiumUserKey)
            })
        }
    }
    
    func bindReceiptData() {
        viewModel.getReceiptStatus(with: self.receiptData).subscribe(
            onSuccess: { [weak self] data in
                guard let self = self else { return }
                self.dismiss(animated: true, completion: {
                    if data.status == 0 {
                        KeychainWrapper.standard.set(true, forKey: K.premiumUserKey)
                    } else if data.status == 21006 {
                        self.showMessage(with: L10n.expiredSubscriptionMessage)
                        KeychainWrapper.standard.set(false, forKey: K.premiumUserKey)
                     } else if data.status == 21010 {
                        self.showMessage(with: L10n.userAccountNotFoundOrDeletedMessage)
                         KeychainWrapper.standard.set(false, forKey: K.premiumUserKey)
                     } else {
                        KeychainWrapper.standard.set(false, forKey: K.premiumUserKey)
                    }
                })
            }, onError: { [weak self] error in
                guard let self = self else { return }
                self.dismiss(animated: true, completion: {
                    self.showMessage(with: error.localizedDescription)
                    KeychainWrapper.standard.set(false, forKey: K.premiumUserKey)
                })
            }).disposed(by: disposeBag)
    }
    
    func showMessage(with message: String) {
        let alert = UIAlertController(title: L10n.appName, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: L10n.ok, style: .default, handler: {(action) in
            self.dismiss(animated: true, completion: nil)
        })
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
    
    public func showLoading() {
        let alert = UIAlertController(title: nil, message: L10n.loading, preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 60, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }
    
    private func bindViewModel() {
        if DefaultPreferences.current.lstOfSongs == nil ||
            DefaultPreferences.current.lstOfSongs?.count == 0
        {
        showLoading()
        viewModel.getSongs()
            .subscribe(onNext: {[weak self] items in
                guard let self = self else { return }
                self.dismiss(animated: true, completion: {
                    DefaultPreferences.current.lstOfSongs = items
                    do {
                        for songObj in items {
                            let song = SongModel()
                            song.songId = songObj.songId!
                            song.songUrl = songObj.songUrl!
                            song.songName = songObj.songName!
                            try self.realm.write {
                                self.realm.add(song)
                            }
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                    self.reachability.stopNotifier()
                    NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: self.reachability)
                })
            }, onError: {[weak self] error in
                guard let self = self else { return }
                self.reachability.stopNotifier()
                NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: self.reachability)
                print(error.localizedDescription)
            }).disposed(by: disposeBag)
        }
    }
}
