//
//  MTOptionsController.h
//  MemoryTiles
//
//  Created by Rajiev Timal on 3/14/13.
//  Copyright (c) 2013 HappyBrain. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol mtOptionsDelegate <NSObject>

-(void)resetGame;

@end

@interface MTOptionsController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) id<mtOptionsDelegate> delegate;

@end
