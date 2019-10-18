@interface PUOneUpViewController : UIViewController
-(id)pu_debugCurrentAsset;
@end

@interface PUNavigationController
-(UIViewController *)_currentToolbarViewController;
@end

@interface PHAsset : NSObject
-(CGSize)imageSize;
-(id)mainFileURL;
@end

@interface PXNavigationTitleView : UIView
- (id) _viewControllerForAncestor;
@end

%hook PXNavigationTitleView
-(void)setTitle:(NSString *)arg1 {
    PHAsset *asset = [(PUOneUpViewController *)[((PUNavigationController *)[self _viewControllerForAncestor]) _currentToolbarViewController] pu_debugCurrentAsset];
    if (asset) {
        CGSize imageSize = [asset imageSize];
        NSString *correctURL = [[[asset mainFileURL] absoluteString] stringByReplacingOccurrencesOfString:@"file://" withString:@""];
        NSDictionary *fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:correctURL error:nil];
        NSNumber *fileSizeNumber = [fileAttributes objectForKey:NSFileSize];
        long long fileSize = [fileSizeNumber longLongValue];
        float fileSizeMB = (float)fileSize / (1024 * 1024);

        NSString *newTitle = [NSString stringWithFormat:@"%@ (%ix%i, %.02fMB)", arg1, (int)imageSize.width, (int)imageSize.height, fileSizeMB];
        %orig(newTitle);
    }
    else
        %orig;
}
%end
