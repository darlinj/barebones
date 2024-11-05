import React, { useEffect, useState } from "react";
import barebones from "/barebones.jpeg";
import { generateClient, GraphQLResult } from "aws-amplify/api";
// import { graphqlOperation } from "aws-amplify";

import { GetPublicDataQuery, PublicData } from "./API";

import { getPublicData } from "./graphql/queries";

const client = generateClient();

export const listItems = /* GraphQL */ `
  query MyQuery {
    getPublicData(id: "2") {
      name
    }
  }
`;

const Home: React.FC = () => {
  const [items, setItems] = useState("");

  const fetchPublicData = async (): Promise<GetPublicDataQuery> => {
    try {
      const response = (await client.graphql({
        query: getPublicData,
        variables: { id: "1" },
      })) as {
        data: GetPublicDataQuery;
      };
      return response.data;
    } catch (error) {
      console.error("Error fetching todos:", error);
      throw error;
    }
  };

  useEffect(() => {
    fetchPublicData().then((data) =>
      setItems(data?.getPublicData?.name || "boo")
    );
  }, []);
  return (
    <div>
      <img src={barebones} className="logo" alt="Barebones logo" />

      <h1>{items}</h1>
    </div>
  );
};

export default Home;
