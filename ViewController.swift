//
//  ViewController.swift
//  sandboxx
//
//  Created by Baran Ayhan on 27.05.2020.
//  Copyright © 2020 Baran Ayhan. All rights reserved.
//


import UIKit
import Alamofire
import CommonCrypto
class ViewController: UIViewController {
    
    let baseUrl = "https://sandbox-api.iyzipay.com"
    let apiKey = ""
    let secretkey = ""
    var bodyStr = ""
    let size = 12
    let options: [String:String] = ["baseUrl":"https://sandbox-api.iyzipay.com","apiKey":"","secretkey":""]
   
 let request:[String : Any] = ["locale":"tr","conversationId":"123456789","price":"1","paidPrice":"1.2" ,"currency":"TRY","installment":"1","basketId":"B67832","paymentChannel":"WEB","paymentGroup":"PRODUCT","paymentCard":["cardHolderName":"John Doe","cardNumber":"5526080000000006","expireMonth": "12","expireYear":"2030","cvc":"123","registerCard":"0"],"buyer":["id":"BY789","name":"John","surname":"Doe","gsmNumber":"+905350000000","email":"email@hotmail.com","identityNumber":"74300864791","lastLoginDate":"2015-10-05 12:43:35","registrationDate":"2013-04-21 15:12:09","registrationAddress":"Nidakule Gztepe, Merdivenky Mah. Bora Sok. No:1","ip":"85.34.78.112","city":"Istanbul","country":"Turkey","zipCode":"34732"],"shippingAddress":["contactName":"Jane Doe","city":"Istanbul","country":"Turkey","address":"Nidakule Gtepe, Merdiveny Mah. Bora Sok. No:1", "zipCode": "34732"],"billingAddress":["contactName":"Jane Doe","city":"Istanbul","country":"Turkey","address":"Nidakule Gtepe, Merdiveny Mah. Bora Sok. No:1","zipCode": "34732"],"basketItems":[["id":"BI101","name":"Binocular","category1":"Collectibles","category2":"Accessories","itemType":"PHYSICAL","price":"0.3"],["id":"BI102","name":"Game code","category1":"Game","category2":"Online Game Items","itemType":"VIRTUAL","price":"0.5"],["id":"BI103","name":"Usb","category1":"Electronics","category2":"UsbCable","itemType":"PHYSICAL","price":"0.2"]]]
  

  
  
    var header:[String:String] =  ["Accept": "application/json", "Content-type": "application/json",]
   
 
    
    
    
  let pki = "[locale=tr,conversationId=123456789,price=1.0,basketId=B67832,paymentGroup=PRODUCT,buyer=[id=BY789,name=John,surname=Doe,identityNumber=74300864791,email=email@email.com,gsmNumber=+905350000000,registrationDate=2013-04-21 15:12:09,lastLoginDate=2015-10-05 12:43:35,registrationAddress=Nidakule Göztepe, Merdivenköy Mah. Bora Sok. No:1,city=Istanbul,country=Turkey,zipCode=34732,ip=85.34.78.112],shippingAddress=[address=Nidakule Göztepe, Merdivenköy Mah. Bora Sok. No:1,zipCode=34742,contactName=Jane Doe,city=Istanbul,country=Turkey],billingAddress=[address=Nidakule Göztepe, Merdivenköy Mah. Bora Sok. No:1,zipCode=34742,contactName=Jane Doe,city=Istanbul,country=Turkey],basketItems=[[id=BI101,price=0.3,name=Binocular,category1=Collectibles,category2=Accessories,itemType=PHYSICAL], [id=BI102,price=0.5,name=Game code,category1=Game,category2=Online Game Items,itemType=VIRTUAL], [id=BI103,price=0.2,name=Usb,category1=Electronics,category2=Usb / Cable,itemType=PHYSICAL]],callbackUrl=https://www.merchant.com/callback,currency=TRY,paidPrice=1.2,enabledInstallments=[1, 2, 3, 6, 9]]"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        let randomstring = randomString(length: size)
        header.updateValue(randomstring, forKey: "x-iyzi-rnd") //RANDOM EKLEME
        let unhashed = options["baseUrl"]!+options["apiKey"]! + options["secretkey"]! + pki
    
        let hashed = unhashed.sha1()
        

        let finalhashed = "IYZWS " + options["apiKey"]! + ":" + hashed
        header.updateValue(finalhashed, forKey: "Authorization") //Authorization EKLEME
        print(finalhashed)
        
        pay()
  
    }
 
    
    
    func pay(){
         Alamofire.request(baseUrl + "/payment/auth", method: .post, parameters: request, encoding: JSONEncoding.default, headers:(header)).responseJSON { (response) in
           print(response)
        }
        
        }
 
    
    func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
}

 
    extension String {
        func sha1() -> String {
            let data = Data(self.utf8)
            var digest = [UInt8](repeating: 0, count:Int(CC_SHA1_DIGEST_LENGTH))
            data.withUnsafeBytes {
                _ = CC_SHA1($0.baseAddress, CC_LONG(data.count), &digest)
            }
            return Data(digest).base64EncodedString()

        }
    }



