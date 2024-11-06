import "./App.css";
import NavBar from "./NavBar";
import { Route, Routes } from "react-router-dom";
import Home from "./Home";
import Login from "./Login";

const App: React.FC = () => {
  return (
    <>
      <NavBar />
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/login" element={<Login />} />
      </Routes>
    </>
  );
};

export default App;
