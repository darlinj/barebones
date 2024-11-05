import React from "react";
import { Authenticator, useAuthenticator } from "@aws-amplify/ui-react";
import "@aws-amplify/ui-react/styles.css";

const Login: React.FC = () => {
  // const { user, signOut } = useAuthenticator((context) => [context.user]);
  return (
    <Authenticator>
      {/* {({ signOut, user }) => (
        <div>
          <h1>Hello {user?.username}</h1>
          <button onClick={signOut}>Sign out</button>
        </div>
      )} */}
    </Authenticator>
  );
};

export default Login;
