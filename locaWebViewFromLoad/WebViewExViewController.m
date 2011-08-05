//
//  WebViewExViewController.m
//  WebViewEx
//
//  Created by azu on 11/08/05.
//  Copyright 2011 azu. All rights reserved.
//
// http://d.hatena.ne.jp/chia1220jp/20110228/1298885373 より
#import "WebViewExViewController.h"

@implementation WebViewExViewController

@synthesize fileName = fileName_;

- (WebViewExViewController *)initWithFileName:(NSString *)fileName{
    self = [super init];
    if(self){
        self.fileName = fileName;
    }
    return self;
}
// アラートの表示
- (void)showAlert:(NSString *)title text:(NSString *)text{
    UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:title message:text delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil] autorelease];
    [alert show];
}
// Web View
- (UIWebView *)makeWebView:(CGRect)rect{
    UIWebView *webView = [[[UIWebView alloc] init] autorelease];
    [webView setFrame:rect];
	[webView setBackgroundColor:[UIColor whiteColor]];
	[webView setScalesPageToFit:NO];
	//サイズ自動調整
	webView.autoresizingMask=
    UIViewAutoresizingFlexibleWidth|
    UIViewAutoresizingFlexibleHeight|
    UIViewAutoresizingFlexibleLeftMargin|
    UIViewAutoresizingFlexibleRightMargin|
    UIViewAutoresizingFlexibleTopMargin|
    UIViewAutoresizingFlexibleBottomMargin;
    
	return webView;
}

- (void)dealloc
{
    // http://iphone-app-developer.seesaa.net/article/139982537.html
    _webView.delegate = nil;
    [_webView release];
    [super dealloc];
}

// NSRangeaのラッパー
- (int)indexOf:(NSString *)str c:(NSString *)c{
    NSRange range = [str rangeOfString:c];
    if(range.location==NSNotFound){
        return -1;
    }
    return range.location;
}

//HTML読み込み開始時に呼ばれる
// NOを返すと読み込みが停止する
- (BOOL)webView:(UIWebView*)webView shouldStartLaodWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType {
	//クリック時
	if (navigationType==UIWebViewNavigationTypeLinkClicked || navigationType==UIWebViewNavigationTypeFormSubmitted) {
		//通信中の時は再度URLジャンプさせない
		if ([UIApplication sharedApplication].networkActivityIndicatorVisible) return NO;
		
		//リクエストからのURL文字列取得
		NSString* url=[[request URL] relativeString];
		NSLog(@"url>%@",url);
		
		//メーラーの起動
		if ([self indexOf:url c:@"mailto:"]==0) {
			[[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
			return NO;
		}
		
		//ページ内リンク時はインジケーターを表示しない
		if ([self indexOf:url c:@"#"]>=0) {
			return YES;
		}
		
		//インジケーター表示
		[UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
	}
	return YES;
}

//HTML読み込み成功時に呼ばれる
- (void)webViewDidFinishLoad:(UIWebView *)webView {
	//インジケーターの非表示
	[UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
}

//HTML読み込み失敗時に呼ばれる
- (void)webView:(UIWebView*)webView didFailLoadWithError:(NSError*)error {
	//インジケーターの非表示
	[UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
	
	//アラート
	[self showAlert:@"" text:@"通信に失敗しました"];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
	//Webビューの生成
    // webview入れる前になんか灰色のボックスがある。 (=> 灰色の正体は背景色)
    // 320 460と正常(ステータスバーは20px)
    NSLog(@"%4.0f %4.0f", self.view.frame.size.width , self.view.frame.size.height);
    // なので 位置が おかしいとわかる
    // 0 20(y座標が20pxずれている。)
    NSLog(@"%4.0f %4.0f", self.view.frame.origin.x , self.view.frame.origin.y);
    // なので、self.view.frameをそのまま使うとおかしい。
	_webView=[[self makeWebView:self.view.frame] retain];
	[_webView setDelegate:self];
    
	[self.view addSubview:_webView];
	
	//インジケーターの表示
	[UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
	
	/*
     //WEB上のHTMLの読み込み
     [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://d.hatena.ne.jp/chiaki1220jp/"]]];
     */
	NSLog(@"%@", self.fileName);
	//▼ ちょとローカルでてすてす
	NSString* path=[[NSBundle mainBundle] pathForResource:self.fileName ofType:@"html"];
    NSURL* url;
    url = [NSURL fileURLWithPath:path];
	[_webView loadRequest:[NSURLRequest requestWithURL:url]];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
