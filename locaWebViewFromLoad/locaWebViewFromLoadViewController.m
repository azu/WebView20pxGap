//
//  locaWebViewFromLoadViewController.m
//  locaWebViewFromLoad
//
//  Created by azu on 11/08/05.
//  Copyright 2011 azu. All rights reserved.
//

#import "locaWebViewFromLoadViewController.h"
#import "WebViewExViewController.h"
@implementation locaWebViewFromLoadViewController

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/
- (void)loadView{
    [super loadView];
    WebViewExViewController *webView = [[WebViewExViewController alloc] initWithFileName:@"hamuchans"];
    // まだViewがないからloadするので、addSubviewではなくてself.viewに入れる
    // self.view = webView.view;
    // と思ったけど、superを呼び出してないからそうなってただけだ
    // http://cheebow.info/chemt/archives/2010/11/loadviewviewdid.html
    [self.view addSubview:webView.view];
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
