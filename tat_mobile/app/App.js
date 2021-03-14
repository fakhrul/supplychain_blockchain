import React from 'react'
import {
  createAppContainer,
  createSwitchNavigator
} from 'react-navigation'

import {Provider as LocationProvider} from './src/context/LocationContext'
import {Provider as TrackProvider} from './src/context/TrackContext';

import { createBottomTabNavigator } from 'react-navigation-tabs'
import { createStackNavigator } from 'react-navigation-stack'

import MainScreen from "./src/screens/MainScreen"
import MovementScreen from "./src/screens/MovementScreen"
import SigninScreen from "./src/screens/SigninScreen"
import SignupScreen from "./src/screens/SignupScreen"
import AccountScreen from "./src/screens/AccountScreen"

import LoadingScreen from "./src/screens/LoadingScreen"

import TrackCreateScreen from "./src/screens/TrackCreateScreen"
import TrackDetailScreen from "./src/screens/TrackDetailScreen"

import { Provider as AuthProvider } from "./src/context/AuthContext"
import {setNavigator} from './src/helper/navigationRef';
import {FontAwesome} from '@expo/vector-icons';

const  mainFlow =  createStackNavigator({
  Main : MainScreen
});


mainFlow.navigationOptions = {
  title: 'Home',
  
  tabBarIcon: <FontAwesome name="home" size={20}></FontAwesome>

}

const movementFlow = createStackNavigator({
  Movement : MovementScreen,
  TrackCreate : TrackCreateScreen,
  TrackDetail: TrackDetailScreen
})

movementFlow.navigationOptions = {
  title: 'Movement',
  tabBarIcon: <FontAwesome name="map" size={20}></FontAwesome>

}


const switchNavigator = createSwitchNavigator({
  Loading: LoadingScreen,
  anonymousFlow: createStackNavigator({
    // Signup: SignupScreen,
    Signin: SigninScreen
  }),
  userFlow: createBottomTabNavigator({
    mainFlow,
    movementFlow,
    Account: AccountScreen
  })
});

const App =  createAppContainer(switchNavigator);

export default () => {
  return (
    <TrackProvider>
      <LocationProvider>
      <AuthProvider>
        <App ref= {(navigator) => {setNavigator(navigator)}}/>
      </AuthProvider>
      </LocationProvider>
    </TrackProvider>
  );
};

// import React from 'react';
// import { StyleSheet, Text, View } from 'react-native';

// export default function App() {
//   return (
//     <View style={styles.container}>
//       <Text>Open up App.js to start working on your app!</Text>
//     </View>
//   );
// }

// const styles = StyleSheet.create({
//   container: {
//     flex: 1,
//     backgroundColor: '#fff',
//     alignItems: 'center',
//     justifyContent: 'center',
//   },
// });
