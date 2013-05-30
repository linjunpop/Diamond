//
//  TopicModelSpec.m
//  Diamond
//
//  Created by Jun Lin on 5/30/13.
//
//

#import "TestHelper.h"
#import "TopicModel.h"

SpecBegin(TopicModel)

describe(@"TopicModel", ^{
    describe(@".all", ^{
        it(@"load all topics", ^{
            expect([TopicModel all]).toNot.beEmpty();
        });
    });
});

SpecEnd
