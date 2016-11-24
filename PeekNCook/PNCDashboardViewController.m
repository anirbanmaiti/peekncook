//
//  ViewController.m
//  PeekNCook
//
//  Created by AnirbanMaiti on 12/4/14.
//  Copyright (c) 2014 PeekNCook. All rights reserved.
//

#import "PNCDashboardViewController.h"
#import "PNCDashboardDefaultCollectionViewCell.h"
#import "PNCContentManager.h"
#import "PNCCategoryTableViewCell.h"
#import "PNCImageDownloader.h"
#import "PNCRecipeDetailedViewController.h"
#import "PNCDashboardDefaultCollectionViewCell.h"
#import "PNCUtilities.h"

@interface PNCDashboardViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *menuView;

@end

@implementation PNCDashboardViewController{
    UIRefreshControl *refreshControl;
    BOOL _viewDidScroll;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.alpha = 0.5f;
    [UIView setAnimationsEnabled:NO];

    UIImageView *logoImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];
    // if you need to resize the image to fit the UIImageView frame
    logoImage.contentMode = UIViewContentModeScaleAspectFit;
    // no extension name needed for image_name
    [logoImage setImage:[UIImage imageNamed:@"headerlogo.png"]];
    UIView *logoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, logoImage.frame.size.width, logoImage.frame.size.height)];
    [logoView addSubview:logoImage];
    self.navigationItem.titleView = logoView;
    
    
//
//    
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.tableView.bounds.size.width, 10.0f)];
//    UIImage *image = [UIImage imageNamed:@"headerlogo.png"];
//    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:image];

    // Do any additional setup after loading the view, typically from a nib.
//    UIView *refreshView = [[UIView alloc] initWithFrame:CGRectMake(0, 40, 0, 0)];
//    [self.tableView insertSubview:refreshView atIndex:0]; //the tableView is a IBOutlet
//    refreshControl = [[UIRefreshControl alloc] init];
//    refreshControl.tintColor = [UIColor lightGrayColor];
//    [refreshControl addTarget:self action:@selector(reloadDatas) forControlEvents:UIControlEventValueChanged];
    /* NSMutableAttributedString *refreshString = [[NSMutableAttributedString alloc] initWithString:@"Pull To Refresh"];
     [refreshString addAttributes:@{NSForegroundColorAttributeName : [UIColor grayColor]} range:NSMakeRange(0, refreshString.length)];
     refreshControl.attributedTitle = refreshString; */
//    [refreshView addSubview:refreshControl];
}
-(void)viewWillAppear:(BOOL)animated{
    UIView *navBorder = [[UIView alloc] initWithFrame:CGRectMake(0,self.navigationController.navigationBar.frame.size.height-1,self.navigationController.navigationBar.frame.size.width, 1)];
    //[navBorder setBackgroundColor:[UIColor colorWithWhite:200.0f/255.f alpha:0.1f]];
    [navBorder setBackgroundColor:[UIColor whiteColor]];
    [navBorder setOpaque:YES];
    [self.navigationController.navigationBar addSubview:navBorder];
}

-(void)viewDidAppear:(BOOL)animated{
    _viewDidScroll = NO;
    [UIView setAnimationsEnabled:YES];
    [UIView animateWithDuration:0.2 animations: ^ {
        self.tableView.alpha = 1.0f;

    } completion:nil];
}
//-(void)reloadDatas
//{
//    //update here...
//    [refreshControl endRefreshing];
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
#pragma mark - UIScrollView handlers
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    _viewDidScroll = YES;
}
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    _viewDidScroll = NO;
}

#pragma mark - UICollectionView handlers

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSIndexPath* pathOfTheCell = [self tableRowIndexFromCollectionView:collectionView];
    PNCCategory *category = [[PNCContentManager sharedInstance] categoryAtIndex:pathOfTheCell.row];
    return [category.recipes count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSIndexPath* pathOfTheCell = [self tableRowIndexFromCollectionView:collectionView];
    PNCCategory *category = [[PNCContentManager sharedInstance] categoryAtIndex:pathOfTheCell.row];

    PNCRecipe* recipe = [category.recipes objectAtIndex:indexPath.row];
    PNCDashboardDefaultCollectionViewCell *cell = (PNCDashboardDefaultCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.dataLabel.text = recipe.name;
    //cell.backgroundColor = [UIColor colorWithRed:(178/255.0) green:(237/255.0) blue:(107/255.0) alpha:1.0];
    
    if (recipe.image1x && recipe.dashboardImage == nil){
        UIImage *originalImage = [UIImage imageWithData:recipe.image1x];
        CGSize size = CGSizeMake(320, 320);
//        UIGraphicsBeginImageContext( size );
//        [originalImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
//        UIImage *picture1 = UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
//        
//        NSData *imageData = UIImagePNGRepresentation(picture1);
        UIImage *picture1 = [PNCUtilities resizedImage:originalImage withRect:CGRectMake(0, 0, size.width, size.height)];
        recipe.dashboardImage = picture1;
        [cell setRecipeImage:picture1];
        
        size = CGSizeMake(160, 160);
//        UIGraphicsBeginImageContext( size );
//        [originalImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
//        picture1 = UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
//        imageData = UIImagePNGRepresentation(picture1);
        UIImage *picture2 = [PNCUtilities resizedImage:originalImage withRect:CGRectMake(0, 0, size.width, size.height)];
        recipe.lowResImage = picture2;

    }
    else if (recipe.dashboardImage){
        [cell setRecipeImage:recipe.dashboardImage];
    }
    else{
        NSString* fileId = recipe.image_uid;
        if (fileId) {
            dispatch_queue_t loaderQ = dispatch_queue_create("com.peekncook.imagedownloader", NULL);
            dispatch_async(loaderQ,^{
                NSData* cachedData = [[PNCImageDownloader sharedInstance] downloadImageWithUID:fileId withCompletionBlock:^(NSData * data) {
                    
                    UIImage *originalImage = [UIImage imageWithData:data];
                    CGSize size = CGSizeMake(320, 320);
                    UIGraphicsBeginImageContext( size );
                    [originalImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
                    UIImage *picture1 = UIGraphicsGetImageFromCurrentImageContext();
                    UIGraphicsEndImageContext();
                    
                    NSData *imageData = UIImagePNGRepresentation(picture1);
                    //UIImage *img=[UIImage imageWithData:imageData];
                    
                    [cell setRecipeImageData:imageData];
                    recipe.image1x = imageData;
                }];
                if (cachedData) {
                    [cell setRecipeImageData:cachedData];
                }
            });
        }
    }
    
    return cell;
}


-(NSIndexPath*) tableRowIndexFromCollectionView:(UICollectionView *)collectionView{
    UIView *view;
    for (view = collectionView.superview; ![view isKindOfClass:UITableViewCell.class]; view = view.superview);
    UITableViewCell *tablecell = (UITableViewCell*)view;
    
    for (view = tablecell.superview; ![view isKindOfClass:UITableView.class]; view = view.superview);
    UITableView* table = (UITableView *)view;
    NSIndexPath* pathOfTheCell = [table indexPathForCell:tablecell];
    return pathOfTheCell;
    //NSLog(@"pathOfTheCell: %ld", (long)pathOfTheCell.row);
}

#pragma mark - UITableView methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[PNCContentManager sharedInstance] categoryCount];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // get the recipe category for index
    PNCCategory *category = [[PNCContentManager sharedInstance] categoryAtIndex:indexPath.row];
    PNCCategoryTableViewCell *cell = (PNCCategoryTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"tablecell" forIndexPath:indexPath];
    UIView *header = (UIView*)[cell.contentView viewWithTag:100];
    UILabel *lbl = (UILabel*)[header viewWithTag:101];
    if (lbl) {
        lbl.text = category.name;
        [lbl setFont:[UIFont fontWithName:@PNC_FONT_HEADER size:(15.0)]];
    }
    

    if (_viewDidScroll) {
        UICollectionView *collectionView = (UICollectionView*)[cell.contentView viewWithTag:200];
        //    collectionView.pagingEnabled = YES;
        [collectionView reloadData];
    }

    //cell.backgroundColor = [UIColor colorWithRed:(178/255.0) green:(237/255.0) blue:(107/255.0) alpha:0.3];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 280;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    return [[UIView alloc] initWithFrame:CGRectZero];
//}

/*-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc] initWithFrame:CGRectZero];
}*/

- (BOOL)prefersStatusBarHidden {
    return NO;
}

-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    
    NSIndexPath* pathOfTheCell = [self tableRowIndexFromCollectionView:collectionView];
    [self.tableView scrollToRowAtIndexPath:pathOfTheCell
                         atScrollPosition:UITableViewScrollPositionMiddle
                                 animated:YES];
    
    return YES;
}
//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    
////    [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
//}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSLog(@"%s", __FUNCTION__);
    
    UICollectionView *collectionView = (UICollectionView *)scrollView;
    for (PNCDashboardDefaultCollectionViewCell *cell in [collectionView visibleCells]) {
        if (cell == nil) {
            return;
        }
        NSIndexPath *indexPath = [collectionView indexPathForCell:cell];
        NSUInteger lastIndex = [indexPath indexAtPosition:[indexPath length] - 1];
        NSLog(@"visible cell value %lu",(unsigned long)lastIndex);
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    //    if ([[segue identifier] isEqualToString:@"showDetail"]) {
    if([segue.destinationViewController isKindOfClass:[PNCRecipeDetailedViewController class]]){
        
        
        PNCRecipeDetailedViewController* detailedView = (PNCRecipeDetailedViewController*)segue.destinationViewController;
        PNCDashboardDefaultCollectionViewCell *cell = (PNCDashboardDefaultCollectionViewCell*)sender;
        UICollectionView* collectionView = (UICollectionView*)cell.superview;
        NSIndexPath* pathOfTheCell = [self tableRowIndexFromCollectionView:collectionView];

        
        PNCCategory *category = [[PNCContentManager sharedInstance] categoryAtIndex:pathOfTheCell.row];
        
        NSIndexPath *selectedCollectionIndexPath = [collectionView indexPathForCell:cell];
        PNCRecipe* recipe = [category.recipes objectAtIndex:selectedCollectionIndexPath.row];
        detailedView.recipe = recipe;
        
        
        self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
        
        //[[PNCContentManager sharedInstance] save];
        
    }
}
@end
