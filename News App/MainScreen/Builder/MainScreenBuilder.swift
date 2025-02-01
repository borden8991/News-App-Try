//
//  MainScreenBuilder.swift
//  News App
//
//  Created by Denis Borovoi on 04.01.2025.
//

import UIKit

final class MainScreenBuilder {
    class func createMainScreen() -> UIViewController {
        let view = ViewController()
        let presenter = MainPresenter(view: view)
        view.presenter = presenter
        print("created main screen")
        return view
    }
}
