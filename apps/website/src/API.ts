/* tslint:disable */
/* eslint-disable */
//  This file was automatically generated and should not be edited.

export type Data = {
  __typename: "Data",
  id: string,
  name: string,
};

export type LambdaData = {
  __typename: "LambdaData",
  message: string,
};

export type PublicData = {
  __typename: "PublicData",
  id: string,
  name: string,
};

export type GetDataQueryVariables = {
  id: string,
};

export type GetDataQuery = {
  getData?:  {
    __typename: "Data",
    id: string,
    name: string,
  } | null,
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
