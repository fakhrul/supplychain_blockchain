import createDataContext from "./createDataContext";
import trackerApi from "../api/tracker";
import { AsyncStorage } from "react-native";
import moment from "moment";

const trackReducer = (state, action) => {
  switch (action.type) {
    case "fetch_tracks":
      return action.payload;
    case "fetch_tracks_by_patient_by_date":
      return action.tracksByPationByDate;
    default:
      return state;
  }
};

const fetchTracks = (dispatch) => async () => {
  const patientId = await AsyncStorage.getItem("patient");
  const response = await trackerApi.get("/trackByPatient/" + patientId);
  dispatch({ type: "fetch_tracks", payload: response.data });
};

// const fetchTracksByPatientIdByDate = (dispatch) => async (patientId, date) => {
//   const dateUri = encodeURIComponent(date);
//   log.console("fetchTracksByPatientIdByDate" + dateUri);
//   // const response = await trackerApi.get("/tracksByPatientIdByDate/" + patientId + "/" + dateUri);
//   // dispatch({ type: "fetch_tracks_by_patient_by_date", payload: response.data });

// };

const fetchTracksByPatientIdByDate = (dispatch) => async ({ date }) => {
  const dateUri = encodeURIComponent(date);
  const patientId = await AsyncStorage.getItem("patient");
  console.log(dateUri);

  const response = await trackerApi.get(
    "/tracksByPatientIdByDate/" + patientId + "/" + dateUri
  );
  dispatch({ type: "fetch_tracks_by_patient_by_date", tracksByPationByDate: response.data });

  // return async ({ patientId, date }) => {
  //   try {
  //     const dateUri = encodeURIComponent(date);
  //     log.console("fetchTracksByPatientIdByDate" + dateUri);
  //   } catch (err) {}
  // };
};

const createTrack = (dispatch) => async (name, locations) => {
  await trackerApi.post("/tracks", { name, locations });
};

// const signup = (dispatch) => {
//   return async ({ email, password }) => {
//     try {
//       const response = await trackerApi.post("/signup", { email, password });
//       console.log(response.data);
//       await AsyncStorage.setItem("token", response.data.token);
//       // await AsyncStorage.getItem('token');
//       dispatch({ type: "signup", payload: response.data.token });

//       navigate("Main");
//     } catch (err) {
//       console.log(err.response.data);
//       dispatch({ type: "add_error", payload: "Something went wrong" });
//     }
//   };
// };

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
  { fetchTracks, fetchTracksByPatientIdByDate, createTrack, saveTrack },
  []
);
