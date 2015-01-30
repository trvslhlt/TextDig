//
//  GooglePlusSignInVC.swift
//  TextDig
//
//  Created by trvslhlt on 1/27/15.
//  Copyright (c) 2015 travis holt. All rights reserved.
//

import UIKit

class GooglePlusSignInVC: TDVC, GPPSignInDelegate, NSURLSessionDelegate {
  
  @IBOutlet weak var signInButton: GPPSignInButton!
  @IBOutlet weak var imageView: UIImageView!
  var downloadTask: NSURLSessionDownloadTask?
  var session: NSURLSession?
  let filename = "033c7c7329d05f8880b4e4c8dd99821e37f9c68e"
  let bucketname = "travis-holt-textdig"
  let destinationURL = NSURL(string: NSTemporaryDirectory().stringByAppendingPathComponent("downloaded"))!
  
  override init() {
    super.init(nibName: "GooglePlusSignInVC", bundle: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let signIn = GPPSignIn.sharedInstance()
    signIn.shouldFetchGooglePlusUser = true
    signIn.clientID = kClientId
    signIn.scopes = ["profile"]
    signIn.delegate = self
    struct Static {
      static var session: NSURLSession?
      static var token: dispatch_once_t = 0
    }
    dispatch_once(&Static.token) {
      let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
      Static.session = NSURLSession(configuration: configuration, delegate: self, delegateQueue: nil)
    }
    self.session = Static.session;
    signIn.trySilentAuthentication()
  }
  
  func finishedWithAuth(auth: GTMOAuth2Authentication!, error: NSError!) {
    if error != nil {
      println("error: \(error.localizedDescription)")
    } else {
      if let idToken: AnyObject = auth.parameters["id_token"] {
        let providerKey = AWSCognitoLoginProviderKey.Google.rawValue
        appDelegate.credentialsProvider.logins = [providerKey: idToken]
        updateInterface()
      }
    }
  }
  
  func updateInterface() {
    
    let serviceConfiguration = AWSServiceConfiguration(region: AWSRegionType.USEast1, credentialsProvider: appDelegate.credentialsProvider)
    let identifier = "identifier"
    let transferManager = AWSS3TransferManager(configuration: serviceConfiguration, identifier: identifier)
    
    let downloadRequest = AWSS3TransferManagerDownloadRequest()
    downloadRequest.bucket = bucketname
    downloadRequest.key = filename
    downloadRequest.downloadingFileURL = destinationURL
    
    transferManager.download(downloadRequest).continueWithExecutor(BFExecutor.mainThreadExecutor(), withBlock: {(task: BFTask!) -> AnyObject in
      if task.error != nil {
        if task.error.domain == AWSS3TransferManagerErrorDomain {
          switch task.error.code {
          case AWSS3TransferManagerErrorType.Cancelled.rawValue:
            return "cancelled"
          case AWSS3TransferManagerErrorType.Paused.rawValue:
            return "paused"
          default:
            return "fukt"
          }
        } else {
          return "fukttt"
        }
      }
      if task.result != nil {
        self.showImgInImageView()
        return "success"
      }
      return "No Dice"
    })

    self.signInButton.hidden = GPPSignIn.sharedInstance().authentication != nil
    
    
  }
  
  func showImgInImageView() {
    let tmpDirURL = NSURL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)
    let fileURL = tmpDirURL?.URLByAppendingPathComponent("downloaded", isDirectory: false)
    println("\(fileURL)")
    let urlString = "\(destinationURL)"
    let fileManager = NSFileManager.defaultManager()
    if let path = fileURL?.path {
      if fileManager.fileExistsAtPath(path) {
        if let contents = fileManager.contentsAtPath(path) {
          let img = UIImage(data: contents)
          self.imageView.image = img
          println("IMAGE!")
        }
      }
    }
  }
  
//  func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
//    
//    let progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
//    
//    NSLog("DownloadTask progress: %lf", progress)
//    
//    dispatch_async(dispatch_get_main_queue()) {
////      self.progressView.progress = progress
////      self.statusLabel.text = "Downloading..."
//    }
//    
//  }
//
//  
//  func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didFinishDownloadingToURL location: NSURL) {
//    
//    NSLog("[%@ %@]", reflect(self).summary, __FUNCTION__)
//    
//    let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
//    
//    let documentsPath = paths.first as? String
//    let filePath = documentsPath! + filename
//    
//    //move the downloaded file to docs directory
//    if NSFileManager.defaultManager().fileExistsAtPath(filePath) {
//      NSFileManager.defaultManager().removeItemAtPath(filePath, error: nil)
//    }
//    
//    NSFileManager.defaultManager().moveItemAtURL(location, toURL: NSURL.fileURLWithPath(filePath)!, error: nil)
//    
//    
//    //update UI elements
//    dispatch_async(dispatch_get_main_queue()) {
//      self.imageView.image = UIImage(contentsOfFile: filePath)
//    }
//  }
//  
//  
//  func URLSession(session: NSURLSession, task: NSURLSessionTask, didCompleteWithError error: NSError?) {
//    if (error == nil) {
//      dispatch_async(dispatch_get_main_queue()) {
////        self.statusLabel.text = "Download Successfully"
//      }
//      NSLog("S3 DownloadTask: %@ completed successfully", task);
//    } else {
//      dispatch_async(dispatch_get_main_queue()) {
////        self.statusLabel.text = "Download Failed"
//      }
//      NSLog("S3 DownloadTask: %@ completed with error: %@", task, error!.localizedDescription);
//    }
//    
//    dispatch_async(dispatch_get_main_queue()) {
////      self.progressView.progress = Float(task.countOfBytesReceived) / Float(task.countOfBytesExpectedToReceive)
//    }
//    
//    self.downloadTask = nil
//  }
//  
//  func URLSessionDidFinishEventsForBackgroundURLSession(session: NSURLSession) {
//    
////    let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
//    if ((appDelegate.backgroundDownloadSessionCompletionHandler) != nil) {
//      let completionHandler:() = appDelegate.backgroundDownloadSessionCompletionHandler!;
//      appDelegate.backgroundDownloadSessionCompletionHandler = nil
//      completionHandler
//    }
//    
//    NSLog("Completion Handler has been invoked, background download task has finished.");
//  }
}



















