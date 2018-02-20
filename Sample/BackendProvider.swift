//
//  BackendProvider.swift
//  Sample
//
//  Created by SysBig on 02/11/17.
//  Copyright © 2017 SysBig. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth


class BackendProvider: NSObject
{
    static let sharedInstance = BackendProvider()
    
    //DatabaseRef:-
    var dbRef : DatabaseReference
    {
        return Database.database().reference()
    }
    var storageRef : StorageReference
    {
        return Storage.storage().reference()
    }

    //ChildRef using dbRef:- DatabaseRef
    var userDataRef : DatabaseReference
    {
        return dbRef.child("UserData")
    }
    
    //ChildRef using storageRefef:- StorageRef
    var userProfileDataRef : StorageReference
    {
        return storageRef.child("UserProfile")
    }

    
    //Saving userData by creating child:- UserData - DatabaseRef
    func saveUserData(userId:String,email:String,password:String)
    {
        var dictionary = Dictionary<String,Any>()
        dictionary["email"] = email
        dictionary["password"] = password
        
        let imageData = UIImagePNGRepresentation(#imageLiteral(resourceName: "image"))
        let base64String = imageData?.base64EncodedString(options: .lineLength64Characters)
        dictionary["userPhoto"] = base64String
        userDataRef.child(userId).setValue(dictionary)
    }
    
    //Upload image to the Storage:- StorageRef
    func saveUserProfileData()
    {
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"
        let imageData = UIImagePNGRepresentation(#imageLiteral(resourceName: "image"))
        
        userProfileDataRef.putData(imageData!, metadata: metaData) { (data, error) in
            if error != nil
            {
                print(error?.localizedDescription ?? "")
                return
            }
            
            //For converting data into String
            
            if let profileImageString = data?.downloadURL()?.absoluteString
            {
                print(profileImageString)
            }
        
        }
    }
    
    //Retriving imageData from the userProfileDataRef :- StorageRef
    func retrivingProfileImageFromStorageRef()
    {
         userProfileDataRef.getData(maxSize: 100*100)
         { (data, error) in
         if error != nil
         {
         print(error?.localizedDescription ?? "")
         return
         }
         print(data ?? "")
         }

    }
    
    //Retriving data from the userDataRef:- DatabaseRef
    func retrieveData(completionHandler:@escaping (Dictionary<String,Any>) -> Void)
    {
        userDataRef.observe(DataEventType.value) { (snapshot:DataSnapshot) in
            
            if let userData = snapshot.value as? Dictionary<String,Any>
            {
                for (key,value) in userData
                {
                    let userId = Auth.auth().currentUser?.uid
                    if key == userId
                    {
                        if let userDict = value as? Dictionary<String,Any>
                        {
                            completionHandler(userDict)
                        }
                    }
                }
            }
            
        }
    }
    
    //Deleting userData :- can be one value/total userData :- DatabaseRef
    func deleteUserData()
    {
        guard let userId = Auth.auth().currentUser?.uid else
        {return}

        userDataRef.child(userId).child("userPhoto").removeValue { (error, ref) in
            if error != nil
            {
                print(error?.localizedDescription ?? "")
                return
            }
            print(ref)
        }
    }
    
    //Updating userData :- can be one value/total dictionary:- DatabaseRef
    func updateUserData()
    {
        guard let userId = Auth.auth().currentUser?.uid else
        {return}

        let dict = ["password":"pranay"]
        userDataRef.child(userId).updateChildValues(dict)
    }
    
    //Updating User SignIn Email or Password:- FireBaseAuth
    func updatePasswordOrEmail(password:String)
    {
        Auth.auth().currentUser?.updatePassword(to: password, completion: { (error) in
            if error != nil
            {
            print(error?.localizedDescription ?? "")
            return
            }
        })
    }
    
    //Forgot/Reset Password:- FireBaseAuth
    func forgotOrResetPassword(email:String)
    {
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if error != nil
            {
                print(error?.localizedDescription ?? "")
                return
            }
        }
    }
    
    //Login through Email:- FireBaseAuth
    func loginThroghEmail(email:String,password:String,completion:@escaping (_ success:Bool) -> Void)
    {
        Auth.auth().signIn(withEmail:email , password: password, completion: { (user, error) in
            
            if error != nil
            {
                return
            }
            if user?.uid != nil
            {
                print("Login success")
                completion(true)
            }
        })
    }
    
    //SignUp with Email: - FireBaseAuth
    func signUpThroghEmail(email:String,password:String,completion:@escaping (_ success:Bool) -> Void)
    {
        Auth.auth().createUser(withEmail:email , password: password, completion: { (user, error) in
            
            if error != nil
            {
                return
            }
            if user?.uid != nil
            {
                print("SignUp success")
                completion(true)
            }
        })
    }
    
    //Signout:- FireBaseAuth
    func signOut()
    {
        do
        {
            if Auth.auth().currentUser != nil
            {
                try Auth.auth().signOut()
            }
        }
        catch
        {
            
        }
    }    
}
