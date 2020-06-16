//
//  ViewController.swift
//  TestDecryptionVideo
//
//  Created by asto_vn2 on 6/11/20.
//  Copyright © 2020 asto_vn2. All rights reserved.
//

import UIKit
import AVFoundation
import MobileCoreServices



class ViewController: UIViewController {
    var player :AVPlayer?
    var movieLength : Int64 = 0
    var chunkMode = true
    var currentOffset  = 0
    var currentBlockIndex = 0
    let blockSize = 128
    var decryptedData : Data? = nil
    var fileHandle : FileHandle!
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        let url = URL(string: "fake_scheme://storage.googleapis.com/wisteria-bucket/videos/publicvideo-BgPa1_encrypt_2020-06-09-17-06-34.mp4")
        let asset = AVURLAsset(url: url!)
        asset.resourceLoader.setDelegate(self, queue: DispatchQueue.main)
        let item = AVPlayerItem(asset: asset)
        player = AVPlayer(playerItem: item)
        movieLength =  Int64(Int((player?.currentItem?.asset.duration.seconds)!))
        player?.play()
    }
    func play () {
        
              let url = URL(string: "https//storage.googleapis.com/wisteria-bucket/videos/publicvideo-BgPa1_encrypt_2020-06-09-17-06-34.mp4")
            do {
                let fileHandle = try FileHandle(forReadingFrom: url!)
                
            } catch {
            }
              let asset = AVURLAsset(url: url!)
              asset.resourceLoader.setDelegate(self, queue: DispatchQueue.main)
              let item = AVPlayerItem(asset: asset)
              player = AVPlayer(playerItem: item)
//              movieLength =  Int64(Int((player?.currentItem?.asset.duration.seconds)!))
              player?.play()
    }
    
//
//    func resourceLoader(_ resourceLoader: AVAssetResourceLoader, shouldWaitForLoadingOfRequestedResource loadingRequest: AVAssetResourceLoadingRequest) -> Bool {
//        print("resourceLoaderresourceLoaderresourceLoaderresourceLoader")
////        let urlComponents = NSURLComponents(url: loadingRequest.request.url!, resolvingAgainstBaseURL: false)
////        urlComponents?.scheme = "http"
////        var mutableLoadingRequest = loadingRequest.request
////        mutableLoadingRequest.url = urlComponents?.url
//
//        play()
//
//        loadingRequest.contentInformationRequest?.contentType = kUTTypeVideo as String
////        loadingRequest.contentInformationRequest?.contentLength = movieLength
//        loadingRequest.contentInformationRequest?.isByteRangeAccessSupported = true
//
//        if !chunkMode {
//            var offset = Int(loadingRequest.dataRequest?.requestedOffset ?? 0)
//
//            if currentOffset != offset {
//                currentOffset = offset
//                let requestedBlock = Int(floor(Float(currentOffset / blockSize)))
//
//                if currentBlockIndex != requestedBlock {
//                    currentBlockIndex = requestedBlock
//                    // Loading other block of data
//                    decryptedData = getDataFromFile(currentBlockIndex)
//                }
//            }
//
//            if currentOffset > blockSize * currentBlockIndex {
//                offset = currentOffset - blockSize * currentBlockIndex
//            } else {
//                offset = 0
//            }
//
//            var maxLength = decryptedData!.count - offset
//            if (loadingRequest.dataRequest?.requestedLength ?? 0) < maxLength && (loadingRequest.dataRequest?.requestedLength ?? 0) <= decryptedData!.count {
//                maxLength = loadingRequest.dataRequest?.requestedLength ?? 0
//            }
//
//            loadingRequest.dataRequest?.respond(with: (decryptedData?.subdata(in: offset..<maxLength))!)
//        } else {
//
//            let offset = Int(loadingRequest.dataRequest?.requestedOffset ?? 0)
//            let totalLenght = loadingRequest.dataRequest?.requestedLength ?? 0
//            loadingRequest.dataRequest?.respond(with: (decryptedData?.subdata(in:offset ..< totalLenght ))!)
//        }
////
//        loadingRequest.finishLoading()
//        return true
//    }
//
//    func getDataFromFile(_ index: Int) -> Data? {
//        if fileHandle != nil  {
////            fileHandle.seek(toFileOffset: UInt64(index * chunksInBlock * chunkSize))
//            return Data(data: AESCrypt.decryptData(fileHandle.readData(ofLength: chunksInBlock * chunkSize), password: PASSWORD, chunkSize: blockSize, iv: IV))
//        }
//        return nil
//    }
    
//    
//     func decryptData(_ data: Data?, password: String?, chunkSize: Int) -> Data? {
//        return self.decryptData(data, password: password, chunkSize: chunkSize, offsetBlock: 0, countBlock: 0, iv: nil)
//    }
//    
//   func decryptData(_ data: Data?, password: String?, chunkSize: Int, iv: Any?) -> Data? {
//        return self.decryptData(data, password: password, chunkSize: chunkSize, offsetBlock: 0, countBlock: 0, iv: iv)
//    }
    
    
    
    
    
    
    //
    //     func resourceLoader(_ resourceLoader: AVAssetResourceLoader, shouldWaitForLoadingOfRequestedResource loadingRequest: AVAssetResourceLoadingRequest) -> Bool {
    //        print("🔑", #function, "Unable to 11read the url/host data.")
    //
    //        print("🔑", #function, "Unable to read the url/host data.")
    //
    //       // We first check if a url is set in the manifest.
    //       guard let url = loadingRequest.request.url else {
    //         print("🔑", #function, "Unable to read the url/host data.")
    //         loadingRequest.finishLoading(with: NSError(domain: "com.icapps.error", code: -1, userInfo: nil))
    //         return false
    //       }
    //       print("🔑", #function, url)
    //
    //       // When the url is correctly found we try to load the certificate date. Watch out! For this
    //       // example the certificate resides inside the bundle. But it should be preferably fetched from
    //       // the server.
    //         guard
    //           let certificateURL = Bundle.main.url(forResource: "certificate", withExtension: "der"),
    //           let certificateData = try? Data(contentsOf: certificateURL) else {
    //           print("🔑", #function, "Unable to read the certificate data.")
    //           loadingRequest.finishLoading(with: NSError(domain: "com.icapps.error", code: -2, userInfo: nil))
    //           return false
    //         }
    //
    //         // Request the Server Playback Context.
    //         let contentId = "hls.icapps.com"
    //         guard
    //             let contentIdData = contentId.data(using: String.Encoding.utf8),
    //             let spcData = try? loadingRequest.streamingContentKeyRequestData(forApp: certificateData, contentIdentifier: contentIdData, options: nil),
    //             let dataRequest = loadingRequest.dataRequest else {
    //             loadingRequest.finishLoading(with: NSError(domain: "com.icapps.error", code: -3, userInfo: nil))
    //             print("🔑", #function, "Unable to read the SPC data.")
    //             return false
    //         }
    //
    //         // Request the Content Key Context from the Key Server Module.
    //         let ckcURL = URL(string: "https://hls.icapps.com/ckc")!
    //         var request = URLRequest(url: ckcURL)
    //         request.httpMethod = "POST"
    //         request.httpBody = spcData
    //         let session = URLSession(configuration: URLSessionConfiguration.default)
    //         let task = session.dataTask(with: request) { data, response, error in
    //           if let data = data {
    //             // The CKC is correctly returned and is now send to the `AVPlayer` instance so we
    //             // can continue to play the stream.
    //             dataRequest.respond(with: data)
    //             loadingRequest.finishLoading()
    //           } else {
    //             print("🔑", #function, "Unable to fetch the CKC.")
    //             loadingRequest.finishLoading(with: NSError(domain: "com.icapps.error", code: -4, userInfo: nil))
    //           }
    //         }
    //         task.resume()
    //
    //         return true
    //       }
    //
    
}

func decryptData(
_ data: Data?,
    password: String?,
    chunkSize: Int,
    offsetBlock: Int,
    countBlock: Int,
    iv: Any?
) -> Data? {
    var chunkSize = chunkSize
    var length = data?.count ?? 0
    if chunkSize > length {
        chunkSize = Int(floor(Float(length / 16)) * 16)
    }
    if countBlock > 0 {
        length = (offsetBlock + countBlock) * chunkSize
    }
    if length > (data?.count ?? 0) {
        length = data?.count ?? 0
    }
    
    var offset = offsetBlock * chunkSize
    var decryptedData = Data()
    
    var encryptedPartOfData: Data?
    repeat {
        let thisChunkSize = length - offset > chunkSize ? chunkSize : length - offset
        
        let partOfData = data?.subdata(in: offset..<thisChunkSize)
        
        if iv == nil {
            do {
//                encryptedPartOfData = try partOfData?.decryptedAES256Data(usingKey: password?.data(using: .utf8)?.sha256Hash())
            } catch {
            }
        } else {
            do {
//                encryptedPartOfData = try partOfData?.decryptedAES256Data(usingKey: password?.data(using: .utf8), initializationVector: iv)
            } catch {
            }
        }
        if let encryptedPartOfData = encryptedPartOfData {
            decryptedData.append(encryptedPartOfData)
        }
        
        offset += thisChunkSize
    } while offset < length
    
    return decryptedData
}



extension ViewController: AVAssetResourceLoaderDelegate {

   func resourceLoader(resourceLoader: AVAssetResourceLoader, shouldWaitForLoadingOfRequestedResource loadingRequest: AVAssetResourceLoadingRequest) -> Bool {
      let request = loadingRequest.request
    guard let path = request.url?.path, request.url?.scheme == "Constants.customVideoScheme" else { return true }
      if let contentRequest = loadingRequest.contentInformationRequest {
         do {
            let fileAttributes = try FileManager.defaultManager().attributesOfItemAtPath(path)
            if let fileSizeNumber = fileAttributes[NSFileSize] {
               contentRequest.contentLength = fileSizeNumber.longLongValue
            }
         } catch { }

         if fileHandle == nil {
            fileHandle = FileHandle(forReadingAtPath: (request.URL.path)!)!
         }
         contentRequest.contentType = "video/mp4"
        contentRequest.isByteRangeAccessSupported = true
      }

    if let data = decryptData(loadingRequest, path: path), let dataRequest = loadingRequest.dataRequest {
         dataRequest.respondWithData(data)
         loadingRequest.finishLoading()
         return true
      }
      return true
   }

   func decryptData(loadingRequest: AVAssetResourceLoadingRequest, path: String) -> NSData? {
      print("Current OFFSET: \(loadingRequest.dataRequest?.currentOffset)")
      print("requested OFFSET: \(loadingRequest.dataRequest?.requestedOffset)")
      print("Current Length: \(loadingRequest.dataRequest?.requestedLength)")
      if loadingRequest.contentInformationRequest != nil {
        var data = fileHandle!.readData(ofLength: (loadingRequest.dataRequest?.requestedLength)!)
        fileHandle!.seek(toFileOffset: 0)
        data = decodeVideoData(data: data)!
        return data as NSData
      } else {
        fileHandle?.seek(toFileOffset: UInt64((loadingRequest.dataRequest?.currentOffset)!))
        let data = fileHandle!.readData(ofLength: (loadingRequest.dataRequest?.requestedLength)!)
// let data = fileHandle!.readDataOfLength(length!) ** When I use this its not playing video but play fine when try with requestedLength **
         return decodeVideoData(data)
      }
   }
    
    
    
    func decodeVideoData(data: NSData) -> NSData? {
       if let cha = ChaCha20(key: Constants.Encryption.SecretKey, iv: Constants.Encryption.IvKey) {
          let decrypted: NSData = try! data.decrypt(cha)
          return decrypted
       }
       return nil
    }
}
