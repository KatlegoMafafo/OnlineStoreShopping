import UIKit
import CoreLocation


class LoginPageViewController: UIViewController {
    
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func loginPress(_ sender: Any) {
        
        let url = NSURL(string: "http://katlego96t.000webhostapp.com/login.php") // locahost MAMP - change to point to your database server
        
        var request = URLRequest(url: url! as URL)
        request.httpMethod = "POST"
        
        var dataString = "secretWord=44fdc74jf3" // starting POST string with a secretWord
        
        
        dataString = dataString + "&email=\(emailTxt.text!)" // add items as name and value
        dataString = dataString + "&password=\(passwordTxt.text!)"
        
        print(emailTxt.text!)
        
        
        let dataD = dataString.data(using: .utf8) // convert to utf8 string
        
        do
        {
            // the upload task, uploadJob, is defined here
            print("Returned data is : ")
            let uploadJob = URLSession.shared.uploadTask(with: request, from: dataD)
            {
                data, response, error in
                
                if error != nil {
                    
                    // display an alert if there is an error inside the DispatchQueue.main.async
                    
                    DispatchQueue.main.async
                        {
                            let alertController = UIAlertController(title: "Failed", message: "Please ensure you've provided the correct email address and password ", preferredStyle: .alert)
                            self.present(alertController, animated: true, completion: nil)
                    }
                }
                else
                {
                    if let unwrappedData = data {
                        
                        let returnedData = NSString(data: unwrappedData, encoding: String.Encoding.utf8.rawValue) // Response from web server hosting the database
                        
                        let email = self.emailTxt.text
                        let defaults = UserDefaults.standard
                        defaults.set(email, forKey: "email")
                        //User(email: self.emailTxt.text!)
                        
                        if returnedData == "1"
                            // insert into database worked
                        {
                            DispatchQueue.main.async
                                {
                                    self.performSegue(withIdentifier: "HomePage", sender: self)
                            }
                        }
                        else
                        {
                            // display an alert if an error and database insert didn't worked (return != 1) inside the DispatchQueue.main.async
                            DispatchQueue.main.async
                                {
                                    
                                    let alert = UIAlertController(title: "Failed to register", message: "Try again!", preferredStyle: .alert)
                                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                                    self.present(alert, animated: true, completion: nil)
                            }
                        }
                    }
                }
            }
            uploadJob.resume()
        }
        
    }
    @IBAction func signupBtnPress(_ sender: Any) {
        self.performSegue(withIdentifier: "registerpage", sender: self)
    }
} // end of code
