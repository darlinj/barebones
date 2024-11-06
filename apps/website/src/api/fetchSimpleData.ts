import { generateClient } from "aws-amplify/api";
import { GetSimpleDataQueryVariables, Data } from "../API";
import { getSimpleData } from "../graphql/queries";
const client = generateClient();
import { fetchAuthSession } from "@aws-amplify/auth";

export const fetchSimpleData = async (
  variables: GetSimpleDataQueryVariables
): Promise<Data | undefined | null> => {
  try {
    const response = await client.graphql({
      query: getSimpleData,
      variables,
      authMode: "userPool",
      authToken:
        (await fetchAuthSession()).tokens?.accessToken.toString() || "",
    });
    return response.data.getSimpleData;
  } catch (error) {
    console.error("Error fetching data:", error);
    throw error;
  }
};
