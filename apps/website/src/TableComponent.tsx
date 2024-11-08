import React from "react";
import { DataGrid, GridColDef, GridRowsProp } from "@mui/x-data-grid";
import { Box } from "@mui/material";

interface DataTableProps {
  data: string[];
}

const TableComponent: React.FC<DataTableProps> = ({ data }) => {
  const rows: GridRowsProp = data.map((item, index) => ({
    id: index,
    value: item,
  }));

  const columns: GridColDef[] = [
    { field: "id", headerName: "ID", width: 90 },
    { field: "value", headerName: "Value", width: 150 },
  ];

  return (
    <Box sx={{ height: 400, width: "100%" }}>
      <DataGrid rows={rows} columns={columns} pageSize={5} />
    </Box>
  );
};

export default TableComponent;
