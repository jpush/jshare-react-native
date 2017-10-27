package cn.jiguang.share.reactnative;

import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReadableArray;
import com.facebook.react.bridge.ReadableMap;
import com.facebook.react.bridge.WritableArray;
import com.facebook.react.bridge.WritableMap;

import java.util.HashMap;
import java.util.List;

import cn.jiguang.share.android.api.AuthListener;
import cn.jiguang.share.android.api.JShareInterface;
import cn.jiguang.share.android.api.PlatActionListener;
import cn.jiguang.share.android.api.Platform;
import cn.jiguang.share.android.api.ShareParams;
import cn.jiguang.share.android.model.AccessTokenInfo;
import cn.jiguang.share.android.model.BaseResponseInfo;
import cn.jiguang.share.android.model.UserInfo;
import cn.jiguang.share.qqmodel.QQ;
import cn.jiguang.share.qqmodel.QZone;
import cn.jiguang.share.wechat.Wechat;
import cn.jiguang.share.wechat.WechatFavorite;
import cn.jiguang.share.wechat.WechatMoments;
import cn.jiguang.share.weibo.SinaWeibo;
import cn.jiguang.share.weibo.SinaWeiboMessage;


public class JShareModule extends ReactContextBaseJavaModule {

    private static final String JSHARE_NAME = "RCTJShareModule";

    public JShareModule(ReactApplicationContext reactContext) {
        super(reactContext);
    }

    @Override
    public String getName() {
        return JSHARE_NAME;
    }

    @ReactMethod
    public void getPlatformList(Callback callback) {
        List<String> list = JShareInterface.getPlatformList();
        WritableArray array = Arguments.createArray();
        for (String platform : list) {
            array.pushString(platform);
        }
        callback.invoke(array);
    }

    @ReactMethod
    public void isClientValid(ReadableMap map, Callback callback) {
        String name = getPlatformName(map);
        callback.invoke(JShareInterface.isClientValid(name));
    }

    @ReactMethod
    public void share(ReadableMap map, final Callback succeedCallback, final Callback failedCallback) {
        ShareParams shareParams = new ShareParams();
        String name = getPlatformName(map);
        String type = map.getString("type");
        int shareType;
        switch (type) {
            case "text":
                shareType = Platform.SHARE_TEXT;
                String shareText = map.getString("text");
                shareParams.setText(shareText);
                if (map.hasKey("imagePath")) {
                    shareParams.setImagePath(map.getString("imagePath"));
                }
                break;
            case "image":
                shareType = Platform.SHARE_IMAGE;
                shareText = map.getString("text");
                shareParams.setText(shareText);
                if (map.hasKey("imagePath")) {
                    shareParams.setImagePath(map.getString("imagePath"));
                } else if (map.hasKey("imageUrl")) {
                    shareParams.setImageUrl(map.getString("imageUrl"));
                } else if (map.hasKey("imageArray")) {
                    ReadableArray array = map.getArray("imageArray");
                    String[] imageArray = new String[array.size()];
                    for (int i=0; i<array.size(); i++) {
                        imageArray[i] = array.getString(i);
                    }
                    shareParams.setImageArray(imageArray);
                }
                break;
            case "video":
                shareType = Platform.SHARE_VIDEO;
                if (map.hasKey("url")) {
                    shareParams.setUrl(map.getString("url"));
                }
                if (map.hasKey("videoUrl")) {
                    shareParams.setVideoPath(map.getString("videoUrl"));
                }
                if (map.hasKey("title")) {
                    shareParams.setTitle(map.getString("title"));
                }
                if (map.hasKey("text")) {
                    shareParams.setText(map.getString("text"));
                }
                if (map.hasKey("imagePath")) {
                    shareParams.setImagePath(map.getString("imagePath"));
                }
                break;
            case "audio":
                shareType = Platform.SHARE_MUSIC;
                shareParams.setMusicUrl(map.getString("musicUrl"));
                if (map.hasKey("url")) {
                    shareParams.setUrl(map.getString("url"));
                }
                if (map.hasKey("imagePath")) {
                    shareParams.setImagePath(map.getString("imagePath"));
                } else if (map.hasKey("imageUrl")) {
                    shareParams.setImageUrl(map.getString("imageUrl"));
                }
                if (map.hasKey("title")) {
                    shareParams.setTitle(map.getString("title"));
                }
                if (map.hasKey("text")) {
                    shareParams.setText(map.getString("text"));
                }
                break;
            case "file":
                shareType = Platform.SHARE_FILE;
                shareParams.setFilePath(map.getString("path"));
                break;
            case "emoticon":
                shareType = Platform.SHARE_EMOJI;
                shareParams.setImagePath(map.getString("imagePath"));
                break;
            case "link":
                shareType = Platform.SHARE_WEBPAGE;
                shareParams.setUrl(map.getString("url"));
                if (map.hasKey("title")) {
                    shareParams.setTitle(map.getString("title"));
                }
                if (map.hasKey("text")) {
                    shareParams.setText(map.getString("text"));
                }
                if (map.hasKey("imagePath")) {
                    shareParams.setImagePath(map.getString("imagePath"));
                } else if (map.hasKey("imageUrl")) {
                    shareParams.setImageUrl(map.getString("imageUrl"));
                }
                break;
            default:
                shareType = Platform.SHARE_APPS;

        }
        shareParams.setShareType(shareType);
        JShareInterface.share(name, shareParams, new PlatActionListener() {
            @Override
            public void onComplete(Platform platform, int i, HashMap<String, Object> hashMap) {
                Logger.i(JSHARE_NAME, "share completed");
                WritableMap writableMap = Arguments.createMap();
                writableMap.putString("name", platform.getName());
                writableMap.putInt("code", i);
                succeedCallback.invoke(writableMap);
            }

            @Override
            public void onError(Platform platform, int action, int errorCode, Throwable throwable) {
                Logger.i(JSHARE_NAME, "share failed");
                WritableMap writableMap = Arguments.createMap();
                writableMap.putString("name", platform.getName());
                writableMap.putInt("code", errorCode);
                failedCallback.invoke(writableMap);
                throwable.printStackTrace();
            }

            @Override
            public void onCancel(Platform platform, int i) {
                Logger.i(JSHARE_NAME, "share has been canceled");
            }
        });
    }

    @ReactMethod
    public void isPlatformAuth(ReadableMap map, Callback callback) {
        String name = getPlatformName(map);
        callback.invoke(JShareInterface.isSupportAuthorize(name));
    }

    @ReactMethod
    public void authorize(final ReadableMap map, final Callback succeedCallback, final Callback failedCallback) {
        String name = getPlatformName(map);
        JShareInterface.authorize(name, new AuthListener() {
            @Override
            public void onComplete(Platform platform, int action, BaseResponseInfo baseResponseInfo) {
                Logger.i(JSHARE_NAME, "authorize completed" + platform + ", action: " + action + ", data: " + baseResponseInfo);
                switch (action) {
                    case Platform.ACTION_AUTHORIZING:
                        if (baseResponseInfo instanceof AccessTokenInfo) {
                            String token = ((AccessTokenInfo) baseResponseInfo).getToken();
                            long expiration = ((AccessTokenInfo) baseResponseInfo).getExpiresIn();
                            String refreshToken = ((AccessTokenInfo) baseResponseInfo).getRefeshToken();
                            String openId = ((AccessTokenInfo) baseResponseInfo).getOpenid();
                            String originData = baseResponseInfo.getOriginData();
                            Logger.i(JSHARE_NAME, "授权成功：" + baseResponseInfo.toString());
                            WritableMap writableMap = Arguments.createMap();
                            writableMap.putString("token", token);
                            writableMap.putDouble("expiration", expiration);
                            writableMap.putString("refreshToken", refreshToken);
                            writableMap.putString("openId", openId);
                            writableMap.putString("originData", originData);
                            succeedCallback.invoke(map);
                        }
                        break;
                }
            }

            @Override
            public void onError(Platform platform, int action, int errorCode, Throwable throwable) {
                Logger.i(JSHARE_NAME, "authorize failed");
                throwable.printStackTrace();
                failedCallback.invoke(errorCode);
            }

            @Override
            public void onCancel(Platform platform, int i) {
                Logger.i(JSHARE_NAME, "authorize has been canceled");
            }
        });
    }

    @ReactMethod
    public void isAuthorize(ReadableMap map, Callback callback) {
        String name = getPlatformName(map);
        callback.invoke(JShareInterface.isAuthorize(name));
    }

    @ReactMethod
    public void cancelAuthWithPlatform(ReadableMap map, final Callback callback) {
        String name = getPlatformName(map);
        JShareInterface.removeAuthorize(name, new AuthListener() {
            @Override
            public void onComplete(Platform platform, int action, BaseResponseInfo data) {
                Logger.i(JSHARE_NAME, "remove auth completed" + platform + ", action: " + action + ", data: " + data);
                switch (action) {
                    case Platform.ACTION_REMOVE_AUTHORIZING:
                        callback.invoke(0);
                        break;
                }
            }

            @Override
            public void onError(Platform platform, int action, int errorCode, Throwable throwable) {
                Logger.i(JSHARE_NAME, "remove auth failed" + platform + ", action: " + action + " errorCode: " + errorCode);
                throwable.printStackTrace();
                switch (action) {
                    case Platform.ACTION_REMOVE_AUTHORIZING:
                        callback.invoke(errorCode);
                        break;
                }
            }

            @Override
            public void onCancel(Platform platform, int i) {
                Logger.i(JSHARE_NAME, "remove auth has been canceled");
            }
        });
    }

    @ReactMethod
    public void getSocialUserInfo(ReadableMap map, final Callback successCallback, final Callback failCallback) {
        String name = getPlatformName(map);
        JShareInterface.getUserInfo(name, new AuthListener() {
            @Override
            public void onComplete(Platform platform, int action, BaseResponseInfo data) {
                Logger.i(JSHARE_NAME, "get userInfo completed" + platform + ", action: " + action + ", data: " + data);
                switch (action) {
                    case Platform.ACTION_USER_INFO:
                        if (data instanceof UserInfo) {      //第三方个人信息
                            String openId = ((UserInfo) data).getOpenid();  //openid
                            String name = ((UserInfo) data).getName();  //昵称
                            String imageUrl = ((UserInfo) data).getImageUrl();  //头像url
                            int gender = ((UserInfo) data).getGender();//性别, 1表示男性；2表示女性
                            //个人信息原始数据，开发者可自行处理
                            String originData = data.getOriginData();
                            WritableMap writableMap = Arguments.createMap();
                            writableMap.putString("name", name);
                            writableMap.putInt("gender", gender);
                            writableMap.putString("imageUrl", imageUrl);
                            writableMap.putString("openId", openId);
                            writableMap.putString("originData", originData);
                            successCallback.invoke(writableMap);
                        }
                        break;
                }
            }

            @Override
            public void onError(Platform platform, int action, int errorCode, Throwable throwable) {
                Logger.i(JSHARE_NAME, "Get userInfo failed" + " errorCode: " + errorCode);
                throwable.printStackTrace();
                switch (action) {
                    case Platform.ACTION_USER_INFO:
                        failCallback.invoke(errorCode);
                        break;
                }
            }

            @Override
            public void onCancel(Platform platform, int i) {
                Logger.i(JSHARE_NAME, "Get userInfo has been canceled");
            }
        });
    }

    private String getPlatformName(ReadableMap map) {
        String name = map.getString("platform");
        switch (name) {
            case "wechat_session":
                name = Wechat.Name;
                break;
            case "wechat_timeLine":
                name = WechatMoments.Name;
                break;
            case "wechat_favourite":
                name = WechatFavorite.Name;
                break;
            case "qq":
                name = QQ.Name;
                break;
            case "qzone":
                name = QZone.Name;
                break;
            case "sina_weibo":
                name = SinaWeibo.Name;
                break;
            default:
                name = SinaWeiboMessage.Name;
        }
        return name;
    }
}
