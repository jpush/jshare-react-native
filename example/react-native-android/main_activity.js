'use strict';

import React from 'react';
import ReactNative from 'react-native';
import JAnalyticsModule from 'janalytics-react-native';

const {
  View,
  Text,
  TouchableHighlight,
  StyleSheet,
} = ReactNative;



export default class MainActivity extends React.Component {
  constructor(props) {
    super(props);
  }

  onLoginPress = () => {
    var LoginEvent = {
      type: 'login',
      extra: {
        userId: "user1"
      },
      method: "login",
      success: true
    };
    JAnalyticsModule.postEvent(LoginEvent);
  }

  onRegisterPress = () => {
    var RegisterEvent = {
      type: "register",
      extra: {
        userId: "user2"
      },
      method: "register",
      success: true
    };
    JAnalyticsModule.postEvent(RegisterEvent);
  }

  onPurchasePress = () => {
    var PurchaseEvent = {
      goodsId: '123',
      type: 'purchase',
      extra: {
        userId: 'user2'
      },
      goodsType: 'sports',
      goodsName: 'basketball',
      price: 300,
      currency: 'CNY',
      count: 1,
      success: true
    };
    JAnalyticsModule.postEvent(PurchaseEvent);
  }

  onCountPress = () => {
    var CountEvent = {
      id: 'count1',
      extra: {
        userId: 'user1'
      },
      type: 'count'
    };
    JAnalyticsModule.postEvent(CountEvent);
  }

  onCalculatePress = () => {
    var CalculateEvent = {
      id: 'calculate1',
      extra: {
        userId: 'user1'
      },
      type: 'calculate',
      value: 200
    };
    JAnalyticsModule.postEvent(CalculateEvent);
  }

  onBrowsePress = () => {
    var BrowseEvent = {
      id: 'browse1',
      name: 'shenzhen news',
      type: 'browse',
      extra: {
        userId: 'user1'
      },
      contentType: 'news',
      duration: 60
    };
    JAnalyticsModule.postEvent(BrowseEvent);
  }

  render() {
    return (
      <View>
        <Text>
          style={styles.welcome}> 
          Welcome ! 
        </Text> 
        <TouchableHighlight 
          underlayColor = '#e4083f'
          activeOpacity = {0.5}
          style = {styles.btnStyle}
          onPress = {this.onLoginPress}>
          <Text style={styles.btnTextStyle}>
            Login event
          </Text> 
        </TouchableHighlight>
        <TouchableHighlight 
          underlayColor = "#e4083f"
          activeOpacity = {0.5}
          style = {styles.btnStyle}
          onPress = {this.onRegisterPress}>
          <Text style = {styles.btnTextStyle}>
            Register event
          </Text>
        </TouchableHighlight>
        <TouchableHighlight 
          underlayColor = "#e4083f"
          activeOpacity = {0.5}
          style = {styles.btnStyle}
          onPress = {this.onPurchasePress}>
          <Text style = {styles.btnTextStyle}>
            Purchase event
          </Text>
        </TouchableHighlight>
        <TouchableHighlight 
          underlayColor = "#e4083f"
          activeOpacity = {0.5}
          style = {styles.btnStyle}
          onPress = {this.onCountPress}>
          <Text style = {styles.btnTextStyle}>
            Count event
          </Text>
        </TouchableHighlight>
        <TouchableHighlight 
          underlayColor = "#e4083f"
          activeOpacity = {0.5}
          style = {styles.btnStyle}
          onPress = {this.onCalculatePress}>
          <Text style = {styles.btnTextStyle}>
            Calculate event
          </Text>
        </TouchableHighlight>
        <TouchableHighlight 
          underlayColor = "#e4083f"
          activeOpacity = {0.5}
          style = {styles.btnStyle}
          onPress = {this.onBrowsePress}>
          <Text style = {styles.btnTextStyle}>
            Browse event
          </Text>
        </TouchableHighlight>
      </View>
    );
  }
}

var styles = StyleSheet.create({
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