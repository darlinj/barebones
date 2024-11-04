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
      <div>
        <img src={barebones} className="logo" alt="Barebones logo" />
      </div>
    </>
  );
};

export default App;
