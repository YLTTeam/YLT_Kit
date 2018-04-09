//
//  YLT_AuthorizationHelper.m
//  Pods
//
//  Created by YLT_Alex on 2017/11/8.
//

#import "YLT_AuthorizationHelper.h"
#import "YLT_BaseMacro.h"
@import UIKit;
@import Photos;
@import AssetsLibrary;
@import CoreTelephony;
@import AVFoundation;
@import AddressBook;
@import Contacts;
@import EventKit;
@import CoreLocation;
@import MediaPlayer;
@import Speech;//Xcode 8.0 or later
@import HealthKit;
@import Intents;
@import CoreBluetooth;
@import Accounts;

@interface YLT_AuthorizationHelper()<CLLocationManagerDelegate>{}

@property (nonatomic, copy) void (^mapAlwaysSussess)(void);
@property (nonatomic, copy) void (^mapAlwaysFailed)(void);
@property (nonatomic, copy) void (^mapWhenInUseSuccess)(void);
@property (nonatomic, copy) void (^mapWhenInUseFailed)(void);
/**
 地理位置管理对象
 */
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) ACAccountStore *accounStore;
@property (nonatomic, assign) BOOL isRequestMapAlways;

@end

@implementation YLT_AuthorizationHelper

YLT_ShareInstance(YLT_AuthorizationHelper);

- (void)ylt_init {
}

- (void)ylt_authorizationType:(ylt_authorizationType)type
                      success:(void(^)(void))success
                       failed:(void(^)(void))failed {
    switch (type) {
        case YLT_PhotoLibrary:
            [self ylt_photoLibraryAccessSuccess:success
                                         failed:failed];
            break;
            
        case YLT_NetWork:
            [self ylt_networkAccessSuccess:success
                                    failed:failed];
            break;
            
        case YLT_Camera:
            [self ylt_cameraAccessSuccess:success
                                   failed:failed];
            break;
            
        case YLT_Microphone:
            [self ylt_audioAccessSuccess:success
                                  failed:failed];
            break;
        case YLT_AddressBook:
            [self ylt_addressBookAccessSuccess:success
                                        failed:failed];
            break;
        case YLT_Calendar:
            [self ylt_calendarAccessSuccess:success
                                     failed:failed];
            break;
        case YLT_Reminder:
            [self ylt_reminderAccessSuccess:success
                                     failed:failed];
            break;
        case YLT_MapAlways:
            [self ylt_mapAlwaysAccessSuccess:success
                                      failed:failed];
            break;
        case YLT_MapWhenInUse:
            [self ylt_mapWhenInUseAccessSuccess:success
                                         failed:failed];
            break;
        case YLT_AppleMusic:
            [self ylt_appleMusicAccessSuccess:success
                                       failed:failed];
            break;
        case YLT_SpeechRecognizer:
            [self ylt_speechRecognizerAccessSuccess:success
                                             failed:failed];
            break;
        case YLT_Siri:
            [self ylt_siriAccessSuccess:success
                                 failed:failed];
            break;
        case YLT_Bluetooth:
            [self ylt_bluetoothAccessSuccess:success
                                      failed:failed];
            break;
            
        default:
            NSAssert(!1, @"该方法暂不提供");
            
            break;
    }
}

#pragma mark - Photo Library
- (void)ylt_photoLibraryAccessSuccess:(void(^)(void))success
                               failed:(void(^)(void))failed{
    if (iOS8Later) {
        //used `PHPhotoLibrary`
        PHAuthorizationStatus authStatus = [PHPhotoLibrary authorizationStatus];
        if (authStatus == PHAuthorizationStatusNotDetermined) {
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                if (status == PHAuthorizationStatusAuthorized) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        success ? success(): nil;
                    });
                }else{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        failed ? failed(): nil;
                    });
                }
            }];
        }else if (authStatus == PHAuthorizationStatusAuthorized){
            success ? success(): nil;
        }else{
            failed ? failed(): nil;
        }
        
    }else{
        //used `AssetsLibrary`
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        ALAuthorizationStatus authStatus = [ALAssetsLibrary authorizationStatus];
        if (authStatus == ALAuthorizationStatusAuthorized) {
            success ? success() : nil;
        }else{
            failed ? failed() : nil;
        }
#pragma clang diagnostic pop
    }
}

#pragma mark - Network
- (void)ylt_networkAccessSuccess:(void(^)(void))success
                          failed:(void(^)(void))failed{
    
    CTCellularData *cellularData = [[CTCellularData alloc] init];
    CTCellularDataRestrictedState authState = cellularData.restrictedState;
    if (authState == kCTCellularDataRestrictedStateUnknown) {
        cellularData.cellularDataRestrictionDidUpdateNotifier = ^(CTCellularDataRestrictedState state){
            if (state == kCTCellularDataNotRestricted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    success ? success() : nil;
                });
            }else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    failed ? failed() : nil;
                });
            }
        };
    }else if (authState == kCTCellularDataNotRestricted){
        success ? success() : nil;
    }else{
        failed ? failed() : nil;
    }
}

#pragma mark - AvcaptureMedia
- (void)ylt_cameraAccessSuccess:(void(^)(void))success
                         failed:(void(^)(void))failed{
    
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusNotDetermined) {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if (granted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    success ? success() : nil;
                });
            }else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    failed ? failed() : nil;
                });
            }
        }];
        
    }else if(authStatus == AVAuthorizationStatusAuthorized){
        success ? success() : nil;
    }else{
        failed ? failed() : nil;
    }
}

- (void)ylt_audioAccessSuccess:(void(^)(void))success
                        failed:(void(^)(void))failed{
    
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    if (authStatus == AVAuthorizationStatusNotDetermined) {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {
            if (granted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    success ? success() : nil;
                });
            }else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    failed ? failed() : nil;
                });
            }
        }];
        
    }else if(authStatus == AVAuthorizationStatusAuthorized){
        success ? success() : nil;
    }else{
        failed ? failed() : nil;
    }
}

#pragma mark - AddressBook
- (void)ylt_addressBookAccessSuccess:(void(^)(void))success
                              failed:(void(^)(void))failed{
    if (iOS9Later) {
        
        CNAuthorizationStatus authStatus = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
        if (authStatus == CNAuthorizationStatusNotDetermined) {
            CNContactStore *contactStore = [[CNContactStore alloc] init];
            [contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
                if (granted) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        success ? success() : nil;
                    });
                }else{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        failed ? failed() : nil;
                    });
                }
            }];
        }else if (authStatus == CNAuthorizationStatusAuthorized){
            success ? success() : nil;
        }else{
            failed ? failed() : nil;
        }
        
        
    }else{
        //iOS9.0 eariler
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        
        ABAuthorizationStatus authStatus = ABAddressBookGetAuthorizationStatus();
        if (authStatus == kABAuthorizationStatusNotDetermined) {
            ABAddressBookRef addressBook = ABAddressBookCreate();
            ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
                if (granted) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        success ? success() : nil;
                    });
                }else{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        failed ? failed() : nil;
                    });
                }
            });
            
            if (addressBook) {
                CFRelease(addressBook);
            }
            
        }else if (authStatus == kABAuthorizationStatusAuthorized){
            success ? success() : nil;
        }else{
            failed ? failed() : nil;
        }
#pragma clang diagnostic pop
        
    }
}

#pragma mark - Calendar
- (void)ylt_calendarAccessSuccess:(void(^)(void))success
                           failed:(void(^)(void))failed{
    
    EKAuthorizationStatus authStatus = [EKEventStore authorizationStatusForEntityType:EKEntityTypeEvent];
    if (authStatus == EKAuthorizationStatusNotDetermined) {
        EKEventStore *eventStore = [[EKEventStore alloc] init];
        [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError * _Nullable error) {
            if (granted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    success ? success() : nil;
                });
            }else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    failed ? failed() : nil;
                });
            }
        }];
    }else if (authStatus == EKAuthorizationStatusAuthorized){
        success ? success() : nil;
    }else{
        failed ? failed() : nil;
    }
}

#pragma mark - Reminder
- (void)ylt_reminderAccessSuccess:(void(^)(void))success
                           failed:(void(^)(void))failed{
    EKAuthorizationStatus authStatus = [EKEventStore authorizationStatusForEntityType:EKEntityTypeReminder];
    if (authStatus == EKAuthorizationStatusNotDetermined) {
        EKEventStore *eventStore = [[EKEventStore alloc] init];
        [eventStore requestAccessToEntityType:EKEntityTypeReminder completion:^(BOOL granted, NSError * _Nullable error) {
            if (granted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    success ? success() : nil;
                });
            }else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    failed ? failed() : nil;
                });
            }
        }];
    }else if (authStatus == EKAuthorizationStatusAuthorized){
        success ? success() : nil;
    }else{
        failed ? failed() : nil;
    }
}

#pragma mark - Map

- (void)ylt_mapAlwaysAccessSuccess:(void(^)(void))success
                            failed:(void(^)(void))failed{
    if (![CLLocationManager locationServicesEnabled]) {
        NSAssert([CLLocationManager locationServicesEnabled], @"Location service enabled failed");
        return;
    }
    if (!self.locationManager) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
    }
    
    CLAuthorizationStatus authStatus = [CLLocationManager authorizationStatus];
    if (authStatus == kCLAuthorizationStatusNotDetermined) {
        
        self.mapAlwaysSussess = success;
        self.mapAlwaysFailed = failed;
        [self.locationManager requestAlwaysAuthorization];
        self.isRequestMapAlways = YES;
        
    }else if (authStatus == kCLAuthorizationStatusAuthorizedAlways){
        success ? success() : nil;
    }else{
        failed ? failed() : nil;
    }
}

- (void)ylt_mapWhenInUseAccessSuccess:(void(^)(void))success
                               failed:(void(^)(void))failed{
    if (![CLLocationManager locationServicesEnabled]) {
        NSAssert([CLLocationManager locationServicesEnabled], @"Location service enabled failed");
        return;
    }
    if (!self.locationManager) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
    }
    CLAuthorizationStatus authStatus = [CLLocationManager authorizationStatus];
    if (authStatus == kCLAuthorizationStatusNotDetermined) {
        
        self.mapWhenInUseSuccess = success;
        self.mapWhenInUseFailed = failed;
        [self.locationManager requestWhenInUseAuthorization];
        self.isRequestMapAlways = NO;
        
    }else if (authStatus == kCLAuthorizationStatusAuthorizedWhenInUse){
        success ? success() : nil;
    }else{
        failed ? failed() : nil;
    }
}
#pragma mark - Apple Music
- (void)ylt_appleMusicAccessSuccess:(void(^)(void))success
                             failed:(void(^)(void))failed{
    MPMediaLibraryAuthorizationStatus authStatus = [MPMediaLibrary authorizationStatus];
    if (authStatus == MPMediaLibraryAuthorizationStatusNotDetermined) {
        [MPMediaLibrary requestAuthorization:^(MPMediaLibraryAuthorizationStatus status) {
            if (status == MPMediaLibraryAuthorizationStatusAuthorized) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    success ? success() : nil;
                });
            }else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    failed ? failed() : nil;
                });
            }
        }];
    }else if (authStatus == MPMediaLibraryAuthorizationStatusAuthorized){
        success ? success() : nil;
    }else{
        failed ? failed() : nil;
    }
}

#pragma mark - SpeechRecognizer
- (void)ylt_speechRecognizerAccessSuccess:(void(^)(void))success
                                   failed:(void(^)(void))failed{
    
    SFSpeechRecognizerAuthorizationStatus authStatus = [SFSpeechRecognizer authorizationStatus];
    if (authStatus == SFSpeechRecognizerAuthorizationStatusNotDetermined) {
        [SFSpeechRecognizer requestAuthorization:^(SFSpeechRecognizerAuthorizationStatus status) {
            if (status == SFSpeechRecognizerAuthorizationStatusAuthorized) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    success ? success() : nil;
                });
            }else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    failed ? failed() : nil;
                });
            }
        }];
        
    }else if (authStatus == SFSpeechRecognizerAuthorizationStatusAuthorized){
        success ? success() : nil;
    }else{
        failed ? failed() : nil;
    }
}

#pragma mark - Health
- (void)ylt_healthAccessSuccess:(void(^)(void))success
                         failed:(void(^)(void))failed{
}
#pragma mark - Siri
- (void)ylt_siriAccessSuccess:(void(^)(void))success
                       failed:(void(^)(void))failed{
    if (!iOS10Later) {
        NSAssert(iOS10Later, @"This method must used in iOS 10.0 or later/该方法必须在iOS10.0或以上版本使用");
        success = nil;
        failed = nil;
        return;
    }
    
    INSiriAuthorizationStatus authStatus = [INPreferences siriAuthorizationStatus];
    if (authStatus == INSiriAuthorizationStatusNotDetermined) {
        [INPreferences requestSiriAuthorization:^(INSiriAuthorizationStatus status) {
            if (status == INSiriAuthorizationStatusAuthorized) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    success ? success() : nil;
                });
            }else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    failed ? failed() : nil;
                });
            }
        }];
        
    }else if (authStatus == INSiriAuthorizationStatusAuthorized){
        success ? success() : nil;
    }else{
        failed ? failed() : nil;
    }
}

#pragma mark - Bluetooth
- (void)ylt_bluetoothAccessSuccess:(void(^)(void))success
                            failed:(void(^)(void))failed{
    CBPeripheralManagerAuthorizationStatus authStatus = [CBPeripheralManager authorizationStatus];
    if (authStatus == CBPeripheralManagerAuthorizationStatusNotDetermined) {
        
        CBCentralManager *cbManager = [[CBCentralManager alloc] init];
        [cbManager scanForPeripheralsWithServices:nil
                                          options:nil];
        
    }else if (authStatus == CBPeripheralManagerAuthorizationStatusAuthorized) {
        success ? success() : nil;
    }else{
        failed ? failed() : nil;
    }
}

@end
