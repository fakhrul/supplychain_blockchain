import React, { useState, useEffect } from 'react';
import { Alert, Linking, Text, View, StyleSheet, Button } from 'react-native';
import { BarCodeScanner } from 'expo-barcode-scanner';
import { SafeAreaView } from "react-navigation";
import Header from "../components/Header";
import url from 'url';

const ScanQrScreen = ({ navigation }) => {
  const [hasPermission, setHasPermission] = useState(null);
  const [scanned, setScanned] = useState(false);

  useEffect(() => {
    (async () => {
      const { status } = await BarCodeScanner.requestPermissionsAsync();
      setHasPermission(status === 'granted');
    })();
  }, []);

  const displayProductTrail = (productId ) => {
    navigation.navigate("ProductTrail", { productId: productId });
  };

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
            displayProductTrail(productId);
            // navigation.navigate("ProductTrail", { productId: productId });
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
      <Header title="Scan QR" isBackButton navigation={navigation} onPress={() => { alert('More option here') }} ></Header>
      <View style={styles.barcode}>
        <BarCodeScanner
          onBarCodeScanned={scanned ? undefined : handleBarCodeScanned}
          style={StyleSheet.absoluteFillObject}
        />
        {scanned && <Button title={'Tap to Scan Again'} onPress={() => setScanned(false)} />}
      </View>
      <Button title="BYPASS SCAN"
        onPress={() =>
          displayProductTrail('0x56ceec9805cac5fa712309bf1b049b1386911c300e5c5b387cefe9cb95610243')
        }>

      </Button>
      <Button title="BYPASS SCAN 2"
        onPress={() =>
          displayProductTrail('0x2a11746e1e87fba5f38b20c067f797e57ea6dbb576760d9f38a40b428280841d')
        }>

      </Button>
      <Button title="BYPASS SCAN 3"
        onPress={() =>
          displayProductTrail('0x7c701380eb9068262c3cd25f8b8f15c621a69904aaf26e6d56218d813a9a06dc')
        }>

      </Button>
    </SafeAreaView >
  );
}

ScanQrScreen.navigationOptions = () => {
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

export default ScanQrScreen;