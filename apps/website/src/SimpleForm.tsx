import React, { useState, ChangeEvent, FormEvent } from "react";
import { TextField, Button, Box } from "@mui/material";

interface SimpleFormProps {
  handleFormSubmit: (value: string) => void;
}

const SimpleForm: React.FC<SimpleFormProps> = ({ handleFormSubmit }) => {
  const [inputValue, setInputValue] = useState<string>("");

  const handleInputChange = (event: ChangeEvent<HTMLInputElement>) => {
    setInputValue(event.target.value);
  };

  const handleSubmit = (event: FormEvent<HTMLFormElement>) => {
    event.preventDefault();
    handleFormSubmit(inputValue);
  };

  return (
    <Box
      component="form"
      onSubmit={handleSubmit}
      sx={{
        display: "flex",
        flexDirection: "column",
        alignItems: "center",
        gap: 2,
      }}
    >
      <TextField
        label="Enter text"
        variant="outlined"
        value={inputValue}
        onChange={handleInputChange}
        required
      />
      <Button type="submit" variant="contained" color="primary">
        Submit
      </Button>
    </Box>
  );
};

export default SimpleForm;
