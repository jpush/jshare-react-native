# Add JSharePackage

> your project/android/app/src…/MainApplication.java

```

import cn.jiguang.share.android.api.JShareInterface;     // <--  Import JShareInterface
import cn.jiguang.share.reactnative.JSharePackage;       // <--  Import JSharePackage

public class MainApplication extends Application implements ReactApplication {

    // 是否关闭 Log，默认不关闭
    private static boolean SHUTDOWN_LOG = false;
    // 是否关闭 toast，默认不关闭
    private static boolean SHUTDOWN_TOAST = false;
    private final ReactNativeHost mReactNativeHost = new ReactNativeHost(this) {

        @Override
        public boolean getUseDeveloperSupport() {
            return BuildConfig.DEBUG;
        }


        @Override
        protected List<ReactPackage> getPackages() {
            return Arrays.<ReactPackage>asList(
                    new MainReactPackage(),
                    new JSharePackage(SHUTDOWN_TOAST, SHUTDOWN_LOG)    // <--    Add JSharePackage
            );
        }
    };

    @Override
    public ReactNativeHost getReactNativeHost() {
        return mReactNativeHost;
    }

    @Override
    public void onCreate() {
        super.onCreate();
        SoLoader.init(this, false);
//        在 Init 之前调用，设置为 true，则会打印 debug 级别日志，否则只会打印 warning 级别以上的日志
//        JShareInterface.setDebugMode(true);
        JShareInterface.init(this);             //   <-- Init here
    }
}
```





