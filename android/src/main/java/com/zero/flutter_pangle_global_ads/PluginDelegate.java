package com.zero.flutter_pangle_global_ads;

import android.app.Activity;
import android.text.TextUtils;
import android.util.Log;

import androidx.annotation.NonNull;

import com.bytedance.sdk.openadsdk.api.init.PAGConfig;
import com.bytedance.sdk.openadsdk.api.init.PAGSdk;
import com.bytedance.sdk.openadsdk.api.open.PAGAppOpenAd;
import com.bytedance.sdk.openadsdk.api.open.PAGAppOpenAdInteractionListener;
import com.bytedance.sdk.openadsdk.api.open.PAGAppOpenAdLoadListener;
import com.bytedance.sdk.openadsdk.api.open.PAGAppOpenRequest;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import com.zero.flutter_pangle_global_ads.event.AdEvent;
import com.zero.flutter_pangle_global_ads.event.AdErrorEvent;
import com.zero.flutter_pangle_global_ads.event.AdEventHandler;
import com.zero.flutter_pangle_global_ads.event.AdEventAction;


/// 插件代理
public class PluginDelegate implements MethodChannel.MethodCallHandler, EventChannel.StreamHandler {
    private final String TAG = PluginDelegate.class.getSimpleName();
    // Flutter 插件绑定对象
    public FlutterPlugin.FlutterPluginBinding bind;
    // 当前 Activity
    public Activity activity;
    // 返回通道
    private MethodChannel.Result result;
    // 事件通道
    private EventChannel.EventSink eventSink;
    // 插件代理对象
    private static PluginDelegate _instance;

    public static PluginDelegate getInstance() {
        return _instance;
    }

    // 广告参数
    public static final String KEY_POSID = "posId";
    // 是否初始化
    public static boolean adInit = false;

    /**
     * 插件代理构造函数构造函数
     *
     * @param activity      Activity
     * @param pluginBinding FlutterPluginBinding
     */
    public PluginDelegate(Activity activity, FlutterPlugin.FlutterPluginBinding pluginBinding) {
        this.activity = activity;
        this.bind = pluginBinding;
        _instance = this;
    }

    /**
     * 方法通道调用
     *
     * @param call   方法调用对象
     * @param result 回调结果对象
     */
    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        String method = call.method;
        Log.d(TAG, "MethodChannel onMethodCall method:" + method + " arguments:" + call.arguments);
        if ("initAd".equals(method)) {
            initAd(call, result);
        } else if ("showSplashAd".equals(method)) {
            showSplashAd(call, result);
        } else {
            result.notImplemented();
        }
    }

    /**
     * 建立事件通道监听
     *
     * @param arguments 参数
     * @param events    事件回调对象
     */
    @Override
    public void onListen(Object arguments, EventChannel.EventSink events) {
        Log.d(TAG, "EventChannel onListen arguments:" + arguments);
        eventSink = events;
    }

    /**
     * 取消事件通道监听
     *
     * @param arguments 参数
     */
    @Override
    public void onCancel(Object arguments) {
        Log.d(TAG, "EventChannel onCancel");
        eventSink = null;
    }

    /**
     * 添加事件
     *
     * @param event 事件
     */
    public void addEvent(Object event) {
        if (eventSink != null) {
            Log.d(TAG, "EventChannel addEvent event:" + event.toString());
            eventSink.success(event);
        }
    }

    /**
     * 发送广告事件
     *
     * @param action 操作
     */
    protected void sendEvent(String posId,String action) {
        AdEventHandler.getInstance().sendEvent(new AdEvent(posId, action));
    }

    /**
     * 发送错误事件
     *
     * @param errCode 错误码
     * @param errMsg  错误事件
     */
    protected void sendErrorEvent(String posId,int errCode, String errMsg) {
        AdEventHandler.getInstance().sendEvent(new AdErrorEvent(posId, errCode, errMsg));
    }

    /**
     * 获取图片资源的id
     *
     * @param resName 资源名称，不带后缀
     * @return 返回资源id
     */
    private int getMipmapId(String resName) {
        return activity.getResources().getIdentifier(resName, "mipmap", activity.getPackageName());
    }


    /**
     * 初始化广告
     *
     * @param call   MethodCall
     * @param result Result
     */
    public void initAd(MethodCall call, final MethodChannel.Result result) {
        String appId = call.argument("appId");
        Boolean debug = call.argument("debug");
        // 构建基础配置x
        PAGConfig config = new PAGConfig.Builder().appId(appId).debugLog(debug).build();
        // 初始化广告
        PAGSdk.init(activity, config, new PAGSdk.PAGInitCallback() {
            @Override
            public void success() {
                Log.d(TAG, "initAd success");
                adInit = true;
                result.success(true);
            }

            @Override
            public void fail(int i, String s) {
                Log.e(TAG, "initAd fail code:" + i + " message:" + s);
                result.success(false);
            }
        });
    }

    /**
     * 显示开屏广告
     *
     * @param call   MethodCall
     * @param result Result
     */
    public void showSplashAd(MethodCall call, MethodChannel.Result result) {
        String posId = call.argument(KEY_POSID);
        int timeout = call.argument("timeout");
        PAGAppOpenRequest request = new PAGAppOpenRequest();
        request.setTimeout(timeout);
        PAGAppOpenAd.loadAd(posId, request, new PAGAppOpenAdLoadListener() {
            @Override
            public void onError(int code, String message) {
                Log.e(TAG, "showSplashAd onError code:" + code + " message:" + message);
                result.success(false);
                sendErrorEvent(posId, code, message);
            }

            @Override
            public void onAdLoaded(PAGAppOpenAd appOpenAd) {
                if (appOpenAd != null) {
                    appOpenAd.setAdInteractionListener(new PAGAppOpenAdInteractionListener() {
                        @Override
                        public void onAdShowed() {
                            Log.d(TAG, "onAdShowed");
                            sendEvent(posId, AdEventAction.onAdShowed);
                        }

                        @Override
                        public void onAdClicked() {
                            Log.d(TAG, "onAdClicked");
                            sendEvent(posId, AdEventAction.onAdClicked);
                        }

                        @Override
                        public void onAdDismissed() {
                            Log.d(TAG, "onAdDismissed");
                            sendEvent(posId, AdEventAction.onAdClosed);
                        }
                    });
                    appOpenAd.show(activity);
                    result.success(true);
                } else {
                    result.success(false);
                }
                // 发送事件
                sendEvent(posId, AdEventAction.onAdLoaded);
            }
        });
    }

}
