/* tslint:disable */
/* eslint-disable */
// this is an auto generated file. This will be overwritten

import * as APITypes from "../API";
type GeneratedQuery<InputType, OutputType> = string & {
  __generatedQueryInput: InputType;
  __generatedQueryOutput: OutputType;
};

export const getSimpleData = /* GraphQL */ `query GetSimpleData {
  getSimpleData {
    message
    __typename
  }
}
` as GeneratedQuery<
  APITypes.GetSimpleDataQueryVariables,
  APITypes.GetSimpleDataQuery
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
