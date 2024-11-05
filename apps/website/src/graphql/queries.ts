/* tslint:disable */
/* eslint-disable */
// this is an auto generated file. This will be overwritten

import * as APITypes from "../API";
type GeneratedQuery<InputType, OutputType> = string & {
  __generatedQueryInput: InputType;
  __generatedQueryOutput: OutputType;
};

export const getData = /* GraphQL */ `query GetData($id: ID!) {
  getData(id: $id) {
    id
    name
    __typename
  }
}
` as GeneratedQuery<APITypes.GetDataQueryVariables, APITypes.GetDataQuery>;
export const getLambdaData = /* GraphQL */ `query GetLambdaData {
  getLambdaData {
    message
    __typename
  }
}
` as GeneratedQuery<
  APITypes.GetLambdaDataQueryVariables,
  APITypes.GetLambdaDataQuery
>;
export const getPublicData = /* GraphQL */ `query GetPublicData($id: ID!) {
  getPublicData(id: $id) {
    id
    name
    __typename
  }
}
` as GeneratedQuery<
  APITypes.GetPublicDataQueryVariables,
  APITypes.GetPublicDataQuery
>;
