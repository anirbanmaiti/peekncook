//
//  PNCRecipeDetailedViewController.m
//  PeekNCook
//
//  Created by AnirbanMaiti on 12/9/14.
//  Copyright (c) 2014 PeekNCook. All rights reserved.
//

#import "PNCRecipeDetailedViewController.h"
#import "PNCUtilities.h"
#import "PNCRecipeView.h"
#import "PNCSectionView.h"
#import "PNCSectionSeperator.h"

@interface PNCRecipeDetailedViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *longName;
@property (weak, nonatomic) IBOutlet UILabel *recipeDescriptionLabel;
@property (strong, nonatomic) IBOutlet PNCRecipeView *_detailView;

@property (weak, nonatomic) IBOutlet UIView *detailedContentView;


@property (weak, nonatomic) IBOutlet UIScrollView *imageContainerScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *wrapperScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (strong, nonatomic) NSMutableArray *_sections;


@end

static CGFloat ImageHeight  = 200.0;
CGFloat ImageWidth  = 320.0;
static CGFloat kParallaxDeltaFactor = 0.7f;


@implementation PNCRecipeDetailedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self._sections = [NSMutableArray array];
    ImageWidth = self.view.bounds.size.width;
    
    //set view controller details
    //self.navigationItem.title = self.recipe.name;
    
    
    UILabel *nav_titlelbl=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.navigationItem.titleView.frame.size.width,40)];
    nav_titlelbl.text=self.recipe.name;
    
    nav_titlelbl.textAlignment=NSTextAlignmentCenter;
    
    UIFont *lblfont=[UIFont fontWithName:@PNC_FONT_HEADER size:17];
    [nav_titlelbl setFont:lblfont];
    self.navigationItem.titleView=nav_titlelbl;
    
    [self.contentView setBackgroundColor:[UIColor whiteColor]];

    //[self.scrollView setBackgroundColor:[UIColor colorWithWhite:0.85f alpha:1.0f]];
    
    NSLog(@"%f", self.imageContainerScrollView.frame.origin.y);
    //self.imageContainerScrollView.frame = self.view.frame;
    self.imageContainerScrollView.backgroundColor = [UIColor clearColor];
    //self.imageContainerScrollView.frame.origin.y = 0.0f;
    //self.imageContainerScrollView.backgroundColor = [UIColor clearColor];
    self.imageContainerScrollView.showsHorizontalScrollIndicator = NO;
    self.imageContainerScrollView.showsVerticalScrollIndicator = NO;
    
        NSData *imageData = self.recipe.image1x;
        UIImage *originalImage = [UIImage imageWithData:imageData];
//        if (imageData && self.recipe.detailedImage == nil) {
            NSLog(@"%f, %f", originalImage.size.width, originalImage.size.height);

            CGSize size = CGSizeMake(400, 200);
    //        UIGraphicsBeginImageContext( size );
    //        [originalImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
    //        UIImage *picture1 = UIGraphicsGetImageFromCurrentImageContext();
    //        UIGraphicsEndImageContext();
    //
    //        imageData = UIImagePNGRepresentation(picture1);
            UIImage *picture1 = [PNCUtilities resizedImage:originalImage withSize:size];
    
            self.recipe.detailedImage = picture1;
//        }
//        if (self.recipe.detailedImage) {
//            _imageView.image = self.recipe.detailedImage;
//        }

    NSArray *images = @[self.recipe.detailedImage, self.recipe.dashboardImage];
    //NSArray *images = [NSArray arrayWithObjects:[UIImage imageNamed:@"ballpark1.png"],
//                       [UIImage imageNamed:@"ballpark2.png"],
//                       [UIImage imageNamed:@"ballpark3.png"],
//                       [UIImage imageNamed:@"ballpark4.png"],
//                       nil];
//    
    int  tag = 0;
    for (UIImage *image in images) {
        UIImageView *imageView  = [[UIImageView alloc] initWithImage:image];
        //UIImageView *imageView  = [[UIImageView alloc] init];
        //imageView.backgroundColor = [UIColor redColor];
        //imageView.image = picture1;
        imageView.frame = CGRectMake(ImageWidth*tag, -64.0f, self.view.bounds.size.width, 200);
        imageView.tag = tag + 10;
        tag++;
        [self.imageContainerScrollView addSubview:imageView];
    }
    self.pageControl.numberOfPages = [images count];
    self.imageContainerScrollView.contentSize = CGSizeMake([images count]*ImageWidth, self.view.bounds.size.height + 10);
    //[self.view bringSubviewToFront:self.imageContainerScrollView];
    
    self.scrollView.delegate = self;
    
    self.wrapperScrollView.contentSize = CGSizeMake([images count]*ImageWidth, ImageHeight);
    self.wrapperScrollView.delegate = self;
    self.wrapperScrollView.pagingEnabled = YES;
    self.wrapperScrollView.showsHorizontalScrollIndicator = NO;
    self.wrapperScrollView.showsVerticalScrollIndicator = NO;

    
    CGFloat yOffset   = self.wrapperScrollView.contentOffset.y;
    CGFloat xOffset   = self.wrapperScrollView.contentOffset.x;
    self.imageContainerScrollView.contentOffset = CGPointMake(xOffset, yOffset);

    [self.view bringSubviewToFront:self.pageControl];
    
    PNCSectionView *sectionVC = nil;
    UIView *sectionView = self.contentView;
    
    PNCSectionSeperator *seperator = nil;
    UIView *seperatorView = nil;

    sectionVC = [PNCSectionView new];
    [self._sections addObject:sectionVC];
    sectionVC.showTruncatedText = NO;
    if (self.recipe.name_long) {
        sectionVC.headerText = self.recipe.name_long;
    }
    else{
        sectionVC.headerText = self.recipe.name;
    }
    sectionVC.contentText = nil;
    UIView *currentSectionView = [sectionVC makeView];
    [self.scrollView addSubview:currentSectionView];
    [sectionVC addConstraints:self.scrollView viewAbove:sectionView];
    sectionView = currentSectionView;

    // add UIView's after the detailed content view
    
    /*seperator = [PNCSectionSeperator new];
    seperatorView = [seperator makeView];
    [self.scrollView addSubview:seperatorView];
    [seperator addConstraints:self.scrollView viewAbove:sectionView];
    [self._sections addObject:seperator];*/

    seperator = [PNCSectionSeperator new];
    seperatorView = [seperator makeView];
    [self.scrollView addSubview:seperatorView];
    [seperator addConstraints:self.scrollView viewAbove:sectionView];
    [self._sections addObject:seperator];

    if (self.recipe.recipe_description) {
        sectionVC = [PNCSectionView new];
        [self._sections addObject:sectionVC];
        sectionVC.showTruncatedText = YES;
        sectionVC.contentText = self.recipe.recipe_description;
        sectionView = [sectionVC makeView];
        [self.scrollView addSubview:sectionView];
        [sectionVC addConstraints:self.scrollView viewAbove:seperatorView];

        
        seperator = [PNCSectionSeperator new];
        seperatorView = [seperator makeView];
        [self.scrollView addSubview:seperatorView];
        [seperator addConstraints:self.scrollView viewAbove:sectionView];
        [self._sections addObject:seperator];
    }

    if (self.recipe.ingredients) {
        sectionVC = [PNCSectionView new];// initWithStyle:UITableViewStylePlain];
        [self._sections addObject:sectionVC];
        sectionVC.showTruncatedText = NO;
        sectionVC.headerText = @"Ingredients";
        NSMutableString *stringIngrediants = [NSMutableString stringWithFormat:@"• %@", [self.recipe.ingredients stringByReplacingOccurrencesOfString:@"\n" withString:@"\n• " ]];
        sectionVC.contentText = stringIngrediants;
        sectionView = [sectionVC makeView];
        [self.scrollView addSubview:sectionView];
        [sectionVC addConstraints:self.scrollView viewAbove:seperatorView];
        
        seperator = [PNCSectionSeperator new];
        seperatorView = [seperator makeView];
        [self.scrollView addSubview:seperatorView];
        [seperator addConstraints:self.scrollView viewAbove:sectionView];
        [self._sections addObject:seperator];
    }
    
    if (self.recipe.steps) {
        sectionVC = [PNCSectionView new];// initWithStyle:UITableViewStylePlain];
        [self._sections addObject:sectionVC];
        sectionVC.showTruncatedText = NO;
        sectionVC.headerText = @"Steps to Prepare";
        sectionVC.contentText = [self.recipe.steps stringByReplacingOccurrencesOfString:@"\n" withString:@"\n\n"];
        sectionView = [sectionVC makeView];
        [self.scrollView addSubview:sectionView];
        [sectionVC addConstraints:self.scrollView viewAbove:seperatorView];
        
        seperator = [PNCSectionSeperator new];
        seperatorView = [seperator makeView];
        [self.scrollView addSubview:seperatorView];
        [seperator addConstraints:self.scrollView viewAbove:sectionView];
        [self._sections addObject:seperator];
    }

    if (self.recipe.serving_tips) {
        sectionVC = [PNCSectionView new];
        [self._sections addObject:sectionVC];
        sectionVC.showTruncatedText = NO;
        sectionVC.headerText = @"Serving Tips";
        sectionVC.contentText = self.recipe.serving_tips;
        sectionView = [sectionVC makeView];
        
        [self.scrollView addSubview:sectionView];
        [sectionVC addConstraints:self.scrollView viewAbove:seperatorView];
        
        seperator = [PNCSectionSeperator new];
        seperatorView = [seperator makeView];
        [self.scrollView addSubview:seperatorView];
        [seperator addConstraints:self.scrollView viewAbove:sectionView];
        [self._sections addObject:seperator];
    }
    
    seperator.isLastSeperator = YES;
    [seperator updateHeightConstraint];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleInterfaceOrientationChangedNotification:) name:UIDeviceOrientationDidChangeNotification object:nil];
}

-(void) updateScrollHeight{
    CGFloat height = 230.0f;
    for (id view in self._sections) {
        height += [view contentHeight];
    }
    NSLog(@"scroll height: %f", height);
    [self.scrollView setContentSize:CGSizeMake(self.view.frame.size.width, height)];

}

- (void)handleInterfaceOrientationChangedNotification:(NSNotification *)not
{
    //[self._detailView addOrUpdateCustomContraints:self.view.bounds.size];
}

-(void)viewWillAppear:(BOOL)animated{
    UIView *navBorder = [[UIView alloc] initWithFrame:CGRectMake(0,self.navigationController.navigationBar.frame.size.height-1,self.navigationController.navigationBar.frame.size.width, 1)];
    [navBorder setBackgroundColor:[UIColor colorWithWhite:190.0f/255.f alpha:1.0f]];
    [navBorder setOpaque:YES];
    [self.navigationController.navigationBar addSubview:navBorder];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationItem.backBarButtonItem.title = @".";
    [self updateScrollHeight];
    
//    [self.scrollView setContentSize:CGSizeMake(self.view.frame.size.width, self.view.frame.size.height + 200.0f)];

    //CGRect newFrame = self.contentView.frame;
    
    //newFrame.size.width = self.view.frame.size.width;
    //newFrame.size.height = self.view.frame.size.height + 200.0f;
    //[self.contentView setFrame:newFrame];
    
    




//    _imageView.layer.shadowOffset = CGSizeMake(0, 1);
//    _imageView.layer.shadowOpacity = 1;
//    _imageView.layer.shadowRadius = 2.0;
//    [_imageView.layer setBorderColor:[[UIColor colorWithWhite:0.85f alpha:1.0f] CGColor]];
//    [_imageView.layer setShadowColor:[[UIColor darkGrayColor] CGColor]];
//    _imageView.clipsToBounds = NO;
//    [_imageView.layer setCornerRadius:2.0f];
//
//    NSData *imageData = self.recipe.image1x;
//    if (imageData && self.recipe.detailedImage == nil) {
//        UIImage *originalImage = [UIImage imageWithData:self.recipe.image1x];
//        CGSize size = CGSizeMake(640, 640);
////        UIGraphicsBeginImageContext( size );
////        [originalImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
////        UIImage *picture1 = UIGraphicsGetImageFromCurrentImageContext();
////        UIGraphicsEndImageContext();
////        
////        imageData = UIImagePNGRepresentation(picture1);
//        UIImage *picture1 = [PNCUtilities resizedImage:originalImage withRect:CGRectMake(0, 0, size.width, size.height)];
//
//        self.recipe.detailedImage = picture1;
//    }
//    if (self.recipe.detailedImage) {
//        _imageView.image = self.recipe.detailedImage;
//    }
}

//-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
//    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
//    NSLog(@"viewWillTransitionToSize: %f", size.width);
//    [self._detailView addOrUpdateCustomContraints: size];
//}
//

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat yOffset   = self.scrollView.contentOffset.y;
    CGFloat xOffset   = self.wrapperScrollView.contentOffset.x;
    CGFloat pageWidth = self.wrapperScrollView.frame.size.width;
    int page = floor((self.wrapperScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageControl.currentPage = page;

    if (scrollView == self.wrapperScrollView) {
        self.imageContainerScrollView.contentOffset = CGPointMake(xOffset, MAX((yOffset) *kParallaxDeltaFactor, 0) - 64.0f);
        return;
    }
    
    if (scrollView == self.scrollView) {
        
        if (yOffset<0) {
            self.imageContainerScrollView.contentOffset = CGPointMake(xOffset, yOffset -64.0f);
        }else{
            
            self.imageContainerScrollView.contentOffset = CGPointMake(xOffset, MAX((yOffset) *kParallaxDeltaFactor, 0) - 64.0f);
        }
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

@end
