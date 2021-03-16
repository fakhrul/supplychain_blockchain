import React, { useContext, useState } from "react";
import { View, Text, StyleSheet, FlatList } from "react-native";
import {
    SafeAreaView,
    withNavigationFocus,
    NavigationEvents,
} from "react-navigation";
import { Context as TrackContext } from "../context/TrackContext";
import MapView, { Polyline } from "react-native-maps";
import { ListItem } from "react-native-elements";
import { Alert } from "react-native";
import { Ionicons, FontAwesome } from "@expo/vector-icons";

import { InputCustom, ActionButtonCustom } from "../components";

var moment = require("moment");

const ProductTrailScreen = ({ navigation }) => {
    const { state: { isFetching, hasError, message, trailList },  fetchTracks } = useContext(TrackContext);
    const productId = navigation.getParam("productId");

    const refreshTracks = () => {
        fetchTracks({ productId });
    };

    const renderDetail = (post) => {
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
                            <Text style={styles.name}>{post.organization_name}</Text>
                            <Text style={styles.timestamp}>
                                Date: {moment(post.createdDate * 1000).format("DD/MM/YYYY HH:mm:ss")}
                            </Text>
                            <Text >Trail Id: {post.id}</Text>
                            <Text >Product: {post.product_name}</Text>
                            <Text >Organization: {post.organization_name}</Text>
                            <Text >Area: {post.area.name}</Text>
                            <Text >Activity: {post.activity.name}</Text>
                            <Text >GPS: {post.gps}</Text>
                        </View>
                    </View>
                </View>
            </View>
        );
    };

    return (
        <SafeAreaView SafeAreaView style={styles.container} >
            <NavigationEvents onWillFocus={refreshTracks}></NavigationEvents>
            {isFetching == true
                ? (<Text>isFetching = true</Text>)
                : (<Text>isFetching = false</Text>)
            }
            {hasError == true
                ? (<Text>hasError = true</Text>)
                : (<Text>hasError = false</Text>)
            }
            <Text>Message: {message}</Text>
            <Text>Product Id: {productId}</Text>
            <FlatList
                data={trailList}
                keyExtractor={(item) => item.id}
                renderItem={({ item }) => renderDetail(item)}
            ></FlatList>
            <ActionButtonCustom title="REFRESH" onPress={refreshTracks} ></ActionButtonCustom>
        </SafeAreaView >
    );
};

const styles = StyleSheet.create({
    container: {
        flex: 1,
    },
    map: {
        height: 300,
    },
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

export default ProductTrailScreen;
