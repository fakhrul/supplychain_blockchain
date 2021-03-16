import React, { useContext, useState, useEffect, useRef } from 'react';
import { Context as AuthContext } from '../../context/AuthContext';
import { Text, View, StyleSheet, TouchableOpacity, Image } from 'react-native';
import { SafeAreaView, NavigationEvents } from "react-navigation";
import Header from "../../components/Header";
import { Picker } from '@react-native-picker/picker';
import { Context as TrackContext } from "../../context/TrackContext";
import { Button, FlatList, ScrollView } from 'react-native';
import UpdateTrackPlaceHolder from "./components/UpdateTrackPlaceHolder";

const UpdateTrackScreen = ({ navigation }) => {
    const { state: { isFetching, hasError, area, activity }, fetchOrganization } = useContext(TrackContext);
    const { state: { profile } } = useContext(AuthContext);
    const [areaId, setAreaId] = useState();
    const [activityId, setActivityId] = useState("");

    const scrollViewRef = useRef();
    const [test, setTest] = useState();

    const refreshOrganization = () => {
        fetchOrganization({ organizationId: profile.organization.id });
    };

    const proceed = () => {
        navigation.navigate("UpdateQr", { areaId: areaId, activityId: activityId });
    };
    useEffect(() => {
        if (!isFetching && area != null && area.length > 0) {
            // setAreaId(area[0].id);
            // setActivityId(activity[0].id);
        }
    });

    let content = <UpdateTrackPlaceHolder></UpdateTrackPlaceHolder>;

    if (!isFetching && !hasError && area != null && area.length > 0) {
        content = (
            <View>
                <Picker
                    mode="dropdown"
                    onValueChange={(itemValue) =>
                        setTest(itemValue)}
                    selectedValue={test}>
                    <Picker.Item label="First Item" value="first" />
                    <Picker.Item label="asd" value="hi" />
                    <Picker.Item label="Cancel" value="cancel" />
                </Picker>
                <Text>Select Area</Text>
                <Picker
                    style={{ width: "100%" }}
                    mode="dropdown"
                    selectedValue={areaId}
                    onValueChange={(itemValue) =>
                        setAreaId(itemValue)}
                >
                    {area.length > 0 ? (
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
                    onValueChange={(itemValue) =>
                        setActivityId(itemValue)}
                >
                    {activity.length > 0 ? (
                        activity.map(item => {
                            return <Picker.Item label={item.name} value={item.id} />;
                        })
                    ) : (
                        <Picker.Item label="Loading..." value="0" />
                    )}
                </Picker>
                <Button title="PROCEED" onPress={proceed}></Button>
            </View>
        );
    }
    return (
        <SafeAreaView style={styles.container} >
            <NavigationEvents onWillFocus={refreshOrganization}></NavigationEvents>

            <Header title="Update Trail" navigation={navigation} onPress={() => { alert('More option here') }} ></Header>
            <ScrollView
                ref={scrollViewRef}
                showsVerticalScrollIndicator={false}
                style={styles.content}
            >
                {content}
            </ScrollView>


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