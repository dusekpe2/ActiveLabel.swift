//
//  ViewController.swift
//  ActiveLabelDemo
//
//  Created by Johannes Schickling on 9/4/15.
//  Copyright © 2015 Optonaut. All rights reserved.
//

import UIKit
import ActiveLabel

class ViewController: UIViewController {
    
    let label = ActiveLabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        let customType = ActiveType.custom(pattern: "\\sare\\b") //Looks for "are"
        let customType2 = ActiveType.custom(pattern: "\\sit\\b") //Looks for "it"
//        let customType3 = ActiveType.custom(pattern: "(#+)\\s+(.+)") //Looks for "heading"
//        label.enabledTypes = [.bold, customType3]
//        label.enabledTypes.append(customType)
//        label.enabledTypes.append(customType2)
//        label.enabledTypes.append(customType3)
        label.enabledTypes.append(.header)
        label.enabledTypes.append(.bold)
        label.enabledTypes.append(.italic)
        label.italicColor = .purple

        label.urlMaximumLength = 31

        label.customize { label in
            label.text = "Tento text je úplně normální\n**tento text je trochu tučný**\n*tento text je kurzívou*\n***tento text je oboje najednou***\n\n# Heading\n* List\n* 1\n* 2\n* 3\n\n[Fiddo odkaz](http://fiddo.cz)\n\t\nwww.fiddo.cz\n\t\n\\#ahoj \\#světe\n \n \n"
            label.numberOfLines = 0
            label.lineSpacing = 4
            
            label.textColor = UIColor(red: 102.0/255, green: 117.0/255, blue: 127.0/255, alpha: 1)
            label.hashtagColor = UIColor(red: 85.0/255, green: 172.0/255, blue: 238.0/255, alpha: 1)
            label.mentionColor = UIColor(red: 238.0/255, green: 85.0/255, blue: 96.0/255, alpha: 1)
            label.URLColor = UIColor(red: 85.0/255, green: 238.0/255, blue: 151.0/255, alpha: 1)
            label.boldColor = .black
            label.URLSelectedColor = UIColor(red: 82.0/255, green: 190.0/255, blue: 41.0/255, alpha: 1)

            label.handleMentionTap { self.alert("Mention", message: $0) }
            label.handleHashtagTap { self.alert("Hashtag", message: $0) }
            label.handleBoldLTap { self.alert("Bold", message: $0) }
            label.handleURLTap { self.alert("URL", message: $0.absoluteString) }

            //Custom types

            label.customColor[customType] = UIColor.purple
            label.customSelectedColor[customType] = UIColor.green
            label.customColor[customType2] = UIColor.magenta
//            label.customSelectedColor[customType3] = UIColor.green
            
            label.configureLinkAttribute = { (type, attributes, isSelected) in
                var atts = attributes
                switch type {
//                case customType3:
//                    atts[NSAttributedString.Key.font] = UIFont.boldSystemFont(ofSize: 20)
                case .bold:
                    atts[NSAttributedString.Key.font] = UIFont.boldSystemFont(ofSize: 14)
                case .italic:
                    atts[NSAttributedString.Key.font] = UIFont.italicSystemFont(ofSize: 14)
                default: ()
                }
                
                return atts
            }
            label.handleCustomTap(for: customType) { self.alert("Custom type", message: $0) }
            label.handleCustomTap(for: customType2) { self.alert("Custom type", message: $0) }
//            label.handleCustomTap(for: customType3) { self.alert("Custom type", message: $0) }
        }

        label.frame = CGRect(x: 20, y: 40, width: view.frame.width - 40, height: 300)
        view.addSubview(label)
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func alert(_ title: String, message: String) {
        let vc = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        vc.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(vc, animated: true, completion: nil)
    }

}

