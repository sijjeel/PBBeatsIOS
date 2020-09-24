//
//  AppDelegate.swift
//  binauralbits
//
//  Created by Byron Chavarría on 2/22/20.
//  Copyright © 2020 Powerbraintuner. All rights reserved.
//

import UIKit
import RNCryptor
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var applicationCoordinator: ApplicationCoordinator?

    func dataEncrypt(fileURL: URL, destinationURL: URL) {
        do {
            let fileData = try NSData(contentsOf: fileURL, options: .mappedIfSafe)
            let encryptData = RNCryptor.encrypt(data: fileData as Data, withPassword: DefaultPreferences.current.defaultValue)
            try encryptData.write(to: destinationURL, options: .completeFileProtection)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        guard let window = self.window
            else { return false }
        
        let applicationCoordinator = ApplicationCoordinator(window: window)
        
        self.window = window
        self.applicationCoordinator = applicationCoordinator
        
        applicationCoordinator.start()
        
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        if DefaultPreferences.current.isFromPlayer && DefaultPreferences.current.urlSong != nil  {
            guard let url = DefaultPreferences.current.urlSong else { return }
            dataEncrypt(fileURL: url, destinationURL: url)
        }
    }
}

