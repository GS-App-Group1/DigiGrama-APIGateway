import {Schema, model } from "mongoose";

const userRequestSchema = new Schema({
  _id: String,
  nic: String,
  email: String,
  address: String,
  civilStatus: String,
  presentOccupation: String,
  reason: String,
  gsNote: String,
  gsDivision: String,
  requestTime: String, 
  status: String
});

const UserRequest = model('UserRequest', userRequestSchema, 'UserRequest');
export default UserRequest;