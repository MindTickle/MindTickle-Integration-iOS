# MindTickle-Integration-iOS

##steps to use this library with cocoapod

- Add following to your podfile
```
pod 'MindTickleIntegrations', :git => 'git@github.com:MindTickle/MindTickle-Integration-iOS.git', :tag=> '1.0'
```
- Run `pod install`
- Include following header and initialize MindTickle's in your appdelegate.h file and library 
```
#import <MindTickleAuth.h>
```
- Initialize MindTickleAuth with given parameters at the beginning of didFinishLaunchingWithOptions
```
[MindTickleAuth initWithDomain:@"yourdomain.mindtickle.com" secretKey:@"yoursecret" 
    email:@"email@example.com"];
```
- Alternatively you can also initialize without email and set email later when it is available
- In storyboard set class as `MTLoginButton` for any UIButton you want to turn on as MindTickle's integration
