// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Person.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@interface PersonID : NSManagedObjectID {}
@end

@interface _Person : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) PersonID *objectID;

@property (nonatomic, strong, nullable) NSString* cell;

@property (nonatomic, strong, nullable) NSString* city;

@property (nonatomic, strong, nullable) NSString* email;

@property (nonatomic, strong, nullable) NSString* firstName;

@property (nonatomic, strong, nullable) NSString* gender;

@property (nonatomic, strong, nullable) NSString* lastName;

@property (nonatomic, strong, nullable) NSString* nat;

@property (nonatomic, strong, nullable) NSString* phone;

@property (nonatomic, strong, nullable) NSString* picLargeURL;

@property (nonatomic, strong, nullable) NSString* picSmallURL;

@property (nonatomic, strong, nullable) NSString* postcode;

@property (nonatomic, strong, nullable) NSString* state;

@property (nonatomic, strong, nullable) NSString* street;

@property (nonatomic, strong, nullable) NSString* title;

@property (nonatomic, strong, nullable) NSString* userName;

@end

@interface _Person (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveCell;
- (void)setPrimitiveCell:(NSString*)value;

- (NSString*)primitiveCity;
- (void)setPrimitiveCity:(NSString*)value;

- (NSString*)primitiveEmail;
- (void)setPrimitiveEmail:(NSString*)value;

- (NSString*)primitiveFirstName;
- (void)setPrimitiveFirstName:(NSString*)value;

- (NSString*)primitiveGender;
- (void)setPrimitiveGender:(NSString*)value;

- (NSString*)primitiveLastName;
- (void)setPrimitiveLastName:(NSString*)value;

- (NSString*)primitiveNat;
- (void)setPrimitiveNat:(NSString*)value;

- (NSString*)primitivePhone;
- (void)setPrimitivePhone:(NSString*)value;

- (NSString*)primitivePicLargeURL;
- (void)setPrimitivePicLargeURL:(NSString*)value;

- (NSString*)primitivePicSmallURL;
- (void)setPrimitivePicSmallURL:(NSString*)value;

- (NSString*)primitivePostcode;
- (void)setPrimitivePostcode:(NSString*)value;

- (NSString*)primitiveState;
- (void)setPrimitiveState:(NSString*)value;

- (NSString*)primitiveStreet;
- (void)setPrimitiveStreet:(NSString*)value;

- (NSString*)primitiveTitle;
- (void)setPrimitiveTitle:(NSString*)value;

- (NSString*)primitiveUserName;
- (void)setPrimitiveUserName:(NSString*)value;

@end

@interface PersonAttributes: NSObject 
+ (NSString *)cell;
+ (NSString *)city;
+ (NSString *)email;
+ (NSString *)firstName;
+ (NSString *)gender;
+ (NSString *)lastName;
+ (NSString *)nat;
+ (NSString *)phone;
+ (NSString *)picLargeURL;
+ (NSString *)picSmallURL;
+ (NSString *)postcode;
+ (NSString *)state;
+ (NSString *)street;
+ (NSString *)title;
+ (NSString *)userName;
@end

NS_ASSUME_NONNULL_END
