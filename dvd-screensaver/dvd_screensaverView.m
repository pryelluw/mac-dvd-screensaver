//
//  dvd_screensaverView.m
//  dvd-screensaver
//
//  Created by Pablo Rivera on 4/15/20.
//  Copyright © 2020 Pablo Rivera. All rights reserved.
//  MIT License
//

#import "dvd_screensaverView.h"
#import <WebKit/WebKit.h>

@implementation dvd_screensaverView

- (instancetype)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
    if (!(self = [super initWithFrame:frame isPreview:isPreview])) return nil;

    NSString *style = @"/dvd.html";
    
    NSURL* indexHTMLDocumentURL = [NSURL URLWithString:[[[NSURL fileURLWithPath:[[NSBundle bundleForClass:self.class].resourcePath stringByAppendingString:style] isDirectory:NO] description] stringByAppendingFormat:@"?screensaver=1%@", self.isPreview ? @"&is_preview=1" : @""]];
    
    WebView* webView = [[WebView alloc] initWithFrame:NSMakeRect(0, 0, frame.size.width, frame.size.height)];

    webView.drawsBackground = NO; // Avoids a "white flash" just before the index.html file has loaded
    [webView.mainFrame loadRequest:[NSURLRequest requestWithURL:indexHTMLDocumentURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0]];
    
    [self addSubview:webView];
    return self;

}

- (void)startAnimation
{
    [super startAnimation];
}

- (void)stopAnimation
{
    [super stopAnimation];
}

- (void)drawRect:(NSRect)rect
{
    [super drawRect:rect];
}

- (void)animateOneFrame { [self stopAnimation]; }


- (BOOL)hasConfigureSheet
{
    return NO;
}

- (NSWindow*)configureSheet
{
    return nil;
}

#pragma mark - ScreenSaverView


#pragma mark - WebFrameLoadDelegate

- (void)webView:(WebView *)sender didFailLoadWithError:(NSError *)error forFrame:(WebFrame *)frame {
    NSLog(@"%@ error=%@", NSStringFromSelector(_cmd), error);
}

@end
