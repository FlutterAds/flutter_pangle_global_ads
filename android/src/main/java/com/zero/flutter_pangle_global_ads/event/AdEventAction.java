package com.zero.flutter_pangle_global_ads.event;

/**
 * 广告事件操作
 */
public class AdEventAction {
    // 广告错误
    public static final String onAdError = "onAdError";
    // 广告加载成功
    public static final String onAdLoaded = "onAdLoaded";
    // 广告曝光
    public static final String onAdShowed = "onAdShowed";
    // 广告关闭（计时结束或者用户点击关闭）
    public static final String onAdClosed = "onAdClosed";
    // 广告点击
    public static final String onAdClicked = "onAdClicked";
    // 获得广告激励
    public static final String onAdReward = "onAdReward";
    // 获得广告 Ecpm 信息
    public static final String onAdEcpm = "onAdEcpm";

}
