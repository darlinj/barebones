/* tslint:disable */
/* eslint-disable */
//  This file was automatically generated and should not be edited.

export type Data = {
  __typename: "Data",
  message: string,
};

export type PublicData = {
  __typename: "PublicData",
  id: string,
  name: string,
};

export type GetSimpleDataQueryVariables = {
};

export type GetSimpleDataQuery = {
  getSimpleData?:  {
    __typename: "Data",
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
