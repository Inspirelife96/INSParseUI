//
//  INSCloseButton.m
//  Bolts
//
//  Created by XueFeng Chen on 2021/6/30.
//

#import "INSCloseButton.h"

@interface INSCloseButton ()

@property (nonatomic, retain) CAShapeLayer *closeLayer;
@property (nonatomic, retain) UIVisualEffectView *circleView;

@end

@implementation INSCloseButton

- (instancetype)init {
    if (self = [super init]) {
        [self buildUI];
    }

    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
    }

    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self buildUI];
    }

    return self;
}

- (void)buildUI {
    self.circleView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    self.circleView.backgroundColor = [ThemeManager colorFor:@"INSCloseButton.backgroundColor"];
    [self addSubview:self.circleView];
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    UIColor *primaryColor = [ThemeManager colorFor:@"INSCloseButton.primaryColor"];

    UIBezierPath *path = [[UIBezierPath alloc] init];
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    CGFloat inset = rect.size.width * 0.3f;
    
    [path moveToPoint:CGPointMake(inset, inset)];
    [path addLineToPoint:CGPointMake(CGRectGetMaxX(rect) - inset, CGRectGetMaxY(rect) - inset)];
    
    [path moveToPoint:CGPointMake(CGRectGetMaxX(rect) - inset, inset)];
    [path addLineToPoint:CGPointMake(inset, CGRectGetMaxY(rect) - inset)];
    
    [layer setPath:path.CGPath];
    
    [layer setStrokeColor:primaryColor.CGColor];
    [layer setLineWidth:2.0f];
    
    if (self.closeLayer) {
        [self.closeLayer removeFromSuperlayer];
    }
    
    self.closeLayer = layer;
    [self.layer addSublayer:self.closeLayer];
    
    [self.circleView setFrame:rect];
    [self.circleView.layer setCornerRadius:self.circleView.bounds.size.width / 2];
    [self.circleView setClipsToBounds:YES];
    [self.circleView setUserInteractionEnabled:NO];
}

@end
