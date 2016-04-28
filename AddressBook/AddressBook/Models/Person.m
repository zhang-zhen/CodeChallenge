#import "Person.h"

#define JSONObjectForKey(JSON, KEY) [[JSON objectForKey:KEY] isKindOfClass:[NSNull class]] ? nil : [JSON objectForKey:KEY]

@interface Person ()


@end

@implementation Person

+ (void)serializeResponseObjectToModel:(id)responseObject
{
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext * _Nonnull localContext) {
        
        [Person MR_truncateAllInContext:localContext];
        
        for (NSDictionary *data in [responseObject valueForKey:@"results"]) {
            
            Person *person = [Person MR_createEntityInContext:localContext];
            
            person.gender = JSONObjectForKey(data, @"gender");
            person.email = JSONObjectForKey(data, @"email");
            person.cell = JSONObjectForKey(data, @"cell");
            person.phone = JSONObjectForKey(data, @"phone");
            person.nat = JSONObjectForKey(data, @"nat");
            
            NSDictionary *name = JSONObjectForKey(data, @"name");
            person.firstName = JSONObjectForKey(name, @"first");
            person.lastName = JSONObjectForKey(name, @"last");
            
            NSDictionary *location = JSONObjectForKey(data, @"location");
            person.city = JSONObjectForKey(location, @"city");
            person.postcode = [NSString stringWithFormat:@"%ld", (long)[JSONObjectForKey(location, @"postcode") integerValue]];
            person.state = JSONObjectForKey(location, @"state");
            person.street = JSONObjectForKey(location, @"street");
            
            NSDictionary *picture = JSONObjectForKey(data, @"picture");
            person.picSmallURL = JSONObjectForKey(picture, @"thumbnail");
            person.picLargeURL = JSONObjectForKey(picture, @"large");
            
            NSDictionary *login = JSONObjectForKey(data, @"login");
            person.userName = JSONObjectForKey(login, @"username");
            
        };
        
    }];
}

@end
