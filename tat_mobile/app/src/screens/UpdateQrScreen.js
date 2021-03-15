import React, { useState, useEffect } from 'react';
import { Alert, Linking, Text, View, StyleSheet, Button } from 'react-native';
import { BarCodeScanner } from 'expo-barcode-scanner';
import { SafeAreaView } from "react-navigation";
import Header from "../components/Header";
import url from 'url';

const UpdateQrScreen = ({ navigation }) => {
  const [hasPermission, setHasPermission] = useState(null);
  const [scanned, setScanned] = useState(false);

  useEffect(() => {
    (async () => {
      const { status } = await BarCodeScanner.requestPermissionsAsync();
      setHasPermission(status === 'granted');
    })();
  }, []);

  const handleBarCodeScanned = ({ type, data }) => {
    setScanned(true);
    Alert.alert(
      'Open this URL?',
      data,
      [
        {
          text: 'Yes',
          onPress: () => {
            var path = url.parse(data);
            var productId = path.pathname.substring(1);
            navigation.navigate("ProductTrail", { productId: productId });
          }
        },
        { text: 'No', onPress: () => { } },
      ],
      { cancellable: false }
    );

  };

  if (hasPermission === null) {
    return <Text>Requesting for camera permission</Text>;
  }
  if (hasPermission === false) {
    return <Text>No access to camera</Text>;
  }

  return (
    <SafeAreaView style={styles.container} >
      <Header title="Scan QR" navigation={navigation} onPress={() => { alert('More option here') }} ></Header>
      <View style={styles.barcode}>
      <BarCodeScanner
        onBarCodeScanned={scanned ? undefined : handleBarCodeScanned}
        style={StyleSheet.absoluteFillObject}
      />
      {scanned && <Button title={'Tap to Scan Again'} onPress={() => setScanned(false)} />}
      </View>
    </SafeAreaView>
  );
}

UpdateQrScreen.navigationOptions = () => {
  return {
      headerShown: false,
  };
};
const styles = StyleSheet.create({
  barcode: {
    flex: 1,
    flexDirection: 'column',
    justifyContent: 'center',
  },
  container: {
    backgroundColor: "white",
    flex: 1,
  },

});

export default UpdateQrScreen;