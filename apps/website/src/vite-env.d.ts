/// <reference types="vite/client" />

interface ImportMetaEnv {
  readonly VITE_REGION: string;
  readonly VITE_COGNITO_USERPOOL_ID: string;
  readonly VITE_COGNITO_USERPOOL_CLIENT_ID: string;
  readonly VITE_GRAPHQL_API: string;
  readonly VITE_API_KEY: string;
}
