import UIKit

class PaymentPageViewController: UIViewController {


    @IBOutlet weak var cardHolderTxt: UITextField!
    @IBOutlet weak var cardNumTxt: UITextField!
    @IBOutlet weak var cardType: UITextField!
    @IBOutlet weak var expireMonth: UITextField!
    @IBOutlet weak var expireYear: UITextField!
    @IBOutlet weak var cvcTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func bckBttnPressed(_ sender: Any) {
        
        self.performSegue(withIdentifier: "backToHomePage", sender: self)
    }
    
    @IBAction func proceedBttnPressed(_ sender: Any) {
        
        if(cardHolderTxt.text != "")
        {
            if(cardNumTxt.text != "")
            {
                if(cardType.text != "")
                {
                    if(expireYear.text != "")
                    {
                        if(expireMonth.text != "")
                        {
                            if(cvcTxt.text != "")
                            {
                                let defaults = UserDefaults.standard
                                var email = defaults.string(forKey: "Email")
                                
                                var b = ""
                                b = (email?.replacingOccurrences(of: "Optional(", with:""))!
                                
                                let url = NSURL(string: "http://katlego96t.000webhostapp.com/addCard.php") // locahost MAMP - change to point to your database server
                                
                                var request = URLRequest(url: url! as URL)
                                request.httpMethod = "POST"
                                
                                var dataString = "secretWord=44fdcv8jf3"
                                
                                // the POST string has entries separated by &
                                
                                print()
                                dataString = dataString + "&txtHolder=\(cardHolderTxt.text!)" // add items as name and value
                                dataString = dataString + "&txtNum=\(cardNumTxt.text!)"
                                dataString = dataString + "&txtType=\(cardType.text!)"
                                dataString = dataString + "&txtExpMonth=\(expireMonth.text!)"
                                dataString = dataString + "&txtExpYear=\(expireYear.text!)"
                                dataString = dataString + "&txtCvc=\(cvcTxt.text!)"
                                dataString = dataString + "&email=\(b)"
                                
                                // convert the post string to utf8 format
                                
                                
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
                                                    let alert = UIAlertController(title: "Upload Didn't Work?", message: "Looks like the connection to the server didn't work.  Do you have Internet access?", preferredStyle: .alert)
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
                                                    
                                                    
                                                    DispatchQueue.main.async
                                                        {
                                                            let alert = UIAlertController(title: "Payment", message:"You're payment has been sucessfully purschased", preferredStyle: .alert)
                                                            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                                                            self.present(alert, animated: true, completion: nil)
                                                    }
                                                }
                                                else
                                                {
                                                    
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
                                
                            }
                        }
                        else
                        {
                            
                        }
                        
                    }
                    else
                    {
                        
                    }
                }
                else
                {
                    
                }
            }
            else
            {
                
            }
            
        }
        else
        {
            
        }
    }
    
} // end of code
