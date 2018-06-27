import UIKit

class RegsiterPageViewController: UIViewController {

    @IBOutlet weak var fnameTxt: UITextField!
    @IBOutlet weak var snameTxt: UITextField!
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var numbersTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var confirmPasswordTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func registerBtnPress(_ sender: Any) {
        

        if(fnameTxt.text != "")
        {
            if(snameTxt.text != "")
            {
                if(usernameTxt.text != "")
                {
                    if(numbersTxt.text != "")
                    {
                        if(emailTxt.text != "")
                        {
                            if(passwordTxt.text == confirmPasswordTxt.text)
                            {
                               
                                let url = NSURL(string: "http://katlego96t.000webhostapp.com/registration.php")
                                // locahost MAMP - change to point to your database server
                                
                                var request = URLRequest(url: url! as URL)
                                request.httpMethod = "POST"
                                
                                var dataString = "secretWord=44fdcv8jf3" // starting POST string with a secretWord
                                
                                // the POST string has entries separated by &
                                
                                print()
                                dataString = dataString + "&fName=\(fnameTxt.text!)" // add items as name and value
                                dataString = dataString + "&lName=\(snameTxt.text!)"
                                dataString = dataString + "&username=\(usernameTxt.text!)"
                                dataString = dataString + "&password=\(passwordTxt.text!)"
                                dataString = dataString + "&email=\(emailTxt.text!)"
                                dataString = dataString + "&pNumber=\(numbersTxt.text!)"
                                
                                // convert the post string to utf8 format
                                let name = fnameTxt.text!
                                
                                let dataD = dataString.data(using: .utf8) // convert to utf8 string
                                
                                do
                                {
                                    
                                    // the upload task, uploadJob, is defined here
                                    
                                    let uploadJob = URLSession.shared.uploadTask(with: request, from: dataD)
                                    {
                                        data, response, error in
                                        
                                        if error != nil {
                                            
                                            // display an alert if there is an error inside the DispatchQueue.main.async
                                            
                                            DispatchQueue.main.async
                                                {
                                                    let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
                                                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                                                    self.present(alert, animated: true, completion: nil)
                                            }
                                        }
                                        else
                                        {
                                            if let unwrappedData = data {
                                                
                                                let returnedData = NSString(data: unwrappedData, encoding: String.Encoding.utf8.rawValue) // Response from web server hosting the database
                                                
                                                if returnedData == "1" // insert into database worked
                                                {
                                                    
                                                    // display an alert if no error and database insert worked (return = 1) inside the DispatchQueue.main.async
                                                    
                                                    DispatchQueue.main.async
                                                        {
                                                            let alert = UIAlertController(title: "Registeration succesful", message: name + ", you've sucessfully registered", preferredStyle: .alert)
                                                            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                                                            self.present(alert, animated: true, completion: nil)
                                                    }
                                                }
                                                else
                                                {
                                                    // display an alert if an error and database insert didn't worked (return != 1) inside the DispatchQueue.main.async
                                                    
                                                    DispatchQueue.main.async
                                                        {
                                                            
                                                            let alert = UIAlertController(title: "Upload Didn't Work", message: "Looks like the insert into the database did not worked.", preferredStyle: .alert)
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
                            else
                            {
                                let alert = UIAlertController(title: "Registeration Failed", message: "Passwords do not match", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                                self.present(alert, animated: true, completion: nil)
                            }
                        }
                        else
                        {
                            let alert = UIAlertController(title: "Registeration Failed", message: "Please enter email", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                    else
                    {
                        let alert = UIAlertController(title: "Registeration Failed", message: "Please enter username", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
                else
                {
                    let alert = UIAlertController(title: "Registeration Failed", message: "Please enter cellphone numbers", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
            else
            {
                let alert = UIAlertController(title: "Registeration Failed", message: "Please enter last name", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        else
        {
            let alert = UIAlertController(title: "Registeration Failed", message: "Please enter first name", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }

}}
 // end of code
