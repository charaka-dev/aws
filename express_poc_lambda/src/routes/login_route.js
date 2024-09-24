// import express from 'express';
// import logger from '../util/xlogger.js';


// const loginRouter = express.Router();

// loginRouter.get('/status', (req, res) => {    //return success message
//     res.status(200).json({ message: 'Login successful' });
// });

// loginRouter.post('/login', (req, res) => {   //validate user credentials and return success or failure message
//    logger.info('User logged in: %s', req.body.username);
//     const { username, password } = req.body;
//     if (username === 'admin' && password === 'password') {
//         res.status(200).json({ message: 'Login successful' });
//     } else {
//         res.status(401).json({ message: 'Invalid credentials' });
//     }
// });

// export default loginRouter;
