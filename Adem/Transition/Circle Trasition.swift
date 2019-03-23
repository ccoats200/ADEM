//
//  Circle Trasition.swift
//  Adem
//
//  Created by Coleman Coats on 3/2/19.
//  Copyright © 2019 Coleman Coats. All rights reserved.
//

import Foundation
import UIKit

class TransitionCoordinator: NSObject, UINavigationControllerDelegate {
	
	func navigationController(_ navigationController: UINavigationController,
							  animationControllerFor operation: UINavigationController.Operation,
							  from fromVC: UIViewController,
							  to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		return CircularTransition()
	}

	
}



