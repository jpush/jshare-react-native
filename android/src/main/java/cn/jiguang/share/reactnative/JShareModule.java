package cn.jiguang.share.reactnative;

import android.content.res.Resources;
import android.os.Bundle;

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
import cn.jiguang.share.facebook.Facebook;
import cn.jiguang.share.facebook.FacebookBroadcastReceiver;
import cn.jiguang.share.facebook.messenger.FbMessenger;
import cn.jiguang.share.qqmodel.QQ;
import cn.jiguang.share.qqmodel.QZone;
import cn.jiguang.share.wechat.Wechat;
import cn.jiguang.share.wechat.WechatFavorite;
import cn.jiguang.share.wechat.WechatMoments;
import cn.jiguang.share.weibo.SinaWeibo;
import cn.jiguang.share.weibo.SinaWeiboMessage;


public class JShareModule extends ReactContextBaseJavaModule {

    private static final String JSHARE_NAME = "RCTJShareModule";
    private static final String STATE = "state";
    private static final String SUCCESS = "success";
    private static final String FAIL = "fail";
    private static final String CANCEL = "cancel";
    private static final String UNKNOWN = "unknown";
    private static final String CODE = "code";
    private static final String DESCRIPTION = "description";

    public JShareModule(ReactApplicationContext reactContext) {
        super(reactContext);
    }

    @Override
    public String getName() {
        return JSHARE_NAME;
    }

    @ReactMethod
    public void setDebug(ReadableMap map) {
        try {
            boolean enable = map.getBoolean("enable");
            JShareInterface.setDebugMode(enable);
        } catch (Exception e) {
            e.printStackTrace();
        }
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
    public void share(final ReadableMap map, final Callback succeedCallback, final Callback failedCallback) {
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
                if (map.hasKey("text")) {
                    shareText = map.getString("text");
                    shareParams.setText(shareText);
                }
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
                if (map.hasKey("quote")) {
                    shareParams.setQuote(map.getString("quote"));
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
                WritableMap result = Arguments.createMap();
                result.putString(STATE, SUCCESS);
                result.putInt(CODE, 0);
                succeedCallback.invoke(result);
            }

            @Override
            public void onError(Platform platform, int action, int errorCode, Throwable throwable) {
                Logger.i(JSHARE_NAME, "share failed");
                throwable.printStackTrace();
                WritableMap result = Arguments.createMap();
                result.putInt(CODE, errorCode);
                result.putString(STATE, FAIL);
                result.putString(DESCRIPTION, getErrorDescription(errorCode));
                failedCallback.invoke(result);
            }

            @Override
            public void onCancel(Platform platform, int i) {
                Logger.i(JSHARE_NAME, "share has been canceled");
                WritableMap result = Arguments.createMap();
                result.putInt(CODE, i);
                result.putString(STATE, CANCEL);
                succeedCallback.invoke(result);
            }
        });
    }

    /**
     * 判断平台是否已经授权
     * @param map 包含平台名字
     * @param callback return boolean
     */
    @ReactMethod
    public void isPlatformAuth(ReadableMap map, Callback callback) {
        String name = getPlatformName(map);
        callback.invoke(JShareInterface.isAuthorize(name));
    }

    @ReactMethod
    public void isSupportAuthorize(ReadableMap map, Callback callback) {
        String name = getPlatformName(map);
        callback.invoke(JShareInterface.isSupportAuthorize(name));
    }

    @ReactMethod
    public void authorize(final ReadableMap map, final Callback succeedCallback, final Callback failedCallback) {
        String name = "";
        try {
            switch (map.getString("platform")) {
                case "wechat":
                    name = Wechat.Name;
                    break;
                case "qq":
                    name = QQ.Name;
                    break;
                case "weibo":
                    name = SinaWeibo.Name;
                    break;
                default:
                    name = Facebook.Name;
            }
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
                                WritableMap result = Arguments.createMap();
                                result.putInt(CODE, 0);
                                result.putString(STATE, SUCCESS);
                                result.putString("token", token);
                                result.putDouble("expiration", expiration);
                                result.putString("refreshToken", refreshToken);
                                result.putString("openId", openId);
                                result.putString("originData", originData);
                                succeedCallback.invoke(result);
                            }
                            break;
                    }
                }

                @Override
                public void onError(Platform platform, int action, int errorCode, Throwable throwable) {
                    Logger.i(JSHARE_NAME, "authorize failed");
                    throwable.printStackTrace();
                    WritableMap result = Arguments.createMap();
                    result.putInt(CODE, errorCode);
                    result.putString(STATE, FAIL);
                    result.putString(DESCRIPTION, getErrorDescription(errorCode));
                    failedCallback.invoke(result);
                }

                @Override
                public void onCancel(Platform platform, int i) {
                    Logger.i(JSHARE_NAME, "authorize has been canceled");
                    WritableMap result = Arguments.createMap();
                    result.putInt(CODE, i);
                    result.putString(STATE, CANCEL);
                    succeedCallback.invoke(result);
                }
            });
        } catch (Exception e) {
            e.printStackTrace();
            WritableMap writableMap = Arguments.createMap();
            writableMap.putString(DESCRIPTION, "Can't get platform name");
            failedCallback.invoke(writableMap);
        }
    }


    @ReactMethod
    public void cancelAuthWithPlatform(final ReadableMap map, final Callback callback) {
        String name = getPlatformName(map);
        JShareInterface.removeAuthorize(name, new AuthListener() {
            @Override
            public void onComplete(Platform platform, int action, BaseResponseInfo data) {
                Logger.i(JSHARE_NAME, "remove auth completed" + platform + ", action: " + action + ", data: " + data);
                WritableMap result = Arguments.createMap();
                result.putString(STATE, SUCCESS);
                result.putInt(CODE, 0);
                callback.invoke(result);
            }

            @Override
            public void onError(Platform platform, int action, int errorCode, Throwable throwable) {
                Logger.i(JSHARE_NAME, "remove auth failed" + platform + ", action: " + action + " errorCode: " + errorCode);
                throwable.printStackTrace();
                WritableMap result = Arguments.createMap();
                result.putInt(CODE, errorCode);
                result.putString(STATE, FAIL);
                result.putString(DESCRIPTION, getErrorDescription(errorCode));
                callback.invoke(result);
            }

            @Override
            public void onCancel(Platform platform, int i) {
                Logger.i(JSHARE_NAME, "remove auth has been canceled");
                WritableMap result = Arguments.createMap();
                result.putInt(CODE, i);
                result.putString(STATE, CANCEL);
                callback.invoke(result);
            }
        });
    }

    @ReactMethod
    public void getSocialUserInfo(final ReadableMap map, final Callback successCallback, final Callback failCallback) {
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
                            writableMap.putInt(CODE, 0);
                            writableMap.putString(STATE, SUCCESS);
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
                WritableMap result = Arguments.createMap();
                result.putInt(CODE, errorCode);
                result.putString(STATE, FAIL);
                result.putString(DESCRIPTION, getErrorDescription(errorCode));
                failCallback.invoke(result);
            }

            @Override
            public void onCancel(Platform platform, int i) {
                Logger.i(JSHARE_NAME, "Get userInfo has been canceled");
                WritableMap result = Arguments.createMap();
                result.putInt(CODE, i);
                result.putString(STATE, CANCEL);
                successCallback.invoke(result);
            }
        });
    }

    private String getErrorDescription(int errorCode) {
        Resources resources = getReactApplicationContext().getResources();
        switch (errorCode) {
            case 40001:
                return resources.getString(R.string.code_40001);
            case 40002:
                return resources.getString(R.string.code_40002);
            case 40003:
                return resources.getString(R.string.code_40003);
            case 40004:
                return resources.getString(R.string.code_40004);
            case 40005:
                return resources.getString(R.string.code_40005);
            case 40006:
                return resources.getString(R.string.code_40006);
            case 40007:
                return resources.getString(R.string.code_40007);
            case 40009:
                return resources.getString(R.string.code_40009);
            case 40010:
                return resources.getString(R.string.code_40010);
            case 40011:
                return resources.getString(R.string.code_40011);
            case 40012:
                return resources.getString(R.string.code_40012);
            case 41001:
                return resources.getString(R.string.code_41001);
            case 41002:
                return resources.getString(R.string.code_41002);
            case 41003:
                return resources.getString(R.string.code_41003);
            case 41004:
                return resources.getString(R.string.code_41004);
            case 41005:
                return resources.getString(R.string.code_41005);
            case 41006:
                return resources.getString(R.string.code_41006);
            case 41009:
                return resources.getString(R.string.code_41009);
            case 41010:
                return resources.getString(R.string.code_41010);
            case 41011:
                return resources.getString(R.string.code_41011);
            case 41012:
                return resources.getString(R.string.code_41012);
            case 41013:
                return resources.getString(R.string.code_41013);
            case 41014:
                return resources.getString(R.string.code_41014);
            case 41015:
                return resources.getString(R.string.code_41015);
            case 41016:
                return resources.getString(R.string.code_41016);
            case 41018:
                return resources.getString(R.string.code_41018);
            case 41019:
                return resources.getString(R.string.code_41019);
            case 41021:
                return resources.getString(R.string.code_41021);
            case 41022:
                return resources.getString(R.string.code_41022);
            case 41025:
                return resources.getString(R.string.code_41025);
            case 41026:
                return resources.getString(R.string.code_41026);
            case 41027:
                return resources.getString(R.string.code_41027);
            case 41028:
                return resources.getString(R.string.code_41028);
            case 41029:
                return resources.getString(R.string.code_41029);
            case 42001:
                return resources.getString(R.string.code_42001);
            case 50001:
                return resources.getString(R.string.code_50001);
            case 50002:
                return resources.getString(R.string.code_50002);
            case 50003:
                return resources.getString(R.string.code_50003);
            case 50004:
                return resources.getString(R.string.code_50004);
            case 50005:
                return resources.getString(R.string.code_50005);
            case 50006:
                return resources.getString(R.string.code_50006);
            case 50007:
                return resources.getString(R.string.code_50007);
            case 50008:
                return resources.getString(R.string.code_50008);
            case 50009:
                return resources.getString(R.string.code_50009);
            default:
                return "Cannot find the description";
        }

    }

    private String getPlatformName(ReadableMap map) {
        String name = "";
        try {
            name = map.getString("platform");
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
                case "facebook":
                    name = Facebook.Name;
                    break;
                case "facebook_messenger":
                    name = FbMessenger.Name;
                    break;
                default:
                    name = SinaWeiboMessage.Name;
            }
            return name;
        } catch (Exception e) {
            Logger.d(JSHARE_NAME, "Illegal platform name, please check your parameter");
            e.printStackTrace();
        }
        return name;
    }

    public static class FaceBookUploadReceiver extends FacebookBroadcastReceiver {

        public FaceBookUploadReceiver() {}

        private static final String TAG = "FaceBookUploadReceiver";

        @Override
        protected void onSuccessfulAppCall(String appCallId, String action, Bundle extras) {
            Logger.i(TAG, String.format("Photo uploaded by call " + appCallId + " succeeded."));

        }

        @Override
        protected void onFailedAppCall(String appCallId, String action, Bundle extras) {
            Logger.i(TAG, String.format("Photo uploaded by call " + appCallId + " failed."));
        }
    }
}
