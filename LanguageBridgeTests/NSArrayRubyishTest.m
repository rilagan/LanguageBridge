//
//  RBYArray.m
//  LanguageBridge
//
//  Created by Ryan Ilagan on 11/14/13.
//
//

#import <XCTest/XCTest.h>
#import "NSArray+Rubyish.h"

@interface NSArrayRubyishTest : XCTestCase

@end

@implementation NSArrayRubyishTest

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testAt {
    NSArray *array = @[@"a", @"b", @"c", @"d"];
    XCTAssertEqualObjects(@"a", [array at:0]);
    XCTAssertEqualObjects(nil, [array at:4]);
    XCTAssertEqualObjects(@"d", [array at:-1]);
    XCTAssertEqualObjects(@"a", [array at:-4]);
    XCTAssertEqualObjects(@"c", [array at:2]);
    XCTAssertEqualObjects(nil, [array at:-5]);
}

- (void)testCollect {
    NSArray *array = @[@1, @2, @3, @4];
    NSArray *collectedArray = [array collect:^id(id obj) {
        NSInteger v = [((NSNumber *)obj)intValue];
        return [NSNumber numberWithInt:v * 2];
    }];
    NSArray *result = @[@2, @4, @6, @8];
    XCTAssertEqualObjects(result, collectedArray);
}

- (void)testCompact {
    NSArray *array = @[@1, [NSNull null], @3, [NSNull null]];
    NSArray *compactArray = [array compact];
    NSArray *result = @[@1, @3];
    XCTAssertEqualObjects(result, compactArray);
}

- (void)testConcat {
    NSArray *first = @[@1, @2, @3, @4];
    NSArray *second = @[@5, @6, @7];
    NSArray *result = @[@1, @2, @3, @4, @5, @6, @7];
    XCTAssertEqualObjects(result, [first concat:second]);
}

- (void)testCount {
    NSArray *array = @[@1, @2, @3, @4, @5];
    NSUInteger count = [array count:^BOOL(id obj) {
        NSInteger v = [((NSNumber *)obj)intValue];
        return (v % 2) == 0;
    }];
    NSUInteger result = 2;
    XCTAssertEqual(result, count);
}

- (void)testDeleteAt {
    NSArray *array = @[@1, @2, @3, @4];
    NSArray *returnedArray = [array deleteAt:1];
    NSArray *result = @[@1, @3, @4];
    XCTAssertEqualObjects(result, returnedArray);
    returnedArray = [array deleteAt:99];
    XCTAssertEqualObjects(nil, returnedArray);
}

- (void)testDeleteObj {
    NSArray *array = @[@1, @2, @3, @4];
    NSArray *returnedArray = [array deleteObj:@2];
    NSArray *result = @[@1, @3, @4];
    XCTAssertEqualObjects(result, returnedArray);
    returnedArray = [array deleteObj:@9];
    XCTAssertEqualObjects(nil, returnedArray);
}

- (void)testDrop {
    NSArray *array = @[@1, @2, @3, @4];
    NSArray *returnedArray = [array drop:2];
    NSArray *result = @[@3, @4];
    XCTAssertEqualObjects(result, returnedArray);
}

- (void)testEach {
    NSMutableArray *modifiedArray = [[NSMutableArray alloc] init];
    NSArray *initialArray = @[@1, @2, @3];
    [initialArray each:^(id obj) {
        [modifiedArray addObject:obj];
    }];
    XCTAssertEqualObjects(initialArray, modifiedArray);
}

- (void)testEmpty {
    XCTAssertTrue([@[] empty]);
    XCTAssertTrue(![@[@1] empty]);
}

- (void)testFind {
    NSArray *array = @[@1, @2, @3, @4];
    id foundObj = [array find:^BOOL(id obj) {
        NSInteger v = [((NSNumber *)obj)intValue];
        return (v % 2) == 0;
    }];
    XCTAssertEqualObjects(@2, foundObj);
}

- (void)testFindAll {
    NSArray *array = @[@1, @2, @3, @4];
    NSArray *returnedArray = [array findAll:^BOOL(id obj) {
        NSInteger v = [((NSNumber *)obj)intValue];
        return (v % 2) == 0;
    }];
    NSArray *result = @[@2, @4];
    XCTAssertEqualObjects(result, returnedArray);
}

- (void)testFlatten {
    NSArray *nonFlattenedArray = @[@[@1, @2], @3, @[@[@4],@5],@6];
    NSArray *result = @[@1, @2, @3, @4, @5, @6];
    XCTAssertEqualObjects(result, [nonFlattenedArray flatten]);
}

- (void)testInclude {
    XCTAssertTrue([@[@1] include:@1]);
    XCTAssertTrue(![@[@1] include:@2]);
    NSArray *array = @[@"good", @"hello"];
    XCTAssertTrue([array include:@"hello"]);
}

- (void)testInject {
    NSArray *array = @[@1, @2, @3];
    NSNumber *sum = [array inject:@0 block:^id(id memo, id obj) {
        int m = ((NSNumber *)memo).intValue;
        int o = ((NSNumber *)obj).intValue;
        return [NSNumber numberWithInt:m+o];
    }];
    XCTAssertEqualObjects(sum, @6);
}

- (void)testJoin {
    NSArray *a = @[@1, @2, @3, @4];
    XCTAssertEqualObjects(@"1-2-3-4", [a join:@"-"]);
    a = @[@1];
    XCTAssertEqualObjects(@"1", [a join:@"-"]);
    a = @[];
    XCTAssertEqualObjects(@"", [a join:@"-"]);
}

- (void)testMax {
    NSArray *array = @[@21, @1, @334, @4, @50];
    XCTAssertEqualObjects(@334, [array max]);
}

- (void)testMaxBlock {
    NSArray *array = @[@21, @1, @334, @4, @50];
    XCTAssertEqualObjects(@334, [array max:^NSComparisonResult(id a, id b) {
        return [a compare:b];
    }]);
}

- (void)testMin {
    NSArray *array = @[@21, @1, @334, @4, @50];
    XCTAssertEqualObjects(@1, [array min]);
}

- (void)testMinBlock {
    NSArray *array = @[@21, @1, @334, @4, @50];
    XCTAssertEqualObjects(@1, [array min:^NSComparisonResult(id a, id b) {
        return [a compare:b];
    }]);
}

- (void)testRindex {
    NSArray *array = @[@6, @2, @4, @4, @5, @6];
    NSUInteger i = 5;
    XCTAssertEqual(i, [array rindex:@6]);
    i = 1;
    XCTAssertEqual(i, [array rindex:@2]);
    i = 3;
    XCTAssertEqual(i, [array rindex:@4]);
    XCTAssertEqual((NSUInteger)NSNotFound, [array rindex:@7]);
}

- (void)testReject {
    NSArray *array = @[@1, @2, @3, @4];
    NSArray *returnedArray = [array reject:^BOOL(id obj) {
        NSInteger v = [((NSNumber *)obj)intValue];
        return (v % 2) == 0;
    }];
    NSArray *result = @[@1, @3];
    XCTAssertEqualObjects(result, returnedArray);
}

- (void)testReverse {
    NSArray *array = @[@1, @2, @3, @4, @5, @6];
    NSArray *result = @[@6, @5, @4, @3, @2, @1];
    XCTAssertEqualObjects(result, [array reverse]);
}

- (void)testReverseEach {
    NSMutableArray *modifiedArray = [[NSMutableArray alloc] init];
    NSArray *initialArray = @[@1, @2, @3];
    [initialArray reverseEach:^(id obj) {
        [modifiedArray addObject:obj];
    }];
    NSArray *a = @[@3, @2, @1];
    XCTAssertEqualObjects(a, modifiedArray);
}

- (void)testRotate {
    NSArray *array = @[@1, @2, @3, @4, @5, @6];
    NSArray *result = @[@2, @3, @4, @5, @6, @1];
    XCTAssertEqualObjects(result, [array rotate:1]);
    result = @[@1, @2, @3, @4, @5, @6];
    XCTAssertEqualObjects(result, [array rotate:6]);
    XCTAssertEqualObjects(result, [array rotate:36]);
    result = @[@6, @1, @2, @3, @4, @5];
    XCTAssertEqualObjects(result, [array rotate:-1]);
    result = @[@1, @2, @3, @4, @5, @6];
    XCTAssertEqualObjects(result, [array rotate:-6]);
    result = @[@4, @5, @6, @1, @2, @3];
    XCTAssertEqualObjects(result, [array rotate:-3]);
}

- (void)testSlice {
    NSArray *array = @[@6, @2, @4, @4, @5, @6];
    NSArray *result = @[@6, @2, @4];
    XCTAssertEqualObjects(result, [array slice:0 length:3]);
    result = @[@2, @4, @4];
    XCTAssertEqualObjects(result, [array slice:1 length:3]);
    result = @[];
    XCTAssertEqualObjects(result, [array slice:100 length:3]);
    result = @[@6];
    XCTAssertEqualObjects(result, [array slice:-1 length:1]);
    result = @[@5, @6];
    XCTAssertEqualObjects(result, [array slice:-2 length:2]);
    result = @[@2, @4];
    XCTAssertEqualObjects(result, [array slice:-5 length:2]);
}

- (void)testSort {
    NSArray *array = @[@6, @2, @4];
    NSArray *result = @[@2, @4, @6];
    XCTAssertEqualObjects(result, [array sort]);
    array = @[@6, @2, @4, @6, @2, @1];
    result = @[@1, @2, @2, @4, @6, @6];
    XCTAssertEqualObjects(result, [array sort]);
    
    array = @[@"Jim", @"Tim", @"Alex"];
    result = @[@"Alex", @"Jim", @"Tim"];
    XCTAssertEqualObjects(result, [array sort]);
}

- (void)testTakeWhile {
    NSArray *array = @[@6, @2, @4, @4, @5, @6];
    NSArray *result = @[@6, @2, @4];
    __block int count = 0;
    NSArray *taken = [array takeWhile:^BOOL(id obj) {
        BOOL take = count < 3;
        count++;
        return take;
    }];
    XCTAssertEqualObjects(result, taken);
}

- (void)testUnique {
    NSArray *array = @[@6, @2, @4, @4, @5, @6];
    NSArray *result = @[@6, @2, @4, @5];
    XCTAssertEqualObjects(result, [array unique]);    
}

@end
