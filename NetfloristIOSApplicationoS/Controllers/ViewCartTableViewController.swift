import UIKit

class ViewCartTableViewController: UITableViewController {

    
    var totalPrice = 0.00
    var cartData = [Cart]()
    
    @IBOutlet weak var totalPriceLbl: UILabel!
    
    @IBOutlet weak var quantityLbl2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        var email = defaults.string(forKey: "Email")
        
        var b = ""
        b = (email?.replacingOccurrences(of: "Optional(", with:""))!
        
        print("Works")
        
        Cart.forecast(completion: { (results:[Cart]?) in
            
            if let weatherData = results {
                self.cartData = weatherData
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        })
    }

    
    var nameOfRemove = "";
    @IBAction func removeProduct(_ sender: Any) {
        
        
        
        var superview = (sender as AnyObject).superview
        while let view = superview, !(view is UITableViewCell) {
            superview = view?.superview
        }
        guard let cell = superview as? UITableViewCell else {
            print("button is not contained in a table view cell")
            return
        }
        guard let indexPath = tableView.indexPath(for: cell) else {
            print("failed to get index path for cell containing button")
            return
        }
        
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl!)
        }
        
        // We've got the index path for the cell that contains the button, now do something with it
        let productObject = cartData[indexPath.section]
        nameOfRemove = productObject.name
        
        let defaults = UserDefaults.standard
        var email = defaults.string(forKey: "Email")
        
        var b = ""
        b = (email?.replacingOccurrences(of: "Optional(", with:""))!
        
        let url = NSURL(string: "http://katlego96t.000webhostapp.com/Removecart.php") // locahost MAMP - change to point to your database server
        
        var request = URLRequest(url: url! as URL)
        request.httpMethod = "POST"
        
        var dataString = "secretWord=44fdcv8jf3" // starting POST string with a secretWord
        
        // the POST string has entries separated by &
        
        dataString = dataString + "&email=\(b)" // add items as name and value
        dataString = dataString + "&prodName=\(nameOfRemove)"
        
        //print(emailTxt.text!)
        // convert the post string to utf8 format
        
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
                        
                        let defaults = UserDefaults.standard
                        defaults.set(email, forKey: "Email")
                        //User(email: self.emailTxt.text!)
                        
                        if returnedData == "1" // insert into database worked
                        {
                            
                            // display an alert if no error and database insert worked (return = 1) inside the DispatchQueue.main.async
                            
                            DispatchQueue.main.async
                                {
                                    let alert = UIAlertController(title: "Remove product", message: self.nameOfRemove + " has been removed from your cart", preferredStyle: .alert)
                                    
                                    
                            }
                        }
                        else
                        {
                            
                            DispatchQueue.main.async
                                {
                                    
                                    let alert = UIAlertController(title: "Unsuccesfully registered", message: "Please check the entered information carefully!", preferredStyle: .alert)
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        print(cartData.count);
        return cartData.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.estimatedRowHeight = 170
        tableView.rowHeight = 170
        let cell = tableView.dequeueReusableCell(withIdentifier: "ViewCartTableViewCell", for: indexPath) as! ViewCartTableViewCell
        
        let weatherObject = cartData[indexPath.section]
        
        cell.prodName.text = weatherObject.name
        cell.prodprice?.text = "R\((weatherObject.price))"
        
        
        var price = Double(weatherObject.price)
        
        totalPrice = totalPrice + price!

        let imageUrlString: String = weatherObject.img_url
        
        let test = String(imageUrlString.filter { !" \n\t\r".contains($0) })
        
        var imageUrl = URL(string: test)!
        
        var imageData = try! Data(contentsOf: imageUrl)
        
        var image = UIImage(data: imageData)
        
        cell.imageViewA?.image = UIImage(data: imageData)
        
        totalPrice = totalPrice + price!

        self.totalPriceLbl.text = "The total price :R\(totalPrice)"
        
        return cell
    }
    
    func getItem() -> String
    {
        return nameOfRemove
    }
    
    func setItem(productName: String)
    {
        
    }
    
    override func tableView(_ tableView: UITableView,didSelectRowAt indexPath: IndexPath) {
        let productSelected = cartData[indexPath.section]
        
        nameOfRemove = productSelected.name;
        
    }
    @IBAction func makePaymentBttn(_ sender: Any) {
        self.performSegue(withIdentifier: "makePaymentPage", sender: self)
        
    }
} // end of code
