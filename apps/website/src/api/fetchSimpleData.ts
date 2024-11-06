import { generateClient } from "aws-amplify/api";
import { GetLambdaDataQueryVariables, LambdaData } from "../API";
import { getLambdaData } from "../graphql/queries";
const client = generateClient();
import { fetchAuthSession } from "@aws-amplify/auth";

export const fetchSimpleData = async (
  variables: GetLambdaDataQueryVariables
): Promise<LambdaData | undefined | null> => {
  try {
    const response = await client.graphql({
      query: getLambdaData,
      variables,
      authMode: "userPool",
      authToken:
        (await fetchAuthSession()).tokens?.accessToken.toString() || "",
    });
    return response.data.getLambdaData;
  } catch (error) {
    console.error("Error fetching data:", error);
    throw error;
  }
};
