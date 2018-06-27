import UIKit
import CoreLocation

class HomePageViewController: UITableViewController{

    var forecastData = [ProductItem]()
    
    
    var NameOfSelecetedProduct = ""
    
    //@IBOutlet weak var productImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ProductItem.forecast(completion: { (results:[ProductItem]?) in
            
            if let weatherData = results {
                self.forecastData = weatherData
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            }
            
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        print(forecastData.count);
        return forecastData.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.estimatedRowHeight = 321
        tableView.rowHeight = 321
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
        
        let weatherObject = forecastData[indexPath.section]
        //print(weatherObject)
        //cell.textLabel?.text = weatherObject.ProductName
        //cell.detailTextLabel?.text = "R \((weatherObject.Price))"
        
        cell.productName.text = weatherObject.ProductName
        cell.productPeric.text = "R \((weatherObject.Price))"
        //let url = URL(string:weatherObject.IMG_URL)
        let imageUrlString: String = weatherObject.IMG_URL

        let test = String(imageUrlString.filter { !" \n\t\r".contains($0) })
        
        var imageUrl = URL(string: test)!
        
        var imageData = try! Data(contentsOf: imageUrl)
        
        var image = UIImage(data: imageData)
        
        //cell.imageView?.image = UIImage(data: imageData)
        
       
        cell.imageB?.image = UIImage(data: imageData)
        //cell.imageView_01?.image = UIImage(data: imageData)
        NameOfSelecetedProduct = weatherObject.ProductName
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView,didSelectRowAt indexPath: IndexPath) {
        let productSelected = forecastData[indexPath.section]
        print("Logged in user is : ")
        let defaults = UserDefaults.standard
        var email = defaults.string(forKey: "Email")
       
        var b = ""
        b = (email?.replacingOccurrences(of: "Optional(", with:""))!
        print(b)
    
        
        let alertController = UIAlertController(title: "Add to Cart", message: "Are you sure you want to add \(productSelected.ProductName) to your cart", preferredStyle: .alert)
        
        // Create the actions
        let okAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.default) {
            UIAlertAction in
            
            let url = NSURL(string: "http://katlego96t.000webhostapp.com/AddCart.php") // locahost MAMP - change to point to your database server
            
            var request = URLRequest(url: url! as URL)
            request.httpMethod = "POST"
            
            var dataString = "secretWord=44fdcv8jf3" // starting POST string with a secretWord
            
            // the POST string has entries separated by &
            
            print()
            dataString = dataString + "&txtName=\(productSelected.ProductName)" // add items as name and value
            dataString = dataString + "&txtDesc=\(productSelected.Description)"
            dataString = dataString + "&txtQty=\(0)"
            dataString = dataString + "&txtPrice=\(productSelected.Price)"
            dataString = dataString + "&txtImageUrl=\(productSelected.IMG_URL)"
            dataString = dataString + "&txtCustomer=\(b)"
            
            
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
                                let alert = UIAlertController(title: "Upload Didn't Work11111?", message: "Looks like the connection to the server didn't work.  Do you have Internet access?", preferredStyle: .alert)
                                //alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
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
                            
                                }
                            }
                            else
                            {
                                // display an alert if an error and database insert didn't worked (return != 1) inside the DispatchQueue.main.async
                                
                                DispatchQueue.main.async
                                    {
                                }
                            }
                        }
                    }
                }
                uploadJob.resume()
                
            }
            
            
        }
        let cancelAction = UIAlertAction(title: "No", style: UIAlertActionStyle.cancel) {
            UIAlertAction in
            NSLog("Cancel Pressed")
        }
        
        // Add the actions
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        // Present the controller
        self.present(alertController, animated: true, completion: nil)
        
        print("You selected cell number: \(indexPath.section)!")
    
        //self.performSegue(withIdentifier: "Cell", sender: self)
    }
  }
 }
} // end of code
