//serial synchronization queue

_syncQueue = dispatch_queue_create("sample.com", NULL);

- (NSString*)someString{
	__block NSString *localString;
	dispatch_sync(_syncQueue, ^{
		localString = _someString;
	})
	return localString;
}

- (void)setSomeString:(NSString*)someString{
	dispatch_sync(_syncQueue, ^{
		_someString = someString;
	})
}


//setter는 동기화가 필요하지 않다.

- (void)setSomeString:(NSString*)someString{
	dispatch_async(_syncQueue, ^{
		_someString = someString;
	})
}

//호출자 관점에서 빨라진 것 처럼 느껴지지만, 읽기와 쓰기는 여전히 각각에 대해 순차적으로 이루어진다.
//비동기 디스패치는 실행될 블록을 복사해야 하기 때문에 동기 디스패치에 비해 오래 걸린다.



//병렬 큐와 배리어 블록을 사용하여, 읽기 쓰기. 읽기는 병렬적으로. 쓰기는 동기화 보장하여
_syncQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

- (NSString*)someString{
	__block NSString *localString;
	dispatch_sync(_syncQueue, ^{
		localString = _someString;
	})
	return localString;
}

- (void)setSomeString:(NSString*)someString{
	dispatch_barrier_async(_syncQueue, ^{
		_someString = someString;
	})
}

