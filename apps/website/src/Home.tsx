import React, { useEffect, useState } from "react";
import barebones from "/barebones.jpeg";
import { fetchPublicData } from "./api/fetchPublicData";
import { fetchSimpleData } from "./api/fetchSimpleData";
import { getCurrentUser } from "@aws-amplify/auth";

const Home: React.FC = () => {
  const [publicData, setPublicData] = useState("");
  const [lambdaData, setLambdaData] = useState("");

  useEffect(() => {
    fetchPublicData({ id: "1" }).then((data) =>
      setPublicData(data?.name || "boo")
    );
    getCurrentUser()
      .then(() => {
        fetchSimpleData({ id: "1" }).then((resp) =>
          setLambdaData(resp?.message || "boo")
        );
      })
      .catch(() => console.log("Login to access this data"));
  }, []);
  return (
    <div>
      <img src={barebones} className="logo" alt="Barebones logo" />

      <h1>{publicData}</h1>
      <h1>{lambdaData}</h1>
    </div>
  );
};

export default Home;
