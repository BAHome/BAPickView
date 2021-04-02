//
//  BACityModel.h
//  BAPickView
//
//  Created by 博爱 on 2021/4/2.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CLLocation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BACityModel : NSObject

/**
 省
 */
@property (nonatomic, copy) NSString *province;

/**
 市
 */
@property (nonatomic, copy) NSString *city;

/**
 区
 */
@property (nonatomic, copy) NSString *area;

/**
 经纬度
 */
@property (nonatomic, assign) CLLocationCoordinate2D coordie;

@end

NS_ASSUME_NONNULL_END
