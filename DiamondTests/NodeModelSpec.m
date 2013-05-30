//
//  NodeModelSpec.m
//  Diamond
//
//  Created by Jun Lin on 5/30/13.
//
//

#import "TestHelper.h"
#import "NodeModel.h"

SpecBegin(NodeModel)

describe(@"NodeModel", ^{
    describe(@".all", ^{
        it(@"load all nodes", ^{
            expect([NodeModel all]).toNot.beEmpty();
        });
    });
});

SpecEnd
