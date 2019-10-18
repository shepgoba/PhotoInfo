#line 1 "Tweak.xm"
@interface PUOneUpViewController : UIViewController
-(id)pu_debugCurrentAsset;
@end

@interface PUNavigationController
-(UIViewController *)_currentToolbarViewController;
@end

@interface PHAsset : NSObject
-(CGSize)imageSize;
-(id)mainFileURL;
-(NSString *)metadataDebugDescription;
@end

@interface PHAssetResource : NSObject
+(id)assetResourcesForAsset:(id)arg1 ;
-(unsigned long long)fileSize;
@end
@interface PHAssetResourceManager : NSObject
-(int)requestDataForAssetResource:(id)arg1 options:(id)arg2 dataReceivedHandler:(id)arg3 completionHandler:(id)arg4 ;
+(id)defaultManager;
@end
@interface PXNavigationTitleView : UIView
@property (nonatomic, retain) NSString *title;
-(void)setTitle:(NSString *)a;
- (id) _viewControllerForAncestor;
@end


#include <substrate.h>
#if defined(__clang__)
#if __has_feature(objc_arc)
#define _LOGOS_SELF_TYPE_NORMAL __unsafe_unretained
#define _LOGOS_SELF_TYPE_INIT __attribute__((ns_consumed))
#define _LOGOS_SELF_CONST const
#define _LOGOS_RETURN_RETAINED __attribute__((ns_returns_retained))
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif

@class PXNavigationTitleView; 
static void (*_logos_orig$_ungrouped$PXNavigationTitleView$setTitle$)(_LOGOS_SELF_TYPE_NORMAL PXNavigationTitleView* _LOGOS_SELF_CONST, SEL, NSString *); static void _logos_method$_ungrouped$PXNavigationTitleView$setTitle$(_LOGOS_SELF_TYPE_NORMAL PXNavigationTitleView* _LOGOS_SELF_CONST, SEL, NSString *); 

#line 29 "Tweak.xm"

static void _logos_method$_ungrouped$PXNavigationTitleView$setTitle$(_LOGOS_SELF_TYPE_NORMAL PXNavigationTitleView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSString * arg1) {
    PHAsset *asset = [(PUOneUpViewController *)[((PUNavigationController *)[self _viewControllerForAncestor]) _currentToolbarViewController] pu_debugCurrentAsset];
    CGSize imageSize = [asset imageSize];
    NSString *correctURL = [[[asset mainFileURL] absoluteString] stringByReplacingOccurrencesOfString:@"file://" withString:@""];
    NSLog(@"poop %@", correctURL);
    NSDictionary *fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:correctURL error:nil];

    NSNumber *fileSizeNumber = [fileAttributes objectForKey:NSFileSize];
    long long fileSize = [fileSizeNumber longLongValue];
    float fileSizeMB = (float)fileSize / (1024 * 1024);
    NSString *newTitle = [NSString stringWithFormat:@"%@ (%ix%i, %.02fMB)", arg1, (int)imageSize.width, (int)imageSize.height, fileSizeMB];
    _logos_orig$_ungrouped$PXNavigationTitleView$setTitle$(self, _cmd, newTitle);
}

static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$PXNavigationTitleView = objc_getClass("PXNavigationTitleView"); MSHookMessageEx(_logos_class$_ungrouped$PXNavigationTitleView, @selector(setTitle:), (IMP)&_logos_method$_ungrouped$PXNavigationTitleView$setTitle$, (IMP*)&_logos_orig$_ungrouped$PXNavigationTitleView$setTitle$);} }
#line 44 "Tweak.xm"
