[self performSelector: @selector(doSomething)
			withObject:nil
			afterDelay:0.5];
// instead of performSelector:withObject:afterDelay:
// -> dispatch_after
dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW,
					 (int64_t)(5.0 * NSEC_PER_SEC));
dispatch_after(time, dispatch_get_main_queue(), ^(void){
	[self doSomething];
});


/* for main thread */
[self performSelectorOnMainThread:@selector(doSomething)
				withObject:nil
				waitUntilDone:NO];
// -> dispatch_async
dispatch_async(dispatch_get_main_queue(), ^{
	[self doSomething];
});


