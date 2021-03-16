import React, { useContext, useEffect } from 'react';
import { Context as AuthContext } from '../../context/AuthContext';
import { Text, View, StyleSheet, TouchableOpacity, Image } from 'react-native';
import { SafeAreaView } from "react-navigation";
import { Ionicons } from "@expo/vector-icons";
import Header from "../../components/Header";
import { colors } from "../../utils";

const HomeScreen = ({ navigation }) => {
    global.__reanimatedWorkletInit = () => {};
    const addNewStream = () => {
        navigation.navigate("ScanQr");
    };
    return (
        <SafeAreaView style={styles.container} >
            <Header title="Home" navigation={navigation} onPress={() => { alert('More option here') }} ></Header>
            <View style={styles.logo}>
                <Image source={require("../../resources/register.png")}></Image>
            </View>
            <View style={{ height: 40 }}></View>

            <Text style={{ alignSelf: "center" }}>Welcome to Track and Trace</Text>
            <View style={{ height: 100 }}></View>
            <Text style={{ alignSelf: "center" }}>Please click QR Code icon to get product tracing</Text>
            <View style={{ position: "absolute", top: "85%", alignSelf: "center" }}>
                <TouchableOpacity style={{ marginRight: 30 }} onPress={addNewStream}>
                    <Ionicons name="qr-code" size={50} color={colors.black} />
                </TouchableOpacity>
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
    container: {
        // alignItems: "center",
        // justifyContent: "center",
        backgroundColor: "white",
        // justifyContent: "center",
        flex: 1,
    },
    logo: {
        // width: 80,
        // height: 80,
        backgroundColor: "white",
        marginTop: 100,
        justifyContent: "center",
        alignItems: "center",
    },
    animationContainer: {
        backgroundColor: '#fff',
        alignItems: 'center',
        justifyContent: 'center',
        flex: 1,
    },
    buttonContainer: {
        paddingTop: 20,
    },
});


export default HomeScreen;