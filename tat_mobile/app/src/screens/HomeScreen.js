import React, { useContext, useEffect } from 'react';
import { Context as AuthContext } from '../context/AuthContext';
import { Text } from 'react-native-elements';
import { View, StyleSheet } from 'react-native';
import { SafeAreaView } from "react-navigation";

const HomeScreen = () => {

    return (
        <SafeAreaView forceInset={{ top: "always" }}>
            <View >
                <Text>Home</Text>
            </View>
        </SafeAreaView>
    );
};

HomeScreen.navigationOptions = () => {
    return {
        headerShown: false,
    };
};
const styles = StyleSheet.create({

});


export default HomeScreen;