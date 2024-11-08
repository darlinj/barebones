import { generateClient } from "aws-amplify/api";
import { AddDataMutationVariables, Data } from "../API";
import { fetchAuthSession } from "@aws-amplify/auth";
import { addData } from "../graphql/mutations";

const client = generateClient();

export const addDataMutation = async (
  variables: AddDataMutationVariables
): Promise<Data | undefined | null> => {
  try {
    const response = await client.graphql({
      query: addData,
      variables,
      authMode: "userPool",
      authToken:
        (await fetchAuthSession()).tokens?.accessToken.toString() || "",
    });
    return response.data.addData;
  } catch (error) {
    console.error("Error fetching data:", error);
    throw error;
  }
};
