`use strict`;

import React from 'react';
import {
	AppRegistry,
} from 'react-native';
import {
	StackNavigator
} from 'react-navigation';
import MainActivity from './react-native-android/main_activity.js';


const JShareDemo = StackNavigator({
	Home: {
		screen: MainActivity
	},
});

AppRegistry.registerComponent('JShareDemoApp', () => JShareDemo);