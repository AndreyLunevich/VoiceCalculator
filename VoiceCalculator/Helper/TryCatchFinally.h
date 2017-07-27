#import <Foundation/Foundation.h>

@interface TryCatchFinally : NSObject

+ (void)try:(void (^_Nullable)())tryBlock
      catch:(nullable void (^)(NSException *_Nullable))catchBlock
    finally:(nullable void (^)())finallyBlock;

@end

