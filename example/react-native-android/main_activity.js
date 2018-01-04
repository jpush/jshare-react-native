'use strict';

import React from 'react';
import ReactNative from 'react-native';
import JShareModule from 'jshare-react-native';

const {
  View,
  Text,
  TouchableHighlight,
  StyleSheet,
  ScrollView,
} = ReactNative;



export default class MainActivity extends React.Component {
  constructor(props) {
    super(props);
  }

  componentDidMount() {
    JShareModule.setDebug({enable: true})
  }

  onGetPlatformList = () => {
    JShareModule.getPlatformList((list) => {
      console.log("list: " + list);
    });
  }

  onGetUserInfo = () => {
    var param = {
      platform: "wechat_session"
    };
    JShareModule.getSocialUserInfo(param, (map) => {
      console.log(map);
    }, (errorCode) => {
      console.log("errorCode: " + errorCode);
    });
  }

  onPlatformAuth = () => {
    var param = {
      platform: "wechat_session"
    };
    JShareModule.isPlatformAuth(param, (result) => {
      console.log(param.platform + "is Auth: " + result);
    });
  }

  onClientValid = () => {
    var param = {
      platform: "wechat_session"
    };
    JShareModule.isClientValid(param, (result) => {
      console.log(param.platform + "is valid: " + result);
    });
  }

  onAuthorize = () => {
    var param = {
      platform: "wechat_session"
    };
    JShareModule.authorize(param, (map) => {
      console.log("Authorize succeed " + map);
    }, (errorCode) => {
      console.log("Authorize failed, errorCode : " + errorCode);
    });
  }

  onRemoveAuthorize = () => {
    var param = {
      platform: "wechat_session"
    };
    JShareModule.cancelAuthWithPlatform(param, (code) => {
      if (code === 0) {
        console.log("remove authorize succeed");
      } else {
        console.log("remove authorize failed, errorCode: " + code);
      }
    });
  }

  onSharePress = () => {
    var shareParam = {
      platform: "wechat_session",
      type: "image",
      text: "JShare test text",
      imagePath: "/storage/emulated/0/DCIM/Camera/IMG20170707202330.jpg"
    };
    JShareModule.share(shareParam, (map) => {
      console.log("share succeed, map: " + map);
    }, (map) => {
      console.log("share failed, map: " + map);
    });
  }

  onShareLinkToFacebook = () => {
    console.log("Share to facebook");
    var shareParam = {
      platform: "facebook",
      type: "link",
      url: "https://jiguang.cn",
      text: "JShare test text",
    };
    JShareModule.share(shareParam, (map) => {
      console.log("Share to facebook succeed " + JSON.stringify(map));
    }, (error) => {
      console.log("Share to facebook failed, error: " + JSON.stringify(error));
    })
  }

  onShareImageToFacebook = () => {
    console.log("Share image to facebook")
    var shareParam = {
      platform: "facebook",
      type: "image",
      imagePath: "assets/jiguang_test_img.png",
    };
    JShareModule.share(shareParam, (map) => {
      console.log("Share image to facebook succeed: " + JSON.stringify(map));
    }, (error) => {
      console.log("Share failed, error: " + JSON.stringify(error));
    });
  }

  onShareVideoToFacebook = () => {
    console.log("Share video to facebook");
    var shareParam = {
      platform: "facebook",
      type: "video",
      videoUrl: "assets/jiguang.mp4"
    };
    JShareModule.share(shareParam, (map) => {
      console.log("Share video to facebook succeed: " + JSON.stringify(map));
    }, (error) => {
      console.log("Share failed; error: " + JSON.stringify(error));
    });
  }

  render() {
    return (
      <ScrollView style={styles.container}>
        <Text>
          style={styles.welcome}> 
          Welcome ! 
        </Text> 
        <TouchableHighlight 
          underlayColor = '#e4083f'
          activeOpacity = {0.5}
          style = {styles.btnStyle}
          onPress = {this.onGetPlatformList}>
          <Text style={styles.btnTextStyle}>
            Get Platform List
          </Text> 
        </TouchableHighlight>
        <TouchableHighlight 
          underlayColor = "#e4083f"
          activeOpacity = {0.5}
          style = {styles.btnStyle}
          onPress = {this.onGetUserInfo}>
          <Text style = {styles.btnTextStyle}>
            Get userInfo
          </Text>
        </TouchableHighlight>
        <TouchableHighlight 
          underlayColor = "#e4083f"
          activeOpacity = {0.5}
          style = {styles.btnStyle}
          onPress = {this.onPlatformAuth}>
          <Text style = {styles.btnTextStyle}>
            Is Platform auth
          </Text>
        </TouchableHighlight>
        <TouchableHighlight 
          underlayColor = "#e4083f"
          activeOpacity = {0.5}
          style = {styles.btnStyle}
          onPress = {this.onClientValid}>
          <Text style = {styles.btnTextStyle}>
            Is client valid
          </Text>
        </TouchableHighlight>
        <TouchableHighlight 
          underlayColor = "#e4083f"
          activeOpacity = {0.5}
          style = {styles.btnStyle}
          onPress = {this.onAuthorize}>
          <Text style = {styles.btnTextStyle}>
            Authorize
          </Text>
        </TouchableHighlight>
        <TouchableHighlight 
          underlayColor = "#e4083f"
          activeOpacity = {0.5}
          style = {styles.btnStyle}
          onPress = {this.onRemoveAuthorize}>
          <Text style = {styles.btnTextStyle}>
            Remove authorize
          </Text>
        </TouchableHighlight>
        <TouchableHighlight 
          underlayColor = "#e4083f"
          activeOpacity = {0.5}
          style = {styles.btnStyle}
          onPress = {this.onSharePress}>
          <Text style = {styles.btnTextStyle}>
            Share
          </Text>
        </TouchableHighlight>
        <TouchableHighlight 
          underlayColor = "#e4083f"
          activeOpacity = {0.5}
          style = {styles.btnStyle}
          onPress = {this.onShareLinkToFacebook}>
          <Text style = {styles.btnTextStyle}>
            Share Link to Facebook
          </Text>
        </TouchableHighlight>
        <TouchableHighlight 
          underlayColor = "#e4083f"
          activeOpacity = {0.5}
          style = {styles.btnStyle}
          onPress = {this.onShareImageToFacebook}>
          <Text style = {styles.btnTextStyle}>
            Share Photo to Facebook
          </Text>
        </TouchableHighlight>
        <TouchableHighlight 
          underlayColor = "#e4083f"
          activeOpacity = {0.5}
          style = {styles.btnStyle}
          onPress = {this.onShareVideoToFacebook}>
          <Text style = {styles.btnTextStyle}>
            Share Video to Facebook
          </Text>
        </TouchableHighlight>
      </ScrollView>
    );
  }
}

var styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 10,
  },
  welcome: {
    textAlign: 'center',
    margin: 10,
  },
  btnStyle: {
    marginTop: 10,
    borderWidth: 1,
    borderColor: '#3e83d7',
    borderRadius: 8,
    backgroundColor: '#3e83d7',
    alignSelf: 'center',
    justifyContent: 'center'
  },
  btnTextStyle: {
    textAlign: 'center',
    fontSize: 25,
    color: '#ffffff'
  },
});