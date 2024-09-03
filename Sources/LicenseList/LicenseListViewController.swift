import UIKit
import SwiftUI

/// A view controller that specializes in managing a license list view.
///
/// A view controller implements the following behavior:
/// - Displays a list of libraries that your project depends on via Swift Package Manager.
/// - The list is sorted alphabetically by library name.
/// - Selecting each library will open a details page where you can view the license body.
@available(iOS 15, *)
public class LicenseListViewController: UIViewController {
    /// The style that specifies behavior of license views.
    public var licenseViewStyle: LicenseViewStyle = .plain

    /// Creates a license list view controller.
    public init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Called after the controller's view is loaded into memory.
    ///
    /// The view controller embeds ``LicenseListView`` as a child view using UIHostingController.
    public override func viewDidLoad() {
        super.viewDidLoad()
        let licenseListView = LicenseListView() { [weak self] library in
            self?.navigateTo(library: library)
        }
        let vc = UIHostingController(rootView: licenseListView)
        self.addChild(vc)
        self.view.addSubview(vc.view)
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        vc.view.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        vc.view.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        vc.view.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        vc.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }

    private func navigateTo(library: Library) {
        let hostingController = UIHostingController(
            rootView: LicenseView(library: library).licenseViewStyle(licenseViewStyle)
        )
        hostingController.title = library.name
        self.navigationController?.pushViewController(hostingController, animated: true)
    }
}
