//
//  UserModelSpec.m
//  Diamond
//
//  Created by Jun Lin on 5/30/13.
//
//

#import "TestHelper.h"
#import "UserModel.h"

SpecBegin(UserModel)

describe(@"UserModel", ^{
    describe(@".all", ^{
        it(@"load all users", ^{
            expect([UserModel all]).toNot.beEmpty();
        });
    });
});

SpecEnd
