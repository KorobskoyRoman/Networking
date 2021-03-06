//
//  DataProvider.swift
//  Networking
//
//  Created by Roman Korobskoy on 21.11.2021.
//

import UIKit

class DataProvider: NSObject {

    private var downloadTask: URLSessionDownloadTask!
    var fileLocation: ((URL) -> ())?
    var onProgress: ((Double) -> ())?
    
    private lazy var bgSession: URLSession = {
        let config = URLSessionConfiguration.background(withIdentifier: "ru.swiftbook.Networking")
        config.isDiscretionary = true //разрешаем запуск в оптимальное время
        config.timeoutIntervalForResource = 300 //время ожидания сети в сек
        config.waitsForConnectivity = true //ожидание подключения к сети
        config.sessionSendsLaunchEvents = true
        return URLSession(configuration: config, delegate: self, delegateQueue: nil)
    }()
    
    func startDownload() {
        if let url = URL(string: "http://hel.icmp.hetzner.com/100MB.bin") {
            downloadTask = bgSession.downloadTask(with: url)
            downloadTask.earliestBeginDate = Date().addingTimeInterval(3)
            downloadTask.countOfBytesClientExpectsToSend = 512
            downloadTask.countOfBytesClientExpectsToReceive = 100 * 1024 * 1024
            downloadTask.resume()
        }
    }
    
    func stopDownload() {
        downloadTask.cancel()
    }
}

extension DataProvider: URLSessionDelegate {
    func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
        DispatchQueue.main.async {
            guard
                let appDelegate = UIApplication.shared.delegate as? AppDelegate,
                let completionHandler = appDelegate.bgSessionCompletionHandler
            else { return }
            
            appDelegate.bgSessionCompletionHandler = nil
            completionHandler()
        }
    }
}

extension DataProvider: URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("Загрузка завершена \(location.absoluteString)")
        
        DispatchQueue.main.async {
            self.fileLocation?(location)
        }
    }
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        
        guard totalBytesExpectedToWrite != NSURLSessionTransferSizeUnknown else {return}
        
        let progress = Double(totalBytesWritten) / Double(totalBytesExpectedToWrite)
        print("Загрузка: \(progress)")
        
        DispatchQueue.main.async {
            self.onProgress?(progress)
        }
    }
}
