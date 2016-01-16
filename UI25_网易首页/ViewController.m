//
//  ViewController.m
//  UI25_网易首页
//
//  Created by dllo on 16/1/16.
//  Copyright © 2016年 lanou.com. All rights reserved.
//

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

#import "ViewController.h"
#import "NetworkHandler.h"
#import "ModelOfData.h"
#import "CellForScrollView.h"
@interface ViewController ()<UIScrollViewDelegate,NetworkHandlerDelegate,UITableViewDataSource,UITableViewDelegate>


@property (nonatomic, retain) NSMutableArray *arrData;
@property (nonatomic, retain) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
 
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    self.navigationController.tabBarController.tabBar.tintColor = [UIColor redColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    [self createScrollView];
    [self createbutton];
    [self handleData];
    [self createTableView];
    
    
}

#pragma mark 数据处理.
- (void)handleData {

    [NetworkHandler handlerJSONWithURL:@"http://c.m.163.com/nc/article/headline/T1348647853363/0-140.html" delegate:self];
}

- (void)handlerDidComplete:(id)result {

    self.arrData = [NSMutableArray array];
    NSArray *arrTemp = [result objectForKey:@"T1348647853363"];

    
    for (NSDictionary *dic in arrTemp) {
        ModelOfData *model = [[ModelOfData alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        NSArray *arrTemp = [dic objectForKey:@"ads"];
        if (model.ads) {
            for (NSDictionary *dic in arrTemp) {
        
                [model.arrAds addObject:dic];
            }
        }
         [self.arrData addObject:model];
//        NSLog(@"%@",model.arrAds);
        NSLog(@"%ld",self.arrData.count);
        [self.tableView reloadData];

    }
}


#pragma mark VC上的视图布局.
- (void)createScrollView {
    
    NSMutableArray *arr = @[@"头条",@"娱乐",@"热点",@"体育",@"大连",@"北京",@"湖南",@"手机",@"资讯",@"互联网"].mutableCopy;

    
    UIScrollView *scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, WIDTH - 50, 50)];
    [self.view addSubview:scroll];
    scroll.pagingEnabled = YES;
//    scroll.scrollIndicatorInsets = UIEdgeInsetsMake(10,10 , 10, 10);
    

    scroll.contentSize = CGSizeMake((WIDTH - 50) / 5 * arr.count, 50);
    
    for (int i = 0; i < arr.count; i ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [scroll addSubview:button];
        button.frame = CGRectMake( (WIDTH - 50) / 5 * i, 0 , (WIDTH - 50) / 5 , 50);
        [button setTitle:arr[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }
}

- (void)createbutton {
    
    UIButton  *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:button];
    button.frame = CGRectMake(WIDTH - 50, 64, 40, 40);

    [button setImage:[UIImage imageNamed:@"08"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(handleActionForCatalogue:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)handleActionForCatalogue:(UIButton *)button {

    NSLog(@"此处推出一个CollectionView");
    
//    ViewControllerTwo *twoViewController = [[ViewControllerTwo alloc]init];
//    self.modalPresentationStyle = UIModalTransitionStyleFlipHorizontal;
//    [self presentViewController:twoViewController animated:YES completion:^{
//        
//    }];
}

- (void)createTableView {

    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 114, WIDTH, HEIGHT - 163) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"CellForScrollView" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"poolForCellOne"];


    
}

#pragma mark tableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    NSLog(@"%s,%ld",__FUNCTION__,self.arrData.count);

    return self.arrData.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    ModelOfData *model = [self.arrData objectAtIndex:indexPath.row];
    if (model.ads) {
         CellForScrollView *cell = [tableView dequeueReusableCellWithIdentifier:@"poolForCellOne"];
   
//        [cell passModel:model];
        return cell;
    } else
    {
        return nil;
    }
}

#pragma mark tableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return [CellForScrollView heightForCellScrollView];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
