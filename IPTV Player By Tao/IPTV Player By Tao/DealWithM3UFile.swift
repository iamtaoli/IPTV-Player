//
//  DealWithM3UFile.swift
//  IPTV Player By Tao
//
//  Created by Tao Li on 2020/6/5.
//  Copyright © 2020 TAO LI. All rights reserved.
//

import Foundation

struct Channel {
    var title: String
    var channelURL: URL?
}

func getTheChannels(m3uURL url: URL) -> [Channel] {
    var channels = [Channel]()
    if let m3uData = try? Data(contentsOf: url) {
        if let m3uString = String(data: m3uData, encoding: .utf8) {
            m3uString.enumerateLines { line, shouldStop in
                if line.hasPrefix("#EXTINF:") {
                    let infoLine = line.replacingOccurrences(of: "#EXTINF:", with: "")
                    let infoItems = infoLine.components(separatedBy: ",")
                    if let title = infoItems.last {
                        let channel = Channel(title: title, channelURL: nil)
                        channels.append(channel)
                    }
                } else {
                    if var channel = channels.popLast() {
                        channel.channelURL = URL(string: line)
                        channels.append(channel)
                    }
                }
            }
        }
    }
    return channels
}




