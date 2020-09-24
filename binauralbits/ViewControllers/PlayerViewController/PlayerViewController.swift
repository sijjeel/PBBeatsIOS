//
//  PlayerViewController.swift
//  binauralbits
//
//  Created by Byron Chavarría on 2/26/20.
//  Copyright © 2020 Powerbraintuner. All rights reserved.
//

import UIKit
import AVKit
import RNCryptor
import Toast_Swift
import MediaPlayer
import AVFoundation
import Reachability

final class PlayerViewController: UIViewController {
    
    // MARK: - Components
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    lazy var principalImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var volumenImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = R.Images.volumeIcon.image
        return imageView
    }()
    
    lazy var progressBarView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.progressTintColor = .white
        progressView.trackTintColor = .gray
        return progressView
    }()
    
    lazy var volumeView: MPVolumeView = {
        let view = MPVolumeView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsVolumeSlider = true
        return view
    }()
    
    lazy var backgroundImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = R.Base.logo.image
        return image
    }()
    
    lazy var powerbrainLogoImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = R.Base.powerbrainLogo.image
        return image
    }()
    
    lazy var buttonsView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.alignment = .fill
        view.distribution = .fillEqually
        view.axis = .horizontal
        view.spacing = 0
        return view
    }()
    
    lazy var repeatButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(R.Images.repeatButton.image, for: .normal)
        return button
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(R.Images.previewButton.image, for: .normal)
        return button
    }()
    
    lazy var playButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(R.Images.playButton.image, for: .normal)
        return button
    }()
    
    lazy var stopButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(R.Images.stopButton.image, for: .normal)
        return button
    }()
    
    lazy var gradientView: CAGradientLayer = {
        let gradientView = CAGradientLayer()
        return gradientView
    }()
    
    lazy var infoImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = R.Base.infoImage.image
        image.isHidden = true
        return image
    }()
    
    lazy var footerView: UIView = {
        let bottomView = UIView()
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.backgroundColor = .white
        return bottomView
    }()
    
    lazy var downloadButton: ActionableButton = {
        let button = ActionableButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(L10n.download, for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    // MARK: - Attributes
    
    var songUrl: String!
    var songName: String?
    var URLData: URL? = nil
    var isFirstDownload: Bool = false
    
    //Use an AVPlayer
    var player: AVPlayer!
    var playerItem: AVPlayerItem!
    var audioSession = AVAudioSession.sharedInstance() // we only need to instantiate this once
    var observer: NSKeyValueObservation?
    weak var delegate: PlayerViewControllerDelegate?
    let reachability = try! Reachability()
    var isRepeatEnable: Bool = false
    var hideLoading: Bool = false
    var isReachable: Bool = true
    var nowPlayingInfo = [String : Any]()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gradientView.frame = view.bounds
        view.layer.insertSublayer(gradientView, at: 0)
        setupLayout()
        setupActions()
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        downloadButton.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        showLoading()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            if let audioUrl = URL(string: self.songUrl.replacingOccurrences(of: " ", with: "%20")) {
                // then lets create your document folder url
                let documentsDirectoryURL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                
                // lets create your destination file url
                let destinationUrl = documentsDirectoryURL.appendingPathComponent(audioUrl.lastPathComponent)
                
                self.URLData = destinationUrl
                
                // to check if it exists before downloading it
                if FileManager.default.fileExists(atPath: destinationUrl.path) {
                    self.hideLoading = true
                    self.playDataDecrypt(fileURL: destinationUrl, destinationsURL: destinationUrl)
                    // if the file doesn't exist
                } else {
                    if self.isReachable {
                        self.dismiss(animated: true, completion: {
                            self.downloadSong()
                            self.hideLoading = false
                            if let url = URL(string: self.songUrl.replacingOccurrences(of: " ", with: "%20")) {
                                self.playerItem = AVPlayerItem(url: url)
                                self.player = AVPlayer(playerItem: self.playerItem)
                                self.play()
                                self.setupAudioSession()
                            }
                        })
                    } else {
                        self.dismiss(animated: true, completion: {
                            let alert = UIAlertController(title: L10n.weSorry, message: L10n.rechableMessage, preferredStyle: .alert)
                            let alertAction = UIAlertAction(title: L10n.ok, style: .default) { (actions: UIAlertAction) in
                                alert.dismiss(animated: true, completion: {
                                    self.delegate?.playerViewControllerDidSelectBack()
                                })
                            }
                            alert.addAction(alertAction)
                            self.present(alert, animated: true, completion: nil)
                        })
                    }
                }
            } else {
                self.dismiss(animated: true, completion: {
                    let alert = UIAlertController(title: L10n.weSorry, message: L10n.needConnectionToInternet, preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: L10n.ok, style: .default) { (actions: UIAlertAction) in
                        alert.dismiss(animated: true, completion: {
                            self.delegate?.playerViewControllerDidSelectBack()
                        })
                    }
                    alert.addAction(alertAction)
                    self.present(alert, animated: true, completion: nil)
                })
            }
        })
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
        switch reachability.connection {
        case .wifi:
            isReachable = true
        case .cellular:
            isReachable = true
        case .unavailable:
            isReachable = false
            reachability.stopNotifier()
            NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: reachability)
        case .none:
            reachability.stopNotifier()
            self.dismiss(animated: true, completion: nil)
            reachability.stopNotifier()
            NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: reachability)
        }
    }
    
    // MARK: - Helpers
    
    func isSongDownloaded() -> Bool {
        if let audioUrl = URL(string: self.songUrl.replacingOccurrences(of: " ", with: "%20")) {
            
            // then lets create your document folder url
            let documentsDirectoryURL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            
            // lets create your destination file url
            let destinationUrl = documentsDirectoryURL.appendingPathComponent(audioUrl.lastPathComponent)
            
            self.URLData = destinationUrl
            
            // to check if it exists before downloading it
            if FileManager.default.fileExists(atPath: destinationUrl.path) {
                //downloadButton.isHidden = true
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
    
    @objc func playInterrupt(notification: NSNotification)
    {
        if notification.name == AVAudioSession.interruptionNotification && notification.userInfo != nil
        {
            let info = notification.userInfo!
            var intValue: UInt = 0

            (info[AVAudioSessionInterruptionTypeKey] as! NSValue).getValue(&intValue)

            if let type = AVAudioSession.InterruptionType(rawValue: intValue)
            {
                switch type {
                case .began:
                    player.pause()
                case .ended:
                    _ = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(resumeNow(timer:)), userInfo: nil, repeats: false)
                default:
                    print("default")
                }
            }
        }
    }
    
    @objc func playerDidEnd(notification: NSNotification) {
        if !isRepeatEnable {
            DefaultPreferences.current.isFromPlayer = false
            MPNowPlayingInfoCenter.default().nowPlayingInfo?.removeAll()
            MPNowPlayingInfoCenter.default().playbackState = .stopped
            if player != nil {
                player.replaceCurrentItem(with: nil)
            }
            if let url = URLData {
                if !isFirstDownload {
                    dataEncrypt(fileURL: url, destinationURL: url)
                    URLData = nil
                }
            }
            self.nowPlayingInfo.removeAll()
            delegate?.playerViewControllerDidSelectBack()
        }
    }

    @objc func resumeNow(timer : Timer) {
        player.play()
    }
    
    func setupAudioSession() {
        do {
            try audioSession.setCategory(.playback, mode: .spokenAudio, options: .allowAirPlay)
            try audioSession.setActive(true)
        } catch {
            print("Error setting the AVAudioSession:", error.localizedDescription)
        }
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(playInterrupt(notification:)),
            name: AVAudioSession.interruptionNotification, object: audioSession
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(playerDidEnd(notification:)),
            name: .AVPlayerItemDidPlayToEndTime, object: nil
        )
    }
    
    func play() {
        player.play()
        self.observer = player.observe(\.status, options:  [.new, .old], changeHandler: { (playerItem, change) in
            if self.player.rate == 1 {
                DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
                    Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateAudioProgressView), userInfo: nil, repeats: true)
                    self.progressBarView.setProgress(Float(playerItem.currentTime().seconds/self.playerItem.asset.duration.seconds), animated: false)
                    self.setupNowPlaying()
                    self.setupRemoteCommandCenter()
                    if self.hideLoading {
                        self.dismiss(animated: true, completion: nil)
                    }
                    self.playButton.setImage(R.Base.pauseButton.image, for: .normal)
                })
            }
        })
    }
    
    
    func setupNowPlaying() {
        // Define Now Playing Info
        let image = principalImage.image
        nowPlayingInfo[MPMediaItemPropertyTitle] = songName
        
        nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = playerItem.currentTime().seconds
        nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = playerItem.asset.duration.seconds
        nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = player.rate
        nowPlayingInfo[MPMediaItemPropertyArtwork] = MPMediaItemArtwork(boundsSize: CGSize(width: 10, height: 10), requestHandler: { (size) -> UIImage in
            return image!
        })
        
        // Set the metadata
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
        MPNowPlayingInfoCenter.default().playbackState = .playing
    }
    
    func updateCurrentTime() {
        nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = playerItem.currentTime().seconds
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
    }
    
    func setupRemoteCommandCenter() {
        let commandCenter = MPRemoteCommandCenter.shared();
        commandCenter.playCommand.isEnabled = true
        commandCenter.playCommand.addTarget {event in
            self.handlePlayAction()
            return .success
        }
        commandCenter.pauseCommand.isEnabled = true
        commandCenter.pauseCommand.addTarget {event in
            self.handlePauseAction()
            return .success
        }
        
        commandCenter.stopCommand.isEnabled = true
    }
    
    @objc private func handleRepeatAction() {
        if isRepeatEnable {
            self.view.makeToast(L10n.disableRepeat, duration: .pi)
            repeatButton.setImage(R.Images.repeatButton.image, for: .normal)
            isRepeatEnable = false
            NotificationCenter.default.removeObserver(self, name: .AVPlayerItemDidPlayToEndTime, object: reachability)
        } else {
            isRepeatEnable = true
            self.view.makeToast(L10n.songWillBeRepeated, duration: .pi)
            repeatButton.setImage(R.Images.selectedRepeatButton.image, for: .normal)
            NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: nil) { (_) in
                self.player.seek(to: CMTime.zero)
                self.player.pause()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    self.player.play()
                    self.setupNowPlaying()
                })
            }
        }
    }
    
    @objc private func handleBackAction() {
        player?.seek(to: .zero)
        player?.pause()
        progressBarView.setProgress(0.0, animated: true)
        setupNowPlaying()
//        updateCurrentTime()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            self.player.play()
            self.setupNowPlaying()
//            self.updateCurrentTime()
        })
    }
    
    @objc private func handlePlayPauseAction() {
        //setupNowPlaying()
        if ((player.rate != 0) && (player.error == nil)) {
            handlePauseAction()
        } else {
            handlePlayAction()
        }
    }
    
    private func handlePlayAction(){
        player?.play()
        playButton.setImage(R.Base.pauseButton.image, for: .normal)
        updateCurrentTime()
        //setupNowPlaying()
    }
    
    private func handlePauseAction(){
        player?.pause()
        playButton.setImage(R.Images.playButton.image, for: .normal)
        //setupNowPlaying()
    }
    
    @objc private func handleStopAction() {
        player?.seek(to: .zero)
        player?.pause()
        progressBarView.setProgress(0.0, animated: true)
        
        DefaultPreferences.current.isFromPlayer = false
        MPNowPlayingInfoCenter.default().nowPlayingInfo?.removeAll()
        MPNowPlayingInfoCenter.default().playbackState = .stopped
        if player != nil {
            player.replaceCurrentItem(with: nil)
        }
        if let url = URLData {
            if !isFirstDownload {
                dataEncrypt(fileURL: url, destinationURL: url)
                URLData = nil
            }
        }
        self.nowPlayingInfo.removeAll()
        delegate?.playerViewControllerDidSelectBack()
    }
    
    private func setupActions() {
        repeatButton.addTarget(self, action: #selector(handleRepeatAction), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(handleBackAction), for: .touchUpInside)
        playButton.addTarget(self, action: #selector(handlePlayPauseAction), for: .touchUpInside)
        stopButton.addTarget(self, action: #selector(handleStopAction), for: .touchUpInside)
    }
    
    @objc func updateAudioProgressView() {
        if player.currentItem?.status == AVPlayerItem.Status.readyToPlay
        {
            // Update progress
            progressBarView.setProgress(Float(playerItem.currentTime().seconds/playerItem.asset.duration.seconds), animated: true)
        }
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
    
    public func showDownloadLoading() {
        let alert = UIAlertController(title: L10n.donwloadTitle, message: L10n.downloadMessage, preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 60, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }
    
    func dataEncrypt(fileURL: URL, destinationURL: URL) {
        do {
            let fileData = try NSData(contentsOf: fileURL, options: .mappedIfSafe)
            let encryptData = RNCryptor.encrypt(data: fileData as Data, withPassword: DefaultPreferences.current.defaultValue)
            try encryptData.write(to: destinationURL, options: .completeFileProtection)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func defaultErrorMessage() {
        let alert = UIAlertController(title: L10n.weSorry,
                                      message: L10n.defaultErrorMessage,
                                      preferredStyle: .alert)
        let alertAction = UIAlertAction(title: L10n.ok, style: .default) { (actions: UIAlertAction) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(alertAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func playDataDecrypt(fileURL: URL, destinationsURL: URL) {
        DefaultPreferences.current.urlSong = destinationsURL
        DefaultPreferences.current.isFromPlayer = true
        do {
            let fileData = try NSData(contentsOf: fileURL, options: .mappedIfSafe)
            let data = try RNCryptor.decrypt(data: fileData as Data, withPassword: DefaultPreferences.current.defaultValue)
            try data.write(to: destinationsURL, options: .completeFileProtection)
            self.playerItem = AVPlayerItem(url: destinationsURL)
            self.player = AVPlayer(playerItem: self.playerItem)
            self.play()
            self.setupAudioSession()
        } catch {
            self.dismiss(animated: true, completion: {
                self.defaultErrorMessage()
            })
        }
    }
    
    private func downloadSong() {
        showDownloadLoading()
        if isSongDownloaded() {
            dismiss(animated: true, completion: {
                let alert = UIAlertController(title: nil, message: L10n.fileAllreadyExist, preferredStyle: .alert)
                let alertAction = UIAlertAction(title: L10n.ok, style: .default) { (actions: UIAlertAction) in
                    alert.dismiss(animated: true, completion: nil)
                }
                alert.addAction(alertAction)
                self.present(alert, animated: true, completion: nil)
            })
            // if the file doesn't exist
        } else {
            // you can use NSURLSession.sharedSession to download the data asynchronously
            if let audioUrl = URL(string: self.songUrl.replacingOccurrences(of: " ", with: "%20")) {
                // then lets create your document folder url
                let documentsDirectoryURL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                
                // lets create your destination file url
                let destinationUrl = documentsDirectoryURL.appendingPathComponent(audioUrl.lastPathComponent)
                URLSession.shared.downloadTask(with: audioUrl) { location, response, error in
                    if  !(error != nil) {
                        guard let location = location, error == nil else { return }
                        do {
                            // after downloading your file you need to move it to your destination url
                            try FileManager.default.moveItem(at: location, to: destinationUrl)
                            self.URLData = destinationUrl
                            self.isFirstDownload = true
                            self.dataEncrypt(fileURL: destinationUrl, destinationURL: destinationUrl)
                            DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
                                self.dismiss(animated: true, completion: {
                                    let alert = UIAlertController(title: L10n.correct, message: L10n.downloadComplete, preferredStyle: .alert)
                                    let alertAction = UIAlertAction(title: L10n.ok, style: .default) { (actions: UIAlertAction) in
                                        alert.dismiss(animated: true, completion: nil)
                                    }
                                    alert.addAction(alertAction)
                                    self.present(alert, animated: true, completion: nil)
                                })
                            })
                        } catch {
                            DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
                                self.defaultErrorMessage()
                            })
                        }
                    } else {
                        DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
                            self.defaultErrorMessage()
                        })
                    }
                }.resume()
            }
        }
    }
}

extension PlayerViewController: AVAudioPlayerDelegate { }
