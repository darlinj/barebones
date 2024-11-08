import React, { useEffect, useMemo, useState } from "react";
import { generateClient } from "aws-amplify/api";
import { OnCreateDataSubscription } from "./API";
import { fetchAuthSession } from "@aws-amplify/auth";
import { onCreateData } from "./graphql/subscriptions";
import DataTableComponent from "./DataTableComponent";

const client = generateClient();

const DataTable: React.FC = () => {
  const [tableData, setTableData] = useState<string[]>([]);

  const subscription = useMemo(() => {
    let subscription = { unsubscribe: () => {} };
    fetchAuthSession().then((token) => {
      subscription = client
        .graphql({
          query: onCreateData,
          authMode: "userPool",
          authToken: token.tokens?.accessToken.toString() || "",
        })
        .subscribe({
          next: (result: { data: OnCreateDataSubscription }) => {
            setTableData((previousTableData) => [
              ...previousTableData,
              result?.data?.onCreateData?.message || "Error",
            ]);
          },
          error: (error: any) => console.warn(error),
        });
    });
    return subscription;
  }, []);

  useEffect(() => {
    return () => subscription.unsubscribe();
  }, []);

  return (
    <div>
      <DataTableComponent data={tableData} />
    </div>
  );
};

export default DataTable;
