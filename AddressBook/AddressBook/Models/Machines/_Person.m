// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Person.m instead.

#import "_Person.h"

@implementation PersonID
@end

@implementation _Person

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Person";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Person" inManagedObjectContext:moc_];
}

- (PersonID*)objectID {
	return (PersonID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic cell;

@dynamic city;

@dynamic email;

@dynamic firstName;

@dynamic gender;

@dynamic lastName;

@dynamic nat;

@dynamic phone;

@dynamic picLargeURL;

@dynamic picSmallURL;

@dynamic postcode;

@dynamic state;

@dynamic street;

@dynamic title;

@dynamic userName;

@end

@implementation PersonAttributes 
+ (NSString *)cell {
	return @"cell";
}
+ (NSString *)city {
	return @"city";
}
+ (NSString *)email {
	return @"email";
}
+ (NSString *)firstName {
	return @"firstName";
}
+ (NSString *)gender {
	return @"gender";
}
+ (NSString *)lastName {
	return @"lastName";
}
+ (NSString *)nat {
	return @"nat";
}
+ (NSString *)phone {
	return @"phone";
}
+ (NSString *)picLargeURL {
	return @"picLargeURL";
}
+ (NSString *)picSmallURL {
	return @"picSmallURL";
}
+ (NSString *)postcode {
	return @"postcode";
}
+ (NSString *)state {
	return @"state";
}
+ (NSString *)street {
	return @"street";
}
+ (NSString *)title {
	return @"title";
}
+ (NSString *)userName {
	return @"userName";
}
@end

