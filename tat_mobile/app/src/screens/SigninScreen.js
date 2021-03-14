import React, { useContext, useEffect, useState } from "react";
import { View, StyleSheet, Text, Image } from "react-native";
import { Context as AuthContext } from "../context/AuthContext";
import AuthForm from "../components/AuthForm";
import NavLink from "../components/NavLink";
import { NavigationEvents, SafeAreaView } from "react-navigation";
import { InputCustom, ActionButtonCustom } from "../components";
import Svg, { Circle, Rect } from "react-native-svg";

const SigninScreen = ({ navigation }) => {
  const { state, signinPatient, clearErrorMessage } = useContext(AuthContext);
  const [form, setForm] = new useState({
    email: "fakhrulazran@gmail.com",
    password: "qwe123",
  });

  // useEffect(() =>{

  // }, []);

  const sendData = () => {
    console.log({form});
    signinPatient({
      email: form.email,
      password: form.password
    });
  };

  const onInputChanged = (value, input) => {
    setForm({
      ...form,
      [input]: value,
    });
  };
  return (
    <SafeAreaView style={styles.container}>
      <View style={styles.logo}>
        <Image source={require("../../assets/logo.png")}></Image>
      </View>
      <Text style={styles.title}>Welcome to Tracks & Monitoring App</Text>
      <View style={{ height: 65 }}></View>
      <InputCustom
        placeholder="Email"
        value={form.email}
        onChangeText={(value) => onInputChanged(value, 'email')}
      ></InputCustom>
      <View style={{ height: 20 }}></View>
      <InputCustom
        placeholder="Password"
        value={form.password}
        onChangeText={(value) => onInputChanged(value,'password')}
        secureTextEntry={true}
      ></InputCustom>
      <View style={{ height: 30 }}></View>
      <ActionButtonCustom title="Login" onPress={sendData}></ActionButtonCustom>
    </SafeAreaView>
    // <View style={styles.container}>
    //   <NavigationEvents onWillBlur={clearErrorMessage} />
    //   <View style={{backgroundColor:"blue", marginVertical:200}}></View>
    //   <AuthForm
    //     headerText="Sign In"
    //     errorMessage={state.errorMessage}
    //     onSubmit={signinPatient}
    //     submitButtonText="Sign In"
    //   />
    //   <NavLink
    //     text="Don't have an account? Sign Up instead!"
    //     routeName="Signup"
    //   ></NavLink>
    // </View>
  );
};

SigninScreen.navigationOptions = () => {
  return {
    headerShown: false,
  };
};

const styles = StyleSheet.create({
  container: {
    alignItems: "center",
    justifyContent: "center",
    backgroundColor: "white",
    justifyContent: "center",
    flex: 1,
  },
  logo: {
    width: 80,
    height: 80,
    backgroundColor: "white",
    marginTop: 10,
    justifyContent: "center",
    alignItems: "center",
  },
  title: {
    fontSize: 18,
    fontWeight: "bold",
    color: "#A5B1C2",
    maxWidth: 200,
    backgroundColor: "white",
    marginTop: 10,
    alignContent: "center",
    justifyContent: "center",
    textAlign: "center",
  },
});

export default SigninScreen;
