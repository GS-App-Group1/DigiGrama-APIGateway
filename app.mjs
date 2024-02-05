import mongoose from 'mongoose';
import express from 'express';
import config from "./config.mjs"
import fs from "fs"
import path from "path"
import exportHTMLtoPDF from './utils/utils.mjs';
import UserRequest from './model/UserRequest.mjs';

// Create the express app
const app = express()

const uri = `mongodb+srv://${config.username}:${config.password}@digigrama.pgauwpq.mongodb.net/${config.database}?retryWrites=true&w=majority`;
const clientOptions = { serverApi: { version: '1', strict: true, deprecationErrors: true } };

// Connect to MongoDB
mongoose.connect(uri, clientOptions)
.then(() => console.log('Connected to MongoDB'))
.catch(err => console.error('Failed to connect to MongoDB:', err));

// Define a route to find an userRequest by name
app.get('/certificate', async (req, res) => {
    try {
      const requestId = req.query.requestId;
      if (!requestId) {
        return res.status(400).json({ error: 'requestId parameter is required' });
      }
      const dataObj = await UserRequest.findOne({ "_id": requestId });
      if (!dataObj) {
        return res.status(404).json({ error: 'Certificate request data not found' });
      }
      dataObj['date'] = new Date().toDateString();
      const outputFilename = `./certificates/${requestId}.pdf`

      if(fs.existsSync(outputFilename)){
        fs.unlinkSync(outputFilename)
      }

      exportHTMLtoPDF(dataObj, outputFilename, res)

    } catch (err) {
      res.status(500).json({ error: err.message });
    }
  });

// Liveness route
app.get('/liveness', (req, res) => {
    res.sendStatus(200);
  });

// Readiness route
app.get('/readiness', async (req, res) =>{
    try {
        const dataObj = await UserRequest.findOne({ "_id": requestId });
        if (!dataObj) {
            return res.status(404).json({ error: 'Certificate request data not found' });
        }

        res.sendStatus(200);
    } catch (error) {
        res.status(500).json({ error: err.message });
    }
})

export default app;