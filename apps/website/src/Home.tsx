import React, { useEffect, useState } from "react";
import barebones from "/barebones.jpeg";
import { generateClient, GraphQLResult } from "aws-amplify/api";

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

  useEffect(() => {
    const apiCall = async () => {
      try {
        const result = (await client.graphql({
          query: listItems,
        })) as GraphQLResult<{ getPublicData: { name: string } }>;

        setItems(result.data?.getPublicData?.name);
      } catch (error) {
        console.log(error);
      }
    };
    apiCall();
  }, []);
  return (
    <div>
      <img src={barebones} className="logo" alt="Barebones logo" />

      <h1>{items}</h1>
    </div>
  );
};

export default Home;
