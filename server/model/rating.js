const mongoose = require("mongoose");

const ratingSchema = mongoose.Schema({
  userId: {//user cant change the rating again. have to implement logic to delete the previous rating and change it to new rating
    type: String,
    required: true,
  },
  rating: {
    type: Number,
    required: true,
  },
});
//not creating a model out of it. jsut creating a structure i.e not creating a separate schema table
module.exports = ratingSchema;