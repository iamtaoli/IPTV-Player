//
//  CollectionViewController.swift
//  IPTV Player By Tao
//
//  Created by Tao Li on 2020/6/3.
//  Copyright © 2020 TAO LI. All rights reserved.
//

import UIKit
import AVKit



class CollectionViewController: UICollectionViewController {
    let M3UFileURL = URL(string: "http://tv.sason.xyz/new.m3u")!
    var channels = [Channel]()
    var selectChannelURL: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        channels = getTheChannels(m3uURL: M3UFileURL)
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return channels.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reuseIdentifier", for: indexPath) as! CollectionViewCell
        cell.labelOutLet.text = channels[indexPath.row].title
        cell.backgroundColor = .darkGray
        return cell
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectChannelURL = channels[indexPath.row].channelURL
//        performSegue(withIdentifier: "cellToAVPlayerViewController", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "cellToAVPlayerViewController" {
            let destinationController = segue.destination as! IPTVPlayerViewController
            if let url = selectChannelURL {
                destinationController.play = AVPlayer(url: url)
                destinationController.play.play()
            }
           
        }
    }

    
}
