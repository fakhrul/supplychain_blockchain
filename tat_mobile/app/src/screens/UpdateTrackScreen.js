import React, { useContext, useState, useEffect } from 'react';
import { Context as AuthContext } from '../context/AuthContext';
import { Text, View, StyleSheet, TouchableOpacity, Image } from 'react-native';
import { SafeAreaView, NavigationEvents } from "react-navigation";
import Header from "../components/Header";
import InputCustom from "../components/InputCustom";
import { Picker } from '@react-native-picker/picker';
import { Context as TrackContext } from "../context/TrackContext";
import { Button, FlatList } from 'react-native';

const UpdateTrackScreen = ({ navigation }) => {
    const { state: { area, activity }, fetchOrganization } = useContext(TrackContext);
    const { state: { profile } } = useContext(AuthContext);
    const [areaId, setAreaId] = useState();
    const [activityId, setActivityId] = useState();

    // const [form, setForm] = new useState({
    //     displayName: "fakhrul",
    //     email: "fakhrulazran@gmail.com",
    //     password: "qwe123",
    //     isLoading: false,
    //     activityId: ""
    // });

    const refreshOrganization = () => {

        // fetchOrganization({ organizationId: '0x5b5ba619a9b837016c876eb1b9f8d82bd46d2bac3b4640e0f0f30c37a3cdc21e' });
        fetchOrganization({ organizationId: profile.organization.id });
        // console.log('area');
        // console.log(area);
    };

    const proceed = () => {
    };

    const renderDetail = (item) => {
        console.log(item);
        return (
            <View style={styles.feedItem}>
                <View style={{ flex: 1 }}>
                    <View
                        style={{
                            flexDirection: "row",
                            justifyContent: "space-between",
                            alignItems: "center",
                        }}
                    >
                        <View>
                            <Text style={styles.name}>{item.name}</Text>
                        </View>
                    </View>
                </View>
            </View>
        );
    };
    useEffect(() => {
    });
    const handleChange = (item) => {

    };
    return (
        <SafeAreaView style={styles.container} >
            <NavigationEvents onWillFocus={refreshOrganization}></NavigationEvents>

            <Header title="Update Trail" navigation={navigation} onPress={() => { alert('More option here') }} ></Header>
            <Text>Select Area</Text>
            <Picker
                style={{ width: "100%" }}
                mode="dropdown"
                selectedValue={areaId}
                onValueChange={(itemValue, itemIndex) =>
                    setAreaId(itemValue)}
            >
                {area !== "" ? (
                    area.map(item => {
                        return <Picker.Item label={item.name} value={item.id} />;
                    })
                ) : (
                    <Picker.Item label="Loading..." value="0" />
                )}
            </Picker>
            <Text>Select Activity</Text>
            <Picker
                style={{ width: "100%" }}
                mode="dropdown"
                selectedValue={activityId}
                onValueChange={(itemValue, itemIndex) =>
                    setActivityId(itemValue)}
            >
                {activity !== "" ? (
                    activity.map(item => {
                        return <Picker.Item label={item.name} value={item.id} />;
                    })
                ) : (
                    <Picker.Item label="Loading..." value="0" />
                )}
            </Picker>
            <Button title="PROCEED" onPress={proceed}></Button>

            {/* <FlatList
                data={area}
                keyExtractor={(item) => item.id}
                renderItem={({ item }) => renderDetail(item)}
            ></FlatList>
            <FlatList
                data={activity}
                keyExtractor={(item) => item.id}
                renderItem={({ item }) => renderDetail(item)}
            ></FlatList> */}
        </SafeAreaView>
    );
};

UpdateTrackScreen.navigationOptions = () => {
    return {
        headerShown: false,
    };
};
const styles = StyleSheet.create({
    feed: {
        marginHorizontal: 16,
    },
    feedItem: {
        backgroundColor: "#FFF",
        borderRadius: 5,
        padding: 8,
        flexDirection: "row",
        marginVertical: 8,
    },
    name: {
        fontSize: 15,
        fontWeight: "500",
        color: "#454D65",
    },
});


export default UpdateTrackScreen;