// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(OSX)
  import AppKit.NSImage
  internal typealias AssetColorTypeAlias = NSColor
  internal typealias AssetImageTypeAlias = NSImage
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIImage
  internal typealias AssetColorTypeAlias = UIColor
  internal typealias AssetImageTypeAlias = UIImage
#endif

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum R {
  internal enum Base {
    internal static let playButtonOverImage = ImageAsset(name: "PlayButtonOverImage")
    internal static let backImage = ImageAsset(name: "backImage")
    internal static let closeButton = ImageAsset(name: "closeButton")
    internal static let infoImage = ImageAsset(name: "infoImage")
    internal static let informationButton = ImageAsset(name: "informationButton")
    internal static let logo = ImageAsset(name: "logo")
    internal static let pauseButton = ImageAsset(name: "pauseButton")
    internal static let powerbrainLogo = ImageAsset(name: "powerbrainLogo")
  }
  internal enum Colors {
    internal static let colorBottom = ColorAsset(name: "ColorBottom")
    internal static let colorTop = ColorAsset(name: "ColorTop")
    internal static let informationViewColor = ColorAsset(name: "InformationViewColor")
    internal static let logoColor = ColorAsset(name: "LogoColor")
    internal static let backgoundColor = ColorAsset(name: "backgoundColor")
    internal static let blue = ColorAsset(name: "blue")
    internal static let contactSupportViewColor = ColorAsset(name: "contactSupportViewColor")
  }
  internal enum Images {
    internal static let fifthImage = ImageAsset(name: "FifthImage")
    internal static let inAppPurchaseIcon = ImageAsset(name: "InAppPurchaseIcon")
    internal static let secondSong = ImageAsset(name: "SecondSong")
    internal static let thirdSong = ImageAsset(name: "ThirdSong")
    internal static let closeIcon = ImageAsset(name: "closeIcon")
    internal static let dot = ImageAsset(name: "dot")
    internal static let fifthPlayerImage = ImageAsset(name: "fifthPlayerImage")
    internal static let firstPlayerImage = ImageAsset(name: "firstPlayerImage")
    internal static let firstSong = ImageAsset(name: "firstSong")
    internal static let fourthImage = ImageAsset(name: "fourthImage")
    internal static let fourthPlayerImage = ImageAsset(name: "fourthPlayerImage")
    internal static let playButton = ImageAsset(name: "playButton")
    internal static let previewButton = ImageAsset(name: "previewButton")
    internal static let repeatButton = ImageAsset(name: "repeatButton")
    internal static let secondPlayerImage = ImageAsset(name: "secondPlayerImage")
    internal static let selectedRepeatButton = ImageAsset(name: "selectedRepeatButton")
    internal static let stopButton = ImageAsset(name: "stopButton")
    internal static let thirdPlayerImage = ImageAsset(name: "thirdPlayerImage")
    internal static let volumeIcon = ImageAsset(name: "volumeIcon")
  }
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal struct ColorAsset {
  internal fileprivate(set) var name: String

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, OSX 10.13, *)
  internal var color: AssetColorTypeAlias {
    return AssetColorTypeAlias(asset: self)
  }
}

internal extension AssetColorTypeAlias {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, OSX 10.13, *)
  convenience init!(asset: ColorAsset) {
    let bundle = Bundle(for: BundleToken.self)
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

internal struct DataAsset {
  internal fileprivate(set) var name: String

  #if os(iOS) || os(tvOS) || os(OSX)
  @available(iOS 9.0, tvOS 9.0, OSX 10.11, *)
  internal var data: NSDataAsset {
    return NSDataAsset(asset: self)
  }
  #endif
}

#if os(iOS) || os(tvOS) || os(OSX)
@available(iOS 9.0, tvOS 9.0, OSX 10.11, *)
internal extension NSDataAsset {
  convenience init!(asset: DataAsset) {
    let bundle = Bundle(for: BundleToken.self)
    #if os(iOS) || os(tvOS)
    self.init(name: asset.name, bundle: bundle)
    #elseif os(OSX)
    self.init(name: NSDataAsset.Name(asset.name), bundle: bundle)
    #endif
  }
}
#endif

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  internal var image: AssetImageTypeAlias {
    let bundle = Bundle(for: BundleToken.self)
    #if os(iOS) || os(tvOS)
    let image = AssetImageTypeAlias(named: name, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    let image = bundle.image(forResource: NSImage.Name(name))
    #elseif os(watchOS)
    let image = AssetImageTypeAlias(named: name)
    #endif
    guard let result = image else { fatalError("Unable to load image named \(name).") }
    return result
  }
}

internal extension AssetImageTypeAlias {
  @available(iOS 1.0, tvOS 1.0, watchOS 1.0, *)
  @available(OSX, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init!(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = Bundle(for: BundleToken.self)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

private final class BundleToken {}
