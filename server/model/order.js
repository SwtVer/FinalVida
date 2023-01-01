const mongoose = require("mongoose");
const { productSchema } = require("./product");

const orderSchema = mongoose.Schema({
  products: [
    {
      product: productSchema,
      quantity: {
        type: Number,
        required: true,
      },
    },
  ],
  totalPrice: {
    type: Number,
    required: true,
  },
  address: {
    type: String,
    required: false,
  },
  userId: {
    required: true,
    type: String,
  },
  orderedAt: {
    type: Number,
    required: true,
  },
  status: {
    type: Number,
    default: 0,
  },
  cancelstatus: {
    type: Number,
    default: 0,
  },
  category:{
    type:String,
    required:true,
 },
 images:[
  {
      type: String,
      //required:false,
  },
],
});

const Order = mongoose.model("Order", orderSchema);
module.exports = Order;