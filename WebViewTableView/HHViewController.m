//
//  HHViewController.m
//  WebViewTableView
//
//  Created by Hao He on 7/16/14.
//  Copyright (c) 2014 HH. All rights reserved.
//

#import "HHViewController.h"

@interface HHViewController () <UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate>
@property IBOutlet UIWebView *webView;
@property IBOutlet UITableView *tableView;
@property IBOutlet UIView *topcardView;

@property float prevY;
@property CGRect topcardViewOrigFrame;
@end

@implementation HHViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.webView loadHTMLString:[self buildTemplate] baseURL:nil];
//    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.cnn.com/"]]];
    self.webView.scrollView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;

    self.topcardViewOrigFrame = self.topcardView.frame;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{

    
    if ([scrollView isEqual:self.webView.scrollView])
    {
        if (scrollView.contentOffset.y >= self.prevY)
        {
            [self hideTopcardView];
        }
        else
        {
            [self showTopcardView];
        }
        self.prevY = scrollView.contentOffset.y;
    }
    
    if ([scrollView isEqual:self.webView.scrollView] && scrollView.contentOffset.y > self.webView.scrollView.contentSize.height - 600)
    {
        [self hideTopcardView];
        [self bringTableViewUp];
    }
    
    if ([scrollView isEqual:self.tableView] && scrollView.contentOffset.y < 0)
    {
        [self bringTableViewDown];
    }
    
}

- (void)bringTableViewUp
{
    [UIView animateWithDuration:1.0f animations:^{
        self.tableView.frame = CGRectMake(0, 0, 320, 568);
    }];
}

- (void)bringTableViewDown
{
    [UIView animateWithDuration:1.0f animations:^{
        self.tableView.frame = CGRectMake(0, 568, 320, 568);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *tableViewCell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    return tableViewCell;
}

- (void)hideTopcardView
{
    [UIView animateWithDuration:1.0f delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        self.topcardView.frame = CGRectMake(0, -self.topcardViewOrigFrame.size.height, 320, self.topcardViewOrigFrame.size.height);
    } completion:nil];
}

- (void)showTopcardView
{
    [UIView animateWithDuration:1.0f delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        self.topcardView.frame = CGRectMake(0, 0, 320, self.topcardViewOrigFrame.size.height);
    } completion:nil];
}

- (NSString *)buildTemplate
{
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"default_template" ofType:@"html"];

    NSMutableDictionary *params = [@{} mutableCopy]; 
    
    NSString *content = @"<p><strong>This is an article</strong></p><p><strong><br></strong><em>intended to test</em></p><p><span class=\"underline\">EVERY POSSIBLE FORMATTING QUIRK</span></p><p><span class=\"underline\"><em><strong>that you might encounter * <em><strong>that you might encounter * </strong></em><em><strong>that you might encounter * </strong></em><em><strong>that you might encounter * </strong></em><em><strong>that you might encounter * </strong></em><em><strong>that you might encounter * </strong></em><em><strong>that you might encounter * </strong></em><em><strong>that you might encounter * </strong></em><em><strong>that you might encounter * </strong></em><em><strong>that you might encounter * </strong></em><em><strong>that you might encounter * </strong></em><em><strong>that you might encounter * </strong></em><em><strong>that you might encounter * </strong></em><em><strong>that you might encounter<em><strong>that you might encounter * </strong></em><em><strong>that you might encounter * </strong></em><em><strong>that you might encounter * </strong></em><em><strong>that you might encounter * </strong></em><em><strong>that you might encounter * </strong></em><em><strong>that you might encounter * </strong></em><em><strong>that you might encounter * </strong></em><em><strong>that you might encounter * </strong></em></strong></em></strong></em><br></span></p><p> </p><p class=\"center\"><span class=\"underline\"><br></span>When attempting to render html</p><p class=\"right\">IN NATIVE CLIENT CODE.</p><p class=\"right\"> </p><p class=\"left\">To quote a man greater than myself:</p><blockquote>\r\n<p class=\"left\">We might encounter pictures</p>\r\n</blockquote><p class=\"right\"><img class=\"left\" src=\"https://media.licdn-ei.com/mpr/mpr/p/1/005/074/027/05a954c.jpg\" alt=\"\"></p><p class=\"left\">s</p><p class=\"left\">Hello:</p><p class=\"left\">d</p><p class=\"left\">d</p><p class=\"left\">d</p><p class=\"left\">d</p><p class=\"left\">d</p><p class=\"left\"> </p><p class=\"left\"> </p><blockquote>\r\n<p class=\"left\">We might encounter video:</p>\r\n</blockquote><p class=\"left\"><iframe src=\"http://www.youtube.com/embed/EXxAJ5mNmfs\" frameborder=\"0\" width=\"420\" height=\"315\"></iframe></p><p class=\"left\"> </p><blockquote>\r\n<p class=\"left\">And we might even encounter <em>slideshare! omg:</em></p>\r\n</blockquote><p class=\"left\"><em><iframe src=\"http://www.slideshare.net/slideshow/embed_code/36977955\" frameborder=\"0\" width=\"427\" height=\"356\"></iframe><br></em></p><p class=\"left\"> </p><p class=\"left\"><em><br></em>So remember these four things:</p><ol>\r\n<li>have a healthy relationship with your PM</li>\r\n<li>get a full night's sleep</li>\r\n<li>there are only 3 things</li>\r\n</ol><ul>\r\n<li>woohoo bullert point yea</li>\r\n<li>i mean bullet point ^</li>\r\n<li>boom</li>\r\n</ul><p class=\"left\"> </p>";
    
    [params setObject:@"Helvetica" forKey:@"content_font_family"];
    [params setObject:content forKey:@"content"];

    
    NSString *articleTemplate = [NSString stringWithContentsOfFile:filePath encoding:NSASCIIStringEncoding error:nil];
//    NSMutableString *template = [articleTemplate mutableCopy];
    NSMutableString *htmlString = [self mutableStringBySubstitutingParameters:params template:articleTemplate];
    return htmlString;
}


- (NSMutableString *)mutableStringBySubstitutingParameters:(NSDictionary *)parameters template:(NSString *)template{
    if (self == nil ) {
        return nil;
    }
    // Make result string with some extra capacity.
    NSMutableString *result = [NSMutableString stringWithCapacity:(template.length * 1.25)];
    NSScanner *scanner = [NSScanner scannerWithString:template];
    
    [scanner setCharactersToBeSkipped:nil];
    
    do {
        // Scan up to the next entity or the end of the string.
        
        NSString *nonTemplateString = nil;
        NSString *templateString = nil;
        
        if ([scanner scanUpToString:@"{{" intoString:&nonTemplateString]) {
            if (nonTemplateString) {
                [result appendString:nonTemplateString];
            }
            [scanner scanString:@"{{" intoString:NULL];
        }
        if ([scanner isAtEnd]) {
            break;
        }
        // Scan either a HTML or numeric character entity reference.
        if ([scanner scanUpToString:@"}}" intoString:&templateString]) {
            templateString = [templateString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            NSString *substitution = [parameters valueForKey:templateString];
            if (substitution) {
                [result appendString:substitution];
            }
            else {
                //skip
            }
            [scanner scanString:@"}}" intoString:NULL];
        } else {
            //an isolated {{ symbol. skip.
            [scanner scanString:@"{{" intoString:NULL];
        }
    }
    while (![scanner isAtEnd]);
    
    return result;
}


@end
