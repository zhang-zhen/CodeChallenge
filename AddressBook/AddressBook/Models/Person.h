#import "_Person.h"
#import <MagicalRecord/MagicalRecord.h>

@interface Person : _Person

// Parse response Json to core data model
+ (void)serializeResponseObjectToModel:(id)responseObject;

@end
