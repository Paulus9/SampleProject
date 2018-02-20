//
//  SampleParsingViewController.swift
//  Sample
//
//  Created by SysBig on 25/10/17.
//  Copyright © 2017 SysBig. All rights reserved.
//

import UIKit

struct Profile:Decodable {
    let userId : Int?
    let userName : String?
}
struct Result:Decodable {
    
    let status:Int?
    let result:[Profile]
}

class SampleParsingViewController: UIViewController,UINavigationBarDelegate
{
    
    @IBOutlet weak var notification: UIBarButtonItem!
    var array = [Profile]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        
        //getData()
       //BackendProvider.sharedInstance.saveUserProfileData()
        
    }
    func getData()
    {
        guard let url = URL(string:"http://ec2-18-216-16-99.us-east-2.compute.amazonaws.com:8080/smarttrips/user/getuser/") else
        {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("12:ad3e49ec4fea903f096103d8953ccc9b", forHTTPHeaderField: "x-auth-token")

        URLSession.shared.dataTask(with: request) { (data, response, err) in
            
            guard let data = data else
            {
                return
            }
            do
            {
            let structResult = try JSONDecoder().decode(Result.self, from: data)
                print(structResult.status ?? "")
                
                self.array = structResult.result
                
                for data in self.array
                {
                    print(data.userName)
                }
            }
            catch
            {
                print(err?.localizedDescription ?? "")
            }
        }.resume()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
@IBDesignable
class EdgeInsetLabel: UILabel {
    var textInsets = UIEdgeInsets.zero {
        didSet { invalidateIntrinsicContentSize() }
    }
    
    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let insetRect = UIEdgeInsetsInsetRect(bounds, textInsets)
        let textRect = super.textRect(forBounds: insetRect, limitedToNumberOfLines: numberOfLines)
        let invertedInsets = UIEdgeInsets(top: -textInsets.top,
                                          left: -textInsets.left,
                                          bottom: -textInsets.bottom,
                                          right: -textInsets.right)
        return UIEdgeInsetsInsetRect(textRect, invertedInsets)
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: UIEdgeInsetsInsetRect(rect, textInsets))
    }
}

extension EdgeInsetLabel {
    @IBInspectable
    var leftTextInset: CGFloat {
        set { textInsets.left = newValue }
        get { return textInsets.left }
    }
    
    @IBInspectable
    var rightTextInset: CGFloat {
        set { textInsets.right = newValue }
        get { return textInsets.right }
    }
    
    @IBInspectable
    var topTextInset: CGFloat {
        set { textInsets.top = newValue }
        get { return textInsets.top }
    }
    
    @IBInspectable
    var bottomTextInset: CGFloat {
        set { textInsets.bottom = newValue }
        get { return textInsets.bottom }
    }
}
