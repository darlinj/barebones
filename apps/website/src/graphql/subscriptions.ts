/* tslint:disable */
/* eslint-disable */
// this is an auto generated file. This will be overwritten

import * as APITypes from "../API";
type GeneratedSubscription<InputType, OutputType> = string & {
  __generatedSubscriptionInput: InputType;
  __generatedSubscriptionOutput: OutputType;
};

export const onCreateData = /* GraphQL */ `subscription OnCreateData {
  onCreateData {
    message
    __typename
  }
}
` as GeneratedSubscription<
  APITypes.OnCreateDataSubscriptionVariables,
  APITypes.OnCreateDataSubscription
>;
