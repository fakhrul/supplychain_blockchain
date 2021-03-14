import React, {useContext} from 'react';
import {View, StyleSheet} from 'react-native';
import {Text, Button} from 'react-native-elements';
import Spacer from '../components/Spacer';
import {Context as AuthContext} from '../context/AuthContext';
import {SafeAreaView} from 'react-navigation';
import {FontAwesome} from '@expo/vector-icons';

const AccountScreen = ({navigation}) => {
    const {signout} = useContext(AuthContext);

    return (
        <SafeAreaView forceInset={{top: 'always'}}>
            <Text style={{fontSize:48}}>Account Screen</Text>
            <Spacer>
            <Button
                title="SingOut"
                onPress={signout}
                
            />
            </Spacer>
        </SafeAreaView>
    );
};

AccountScreen.navigationOptions = {
    title: 'Account',
    tabBarIcon: <FontAwesome name="gear" size={20}></FontAwesome>
}


const styles = StyleSheet.create({});

export default AccountScreen;