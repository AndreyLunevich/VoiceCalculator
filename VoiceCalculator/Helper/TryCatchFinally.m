#import "TryCatchFinally.h"

@implementation TryCatchFinally

+ (void)try:(void (^)())tryBlock
      catch:(void (^)(NSException * _Nullable))catchBlock
    finally:(void (^)())finallyBlock {

    @try {
        if (tryBlock) {
            tryBlock();
        }
    }
    @catch (NSException *e) {
        if (catchBlock) {
            catchBlock(e);
        }
    }
    @finally {
        if (finallyBlock) {
            finallyBlock();
        }
    }
}

@end
