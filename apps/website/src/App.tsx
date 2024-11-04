import barebones from "/barebones.jpeg";
import "./App.css";
import { Amplify } from "aws-amplify";
import {
  signIn,
  fetchAuthSession,
  confirmSignIn,
  signOut,
} from "aws-amplify/auth";
import NavBar from "./NavBar";
import { Route, Routes } from "react-router-dom";
import Home from "./home";
import Login from "./Login";

const clientId = import.meta.env.VITE_COGNITO_USERPOOL_CLIENT_ID;
const cognitoId = import.meta.env.VITE_COGNITO_USERPOOL_ID;
// const region = import.meta.env.VITE_REGION;

Amplify.configure({
  Auth: {
    Cognito: {
      userPoolId: cognitoId,
      userPoolClientId: clientId,
      loginWith: { email: true },
    },
  },
});

const App: React.FC = () => {
  return (
    <>
      <NavBar />
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/login" element={<Login />} />
      </Routes>
    </>
  );
};

export default App;
