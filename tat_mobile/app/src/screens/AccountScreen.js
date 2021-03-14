import React, { useContext } from 'react';
import { View, StyleSheet } from 'react-native';
import { Text, Button } from 'react-native-elements';
import Spacer from '../components/Spacer';
import { Context as AuthContext } from '../context/AuthContext';
import { SafeAreaView } from 'react-navigation';
import { FontAwesome } from '@expo/vector-icons';

const AccountScreen = ({ navigation }) => {
    const { state: {profileId, profile}, signout } = useContext(AuthContext);
    return (
        <SafeAreaView forceInset={{ top: 'always' }}>
            <Text style={{ fontSize: 48 }}>Account Screen</Text>
            <Spacer>
                <Text>ID: {profile.id}</Text>
            </Spacer>
            <Spacer>
                <Text>Name: {profile.name}</Text>
            </Spacer>
            <Spacer>
                <Text>Email: {profile.email}</Text>
            </Spacer>
            <Spacer>
                <Text>Phone: {profile.phone}</Text>
            </Spacer>
            <Spacer>
                <Text>Organization: {profile.organization.name}</Text>
            </Spacer>
            <Spacer>
                <Button
                    title="Sign Out"
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