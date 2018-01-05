

// http://www.cnblogs.com/makemelike/articles/3802518.html



#import <Foundation/Foundation.h>

@interface RSAEncryptor : NSObject

#pragma mark - Instance Methods
- (void) loadPublicKeyFromFile: (NSString*) derFilePath;
- (void) loadPublicKeyFromData: (NSData*) derData;

- (void) loadPrivateKeyFromFile: (NSString*) p12FilePath password:(NSString*)p12Password;
- (void) loadPrivateKeyFromData: (NSData*) p12Data password:(NSString*)p12Password;

- (NSString*) rsaEncryptString:(NSString*)string;
- (NSData*) rsaEncryptData:(NSData*)data ;

- (NSString*) rsaDecryptString:(NSString*)string;
- (NSData*) rsaDecryptData:(NSData*)data;

- (NSString*)signature:(NSString*)data;
- (BOOL)verifySignature:(NSString*)data signature:(NSString*)sign;

#pragma mark - Class Methods
+ (void) setSharedInstance: (RSAEncryptor*)instance;
+ (RSAEncryptor*) sharedInstance;
@end



@interface RSAEncryptor (PEM)
-(BOOL) setPublicPEM:(NSString*)str;
-(BOOL) setPrivatePEM:(NSString*)str;
@end
