import React, { useContext, useEffect } from 'react';
import {Context as AuthContext} from '../context/AuthContext';
import {Text} from 'react-native-elements';
import {View, StyleSheet} from 'react-native';

const LoadingScreen = () => {
    const {tryLocalSignIn} = useContext(AuthContext);

    useEffect(() => {
        tryLocalSignIn();
    }, []);

    return (
<View style={styles.container}>
                <Text>Welcome</Text>
                </View>
    );
};


const styles = StyleSheet.create({
    container: {
        // borderColor : 'red',
        // borderWidth: 10,
        flex: 1,
        justifyContent: 'center',
    }
});


export default LoadingScreen;