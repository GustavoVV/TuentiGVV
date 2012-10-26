//
//  ViewController.m
//  TuentiGVV
//
//  Created by Gustavo Vidal Vicent on 14/07/2012.
//  Copyright (c) 2012 Hochschule Luzern. All rights reserved.
//

#import "ViewController.h"
#import "Transaction.h"

NSMutableArray * transactionsArray ;  
UIScrollView * fullScreenScrollView;

NSMutableArray * transactionsNames; 
@implementation ViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    transactionsArray = [[NSMutableArray alloc] init];
    transactionsNames = [[NSMutableArray alloc] init];
    
    
    
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
	
	NSURL *request = [NSURL URLWithString:@"http://quiet-stone-2094.herokuapp.com/rates"];
	
	
	
	
	
	NSMutableURLRequest *theRequest = [[NSMutableURLRequest alloc]initWithURL:request];
	
	
	NSURLConnection *returnData = [NSURLConnection sendSynchronousRequest: theRequest returningResponse: nil error: nil ];
	
	
	NSString *xml= [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
	NSLog(@"data: %@", xml);
    
    
    
    
    int i=1;
	int endIdaux;
	NSString *s= [[NSString alloc]init];
	
    
	for (i; i<[xml length]-1; ++i) {
		
		s = [NSString stringWithFormat:@"%c",[xml characterAtIndex:i]];
		
		
		if (![s compare: @"{" ]) {
			i++;
			s = [NSString stringWithFormat:@"%c",[xml characterAtIndex:i]];
			
			if (![s compare: @"\"" ]) {
				i++;
				s = [NSString stringWithFormat:@"%c",[xml characterAtIndex:i]];
				
				
				if (![s compare: @"f" ]) {
                    
                    
                    NSString * s1=[xml substringWithRange:NSMakeRange(i+7, 3)];		
                    // NSLog(@"sTring : %@", s1);
                    NSString * s2=[xml substringWithRange:NSMakeRange(i+18, 3)];		
                    //NSLog(@"sTring2 : %@", s2);
                    
                    s = [NSString stringWithFormat:@"%c",[xml characterAtIndex:(i+31)]];
                    
                    int endId=0;
                    for (endId;![s isEqualToString: @"\""] ; endId++) {
                        s = [NSString stringWithFormat:@"%c",[xml characterAtIndex:(i+31+endId)]];
                        
                    }
                    
                    
                    NSString * s3=[xml substringWithRange:NSMakeRange(i+31, endId-1)];		
                    //NSLog(@"sTring3 : %@", s3);
                    
                    
                    //  NSLog(@"%@%@",s1,s2);
                    
                    [prefs setObject:[NSString stringWithFormat:s3] forKey:[NSString stringWithFormat:@"%@%@",s1,s2]];   
                    
                    
                }
            }
        }
    }
    
    NSString * name = [prefs stringForKey:[NSString stringWithFormat:@"EURUSD"]];
    NSLog(@"%@",name);
    
	NSURL *request2 = [NSURL URLWithString:@"http://quiet-stone-2094.herokuapp.com/transactions"];
	
	
	
	
    
	
	NSMutableURLRequest *theRequest2 = [[NSMutableURLRequest alloc]initWithURL:request2];
	
	
	NSURLConnection *returnData2 = [NSURLConnection sendSynchronousRequest: theRequest2 returningResponse: nil error: nil ];
	
	
	NSString *xml2= [[NSString alloc] initWithData:returnData2 encoding:NSUTF8StringEncoding];
	NSLog(@"data: %@", xml2);
    
    
    i=1;
    for (i; i<[xml2 length]-1; ++i) {
		
		s = [NSString stringWithFormat:@"%c",[xml2 characterAtIndex:i]];
		
		
		if (![s compare: @"{" ]) {
			i++;
			s = [NSString stringWithFormat:@"%c",[xml2 characterAtIndex:i]];
			
			if (![s compare: @"\"" ]) {
				i++;
				s = [NSString stringWithFormat:@"%c",[xml2 characterAtIndex:i]];
				
				
				if (![s compare: @"s" ]) {
                    
                    i++;
                    s = [NSString stringWithFormat:@"%c",[xml2 characterAtIndex:i]];
                    
                    
                    if (![s compare: @"k" ]) {
                        
                        
                        NSString * s1=[xml2 substringWithRange:NSMakeRange(i+5, 5)];		
                        //  NSLog(@"sTring : %@", s1);
                        
                        
                        NSString * s2=[xml2 substringWithRange:NSMakeRange(i+22, 4)];		
                        //  NSLog(@"sTring2 : %@", s2);
                        
                        
                        
                        
                        
                        
                        NSString * s3=[xml2 substringWithRange:NSMakeRange(i+40, 3)];		
                        //  NSLog(@"sTring3 : %@", s3);
                        
                        
                        
                        
                        
                        //Add items
                        
                        NSUInteger index = [transactionsNames indexOfObject:s1];
                        
                        int myInt = index;
                        
                        if(myInt==2147483647) {
                            [transactionsNames addObject:s1];
                        }
                        
                        
                        Transaction * transaccion=[[ Transaction alloc  ] init];
                        transaccion.name=s1;
                        transaccion.amount=s2;
                        transaccion.currency=s3;
                        [transactionsArray addObject:transaccion];  
                        
                        
                        
                        
                        
                        //  NSLog(@"%@%@",s1,s2);
                        
                        // [prefs setObject:[NSString stringWithFormat:s3] forKey:[NSString stringWithFormat:@"%@%@",s1,s2]];   
                        
                    }
                }
            }
        }
    }
    
    /*  
     for (Transaction * t in transactionsArray) {  
     // Results from NSLog are in the Console  
     NSLog([NSString stringWithFormat:@"name: %@", t.name]);  
     }
     */
    int height=10;
    for (NSString * t in transactionsNames) {  
        // Results from NSLog are in the Console  
     //   NSLog([NSString stringWithFormat:@"name: %@", t]);  
        

        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button addTarget:self 
                   action:@selector(aMethod:)
         forControlEvents:UIControlEventTouchDown];
        [button setTitle:t forState:UIControlStateNormal];
        button.frame = CGRectMake(80.0, height, 160.0, 25);
        [self.view addSubview:button];
        height+=30;
        
    }

	// Do any additional setup after loading the view, typically from a nib.
}

- (void)backMethod:(id)sender {
[fullScreenScrollView removeFromSuperview];
    
   }  
- (void)aMethod:(id)sender {

    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];

    
  fullScreenScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0.0,320, 480) ];
	fullScreenScrollView.backgroundColor=[UIColor colorWithRed:0.36328125 green:0.7382125 blue:0.90234375 alpha:0.7f];
	fullScreenScrollView.showsHorizontalScrollIndicator = YES;
	fullScreenScrollView.scrollEnabled=YES;

	[self.view  addSubview:fullScreenScrollView];
    
    
    UIButton *buttonBack = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [buttonBack addTarget:self 
                   action:@selector(backMethod:)
         forControlEvents:UIControlEventTouchDown];
    [buttonBack setTitle:@"Back" forState:UIControlStateNormal];
    buttonBack.frame = CGRectMake(250, 5, 80, 25);
    [fullScreenScrollView addSubview:buttonBack];
    
    int i=10;
    
    
    for (Transaction * t in transactionsArray) {  
        // Results from NSLog are in the Console 
 
        if ([t.name isEqualToString:[sender currentTitle]]) {
            
            
            NSString * conversion = [prefs stringForKey:[NSString stringWithFormat:@"%@EUR",t.currency]];

            if (conversion==nil) {
                UILabel * texto= [ [UILabel alloc ] initWithFrame:CGRectMake(5, i, 360, 40.0) ];
                texto.backgroundColor= [UIColor clearColor];
                texto.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:(16.0)];
                
                
                
                texto.text =[NSString stringWithFormat:@"%@ %@ %@",t.name,t.amount, t.currency] ;
                texto.textColor=[UIColor whiteColor];
                
                [fullScreenScrollView addSubview: texto];
                i+=50;
                

            }
            else {
                
                UILabel * texto= [ [UILabel alloc ] initWithFrame:CGRectMake(5, i, 360, 40.0) ];
                texto.backgroundColor= [UIColor clearColor];
                texto.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:(16.0)];
                
                float eurTotal =  [t.amount floatValue]*[conversion floatValue];
                
                texto.text =[NSString stringWithFormat:@"%@ %f EUR",t.name,eurTotal ] ;
                texto.textColor=[UIColor whiteColor];
                
                [fullScreenScrollView addSubview: texto];
                i+=50;
                
                
                
                
                }
                       
        }
        
    }
    fullScreenScrollView.contentSize = CGSizeMake(320 , i);

    
    
    
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

@end
