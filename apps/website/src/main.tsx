import { StrictMode } from "react";
import { createRoot } from "react-dom/client";
import "./index.css";
import App from "./App.tsx";
import { BrowserRouter } from "react-router-dom";
import { Authenticator } from "@aws-amplify/ui-react";
import { Amplify } from "aws-amplify";

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

createRoot(document.getElementById("root")!).render(
  <StrictMode>
    <Authenticator.Provider>
      <BrowserRouter>
        <App />
      </BrowserRouter>
    </Authenticator.Provider>
  </StrictMode>
);
