const mongoose = require('mongoose');
//const ratingSchema = require('./rating');


const subscriptionSchema=mongoose.Schema({
 
 description:{
    type:String,
    required:true,
    trim:true,
 },
 userId: {
   required: true,
   type: String,
 },
 //array of images
 images:[
    {
        type: String,
        required:true,
    },
 ],
 
 
 category:{
    type:String,
    required:true,
 },
 orderedAt: {
   type: String,
   required: true,
 },
 
 
 
//array of objects
 //ratings:[ratingSchema],

});
const Subscription=mongoose.model("Subscription",subscriptionSchema);
module.exports={Subscription,subscriptionSchema};