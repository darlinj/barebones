import React from "react";
import barebones from "/barebones.jpeg";

const Home: React.FC = () => {
  return (
    <div>
      <img src={barebones} className="logo" alt="Barebones logo" />
    </div>
  );
};

export default Home;
