//
//  RBYStringTest.m
//  Rubyish
//
//  Created by Ryan Ilagan on 11/12/13.
//
//  Copyright (c) 2014 Ryan Ilagan
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import <XCTest/XCTest.h>
#import "NSString+Rubyish.h"
#import "NSArray+Rubyish.h"

@interface NSStringRubyishTest : XCTestCase

@end

@implementation NSStringRubyishTest

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testCapitalize {
    XCTAssertEqualObjects(@"Hello", [@"hello" capitalize]);
    XCTAssertEqualObjects(@"Hello", [@"HELLO" capitalize]);
    XCTAssertEqualObjects(@"123hello", [@"123HELLO" capitalize]);
}

- (void)testChomp {
    XCTAssertEqualObjects(@"", [@"" chomp]);
    XCTAssertEqualObjects(@"", [@"\n" chomp]);
    XCTAssertEqualObjects(@"Value", [@"Value\n" chomp]);
    XCTAssertEqualObjects(@"Value", [@"Value\r" chomp]);
    XCTAssertEqualObjects(@"Value", [@"Value\r\n" chomp]);
    XCTAssertEqualObjects(@"Value\n", [@"Value\n\r" chomp]);
}

- (void)testChompSeperator {
    XCTAssertEqualObjects(@"Value", [@"Value" chomp:@"due"]);
    XCTAssertEqualObjects(@"Value", [@"Value" chomp:@"u"]);
    XCTAssertEqualObjects(@"Valu", [@"Value" chomp:@"e"]);
    XCTAssertEqualObjects(@"Val", [@"Value" chomp:@"ue"]);
    XCTAssertEqualObjects(@"Va", [@"Value" chomp:@"lue"]);
    XCTAssertEqualObjects(@"V", [@"Value" chomp:@"alue"]);
    XCTAssertEqualObjects(@"", [@"Value" chomp:@"Value"]);
    XCTAssertEqualObjects(@"", [@"" chomp:@"ue"]);
}

- (void)testChop {
    XCTAssertEqualObjects(@"", [@"" chop]);
    XCTAssertEqualObjects(@"", [@"\n" chop]);
    XCTAssertEqualObjects(@"Value", [@"Value\n" chop]);
    XCTAssertEqualObjects(@"Value", [@"Value\r" chop]);
    XCTAssertEqualObjects(@"Value", [@"Value\r\n" chop]);
    XCTAssertEqualObjects(@"Value\n", [@"Value\n\r" chop]);
}

- (void)testChar {
    XCTAssertEqualObjects(@"", [@"" chr]);
    XCTAssertEqualObjects(@"A", [@"A value" chr]);
    XCTAssertEqualObjects(@"v", [@"value" chr]);
}

- (void)testConcat {
    XCTAssertEqualObjects(@"v", [@"" concat:@"v"]);
    XCTAssertEqualObjects(@"vv", [@"v" concat:@"v"]);
    XCTAssertEqualObjects(@"hello world", [@"hello " concat:@"world"]);
}

- (void)testCount {
    XCTAssertEqual(1, [@"value" count:@"l"]);
    XCTAssertEqual(4, [@"value" count:@"^l"]);
    XCTAssertEqual(2, [@"value" count:@"vl"]);
    XCTAssertEqual(3, [@"vallue" count:@"vl"]);
    XCTAssertEqual(4, [@"hello world" count:@"ej-m"]);
}

- (void)testEmpty {
    XCTAssert([@"" empty]);
    XCTAssert(![@"value" empty]);
}

- (void)testGsub {
    XCTAssertEqualObjects(@"h*ll*", [@"hello" gsub:@"[aeiou]" replacement:@"*"]);
    XCTAssertEqualObjects(@"aaaaavvaa", [@"bbbbbvvbb" gsub:@"b" replacement:@"a"]);
    XCTAssertEqualObjects(@"dateless", [@"dated" gsub:@"d$" replacement:@"less"]);
    XCTAssertEqualObjects(@"value", [@"value data test" gsub:@" d.*" replacement:@""]);
    XCTAssertEqualObjects(@"abababvbvbvb", [@"acacacvkvkvk" gsub:@"[ck]" replacement:@"b"]);
}

- (void)testInclude {
    XCTAssert([@"hello" include:@"h"]);
    XCTAssert([@"hello" include:@"ello"]);
    XCTAssert([@"hello" include:@"hello"]);
    XCTAssert(![@"hello" include:@"g"]);
}

- (void)testIndex {
    XCTAssertEqual(NSMakeRange(0, 5), [@"hello" index:@"hello"]);
    XCTAssertEqual(NSMakeRange(0, 1), [@"hello" index:@"h"]);
    XCTAssertEqual(NSMakeRange(1, 1), [@"hello" index:@"e"]);
    XCTAssertEqual(NSMakeRange(2, 1), [@"hello" index:@"l"]);
    XCTAssertEqual(NSMakeRange(3, 2), [@"hello" index:@"lo"]);
    XCTAssertEqual(NSMakeRange(NSNotFound, 0), [@"hello" index:@"a"]);
    XCTAssertEqual(NSMakeRange(2, 3), [@"hello" index:@"l*o"]);
    XCTAssertEqual(NSMakeRange(NSNotFound, 0), [@"hello" index:@"lllo"]);
}

- (void)testInsert {
    XCTAssertEqualObjects(@"hello", [@"heo" insert:2 string:@"ll"]);
}

- (void)testPrepend {
    XCTAssertEqualObjects(@"Hello", [@"ello" prepend:@"H"]);
}

- (void)testReverse {
    XCTAssertEqualObjects(@"sweet", [@"teews" reverse]);
}

- (void)testRIndex {
    XCTAssertEqual(NSMakeRange(0, 5), [@"hello" rindex:@"hello"]);
    XCTAssertEqual(NSMakeRange(0, 1), [@"hello" rindex:@"h"]);
    XCTAssertEqual(NSMakeRange(1, 1), [@"hello" rindex:@"e"]);
    XCTAssertEqual(NSMakeRange(3, 1), [@"hello" rindex:@"l"]);
    XCTAssertEqual(NSMakeRange(3, 2), [@"hello" rindex:@"lo"]);
    XCTAssertEqual(NSMakeRange(NSNotFound, 0), [@"hello" rindex:@"a"]);
    XCTAssertEqual(NSMakeRange(5, 3), [@"llohello" rindex:@"l*o"]);
}

- (void)testScan {
    NSArray *matches = @[@"ell", @"ell"];
    XCTAssertEqualObjects(matches, [@"hello dell" scan:@"el*"]);
}

- (void)testSize {
    XCTAssertEqual((NSUInteger)5, [@"hello" size]);
}

- (void)testSplit {
    NSArray *results = @[@"data", @"value"];
    XCTAssertEqualObjects(results, [@"data value" split:@" "]);
    XCTAssertEqualObjects(results, [@"data value " split:@" "]);
    results = @[@"d", @"d", @"d", @"", @"", @"d"];
    XCTAssertEqualObjects(results, [@"dadadaaad" split:@"[ab]"]);
    results = @[@"data", @"va", @"ue", @"", @"", @"", @"1"];
    XCTAssertEqualObjects(results, [@"datalvaluellll1" split:@"l"]);
    results = @[@"data", @"value", @"", @"", @"", @"1"];
    XCTAssertEqualObjects(results, [@"data value    1" split:@" "]);
    results = @[@"a", @"b", @"c", @"d", @"e", @"f", @"g"];
    XCTAssertEqualObjects(results, [@"a|b-c-d|e|f!g" split:@"[\\|\\-\\!]" ]);
}

- (void)testSqueeze {
    XCTAssertEqualObjects(@"data value", [@"data  value" squeeze:@" "]);
    XCTAssertEqualObjects(@"dv", [@"dddvv" squeeze:@"dv"]);
    XCTAssertEqualObjects(@"data value", [@"ddaattaa  vvaalluuee" squeeze:@"data value"]);
    XCTAssertEqualObjects(@"data value", [@"ddaattaa  vvaalluuee" squeeze:@"a-z "]);
}

- (void)testStrip {
   XCTAssertEqualObjects(@"goodbye", [@"\tgoodbye\r\n" strip]);
}

@end
