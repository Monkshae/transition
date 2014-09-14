

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

#define which 2
@implementation ViewController

- (void) viewDidLoad {
    [super viewDidLoad];

    //初始化一个layer,添加到主视图
    _layer=[CALayer layer];
    _layer.bounds = CGRectMake(0, 0, 200, 200);
    _layer.position = CGPointMake(160, 250);
    _layer.backgroundColor = [UIColor redColor].CGColor;
    _layer.borderColor = [UIColor blackColor].CGColor;
    _layer.opacity = 1.0f;
    [self.view.layer addSublayer:_layer];
}

-(IBAction)changeLayerProperty
{
    switch (which) {
        case 1:
            //设置变化动画过程是否显示，默认为YES不显示
            [CATransaction setDisableActions:NO];
            //设置圆角
            _layer.cornerRadius = (_layer.cornerRadius == 0.0f) ? 30.0f : 0.0f;
            //设置透明度
            _layer.opacity = (_layer.opacity == 1.0f) ? 0.5f : 1.0f;
            break;
            
        case 2:
            /**
             显式事务
             通过明确的调用begin,commit来提交动画
             修改执行时间
             */
            [CATransaction begin];
            //显式事务默认开启动画效果,kCFBooleanTrue关闭
            [CATransaction setValue:(id)kCFBooleanFalse
                             forKey:kCATransactionDisableActions];
            //动画执行时间
            [CATransaction setValue:[NSNumber numberWithFloat:1.0f] forKey:kCATransactionAnimationDuration];
            //[CATransaction setAnimationDuration:[NSNumber numberWithFloat:5.0f]];
            _layer.cornerRadius = (_layer.cornerRadius == 0.0f) ? 30.0f : 0.0f;
            _layer.opacity = (_layer.opacity == 1.0f) ? 0.5f : 1.0f;
            [CATransaction commit];
            break;
            
        case 3:
            /**
             *  事务嵌套
             */
            [CATransaction begin];
            
            [CATransaction begin];
            [CATransaction setDisableActions:YES];
            [CATransaction setValue:[NSNumber numberWithFloat:1.0f] forKey:kCATransactionAnimationDuration];
            
            _layer.opacity = (_layer.opacity == 1.0f) ? 0.5f : 1.0f;
            [CATransaction commit];
            
            //上面的动画并不会立即执行，需要等最外层的commit
            [NSThread sleepForTimeInterval:2];
            //显式事务默认开启动画效果,kCFBooleanTrue关闭
            [CATransaction setValue:(id)kCFBooleanFalse
                             forKey:kCATransactionDisableActions];
            //动画执行时间
            [CATransaction setValue:[NSNumber numberWithFloat:1.0f] forKey:kCATransactionAnimationDuration];
            _layer.cornerRadius = (_layer.cornerRadius == 0.0f) ? 30.0f : 0.0f;
            [CATransaction commit];

            break;
        default:
            break;
    }
    
    
    
    

    
    
    
    
    
}


@end
