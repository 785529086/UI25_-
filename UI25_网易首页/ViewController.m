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
#import "CellForNormalNews.h"
#import "CollectionViewCell.h"
@interface ViewController ()<UIScrollViewDelegate,NetworkHandlerDelegate,UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>


@property (nonatomic, retain) NSMutableArray *arrData;
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) UICollectionView *collection;
@property (nonatomic, retain) UICollectionViewFlowLayout *flowout;
@property (nonatomic, retain) NSArray *arrTitle;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    self.navigationController.tabBarController.tabBar.tintColor = [UIColor redColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
   
    [self addArrTitileData];
    [self createScrollView];
    [self createbutton];
    
    [self handleData];
    [self createTableView];
}

#pragma mark 数据处理.

- (void)addArrTitileData {
    
     self.arrTitle = @[@"头条",@"娱乐",@"热点",@"体育",@"大连",@"北京",@"湖南",@"手机",@"资讯",@"互联网",@"头条",@"娱乐",@"热点",@"体育",@"大连",@"北京",@"湖南",@"手机",@"资讯",@"互联网"];

}

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
   
        [self.tableView reloadData];

    }
}


#pragma mark VC上的视图布局.

#pragma mark 1.CreateScrollView
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
    button.frame = CGRectMake(WIDTH - 50, 78, 25, 25);
//    button.backgroundColor = [UIColor cyanColor];

    [button setImage:[UIImage imageNamed:@"06"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(handleActionForCatalogue:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)handleActionForCatalogue:(UIButton *)button {

    NSLog(@"此处推出一个CollectionView");
    
    
    [self createCollection:(UIButton *)button];

    
    

}

#pragma mark 2.CreateCollectionView
// 将button中创建的CollectionView提出来
- (void)createCollection:(UIButton *)button {
    
//    if (self.collection == nil) {
//        <#statements#>
//    }

    button.selected = !button.selected;
    NSLog(@"%d",!button.selected);
    if (button.isSelected) {
        
    UICollectionViewFlowLayout *flowout = [[UICollectionViewFlowLayout alloc]init];
    flowout.itemSize = CGSizeMake((WIDTH - 50) / 4, 50);
        flowout.minimumInteritemSpacing = 10;
        flowout.minimumLineSpacing = 10;
        flowout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    self.collection = [[UICollectionView alloc]initWithFrame:CGRectMake( 0, 64 + 40, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height / 2) collectionViewLayout:flowout];

     self.collection.backgroundColor = [UIColor whiteColor];
     [self.view addSubview:self.collection];
    
    self.collection.dataSource = self;
    self.collection.delegate = self;
    
    // 动画展开.
    [UIView animateWithDuration:0.25 animations:^{
        self.collection.frame = CGRectMake(0, 104, WIDTH, HEIGHT - 104);
        button.transform = CGAffineTransformMakeRotation(M_PI);
    }];
    [self.collection registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"poolForCollectionCell"];
    }
    else {
        [UIView animateWithDuration:0.25 animations:^{
            self.collection.frame = CGRectMake(0, 104, WIDTH, 0);
          button.transform = CGAffineTransformMakeRotation(0);
        }];
    }
}

#pragma mark collectionView DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"poolForCollectionCell" forIndexPath:indexPath];

    
    [cell passArrTitle:self.arrTitle[indexPath.item]];
    
    
    return cell;
}

#pragma mark collectionView Delegate



#pragma mark 3.CreateTableView
- (void)createTableView {

    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 114, WIDTH, HEIGHT - 163) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
//    [self.tableView registerNib:[UINib nibWithNibName:@"CellForScrollView" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"poolForCellOne"];

    
    [self.tableView registerClass:[CellForScrollView class] forCellReuseIdentifier:@"poolForCellOne"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CellForNormalNews"bundle:[NSBundle mainBundle]]forCellReuseIdentifier:@"poolForCellTwo"];
}

#pragma mark tableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.arrData.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    ModelOfData *model = [self.arrData objectAtIndex:indexPath.row];
    if (model.ads) {
         CellForScrollView *cell = [tableView dequeueReusableCellWithIdentifier:@"poolForCellOne"];
        [cell passModel:model];
        return cell;
    } else
    {
        CellForNormalNews *cell = [tableView dequeueReusableCellWithIdentifier:@"poolForCellTwo"];
        
        [cell passModel:model];
        
        return cell;
     
    }
}

#pragma mark tableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    ModelOfData *model = [self.arrData objectAtIndex:indexPath.row];
    if (model.ads) {
        return [CellForScrollView heightForCellScrollView];
    }else
    {
        return 200;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    NSLog(@"ddd");
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
