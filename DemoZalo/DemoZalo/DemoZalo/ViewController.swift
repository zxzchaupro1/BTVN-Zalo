//
//  ViewController.swift
//  DemoZalo
//
//  Created by ChâuNT on 02/11/2022.
//

import UIKit
import MessageKit
import InputBarAccessoryView

class ViewController: MessagesViewController,MessagesDataSource,MessagesDisplayDelegate,MessagesLayoutDelegate, InputBarAccessoryViewDelegate {
    
    var currentSender:SenderType {
        return chauNtSender
    }
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessageKit.MessagesCollectionView) -> MessageKit.MessageType {
        return messages [indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessageKit.MessagesCollectionView) -> Int {
        return messages.count
    }
    
    let chauNtSender = Sender (senderId: "ChauNT", displayName: "Chau")
    let haiSender = Sender (senderId: "HaiLQ", displayName: "Hai")
    var messages: [ChatMessage] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        messages.append(ChatMessage(sender: currentSender,
                                    messageId: "1",
                                    sentDate: Date(),
                                    kind: .photo(Media (url:nil,
                                                      image: UIImage(named: "image1"),
                                                       placeholderImage: UIImage(named: "image1")!,
                                                       size: CGSize(width: 250, height: 100)))))
        messages.append(ChatMessage(sender: haiSender,
                                    messageId: "1",
                                    sentDate: Date(),
                                    kind: .photo(Media (url:nil,
                                                      image: UIImage(named: "image1"),
                                                       placeholderImage: UIImage(named: "image1")!,
                                                       size: CGSize(width: 250, height: 100)))))
        
        
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messageInputBar.delegate = self
    }
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        let currentMessges = ChatMessage (sender: haiSender, messageId: UUID().uuidString, sentDate: Date(), kind: .text(text) )
        messages.append(currentMessges)
        messagesCollectionView.reloadData()
        inputBar.inputTextView.text=""
    }
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
            avatarView.image = UIImage(named: "Avatar")
    }


}
struct Sender: SenderType {
    var senderId: String
    
    var displayName: String
    
//    var avatar: String
    
}

struct ChatMessage: MessageType {
    
    var sender: MessageKit.SenderType
    
    var messageId: String
    
    var sentDate: Date
    
    var kind: MessageKit.MessageKind
    

}

struct Media: MediaItem {
    var url: URL?
    var image: UIImage?
    var placeholderImage: UIImage
    var size: CGSize
}
