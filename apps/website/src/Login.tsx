import React, { useEffect } from "react";
import { Authenticator, useAuthenticator } from "@aws-amplify/ui-react";
import "@aws-amplify/ui-react/styles.css";
import { useNavigate } from "react-router-dom";

const Login: React.FC = () => {
  const navigate = useNavigate();
  const { user } = useAuthenticator((context) => [context.user]);
  useEffect(() => {
    if (user) {
      navigate("/");
    }
  }, [user, navigate]);
  return <Authenticator />;
};

export default Login;
