exports.handler = async (event) => {
  return {
    statusCode: 200,
    body: JSON.stringify({
      message: "This message can only be seen if you are logged in",
    }),
  };
};
