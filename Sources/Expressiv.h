//
//  Expressiv.h
//  Expressiv
//
//  Created by Fengwei Liu on 09/04/2017.
//  Copyright © 2017 kAzec. All rights reserved.
//

#import <TargetConditionals.h>

#if TARGET_OS_IPHONE || TARGET_OS_TV
    #import <UIKit/UIKit.h>
#else
    #import <AppKit/AppKit.h>
#endif

//! Project version number for Expressiv.
FOUNDATION_EXPORT double ExpressivVersionNumber;

//! Project version string for Expressiv.
FOUNDATION_EXPORT const unsigned char ExpressivVersionString[];
