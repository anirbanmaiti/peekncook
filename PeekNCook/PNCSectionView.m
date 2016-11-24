//
//  PNCSectionView.m
//  PeekNCook
//
//  Created by AnirbanMaiti on 12/23/14.
//  Copyright (c) 2014 PeekNCook. All rights reserved.
//

#import "PNCSectionView.h"
#import "PNCUtilities.h"

@interface PNCSectionView ()
@property (strong, nonatomic) UITableView *tableView;
@property (weak, nonatomic) UIView *containerView;
@property (weak, nonatomic) UIView *aboveView;
@property (strong, nonatomic) UIFont *contentFont;
@property (strong, nonatomic) UIFont *contentHeaderFont;
@property (strong, nonatomic) NSMutableString* truncatedText;
@property (strong, nonatomic) NSMutableArray* autoLayoutConstraints;
@property (strong, nonatomic) NSArray *constraint_H;
@end

@implementation PNCSectionView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.headerText = nil;
        self.contentText = @"";
        self.targetTruncatedContentHeight = 40.0f;
        self.showTruncatedText = NO;
        self.contentHasReducedHeight = NO;
        self.truncatedText = nil;
        self.contentFont = [UIFont fontWithName:@PNC_FONT size:(14.0)];
        self.contentHeaderFont = [UIFont fontWithName:@PNC_FONT_BOLD size:(17.0)];
        self.autoLayoutConstraints = [NSMutableArray array];
        self.constraint_H = nil;
    }
    return self;
}

-(UIView *)makeView
{
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat width = 200;
    CGFloat height = 200;
    CGRect tableFrame = CGRectMake(x, y, width, height);
    
    self.tableView = [[UITableView alloc]initWithFrame:tableFrame style:UITableViewStylePlain];
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.rowHeight = 45;
    self.tableView.sectionFooterHeight = 0;
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.scrollEnabled = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.userInteractionEnabled = YES;
    self.tableView.bounces = NO;
    //self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"sectionCell"];
    return self.tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.view = self.tableView;

    //[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"sectionCell"];
    //[self.view addSubview:self.tableView];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    NSInteger numberOfRows = 0;
    if (self.headerText != nil) {
        numberOfRows++;
    }
    if (self.contentText != nil) {
        numberOfRows++;
    }
    return numberOfRows;
}

- (void)addConstraints:(UIView*)parentView viewAbove:(UIView*) aboveView{
    self.containerView = parentView;
    self.aboveView = aboveView;
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.containerView removeConstraints:self.autoLayoutConstraints];
    [self.autoLayoutConstraints removeAllObjects];
    [self.tableView removeConstraints:self.constraint_H];
    NSDictionary *viewsDictionary = @{@"thisView":self.tableView};
    
    NSLayoutConstraint * constraint = [NSLayoutConstraint constraintWithItem:aboveView attribute:NSLayoutAttributeBottom
                                                                   relatedBy:NSLayoutRelationEqual toItem:self.tableView
                                                                   attribute:NSLayoutAttributeTop multiplier:1.0 constant:1.0f];
    
    [parentView addConstraint:constraint];
    [self.autoLayoutConstraints addObject:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:parentView
                                              attribute:NSLayoutAttributeRight
                                              relatedBy:NSLayoutRelationEqual toItem:self.tableView
                                              attribute:NSLayoutAttributeTrailing
                                             multiplier:1.0 constant:0.0];
    [parentView addConstraint:constraint];
    [self.autoLayoutConstraints addObject:constraint];

    constraint = [NSLayoutConstraint constraintWithItem:parentView
                                              attribute:NSLayoutAttributeLeft
                                              relatedBy:NSLayoutRelationEqual
                                                 toItem:self.tableView
                                              attribute:NSLayoutAttributeLeading
                                             multiplier:1.0 constant:0.0];
    [parentView addConstraint:constraint];
    [self.autoLayoutConstraints addObject:constraint];
    
    [self.tableView layoutIfNeeded];
    NSString *formattedString = [NSString stringWithFormat:@"V:[thisView(%f)]", self.tableView.contentSize.height];
    NSLog(@"formattedString: %@", formattedString);
    self.constraint_H = [NSLayoutConstraint constraintsWithVisualFormat:formattedString
                                                                    options:0
                                                                    metrics:nil
                                                                      views:viewsDictionary];
    
    [self.tableView addConstraints:self.constraint_H];

    
}

-(CGFloat)contentHeight{
    CGFloat tableViewContentHeight = self.tableView.bounds.size.height;
    NSLog(@"tableViewContentHeight: %f", tableViewContentHeight);
    return tableViewContentHeight + 1.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"sectionCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row == 0 && self.headerText != nil) {
        cell.textLabel.font = self.contentHeaderFont;
        cell.textLabel.textColor = [UIColor blackColor];
        cell.textLabel.text = self.headerText;
        cell.textLabel.numberOfLines = 0;
        [cell.textLabel sizeToFit];
        
//        UITextField *cellText = [[UITextField alloc]init];
//        [cellText setFrame:CGRectMake(0, 0, 300, 200)];
//        cellText.text = self.headerText;
//        cellText.borderStyle = UITextBorderStyleRoundedRect;
//        cellText.hidden = YES;
//        cellText.userInteractionEnabled = NO;
//        cellText.textColor = [UIColor blueColor];
//        cellText.backgroundColor = [UIColor blueColor];
//        cellText.tag = 10;
//        [cell.contentView addSubview:cellText];
//        [cellText sizeToFit];
    }
    else{
        
        NSString *temp = @"";
        if (self.truncatedText) {
            temp = [self.truncatedText stringByAppendingString:@"...More\n\n"];
        }
        else{
            temp = [self.contentText stringByAppendingString:@"\n\n"];
        }
        NSMutableAttributedString* attrString = [[NSMutableAttributedString alloc] initWithString:temp];
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        [style setLineSpacing:1.0f];
        [attrString addAttribute:NSParagraphStyleAttributeName
                           value:style
                           range:NSMakeRange(0, temp.length)];
//        [attrString addAttribute:NSKernAttributeName
//                           value:@(0.15)
//                           range:NSMakeRange(0, temp.length)];
        
        if (self.truncatedText) {
        [attrString addAttribute:NSForegroundColorAttributeName
                           value:[UIColor colorWithRed:19/255.0 green:144/255.0 blue:255/255.0 alpha:1.0]
                           range:NSMakeRange(temp.length - 6, 4)];
        }
        
        //cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:(15.0)];
        cell.textLabel.font = self.contentFont;
        cell.textLabel.textColor = [UIColor darkGrayColor];
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
        cell.textLabel.attributedText = attrString;
        cell.detailTextLabel.text = nil;

        cell.textLabel.numberOfLines = 0;
        [cell.textLabel sizeToFit];
    }
    
    return cell;
}
//-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    NSLog(@"%s: %@", __FUNCTION__, indexPath);
////    //[self.tableView layoutIfNeeded];
//}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0 && self.headerText != nil) {
        CGSize actualSize = [self calculateTextHeight:self.headerText];
        NSLog(@"heightForRowAtIndexPath: header: %f", (actualSize.height + 20.0f));
        
        return roundf(actualSize.height + 20.0f);
    }
    return roundf([self processContentTextHeightWithCellExpansion] + 10.0f);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%s: %@", __FUNCTION__, indexPath);
    if (self.showTruncatedText) {
        self.showTruncatedText = NO;
        self.truncatedText = nil;

        CGSize previousContentSize = self.tableView.contentSize;

        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        [self.tableView layoutIfNeeded];
        self.tableView.bounds = CGRectMake(self.tableView.bounds.origin.x, self.tableView.bounds.origin.y, self.tableView.bounds.size.width, self.tableView.contentSize.height);
        
        [self addConstraints:self.containerView viewAbove:self.aboveView];
        UIScrollView *scrollView = (UIScrollView *)self.containerView;
        [scrollView setContentSize:CGSizeMake(self.containerView.frame.size.width, scrollView.contentSize.height + self.tableView.contentSize.height - previousContentSize.height)];
    }
}


- (CGSize) calculateFontHeight{
    NSString *sampleText = @"H";
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:1.0f];
    
    // Create the attributes dictionary with the font and paragraph style
    NSDictionary *attributes = @{
                                 NSFontAttributeName:self.contentFont,
                                 NSParagraphStyleAttributeName:paragraphStyle,
                                 NSKernAttributeName:@(0.25)
                                 };

    CGSize textSize = [sampleText sizeWithAttributes:attributes];
    return textSize;
}

- (CGFloat) processContentTextHeightWithCellExpansion{
    CGSize actualSize = [self calculateTextHeight:self.contentText];
    if (!self.showTruncatedText) {
        return actualSize.height;
    }
    
    if (self.targetTruncatedContentHeight + 20.0f > actualSize.height) {
        self.showTruncatedText = NO;
        return actualSize.height;
    }
    
    // calculate the desired substring length
    CGSize letterSize = [self calculateFontHeight];
    CGFloat numberOfLines = 5.0f;
    CGFloat numberOfCharacters = ((self.tableView.frame.size.width - 17 * 2) * (numberOfLines * letterSize.height)) / (letterSize.height * letterSize.width);
    NSLog(@"numberOfCharacters: %f", numberOfCharacters);
    if ([self.contentText length] > numberOfCharacters + 10) {
        self.contentHasReducedHeight = YES;
        self.truncatedText = [NSMutableString stringWithFormat:@"%@", [self.contentText substringToIndex:numberOfCharacters]];
        CGSize truncatedSize = [self calculateTextHeight:self.truncatedText];
        return truncatedSize.height;
    }
    return actualSize.height;
}

- (CGSize) calculateTextHeight:(NSString*)targetText{
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:1.0f];
    
    // Create the attributes dictionary with the font and paragraph style
    NSDictionary *attributes = @{
                                 NSFontAttributeName:self.contentFont,
                                 NSParagraphStyleAttributeName:paragraphStyle,
                                 NSKernAttributeName:@(0.25)
                                 };
    
    CGRect rect = [targetText boundingRectWithSize:CGSizeMake(self.tableView.frame.size.width - 17 * 2, CGFLOAT_MAX) //tableView width - left border width - accessory indicator - right border width
                                                 options:NSStringDrawingUsesLineFragmentOrigin
                                              attributes:attributes
                                                 context:nil];
    NSLog(@"rect.size.height: %f", rect.size.height);
    return rect.size;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
