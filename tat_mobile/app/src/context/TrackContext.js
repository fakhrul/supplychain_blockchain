import createDataContext from "./createDataContext";
import trackerApi from "../api/tracker";
import { AsyncStorage } from "react-native";
import moment from "moment";

const trackReducer = (state, action) => {
  switch (action.type) {
    case "fetch_tracks":
      return action.payload;
      break;
    case "fetch_organization":
      return {area: action.area, activity: action.activity};
      break;
    default:
      return state;
  }
};

const fetchOrganization = (dispatch) => async ({ organizationId }) => {
  const response = await trackerApi.get("/areaByOrganization/" + organizationId);
  var area = response.data.data;
  const responseActivity = await trackerApi.get("/activityByOrganization/" + organizationId);
  var activity = responseActivity.data.data;
  dispatch({ type: "fetch_organization", area: area, activity: activity });
};

const fetchTracks = (dispatch) => async ({ productId }) => {
  const response = await trackerApi.get("/trail/" + productId);
  var dataToFilter = response.data.data.trailInfoList.reverse();
  dispatch({ type: "fetch_tracks", payload: dataToFilter });
};

const createTrack = (dispatch) => async (name, locations) => {
  await trackerApi.post("/tracks", { name, locations });
};

const saveTrack = (dispatch) => {
  return async ({ location }) => {
    try {
      //   console.log("saveTrack");
      //   console.log(location);
      const patientId = await AsyncStorage.getItem("patient");
      const userId = patientId;
      //   console.log(patientId);
      //   console.log('asdadasd');
      const currentTime = Date.now();
      const track = {
        name: "App Client",
        patientId: patientId,
        userId: userId,
        timestamp: currentTime,
        date: moment(currentTime).format("DD/MM/YYYY"),
        time: moment(currentTime).format("HH:mm:ss"),
        latitude: location.latitude,
        longitude: location.longitude,
        altitude: location.altitude,
        accuracy: location.accuracy,
        heading: location.heading,
        speed: location.speed,
      };
      //   console.log(track);

      await trackerApi.post("/track", track);
    } catch (err) {
      console.log(err.message);
    }
  };
};

export const { Provider, Context } = createDataContext(
  trackReducer,
  { fetchTracks, fetchOrganization, createTrack, saveTrack },
  { trailList: null, area: [], activity: [] }
);
