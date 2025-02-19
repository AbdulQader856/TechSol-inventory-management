//
//  Constants.swift
//  TechSol
//
//  Created by fcp22 on 01/02/25.
//

import Foundation

struct Constants {
    // MARK: - Firestore Collections
    static let usersCollection = "users"
    static let inventoryCollection = "inventory"
    static let schedulesCollection = "schedules"

    // MARK: - User Roles
    static let adminRole = "admin"
    static let labAssistantRole = "labAssistant"

    // MARK: - Error Messages
    static let loginError = "Login failed. Please check your email and password."
    static let signUpError = "Sign up failed. Please try again."
    static let invalidEmail = "Please enter a valid email address."

    // MARK: - App Colors
    static let primaryColor = "PrimaryColor" // Define in Assets.xcassets
    static let secondaryColor = "SecondaryColor" // Define in Assets.xcassets

    // MARK: - App Fonts
    static let titleFont = "HelveticaNeue-Bold"
    static let bodyFont = "HelveticaNeue"
}
