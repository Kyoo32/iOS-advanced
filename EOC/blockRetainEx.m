//EOCNetworkFetcher.h
#import <Foundation/Foundtaion.h>

typedef void(^EOCNetworkFetcherCompletionHandler)(NSData *data);

@interface EOCNetworkFetcher : NSObject
@property (nonatomic, strong, readonly) NSURL *url;
- (id)initWithURL: (NSURL*)url;
- (void)startWithCompletionHandler: (EOCNetworkFetcherCompletionHandler)completion;

@end

//EOCNetworkFetcher.m
#import "EOCNetworkFetcher.h"

@interface EOCNetworkFetcher()
@property (nonatomic, strong, readwrite) NSURL *url;
@property (nonatomic, copy) EOCNetworkFetcherCompletionHandler completionHandler;
@property (nonatomic, strong) NSData *downloadedData;

@end

@implementation EOCNetworkFetcher

- (id)initWithURL: (NSURL*)url {
	if((self = [super init])){
		_url = url;
	}
	return self;
}
- (void)startWithCompletionHandler: (EOCNetworkFetcherCompletionHandler)completion {
	self.completionHandler = completion;
}

-(void)p_requestCompleted {
	if(_completionHandler){
		_completionHandler(_downloadedData);
	}
}

@end


//EOCClass.m
@implementation EOCClass {
	EOCNetworkFetcher *_networkFetcher;
	NSData *_fetchedData;
}

- (void)downloadData {
	NSURL *url = [[NSURL alloc] initWithURL: @"sample.com"];
	_networkFetcher = [[EOCNetworkFetcher alloc] initWithURL: url];
	[_networkFetcher startWithCompletionHandler:^(NSData *data){
		NSLog(@"Request URL %@ finished", _networkFetcher.url);
		_fetchedData = data;

		/////////IMPORTANT for not making retain cycle
		_networkFetcher = nil;
	}]
}


