/* tslint:disable */
/* eslint-disable */
//  This file was automatically generated and should not be edited.

export type LambdaData = {
  __typename: "LambdaData",
  message: string,
};

export type PublicData = {
  __typename: "PublicData",
  id: string,
  name: string,
};

export type GetLambdaDataQueryVariables = {
};

export type GetLambdaDataQuery = {
  getLambdaData?:  {
    __typename: "LambdaData",
    message: string,
  } | null,
};

export type GetPublicDataQueryVariables = {
  id: string,
};

export type GetPublicDataQuery = {
  getPublicData?:  {
    __typename: "PublicData",
    id: string,
    name: string,
  } | null,
};