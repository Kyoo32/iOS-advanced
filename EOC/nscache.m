#import <Foundation/Foundation.h>

//network fetch class
typedef void(^EOCNetworkFetcherCompletionHandler)(NSData *data);
@interface EOCNetworkFetcher : NSObject
-(id)initWithURL: (NSURL*)url;
-(void)startWithCompletionHandler: (EOCNetworkFetcherCompletionHandler)handler;
@end

//네트워크 패처를 사용하는 클래스
@interface EOCClass : NSObject
@end

@implementation EOCClass {
	NSCache *_cache;
}

-(id)init {
	if ((self = [super init])){
		_cache = [NSCache new];
		_cache.countLimit = 100;
		_cache.totalCostLimit = 5 * 1024 * 1024;
	}
	return self;
}

-(void)downloadDataForURL : (NSURL*)url {
	NSData *cachedData = [_cache objectForKey: url];
	if(cachedData){
		[cachedData beingContentAccess];
		[self useData: cachedData];
		[cachedData endContentAccess];
	} else {
		EOCNetworkFetcher *fetcher = [[EOCNetworkFetcher alloc]initWithURL: url];
		[fetcher startWithCompletionHandler: ^(NSData* data){
			//1.
			[_cache setObject:data forKey:url cost:data.length];
			[self useData:data];
			//2.
			NSPurgeableData *purgeableData = [NSPurgeableData dataWithData: data];
			[_cache setObject:purgeableData forKey:url cost:purgeableData.length];
			[self useData:data];
			
			[purgeableData endContentAccess];
		}]
	}
}

@end