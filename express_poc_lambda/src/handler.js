'use strict';

module.exports.hello = async (event) => {
  return {
    statusCode: 200,
    body: JSON.stringify({
      message: 'Hello, World!',
      input: event,
    }, null, 2)
  };
};

module.exports.saveTicket = async (event) => {
  const body = JSON.parse(event.body);
  // Here you would typically save the user to a database
  return {
    statusCode: 201,
    body: JSON.stringify({
      message: 'User created successfully',
      user: body,
    }, null, 2)
  };
};