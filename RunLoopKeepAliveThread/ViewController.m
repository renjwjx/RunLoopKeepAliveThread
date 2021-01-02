//
//  ViewController.m
//  RunLoopKeepAliveThread
//
//  Created by renjinwei on 2021/1/2.
//  Copyright © 2021 renjinwei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) NSThread* thread;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)createThread:(id)sender {
    NSThread* thread = [[NSThread alloc] initWithTarget:self selector:@selector(threadMain) object:nil];
    [thread start];
    self.thread = thread;
    
}

- (void)threadMain
{
    NSLog(@"@thread start - %@", [NSThread currentThread]);
    [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc] init] forMode:NSDefaultRunLoopMode];
    //add port 会让current RunLoop 不会退出
    [[NSRunLoop currentRunLoop] run];
    
}

- (IBAction)performTask:(id)sender
{
    NSLog(@"start perfromTask");
    [self performSelector:@selector(performTaskOnThread) onThread:self.thread withObject:nil waitUntilDone:YES];
}

- (void)performTaskOnThread
{
    NSLog(@"perfromTask on thread %@", [NSThread currentThread]);
}

@end
