//
//  ContactListViewController.m
//  AddressBook
//
//  Created by Zhen Zhang on 2016-04-27.
//  Copyright © 2016 Zhang Zhen. All rights reserved.
//
#import "ContactListViewController.h"
#import "ContactDetailViewController.h"
#import "ContactCell.h"
#import "Person.h"
#import "Reachability.h"

#define kBaseURL @"http://api.randomuser.me/?"

typedef enum {
    PickerViewTypeGender = 0,
    PickerViewTypeNat
}PickerViewType;

@interface ContactListViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@property UISearchBar *searchBar;

@property NSArray *persons;
@property NSArray *nationalies;
@property NSArray *genders;

@property NSArray *filteredPersons;
@property NSArray *filteredPersonsBeforeSearch;

@property NSString *selectedItem;
@property NSString *query;

@property NSMutableDictionary *imageDownloadOperations;
@property NSOperationQueue *imageLoadingOperationQueue;

@property (nonatomic, assign) PickerViewType pickerViewType;


- (IBAction)segmentChanged:(id)sender;
- (IBAction)pickerSelected:(id)sender;

@end

@implementation ContactListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.persons = [[NSArray alloc] init];
    
    _imageDownloadOperations = [[NSMutableDictionary alloc] init];
    _imageLoadingOperationQueue = [[NSOperationQueue alloc] init];
    
    _nationalies = [[NSArray alloc] initWithObjects:@"AU", @"BR", @"CA", @"CH", @"DE", @"DK", @"ES", @"FI", @"FR", @"GB", @"IE", @"IR", @"NL", @"NZ", @"TR", @"US", nil];
    _genders = [[NSArray alloc] initWithObjects:@"male", @"female",nil];
    
    _segmentedControl.selectedSegmentIndex = 0;
    
    self.searchBar = [[UISearchBar alloc] init];
    self.searchBar.placeholder = @"Search All Contacts";
    self.searchBar.delegate = self;
    self.navigationItem.titleView = self.searchBar;
    
    self.pickerView.hidden = YES;
    self.toolBar.hidden = YES;
    
    [self getAllContacts];
}

- (void)getAllContacts
{
    if ([Reachability reachabilityForInternetConnection].currentReachabilityStatus == NotReachable) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"ERROR" message:@"Please check your internet connection and try again!" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction *action)
                                   {
                                       
                                   }];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
        
    }else{
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kBaseURL, @"results=100"]];
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            NSURLSession *session = [NSURLSession sharedSession];
            NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                NSError *err = nil;
                
                [Person serializeResponseObjectToModel:[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err]];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.persons = [Person MR_findAll];
                    
                    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"firstName" ascending:YES selector:@selector(localizedCompare:)];
                    self.persons = [_persons sortedArrayUsingDescriptors:@[sortDescriptor]];
                    
                    self.filteredPersons = _persons;
                    [_tableView reloadData];
                });
                
            }];
            [task resume];
        });
    }
    
}

- (void)getSearchedPersons:(NSString*)query;
{
    if (query.length) {
        
        NSMutableArray *filtered = [[NSMutableArray alloc] init];
        for(Person *person in _filteredPersons) {
            if ([person.firstName containsString:_query] || [person.lastName containsString:_query]) {
                [filtered addObject:person];
            }
        }
        self.filteredPersons = filtered;
        [self.tableView reloadData];
    }
}

- (IBAction)segmentChanged:(id)sender {
    
    if (_segmentedControl.selectedSegmentIndex == 0) {
        self.pickerView.hidden = YES;
        self.toolBar.hidden = YES;
        self.filteredPersons = _persons;
        [self.tableView reloadData];
    }else if (_segmentedControl.selectedSegmentIndex == 1) {
        _pickerView.hidden = NO;
        _toolBar.hidden = NO;
        _pickerViewType = PickerViewTypeGender;
        [_pickerView reloadAllComponents];
        _selectedItem = [_genders objectAtIndex:0];
    }else if (_segmentedControl.selectedSegmentIndex == 2) {
        _pickerView.hidden = NO;
        _toolBar.hidden = NO;
        _pickerViewType = PickerViewTypeNat;
        [_pickerView reloadAllComponents];
        _selectedItem = [_nationalies objectAtIndex:0];
    }
}

- (IBAction)pickerSelected:(id)sender {
    
    if (_pickerViewType == PickerViewTypeGender) {
        NSMutableArray *filtered = [[NSMutableArray alloc] init];
        for (Person *person in _persons) {
            if ([person.gender isEqualToString:_selectedItem]) {
                [filtered addObject:person];
            }
        }
        self.filteredPersons = filtered;
    }else if (_pickerViewType == PickerViewTypeNat) {
        NSMutableArray *filtered = [[NSMutableArray alloc] init];
        for (Person *person in _persons) {
            if ([person.nat isEqualToString:_selectedItem]) {
                [filtered addObject:person];
            }
        }
        self.filteredPersons = filtered;
    }
    
    [self.pickerView resignFirstResponder];
    self.pickerView.hidden = YES;
    self.toolBar.hidden = YES;
    
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.filteredPersons count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ContactCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ContactCell"];
    if (!cell) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ContactCell" owner:nil options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    Person *person = [self.filteredPersons objectAtIndex:indexPath.row];
    
    cell.nameLabel.text = [NSString stringWithFormat:@"%@ %@", person.firstName, person.lastName];
    
    NSBlockOperation *loadImageOp = [[NSBlockOperation alloc] init];
    __weak NSBlockOperation *weakOp = loadImageOp;
    
    [loadImageOp addExecutionBlock:^{
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:person.picSmallURL]]];
        //Once the imagre is ready, it will show in the cell on the main queue
        [[NSOperationQueue mainQueue] addOperationWithBlock:^(void){
            if (!weakOp.isCancelled) {
                ContactCell *theCell = (ContactCell*)[tableView cellForRowAtIndexPath:indexPath];
                [theCell.headImageView setImage:image];
                if (person.userName) {
                    [self.imageDownloadOperations removeObjectForKey:person.userName];
                }
                
            }
        }];
    }];
    
    // Save the operation to the dictionary so that it can be cancelled later. Since 'username' is uniqu, so it is used as key.
    if (person.userName) {
        [self.imageDownloadOperations setObject:loadImageOp forKey:person.userName];
    }
    
    if (loadImageOp) {
        [self.imageLoadingOperationQueue addOperation:loadImageOp];
    }
    
    cell.headImageView.image = nil;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 66;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.searchBar resignFirstResponder];
    [self.pickerView resignFirstResponder];
    self.pickerView.hidden = YES;
    self.toolBar.hidden = _pickerView.hidden;
    if (indexPath.row < _filteredPersons.count) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        ContactDetailViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"ContactDetailViewController"];
        
        Person *person = [_filteredPersons objectAtIndex:indexPath.row];
        viewController.person = person;
        [self.navigationController pushViewController:viewController animated:YES];
    }
    
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //Cancel operation that does not need executing anymore, and remove it from dictionary
    if (indexPath.row < _filteredPersons.count) {
        Person *person = [self.filteredPersons objectAtIndex:indexPath.row];
        
        NSBlockOperation *ongoingDownloadOperation = [self.imageDownloadOperations objectForKey:person.userName];
        if (ongoingDownloadOperation) {
            
            [ongoingDownloadOperation cancel];
            [self.imageDownloadOperations removeObjectForKey:person.userName];
        }
    }
    
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (_pickerViewType == PickerViewTypeGender) {
        return [_genders count];
    }
    return [_nationalies count];
}

#pragma mark - UIPickerViewDelegate
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (_pickerViewType == PickerViewTypeGender) {
        return [_genders objectAtIndex:row];
    }
    return [_nationalies objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (_pickerViewType == PickerViewTypeGender) {
        _selectedItem = [_genders objectAtIndex:row];
    }else if (_pickerViewType == PickerViewTypeNat) {
        _selectedItem = [_nationalies objectAtIndex:row];
    }
}

#pragma mark - UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    self.segmentedControl.selectedSegmentIndex = 0;
    self.filteredPersons = _persons;
    [self.tableView reloadData];
    [self.searchBar setShowsCancelButton:YES animated:YES];
    return YES;
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    self.filteredPersonsBeforeSearch = _filteredPersons;
    self.pickerView.hidden = YES;
    self.toolBar.hidden = _pickerView.hidden;
    [self.pickerView resignFirstResponder];
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    _query = [searchText lowercaseString];
    [self getSearchedPersons:searchText];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    self.filteredPersons = _filteredPersonsBeforeSearch;
    searchBar.text = @"";
    [searchBar setShowsCancelButton:NO animated:YES];
    [self.searchBar resignFirstResponder];
    [self.tableView reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [self.searchBar resignFirstResponder];
}

@end
