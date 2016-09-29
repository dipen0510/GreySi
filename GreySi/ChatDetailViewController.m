//
//  ChatDetailViewController.m
//  GreySi
//
//  Created by Dipen Sekhsaria on 08/08/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import "ChatDetailViewController.h"

@interface ChatDetailViewController ()

@end

@implementation ChatDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupInitialUI];
    
}

-(void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    [self addMessage:@"Hi" forSenderId:@"7890"];
    [self addMessage:@"Hello" forSenderId:self.senderId];
    [self addMessage:@"How are you?" forSenderId:self.senderId];
    
    [self.collectionView reloadData];
    
}

- (void) setupInitialUI {
    
    messages = [[NSMutableArray alloc] init];
    self.profileImageView.layer.masksToBounds = YES;
    self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.height/2.;
    self.senderId = @"1234";
    self.senderDisplayName = @"Emily Rose";
    [self.backButton addTarget:self action:@selector(backButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    [self setupBubbles];
    
}

- (void) setupBubbles {
    
    JSQMessagesBubbleImageFactory* factory = [[JSQMessagesBubbleImageFactory alloc] init];
    outgoingBubbleImageView = [factory outgoingMessagesBubbleImageWithColor:[UIColor jsq_messageBubbleLightGrayColor]];
    incomingBubbleImageView = [factory incomingMessagesBubbleImageWithColor:[UIColor jsq_messageBubbleLightGrayColor]];
    
    outgoingAvtarImageView = [JSQMessagesAvatarImageFactory avatarImageWithImage:[UIImage imageNamed:@"mike.jpg"] diameter:60.0];
    incomingAvtarImageView = [JSQMessagesAvatarImageFactory avatarImageWithImage:[UIImage imageNamed:@"Screen Shot 2016-03-30 at 12.44.22 AM.png"] diameter:60.0];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - User Action Events

- (void)didPressSendButton:(UIButton *)button withMessageText:(NSString *)text senderId:(NSString *)senderId senderDisplayName:(NSString *)senderDisplayName date:(NSDate *)date {
    
    [self addMessage:text forSenderId:senderId];
    [self finishSendingMessage];
    
}

-(void)didPressAccessoryButton:(UIButton *)sender {
    
    
    
}

#pragma mark - Message Collection View Data Source

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return messages.count;
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    JSQMessagesCollectionViewCell *cell = (JSQMessagesCollectionViewCell *)[super collectionView:collectionView cellForItemAtIndexPath:indexPath];

    cell.textView.textColor = [UIColor blackColor];
    cell.textView.font = [UIFont systemFontOfSize:12.0];

    
    return cell;
    
}

-(id<JSQMessageData>)collectionView:(JSQMessagesCollectionView *)collectionView messageDataForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return messages[indexPath.item];
    
}

- (id<JSQMessageBubbleImageDataSource>)collectionView:(JSQMessagesCollectionView *)collectionView messageBubbleImageDataForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    JSQMessage* message = messages[indexPath.item];
    
    if ([message.senderId isEqualToString: self.senderId]) {
        return outgoingBubbleImageView;
    }
    else {
        return incomingBubbleImageView;
    }
    
}

- (id<JSQMessageAvatarImageDataSource>)collectionView:(JSQMessagesCollectionView *)collectionView avatarImageDataForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    JSQMessage* message = messages[indexPath.item];
    
    if ([message.senderId isEqualToString: self.senderId]) {
        return outgoingAvtarImageView;
    }
    else {
        return incomingAvtarImageView;
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark - Message Handlers

- (void) addMessage:(NSString *)message forSenderId:(NSString *)senderId {
    
    JSQMessage* tmpMessage = [[JSQMessage alloc] initWithSenderId:senderId senderDisplayName:@"" date:[NSDate date] text:message];
    [messages addObject:tmpMessage];
    
}

#pragma mark - User Action Events

- (IBAction)backButtonTapped:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
