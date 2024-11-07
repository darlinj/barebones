/* tslint:disable */
/* eslint-disable */
// this is an auto generated file. This will be overwritten

import * as APITypes from "../API";
type GeneratedMutation<InputType, OutputType> = string & {
  __generatedMutationInput: InputType;
  __generatedMutationOutput: OutputType;
};

export const addData = /* GraphQL */ `mutation AddData($message: String!) {
  addData(message: $message) {
    message
    __typename
  }
}
` as GeneratedMutation<
  APITypes.AddDataMutationVariables,
  APITypes.AddDataMutation
>;
