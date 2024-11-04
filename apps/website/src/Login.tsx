import React from "react";
import barebones from "/barebones.jpeg";

const Login: React.FC = () => {
  return (
    <div>
      <h1>Login</h1>
      <img src={barebones} className="logo" alt="Barebones logo" />
    </div>
  );
};

export default Login;
