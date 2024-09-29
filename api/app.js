const express = require('express');

const zoomRouter = require('./routes/zoomRoute');
const cors = require('cors');
const app = express();

app.use(cors());

app.use(express.json());
// app.use(express.static(`${__dirname}/public`));

app.use('/api/v1/zoomBot', zoomRouter);

module.exports = app;