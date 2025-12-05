//
//  UserDefaultsHandler.swift
//  TestCursor
//
//  Created by Ahmed Abdo on 04/12/2025.
//

import Foundation

class UserDefaultsHandler {
    // MARK: - enum containing userDefault keys for unified access
    enum UDKeys: String {
        case doneOnboarding
        case userAnswers
        case currentScreenIndex
    }
    
    // MARK: - Properties
    static var shared: UserDefaultsHandler = .init()
    private var userDefaults: UserDefaults = .standard
    
    // MARK: - Private initializer (Singleton)
    private init() {}
    
    /// Check whether onboarding flow is done
    var doneOnboarding: Bool {
        get {
            return userDefaults.bool(forKey: UDKeys.doneOnboarding.rawValue)
        } set {
            userDefaults.set(newValue, forKey: UDKeys.doneOnboarding.rawValue)
        }
    }
    
    /// OnBoarding Answers
    var onBoardingUserAnswers: [OnBoardingScreenType]? {
        get {
            return get([OnBoardingScreenType].self, forKey: .userAnswers)
        } set {
            set(newValue, forKey: .userAnswers)
        }
    }
    
    /// Saving the current onboarding screen index to scroll to it on the next app opening
    var currentScreenIndex: Int {
        get {
            return userDefaults.integer(forKey: UDKeys.currentScreenIndex.rawValue)
        } set {
            userDefaults.set(newValue, forKey: UDKeys.currentScreenIndex.rawValue)
        }
    }
    
    /// User name
    var userName: String {
        onBoardingUserAnswers?.first(where: { $0 == .nameEntry(name: "") })?.getUserName() ?? ""
    }
    
    /// Selected theme
    var selectedTheme: Themes {
        onBoardingUserAnswers?.first(where: { $0 == .themeSelection(data: ThemeSelectionViewData(question: "")) })?.getSelectedTheme() ?? .theme1
    }
    
    // MARK: - Setting codable data in UD
    func set<T: Codable>(_ value: T, forKey key: UDKeys) {
        if let data = try? JSONEncoder().encode(value) {
            userDefaults.set(data, forKey: key.rawValue)
        }
    }
    
    // MARK: - Getting codable data from UD
    func get<T: Codable>(_ type: T.Type, forKey key: UDKeys) -> T? {
        guard let data = userDefaults.data(forKey: key.rawValue) else { return nil }
        return try? JSONDecoder().decode(T.self, from: data)
    }
}
