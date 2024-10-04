import UIKit
/*
 UIViewControllerTransitioningDelegate's responsibility is to handle pairing for the correct presentation controller, animation controller and interaction controller for the presentation.
 */
class BottomSheetTransition: NSObject, UIViewControllerTransitioningDelegate {
    private let configuration: BottomSheetTransitionConfiguration
    private var animationController: BottomSheetAnimationController!

    init(configuration: BottomSheetTransitionConfiguration) {
        self.configuration = configuration
    }

    func presentationController(
        forPresented presented: UIViewController,
        presenting: UIViewController?,
        source _: UIViewController
    ) -> UIPresentationController? {
        animationController = nil
        return BottomSheetPresentationController(
            presentedViewController: presented,
            presenting: presenting,
            configuration: configuration
        )
    }

    func animationController(
        forPresented presented: UIViewController,
        presenting _: UIViewController,
        source _: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        if animationController == nil {
            animationController = BottomSheetAnimationController(
                presentedViewController: presented,
                configuration: configuration
            )
        }
        return animationController
    }

    func animationController(forDismissed _: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animationController
    }

    func interactionControllerForPresentation(using _: any UIViewControllerAnimatedTransitioning) -> (any UIViewControllerInteractiveTransitioning)? {
        nil
    }

    func interactionControllerForDismissal(using _: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        animationController.isInteracting ? animationController : nil
    }
}
