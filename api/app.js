const express = require('express');

const zoomRouter = require('./routes/zoomRoute');
const app = express();

app.use(express.json());
// app.use(express.static(`${__dirname}/public`));

app.use('/api/v1/zoomBot', zoomRouter);

module.exports = app;