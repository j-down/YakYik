//
//  HomeTableViewCell.swift
//  YakYik
//
//  Created by Admin on 3/22/17.
//  Copyright © 2017 Downing Development. All rights reserved.
//

import Foundation
import UIKit

class HomeTableViewCell: UITableViewCell {
    
    var yik = Yik()
    
    @IBOutlet var yikTextLabel: UILabel!
    
    @IBOutlet var upvoteButton: UIButton!
    @IBOutlet var downvoteButton: UIButton!
    
    @IBOutlet var voteCountLabel: UILabel!
    
    @IBOutlet var commentsView: UIView!
    @IBOutlet var commentsIconButton: UIButton!
    @IBOutlet var commentsLabel: UILabel!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        //Any setup
    }
    
    func setup(for yik: Yik) {
        
        self.yik = yik
        
        yikTextLabel.text = yik.text
        voteCountLabel.text = String(yik.votes())
        
        setupButtons()
    }
    
    func setupButtons() {
        
        commentsIconButton.setImage(UIImage(named: "Comments")?.with(color: UIColor.gray), for: .normal)
        upvoteButton.setImage(UIImage(named: "Up")?.with(color: UIColor.gray), for: .normal)
        downvoteButton.setImage(UIImage(named: "Down")?.with(color: UIColor.gray), for: .normal)
    }
    
    @IBAction func upvoteButtonPressed(_ sender: Any) {
        
        updateVoteCountLabel(by: 1)
    }
    
    @IBAction func downvoteButtonPressed(_ sender: Any) {
        
        updateVoteCountLabel(by: -1)
    }
    
    func updateVoteCountLabel(by count: Int) {
        
        if let text = voteCountLabel?.text, let textInt = Int(text) {
            
            voteCountLabel.text = String(textInt)
        
            if count > 0 {
                
                upvoteButton.setImage(UIImage(named: "Up")?.with(color: UIColor.yakYikPink()), for: .normal)
                downvoteButton.setImage(UIImage(named: "Down")?.with(color: UIColor.gray), for: .normal)
            }
            else {
                
                upvoteButton.setImage(UIImage(named: "Up")?.with(color: UIColor.gray), for: .normal)
                downvoteButton.setImage(UIImage(named: "Down")?.with(color: UIColor.yakYikPink()), for: .normal)
            }
            
            if let yik = yik {
                
                let noteUpdates = [ "\(FirebasePath.yiks)\(yik.uuid)" : yik.toAny() ]
                
                FirebaseReference.updateChildValues(noteUpdates)
            }
        }
    }
}
