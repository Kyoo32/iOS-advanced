//basic syntax

dispatch_group_t dispatch_group_create();

//group은 식별자가 없다.
//테스크와 그룹을 연관지어야 한다.

//방법 1
void dispatch_group_async(dispatch_group_t group,
						dispatch_queue_t queue,
						dispatch_block_t block);

//방법 2
void dispatch_group_enter(dispatch_group_t group);
void dispatch_group_leave(dispatch_group_t group);


//그룹의 테스크가 끝나길 기다리기 원할 때

//현재 스레드 멈춤
long dispatch_group_wait(dispatch_group_t group,
						dispatch_time_t timeout);
// timeout : 최대시간
// timeout = DISPATCH_TIME_FOREVER 일 경우, 그룹이 끝날 때까지 기다림
// return : 타임아웃전에 끝나면 0

void dispatch_group_notify(dispatch_group_t group,
						dispatch_queue_t queue,
						dispatch_block_t block);
//현재 스레드를 멈추지 않는다.
// queue,block : 그룹의 일이 끝났을 때 실행될 큐와 블럭


// #ex1
dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
dispatch_group_t dispatchGroup = dispatch_group_create();
for (id object in collection) {
	dispatch_group_async(dispatchGroup, queue, ^{ [object performTask];});

}
dispatch_group_wait(dispatchGroup, DISPATCH_TIME_FOREVER);


// #ex2
dispatch_queue_t notifyQueue = dispatch_get_main_queue();
dispatch_group_notify(dispatchGroup, notifyQueue, ^{
	//완료 후 처리할 블록
});


// #ex3
dispatch_queue_t lowPriorityQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);
dispatch_queue_t highPriorityQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
dispatch_group_t dispatchGroup = dispatch_group_create();

for(id object in lowPriorityQueue){
	dispatch_group_async(dispatchGroup, lowPriorityQueue, ^{
		[object performTask];
	});
}

for(id object in highPriorityQueue){
	dispatch_group_async(dispatchGroup, highPriorityQueue, ^{
		[object performTask];
	});
}

dispatch_queue_t notifyQueue = dispatch_get_main_queue();
dispatch_group_notify(dispatchGroup, notifyQueue, ^{
	//완료 후 처리할 블록
});


