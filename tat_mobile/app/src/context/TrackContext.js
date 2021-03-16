import createDataContext from "./createDataContext";
import trackerApi from "../api/tracker";
import { AsyncStorage } from "react-native";
import moment from "moment";

const trackReducer = (state, action) => {
  switch (action.type) {
    case "save_tracks":
      return { isFetching: true, hasError: false };
    case "save_tracks_success":
      return { isFetching: false, hasError: false };
    case "save_tracks_failed":
      return { isFetching: false, hasError: true, message: action.message };
    case "fetch_tracks":
      return { isFetching: true, hasError: false };
    case "fetch_tracks_success":
      return { isFetching: false, hasError: false, trailList: action.payload };
    case "fetch_tracks_failed":
      return { isFetching: false, hasError: true, message: action.message, trailList: action.payload };
    case "fetch_organization":
      return { ...state, isFetching: true, hasError: false };
    case "fetch_organization_success":
      return { ...state, isFetching: false, hasError: false, area: action.area, activity: action.activity };
    case "fetch_organization_failed":
      return { ...state, isFetching: false, hasError: true, message: action.message, area: action.area, activity: action.activity };
    default:
      return state;
  }
};

const fetchOrganization = (dispatch) => async ({ organizationId }) => {
  dispatch({ type: "fetch_organization" });
  try {
    const response = await trackerApi.get("/areaByOrganization/" + organizationId);
    var area = response.data.data;
    const responseActivity = await trackerApi.get("/activityByOrganization/" + organizationId);
    var activity = responseActivity.data.data;
    dispatch({ type: "fetch_organization_success", area: area, activity: activity });
  } catch (err) {
    dispatch({ type: "fetch_organization_failed", message: err });
  }
};



const fetchTracks = (dispatch) => async ({ productId }) => {
  dispatch({ type: "fetch_tracks" });
  try {
    const response = await trackerApi.get("/trail/" + productId);
    var dataToFilter = response.data.data.trailInfoList.reverse();
    dispatch({ type: "fetch_tracks_success", payload: dataToFilter });
  } catch (err) {
    dispatch({ type: "fetch_tracks_failed", message: err });
  }
};

const createTrack = (dispatch) => async (name, locations) => {
  await trackerApi.post("/tracks", { name, locations });
};

// const saveTrack = (dispatch) => {
//   return async ({ location }) => {
//     try {
//       const patientId = await AsyncStorage.getItem("patient");
//       const userId = patientId;
//       const currentTime = Date.now();
//       const track = {
//         name: "App Client",
//         patientId: patientId,
//         userId: userId,
//         timestamp: currentTime,
//         date: moment(currentTime).format("DD/MM/YYYY"),
//         time: moment(currentTime).format("HH:mm:ss"),
//         latitude: location.latitude,
//         longitude: location.longitude,
//         altitude: location.altitude,
//         accuracy: location.accuracy,
//         heading: location.heading,
//         speed: location.speed,
//       };
//         console.log(track);

//       await trackerApi.post("/track", track);
//     } catch (err) {
//       console.log(err.message);
//     }
//   };
// };

const saveTrack = (dispatch) => {
  return async ({ productId, activityId, areaId, gps }) => {
    dispatch({ type: "save_tracks" });

    try {
      const profileId = await AsyncStorage.getItem("profileId");
      const data = {
        product: {
          id: productId
        },
        activity: {
          id: activityId
        },
        area: {
          id: areaId
        },
        profile: {
          id: profileId
        },
        gps: gps,
        remarks: "",
        customJsonData: ""

      };

      await trackerApi.post("/trail", data);

      dispatch({ type: "save_tracks_success" });

    } catch (err) {
      console.log(err.message);
      dispatch({ type: "save_tracks_failed" , message: err });
    }
  };
};

export const { Provider, Context } = createDataContext(
  trackReducer,
  { fetchTracks, fetchOrganization, createTrack, saveTrack },
  { isFetching: false, hasError: false, message: "", trailList: null, area: [], activity: [] }
);
