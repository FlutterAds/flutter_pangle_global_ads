package com.zero.flutter_pangle_global_ads.event;

import android.util.Log;
import com.zero.flutter_pangle_global_ads.PluginDelegate;

/**
 * 广告事件处理类
 */
public class AdEventHandler {
    // 广告事件处理对象
    private static volatile AdEventHandler _instance;

    /**
     * 获取广告事件处理类
     *
     * @return 广告事件处理对象
     */
    public static AdEventHandler getInstance() {
        if (_instance == null) {
            synchronized (AdEventHandler.class) {
                _instance = new AdEventHandler();
            }
        }
        return _instance;
    }

    /**
     * 添加广告事件
     *
     * @param event 广告事件
     */
    public void sendEvent(AdEvent event) {
        if (event != null) {
            PluginDelegate.getInstance().addEvent(event.toMap());
        }
    }

    /**
     * 发送广告事件
     *
     * @param action 操作
     */
    protected void sendEvent(String posId, String action) {
        sendEvent(new AdEvent(posId, action));
    }

    /**
     * 发送错误事件
     *
     * @param errCode 错误码
     * @param errMsg  错误事件
     */
    protected void sendErrorEvent(String posId, int errCode, String errMsg) {
        sendEvent(new AdErrorEvent(posId, errCode, errMsg));
    }

}
