//
//  IGWebImageManager.swift
//  InstacartGrocery
//
//  Created by DingXiao on 2017/8/18.
//  Copyright © 2017年 AwesomeDennis. All rights reserved.
//

import UIKit

class IGWebImageManager: NSObject {
    
    struct IGWebImageConsts {
        static let cacheDirectory = "IGWebImage";
    }
    
    static let shared = IGWebImageManager()
    // memory cache
    private let memoryCache : NSCache<NSString, AnyObject> = {
        let cache = NSCache<NSString, AnyObject>()
        cache.totalCostLimit = 10*1024*1024
        return cache;
    }()
    // 保存回调闭包
    var completionDict = [String:(image:UIImage) -> Void]()
    // 队列
    var queue:OperationQueue = {
        let queue = OperationQueue.init()
        queue.maxConcurrentOperationCount = 3
        return queue
    }()
    
    
    func downloadImage(url:String, completion:@escaping (_ image: UIImage?,  _ error: NSError?)->Void) {
        
        
        // fetch data from memory cahce
        if let cacheImage = memoryCache.object(forKey: url as NSString) {
            // fetch image form sandbox
            completion(cacheImage as? UIImage, nil);
        }
        
        // fetch image from sandbox
        let cachePath = imageCachePath(imagePath: url);
        
        if let sanboxData = NSData.init(contentsOfFile: cachePath) {
            if let sandboxImage = UIImage.init(data: sanboxData as Data) {
                // save image to cache
                memoryCache.setObject(sandboxImage, forKey: url as NSString)
                completion(sandboxImage, nil)
            } else {
                // remove error data
                do {
                    try FileManager.default.removeItem(atPath: cachePath)
                } catch let error {
                    IGLog("error occured \(error)")
                }
            }
            return;
        }
        
        
        // 内存和沙盒中均没有图片，开始下载
        queue.addOperation {
            let downloadData = NSData.init(contentsOf: URL.init(string: url)!)
            let downloadImage = UIImage.init(data: downloadData! as Data)
            
            // 回主线程
            OperationQueue.main.addOperation {
                completion(downloadImage!, nil);
                // save to memory
                self.memoryCache.setObject(downloadImage!, forKey: url as NSString);
                // 保存到沙盒
                downloadData?.write(to: URL.init(fileURLWithPath: cachePath), atomically: true)
            }
        }
    }
    
    // MARK: - Private method
    
    private func imageCachePath(imagePath: String) -> String {
        let imagePathString = imagePath as NSString
        let imageName = imagePathString.lastPathComponent
        var arr = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)
        let path = arr[0]
        let imageCachePath = path+"/"+IGWebImageConsts.cacheDirectory+imageName;
        IGLog(imageCachePath);
        return imageCachePath;
    }
    
    private func imageCacheDirectory() -> String {
        var arr = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)
        let path = arr[0]
        let imageDirectory = path+"/"+IGWebImageConsts.cacheDirectory
        IGLog(imageDirectory);
        return imageDirectory
    }
    
}
