//
//  WebViewExViewController.h
//  WebViewEx
//
//  Created by azu on 11/08/05.
//  Copyright 2011 azu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewExViewController : UIViewController <UIWebViewDelegate> {
    UIWebView *_webView;
    NSString *fileName_;
}
@property (nonatomic,retain)NSString *fileName;
- (WebViewExViewController *)initWithFileName:(NSString*)fileName;
@end
