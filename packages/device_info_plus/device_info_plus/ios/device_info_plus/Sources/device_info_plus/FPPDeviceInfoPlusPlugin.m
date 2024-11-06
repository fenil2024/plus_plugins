// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#import "./include/device_info_plus/FPPDeviceInfoPlusPlugin.h"
#import "./include/device_info_plus/DeviceIdentifiers.h"
#import <sys/utsname.h>

@implementation FPPDeviceInfoPlusPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
  FlutterMethodChannel *channel = [FlutterMethodChannel
      methodChannelWithName:@"dev.fluttercommunity.plus/device_info"
            binaryMessenger:[registrar messenger]];
  FPPDeviceInfoPlusPlugin *instance = [[FPPDeviceInfoPlusPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall *)call
                  result:(FlutterResult)result {
  if ([@"getDeviceInfo" isEqualToString:call.method]) {
    UIDevice *device = [UIDevice currentDevice];
    struct utsname un;
    uname(&un);

    NSNumber *isPhysicalNumber =
        [NSNumber numberWithBool:[self isDevicePhysical]];
    NSString *machine;
    NSString *deviceName;
    if ([self isDevicePhysical]) {
      machine = @(un.machine);
      deviceName = [DeviceIdentifiers userKnownDeviceModel:@(un.machine)];
    } else {
      machine = [[NSProcessInfo processInfo]
          environment][@"SIMULATOR_MODEL_IDENTIFIER"];
    }

    result(@{
      @"name" : [device name],
      @"systemName" : [device systemName],
      @"systemVersion" : [device systemVersion],
      @"model" : deviceName,
      @"localizedModel" : [device localizedModel],
      @"identifierForVendor" : [[device identifierForVendor] UUIDString]
          ?: [NSNull null],
      @"isPhysicalDevice" : isPhysicalNumber,
      @"utsname" : @{
        @"sysname" : @(un.sysname),
        @"nodename" : @(un.nodename),
        @"release" : @(un.release),
        @"version" : @(un.version),
        @"machine" : machine,
      }
    });
  } else {
    result(FlutterMethodNotImplemented);
  }
}

// return value is false if code is run on a simulator
- (BOOL)isDevicePhysical {
  BOOL isPhysicalDevice = NO;
#if TARGET_OS_SIMULATOR
  isPhysicalDevice = NO;
#else
  isPhysicalDevice = YES;
#endif

  return isPhysicalDevice;
}

@end
