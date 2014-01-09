
LanguageBridge
--------------

This library provides a familar api (for foundation classes) for those who are new to objective c, 
or for those looking for functionality similar to other languages.

Core Classes Supported
----------------------

NSString
NSDictionary
NSArray

Languages
---------
Java
Ruby

How to Use
----------

Java
----

Copy NSString+Javaish.* and NSString+Base.* Files

```objective-c
if ([@"hhhello" matches:@"\\D+ello"]) {
    NSLog(@"Matched!");
}
```

Output
------
Matched!

Ruby
----

Copy NSString+Rubyish.* and NSString+Base.* Files
Copy NSArray+Rubyish.*

```objective-c
#import "NSString+Rubyish.h"
#import "NSArray+Rubyish.h"

[[@"hello there" split:@" "] each:^(id obj) {
    NSLog(@"%@", obj);
}];
```

Output
------
hello

there
