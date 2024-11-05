import React, { useEffect, useState } from "react";
import barebones from "/barebones.jpeg";

import { generateClient } from "aws-amplify/api";
import { GetPublicDataQueryVariables, PublicData } from "./API";
import { getPublicData } from "./graphql/queries";
const client = generateClient();

const Home: React.FC = () => {
  const [items, setItems] = useState("");

  const fetchPublicData = async (
    variables: GetPublicDataQueryVariables
  ): Promise<PublicData | undefined | null> => {
    try {
      const response = await client.graphql({
        query: getPublicData,
        variables,
      });
      console.log(response);
      return response.data.getPublicData;
    } catch (error) {
      console.error("Error fetching data:", error);
      throw error;
    }
  };

  useEffect(() => {
    fetchPublicData({ id: "1" }).then((data) => setItems(data?.name || "boo"));
  }, []);
  return (
    <div>
      <img src={barebones} className="logo" alt="Barebones logo" />

      <h1>{items}</h1>
    </div>
  );
};

export default Home;
