import React, { useEffect, useState } from "react";
import barebones from "/barebones.jpeg";
import { fetchPublicData } from "./api/fetchPublicData";
import { fetchData } from "./api/fetchData";
import { getCurrentUser } from "@aws-amplify/auth";

const Home: React.FC = () => {
  const [publicData, setPublicData] = useState("");
  const [data, setData] = useState("");

  useEffect(() => {
    fetchPublicData({ id: "1" }).then((data) =>
      setPublicData(data?.name || "boo")
    );
    getCurrentUser()
      .then(() => {
        fetchData({ id: "1" }).then((data) => setData(data?.name || "boo"));
      })
      .catch(() => console.log("Login to access this data"));
  }, []);
  return (
    <div>
      <img src={barebones} className="logo" alt="Barebones logo" />

      <h1>{publicData}</h1>
      <h1>{data}</h1>
    </div>
  );
};

export default Home;
