import { generateClient } from "aws-amplify/api";
import { GetDataQueryVariables, Data } from "../API";
import { getData } from "../graphql/queries";
// import { useAuthenticator } from "@aws-amplify/ui-react";
const client = generateClient();
import { fetchAuthSession } from "@aws-amplify/auth";

export const fetchData = async (
  variables: GetDataQueryVariables
): Promise<Data | undefined | null> => {
  // const { user } = useAuthenticator((context) => [context.user]);
  try {
    const response = await client.graphql({
      query: getData,
      variables,
      authMode: "userPool",
      authToken:
        (await fetchAuthSession()).tokens?.accessToken.toString() || "",
    });
    return response.data.getData;
  } catch (error) {
    console.error("Error fetching data:", error);
    throw error;
  }
};
