//
//  FirstViewController.swift
//  Sample
//
//  Created by SysBig on 16/10/17.
//  Copyright © 2017 SysBig. All rights reserved.
//

import UIKit
import TwitterKit

class FirstViewController: UIViewController {

    @IBOutlet weak var twitterButton: TWTRLogInButton!
    @IBOutlet weak var thirdLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var textFieldThird: UITextField!
    @IBOutlet weak var textfieldSecond: UITextField!
    @IBOutlet weak var textFieldFirst: UITextField!
    var imageData : Data?
    var count = 0
    
    @IBOutlet weak var l2: UILabel!
    @IBOutlet weak var l1: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print(l1.frame)
        print(l2.frame)
    }
    func getTwitterAccount()
    {
        let  twitterButton = TWTRLogInButton(logInCompletion: { session, error in
            if let loginSession = session
            {
                print("signed in as \(String(describing: loginSession.userName))")
                
                let client = TWTRAPIClient(userID:loginSession.userID)
                client.loadUser(withID: loginSession.userID, completion: { (user, error) in
                    if let userData = user
                    {
                        print(userData.profileURL)
                        print(userData.profileImageLargeURL)
                        print(userData.profileImageMiniURL)
                        print(userData.screenName)
                        print(userData.name)
                        
                        let client = TWTRAPIClient.withCurrentUser()
                        let request = client.urlRequest(withMethod: "GET", url: "https://api.twitter.com/1.1/account/verify_credentials.json?include_email=true", parameters: ["include_email": "true", "skip_status": "true"], error:nil)
                        
                        client.sendTwitterRequest(request, completion: { (response, data, error) in
                            
                            if error != nil
                            {
                                print(error?.localizedDescription)
                            }
                            else
                            {
                                do
                                {
                                    let jsonDict = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]
                                    print(jsonDict)
                                }
                                catch
                                {
                                    
                                }
                            }
                        })
                        
                    }else
                    {
                        print("error: \(String(describing: error?.localizedDescription))")
                    }
                })
                
            } else {
                print("error: \(String(describing: error?.localizedDescription))")
            }
        })
        twitterButton.center = self.view.center
        self.view.addSubview(twitterButton)

    }
    func getData()
    {
        let url = URL(string:"http://ec2-18-216-16-99.us-east-2.compute.amazonaws.com:8080/smarttrips/forgotpassword?mobileNumber=919700601028&newPassword=654321")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            do
            {
                let jsonDict = try JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any]
                print(jsonDict)
            }
            catch
            {
             print(error.localizedDescription)
            }
        }
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonAction(_ sender: UIButton)
    {
        if checkAllValidations() == true
        {
            //
        }

    }
    func checkAllValidations() -> Bool
    {
        var isValid = true
        if textFieldFirst.text == ""
        {
           firstLabel.isHidden = false
            isValid = false
        }
        if textfieldSecond.text == ""
        {
            secondLabel.isHidden = false
            isValid = false
        }
        if textFieldThird.text == ""
        {
            thirdLabel.isHidden = false
            isValid = false
        }
        return isValid
    }

    func getDictionary() -> Dictionary<String,String>
    {
        var parametersDictionary = Dictionary<String,String>()
        parametersDictionary["x-auth-token"] = "11:eb08f3b5544907e79a79eb2516358415"
        return parametersDictionary
    }
    func uploadImageToDatabase()
    {
        guard let url = URL(string: "http://ec2-18-216-16-99.us-east-2.compute.amazonaws.com:8080/smarttrips/user/uploadids") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let boundary = generateBoundary()
        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var selectedImage : UIImage?
        let arryaOfImages = [UIImage(named:"image"),UIImage(named:"id")]
        
        
        for arr in arryaOfImages
        {
            selectedImage = arr
            if let chosenImage = selectedImage
            {
                imageData = UIImageJPEGRepresentation(chosenImage,0.1)
            }
            let parametersDictionary = getDictionary()
            //request.addValue("11:eb08f3b5544907e79a79eb2516358415", forHTTPHeaderField:"x-auth-token")
            count = count + 1
            
            var  fileKey = ""
            if count == 1
            {
                fileKey = "image"
            }
            else
            {
                fileKey = "id"
            }
            request.httpBody = createBodyWithParameters(parameters: parametersDictionary, filePathKey: fileKey, imageDataKey: imageData! as NSData, boundary: boundary) as Data
        }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request as URLRequest) {(data,response,error) in
            
            guard let myData:NSData = data as NSData?, let _:URLResponse = response, error == nil else {
                
                return
            }
            
            if error != nil {
                
                print(error!)
                
            } else {
                do {
                    
                    let parsedData = try JSONSerialization.jsonObject(with: myData as Data, options:.allowFragments)
                    print(parsedData)
                    
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
    func generateBoundary() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
    
    func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, imageDataKey: NSData, boundary: String) -> NSData {
        let body = NSMutableData();
        
        if parameters != nil {
            for (key, value) in parameters! {
                body.appendString(string:"--\(boundary)\r\n")
                body.appendString(string:"Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString(string:"\(value)\r\n")
            }
        }
        
        let filename = getFileName() + ".png"
        let mimetype = "image/png"
        
        body.appendString(string: "--\(boundary)\r\n")
        body.appendString(string: "Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
        body.appendString(string: "Content-Type: \(mimetype)\r\n\r\n")
        body.append(imageDataKey as Data)
        body.appendString(string: "\r\n")
        body.appendString(string: "--\(boundary)--\r\n")
        
        return body
    }
    func getFileName() -> String
    {
        var fileString = String()
        
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)
        fileString = String(hour) + String(minutes)+String(seconds)
        return fileString
    }
    
}
extension NSMutableData {
    
    func appendString(string: String)
    {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        append(data!)
    }
}


