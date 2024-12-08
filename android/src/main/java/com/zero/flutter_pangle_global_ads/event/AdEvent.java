package com.zero.flutter_pangle_global_ads.event;

import java.util.HashMap;

/**
 * 广告事件
 */
public class AdEvent {
    // 广告 id
    private final String posId;
    // 操作
    private final String action;

    public AdEvent(String posId, String action) {
        this.posId = posId;
        this.action = action;
    }

    /**
     * 转换为 Map 方面传输
     *
     * @return 转换后的 Map 对象
     */
    public HashMap<String, Object> toMap() {
        HashMap<String, Object> map = new HashMap<String, Object>();
        map.put("posId", posId);
        map.put("action", action);
        return map;
    }
}
