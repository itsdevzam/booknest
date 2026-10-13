//
//  Generated file. Do not edit.
//

// clang-format off

#import "GeneratedPluginRegistrant.h"

#if __has_include(<background_downloader/BackgroundDownloaderPlugin.h>)
#import <background_downloader/BackgroundDownloaderPlugin.h>
#else
@import background_downloader;
#endif

#if __has_include(<flutter_file_manager_ios/FlutterFileManagerIosPlugin.h>)
#import <flutter_file_manager_ios/FlutterFileManagerIosPlugin.h>
#else
@import flutter_file_manager_ios;
#endif

#if __has_include(<flutter_rar/FlutterRarPlugin.h>)
#import <flutter_rar/FlutterRarPlugin.h>
#else
@import flutter_rar;
#endif

#if __has_include(<pdfx/PdfxPlugin.h>)
#import <pdfx/PdfxPlugin.h>
#else
@import pdfx;
#endif

#if __has_include(<url_launcher_ios/URLLauncherPlugin.h>)
#import <url_launcher_ios/URLLauncherPlugin.h>
#else
@import url_launcher_ios;
#endif

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [BackgroundDownloaderPlugin registerWithRegistrar:[registry registrarForPlugin:@"BackgroundDownloaderPlugin"]];
  [FlutterFileManagerIosPlugin registerWithRegistrar:[registry registrarForPlugin:@"FlutterFileManagerIosPlugin"]];
  [FlutterRarPlugin registerWithRegistrar:[registry registrarForPlugin:@"FlutterRarPlugin"]];
  [PdfxPlugin registerWithRegistrar:[registry registrarForPlugin:@"PdfxPlugin"]];
  [URLLauncherPlugin registerWithRegistrar:[registry registrarForPlugin:@"URLLauncherPlugin"]];
}

@end
