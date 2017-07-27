`use strict`;

import React from 'react';
import {
	AppRegistry,
} from 'react-native';
import {
	StackNavigator
} from 'react-navigation';
import MainActivity from './react-native-ios/main_activity.js';


const jshare = StackNavigator({
	Home: {
		screen: MainActivity
	},
});

AppRegistry.registerComponent('jshare', () => jshare);