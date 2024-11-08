import React, { useEffect, useState } from "react";
import { generateClient } from "aws-amplify/api";
import { Data } from "./API";
import { fetchAuthSession } from "@aws-amplify/auth";
import { onCreateData } from "./graphql/subscriptions";
import DataTableComponent from "./DataTableComponent";

const client = generateClient();

const DataTable: React.FC = () => {
  const [tableData, setTableData] = useState<string[]>([]);
  useEffect(() => {
    let subscription = { unsubscribe: () => {} };
    fetchAuthSession().then((token) => {
      console.log("getting credentials");
      subscription = client
        .graphql({
          query: onCreateData,
          authMode: "userPool",
          authToken: token.tokens?.accessToken.toString() || "",
        })
        .subscribe({
          next: (result: any) => {
            setTableData((previousTableData) => [
              ...previousTableData,
              result.data.onCreateData.message,
            ]);
            console.log(
              "New message received:",
              result.data.onCreateData.message
            );
          },
          error: (error: any) => console.warn(error),
        });
    });
    console.log("Running useEffect");

    return () => subscription.unsubscribe();
  }, []);

  return (
    <div>
      <DataTableComponent data={tableData} />
    </div>
  );
};

export default DataTable;
