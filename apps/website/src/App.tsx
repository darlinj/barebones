import barebones from "/barebones.jpeg";
import "./App.css";
const clientId = import.meta.env.VITE_COGNITO_USERPOOL_CLIENT_ID;
const cognitoId = import.meta.env.VITE_COGNITO_USERPOOL_ID;

function App() {
  return (
    <>
      <div>
        <img src={barebones} className="logo" alt="Barebones logo" />
      </div>
      <p>hello</p>
      {clientId}
      {cognitoId}
    </>
  );
}

export default App;
