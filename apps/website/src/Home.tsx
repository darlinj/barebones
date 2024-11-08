import React, { useEffect, useState } from "react";
import barebones from "/barebones.jpeg";
import { fetchPublicData } from "./api/fetchPublicData";
import { fetchSimpleData } from "./api/fetchSimpleData";
import { getCurrentUser } from "@aws-amplify/auth";
import SimpleForm from "./SimpleForm";
import { addDataMutation } from "./api/addData";
import DataTable from "./DataTable";

const Home: React.FC = () => {
  const [loggedIn, setloggedIn] = useState(false);
  const [publicData, setPublicData] = useState("");
  const [privateData, setPrivateData] = useState("");

  useEffect(() => {
    getCurrentUser()
      .then(() => {
        setloggedIn(true);
      })
      .catch(() => setloggedIn(false));
    fetchPublicData({ id: "1" }).then((data) =>
      setPublicData(data?.name || "Failed to fetch data")
    );
  }, []);

  useEffect(() => {
    if (!loggedIn) return;
    fetchSimpleData({ id: "1" }).then((resp) =>
      setPrivateData(resp?.message || "Failed to fetch data")
    );
  }, [loggedIn]);

  const handleFormSubmit = (input: string) => {
    console.log(input);
    getCurrentUser()
      .then(() => {
        addDataMutation({ message: input }).then((resp) =>
          console.log(`Successfully added data: ${resp?.message}`)
        );
      })
      .catch(() => console.log("Login to access this data"));
  };

  return (
    <div>
      <img src={barebones} className="logo" alt="Barebones logo" />

      <h1>{publicData}</h1>
      {loggedIn && (
        <>
          <h1>{privateData}</h1>
          <DataTable />
          <SimpleForm handleFormSubmit={handleFormSubmit} />
        </>
      )}
    </div>
  );
};

export default Home;
