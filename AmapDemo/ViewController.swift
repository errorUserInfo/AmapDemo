//
//  ViewController.swift
//  AmapDemo
//
//  Created by 温天浩 on 2020/8/20.
//  Copyright © 2020 CF. All rights reserved.
//

import UIKit
import AMapLocationKit
import MAMapKit
import AMapNaviKit

class ViewController: UIViewController,AMapLocationManagerDelegate,AMapNaviDriveManagerDelegate,MAMapViewDelegate {

    @IBOutlet weak var mapView: MAMapView!
    private var movingAnnotation: MAAnimatedAnnotation!
    private var line: MAMultiPolyline!
    private var colors: [UIColor]!
    private lazy var locationManager = AMapLocationManager()
    private var timer:Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        timer = Timer(timeInterval: 5, repeats: true, block: { (timer) in
//
//        })
//
        configureLocation()
        configrueLine()
        
    }
    
    func initLine() {
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationManager.startUpdatingLocation()
    }
    
    // MARK: Method
    func configureLocation() {
        locationManager.delegate = self
        
        locationManager.pausesLocationUpdatesAutomatically = false
        
        locationManager.allowsBackgroundLocationUpdates = true
    }
    
    func configrueLine() {
        
        //初始化
        let startPoint = AMapNaviPoint.location(withLatitude: 39.993135, longitude: 116.474175)
        let endPoint = AMapNaviPoint.location(withLatitude: 39.908791, longitude: 116.321257)
        
        AMapNaviDriveManager.sharedInstance().delegate = self
        mapView.delegate = self
        
        //计算驾车规划路线
        let info = AMapNaviVehicleInfo()
        info.vehicleId = "京N66Y66"
        info.type = 1//设置车辆类型,0:小车; 1:货车. 默认0(小车)
        info.size = 4//1:微型货车; 2:轻型/小型货车; 3:中型货车; 4:重型货车
        info.width = 3//设置货车的宽度,范围:(0,5],单位：米
        info.height = 3.9//设置货车的高度,范围:(0,10],单位：米
        info.length = 15//设置货车的长度,范围:(0,25],单位：米
        info.load = 50//设置货车的核定载重,范围:(0,100],单位：吨. 注意:核定载重应小于总重量
        info.weight = 45//设置货车的核定载重,范围:(0,100),单位：吨
        info.axisNums = 6//设置货车的轴数（用来计算过路费及限重）
        
        if AMapNaviDriveManager.sharedInstance().setVehicleInfo(info) {
            
        }
        
        AMapNaviDriveManager.sharedInstance().calculateDriveRoute(withStart: [startPoint!], end: [endPoint!], wayPoints: nil, drivingStrategy: .multipleAvoidCostAndCongestion)
        
        //添加大头针
        
    }
    
    // MARK: AMapLocationManagerDelegate
    func amapLocationManager(_ manager: AMapLocationManager!, doRequireLocationAuth locationManager: CLLocationManager!) {
        locationManager.requestAlwaysAuthorization()
    }
    
    func amapLocationManager(_ manager: AMapLocationManager!, didUpdate location: CLLocation!) {
        print("location:{lat:\(location.coordinate.latitude); lon:\(location.coordinate.longitude); accuracy:\(location.horizontalAccuracy)};")
    }
    
    func amapLocationManager(_ manager: AMapLocationManager!, didFailWithError error: Error!) {
        let error = error as NSError
        print("didFailWithError:{\(error.code) - \(error.localizedDescription)};")
    }

    // MARK: AMapNaviDriveManagerDelegate
    func driveManager(onCalculateRouteSuccess driveManager: AMapNaviDriveManager) {
        
        //禁行信息
        if driveManager.naviRoute?.forbiddenInfo != nil && driveManager.naviRoute?.forbiddenInfo.count != 0 {
            for info in (driveManager.naviRoute?.forbiddenInfo)! {
//                NSLog("禁行信息：类型： \(info.type)，车型： \(String(describing: info.vehicleType))，道路名： \(String(describing: info.roadName))，禁行时间段： \(String(describing: info.timeDescription))，经纬度： \(String(describing: info.coordinate))")
            }
        }
        
        //限行设施
        if driveManager.naviRoute?.roadFacilityInfo != nil && driveManager.naviRoute?.roadFacilityInfo.count != 0 {
            for info in (driveManager.naviRoute?.roadFacilityInfo)! {
//                NSLog("限行信息：类型： \(info.type.rawValue)，道路名： \(String(describing: info.roadName))，经纬度： \(String(describing: info.coordinate))")
            }
        }
        
        //路线绘制
        if driveManager.naviRoute?.wayPointsInfo != nil && driveManager.naviRoute?.wayPointsInfo.count != 0 {
            for info in (driveManager.naviRoute?.wayPointsInfo)! {
                print("经度：\(String(describing: info.point.longitude)),纬度：\(String(describing: info.point.latitude))")
            }
        }
//        driveManager.naviRoute?.drawStyleIndexes
        
    }
    
    // MARK: MAMapViewDelegate
    func mapView(_ mapView: MAMapView!, viewFor annotation: MAAnnotation!) -> MAAnnotationView! {
        if annotation.isKind(of: MAAnnotation.self){
            
        }
        return nil
    }
    
    func mapView(_ mapView: MAMapView!, rendererFor overlay: MAOverlay!) -> MAOverlayRenderer! {
        return nil
    }
    
    // MARK: AMapGeoFenceManagerDelegate
    
}

//extension ViewController:MAMapViewDelegate,AMapLocationManagerDelegate {
//
//
//
//}
