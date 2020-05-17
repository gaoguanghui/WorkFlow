//
//  ViewController.m
//  WKWebView-demo1
//
//  Created by jinjin on 2020/3/8.
//  Copyright © 2020 jinjin. All rights reserved.
//
// https://www.jianshu.com/p/ec6993727741
#import "ViewController.h"
#import <WebKit/WebKit.h>

@interface ViewController ()<WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler>

@property (nonatomic, strong) WKWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor cyanColor];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //注册jsCallOc方法 以供JS调用OC方法
    WKUserContentController *userContentController = [[WKUserContentController alloc] init];
    //需要实现<WKScriptMessageHandler>,可同时注册多个方法名字,但是记得在控制器销毁时候移除。
    [userContentController addScriptMessageHandler:self name:@"jsCallOc"];
    WKWebViewConfiguration *webConfiguration = [[WKWebViewConfiguration alloc] init];
    webConfiguration.userContentController = userContentController;
    _webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:webConfiguration];
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    [self.view addSubview:_webView];
    //网络加载
//    NSURL *url = [[NSURL alloc] initWithString:@"http://192.168.2.5:8080"];
//    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
//    [_webView loadRequest:request];
    //本地加载
    //加载本地html
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"testFunction" ofType:@"html"];
    [_webView loadFileURL:[NSURL fileURLWithPath:filePath] allowingReadAccessToURL:[NSBundle mainBundle].resourceURL];
}

#pragma mark --
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    //获取值
    NSLog(@"data:%@", message.body);
    
    //获取函数名字
    NSLog(@"data:%@", message.name);
}

#pragma mark -- WKNavigationDelegate
//html加载失败
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    NSLog(@"error message:%@",error);
}

//html开始加载
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    NSLog(@"begin load html");
}

//html加载完成
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    NSLog(@"finish load");
    
//    //调用js无参函数
//    [webView evaluateJavaScript:@"testA()" completionHandler:^(id _Nullable response, NSError * _Nullable error) {
//
//        //js函数调用return,这里才会有东西,否则无任何信息。
//        NSLog(@"response: %@ error: %@", response, error);
//    }];
//
    //调用js有参函数
    [webView evaluateJavaScript:[NSString stringWithFormat:@"testB('%@')",@"show"] completionHandler:^(id _Nullable response, NSError * _Nullable error) {

        //js函数调用return,这里才会有东西,否则无任何信息。
        NSLog(@"response: %@ error: %@", response, error);
    }];
//
//    //调用js有参函数并获得返回值
//    [webView evaluateJavaScript:[NSString stringWithFormat:@"testC('%@')",@"return value"] completionHandler:^(id _Nullable response, NSError * _Nullable error) {
//
//        //js函数调用return,这里才会有东西,否则无任何信息。
//        NSLog(@"response: %@ error: %@", response, error);
//    }];
}

#pragma mark -- WKNavigationDelegate
// OC 调用 JS 弹窗
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    NSLog(@"finish load");
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
    //    DLOG(@"msg = %@ frmae = %@",message,frame);
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }])];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
