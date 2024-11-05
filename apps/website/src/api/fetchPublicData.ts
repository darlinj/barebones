import { generateClient } from "aws-amplify/api";
import { GetPublicDataQueryVariables, PublicData } from "../API";
import { getPublicData } from "../graphql/queries";
const client = generateClient();

export const fetchPublicData = async (
  variables: GetPublicDataQueryVariables
): Promise<PublicData | undefined | null> => {
  try {
    const response = await client.graphql({
      query: getPublicData,
      variables,
    });
    return response.data.getPublicData;
  } catch (error) {
    console.error("Error fetching data:", error);
    throw error;
  }
};
