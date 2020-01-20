package com.vmloft.develop.app.flutter.vf_girls;

import android.os.Bundle;
import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;

import com.mob.MobSDK;
import cn.smssdk.flutter.MobsmsPlugin;

public class MainActivity extends FlutterActivity {

	// 通过Mob console申请获得
	// private static final String MOB_APPKEY = "moba6b6c6d6";
	// private static final String MOB_APPSECRET = "b89d2427a3bc7ad1aea1e1e8c1d36bf3";
	private static final String MOB_APPKEY = "2ddfd7a48e000";
	private static final String MOB_APPSECRET = "28385342a81f0c6d5aace2fa3718af77";

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
  }

  private void initMob(){
     // 注册SMSSDK Flutter插件
    MobsmsPlugin.registerWith(registrarFor(MobsmsPlugin.CHANNEL));
    // 初始化SMSSDK
    MobSDK.init(this, MOB_APPKEY, MOB_APPSECRET);
  }

  @Override
  protected void onDestroy() {
    super.onDestroy();
    // 执行回收操作
    MobsmsPlugin.recycle();
  }
}
