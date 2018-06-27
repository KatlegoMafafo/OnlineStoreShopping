import UIKit

class Logout: UITabBarController{
    
    @IBOutlet weak var labelItemCustomer: UIBarButtonItem!
    
    @IBAction func logoutButtonPressed(_ sender: Any) {
        
        self.performSegue(withIdentifier: "logOutButtonPressed", sender: self)
    }
} // end of code
