const express = require('express');
const adminRouter = express.Router();
const admin= require('../middlewares/admin');
const {Product} = require('../model/product');
const {Subscription} = require("../model/subscription");
const Order = require("../model/order");
const User = require("../model/user");
//const { PromiseProvider } = require("mongoose");

//Add product
 adminRouter.post('/admin/add-product',admin,async(req,res)=>{
    try{
        //name should match with that in product.dart
       const{name,description,images,quantity,price,category}=req.body;
       // let so that these fields are changed
       let product = new Product({
        name,
        description,
        images,
        quantity,
        price,
        category,
        
    
    });
    product = await product.save();
    res.json(product);
    }catch(e){
        res.status(500).json({
            error:e.message
        });
    }
 });
 // Get all products
 adminRouter.get('/admin/get-products',admin,async(req,res)=>{
  try{
   const products= await Product.find({});
   
   res.json(products);
   
   
  
  
  }catch(e){
    res.status(500).json({error:e.message});
  }
 });

 //delete products
 adminRouter.post('/admin/delete-product',admin,async(req,res)=>{
   try{
    const {id}=req.body;
    let product = await Product.findByIdAndDelete(id);

    res.json(product);

   }catch(e){
    res.status(500).json({error:e.message});
  }
 })
 //get orders
 adminRouter.get("/admin/get-orders", admin, async (req, res) => {
  try {
    const orders = await Order.find({});
    res.json(orders);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});
//change order status
adminRouter.post("/admin/change-order-status", admin, async (req, res) => {
  try {
    const { id, status } = req.body;
    let order = await Order.findById(id);
    order.status = status;
    order = await order.save();
    res.json(order);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});
//cancel order status
adminRouter.post("/admin/cancel-status", admin, async (req, res) => {
  try {
    const { id, cancelstatus } = req.body;
    let order = await Order.findById(id);
    order.cancelstatus = cancelstatus;
    order = await order.save();
    res.json(order);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});
//admin get subscription
adminRouter.get("/admin/get-subscription", admin, async (req, res) => {
  try {
    const orders = await Subscription.find({});
    res.json(orders);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});
//total number of collection
adminRouter.get("/admin/total", admin, async (req, res) => {
  try{
    let userCount = 0;
    let productCount = 0;
    let orderCount = 0;
    let subscriptionCount = 0;
    const users = await User.find({});
    const products = await Product.find({});
    const orders = await Order.find({});
    const subscriptions = await Subscription.find({});
    
    userCount=users.length;
    productCount=products.length;
    orderCount=orders.length;
    subscriptionCount=subscriptions.length;
    let collection = {
      userCount,
      productCount,
      orderCount,
      subscriptionCount
    };
    console.log(collection)

    res.json(collection);

  }catch (e) {
    res.status(500).json({ error: e.message });
  }
});
//total earnings
adminRouter.get("/admin/analytics", admin, async (req, res) => {
  try {
    const orders = await Order.find({});
    let totalEarnings = 0;

    for (let i = 0; i < orders.length; i++) {
      for (let j = 0; j < orders[i].products.length; j++) {
        totalEarnings +=
          orders[i].products[j].quantity * orders[i].products[j].product.price;
      }
    }
    // CATEGORY WISE ORDER FETCHING
    let homeopathyEarnings = await fetchCategoryWiseProduct("Homeopathy");
    let allopathyEarnings = await fetchCategoryWiseProduct("Allopathy");
    let ayurvedicEarnings = await fetchCategoryWiseProduct("Ayurvedic");
    let otcEarnings = await fetchCategoryWiseProduct("OTC Product");
    

    let earnings = {
      totalEarnings,
      homeopathyEarnings,
      allopathyEarnings,
      ayurvedicEarnings,
      otcEarnings,
      
    };
    console.log(earnings)
    res.json(earnings);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});
//creating call back function
async function fetchCategoryWiseProduct(category) {
  let earnings = 0;
  let categoryOrders = await Order.find({
    "products.product.category": category,
  });
  //console.log(categoryOrders);

  for (let i = 0; i < categoryOrders.length; i++) {
    for (let j = 0; j < categoryOrders[i].products.length; j++) {
      earnings +=
        categoryOrders[i].products[j].quantity *
        categoryOrders[i].products[j].product.price;
    }
  }
  return earnings;
}
//total subsription
adminRouter.get("/admin/sub-analytics", admin, async (req, res) => {
  try {
    
    const one = await Subscription.find({category:'One(1)-Month'});
    const two = await Subscription.find({category:'Two(2)-Month'});
    const three = await Subscription.find({category:'Three(3)-Month'});
    //console.log(subscription.length);
    
    //let totalEarnings = 0;

    //for (let i = 0; i < subscription.length; i++) {
      //for (let j = 0; j < orders[i].products.length; j++) {
       // totalEarnings +=
          //orders[i].products[j].quantity * orders[i].products[j].product.price;
     // }
    //}
    // CATEGORY WISE ORDER FETCHING
    let oneMonth = one.length;// await fetchCategoryWiseSubscription("One(1)-Month");
    let twoMonth =two.length; //await fetchCategoryWiseSubscription("Two(2)-Month");
    let threeMonth = three.length;//await fetchCategoryWiseSubscription("Three(3)-Month");
    //let otcEarnings = await fetchCategoryWiseProduct("OTC Product");
    

    let subb = {
      //totalEarnings,
     oneMonth,
     twoMonth,
     threeMonth
     // otcEarnings,
      
    };
    console.log(subb)
    res.json(subb);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});


//delete order
adminRouter.post('/admin/delete-order',admin,async(req,res)=>{
  try{
   const {id}=req.body;
   let product = await Order.findByIdAndDelete(id);

   res.json(product);

  }catch(e){
   res.status(500).json({error:e.message});
 }
});

//creating call back function
/*async function fetchCategoryWiseSubscription(category) {
  let one = 0;
  let two = 0;
  let three = 0;
  let categorySubscription = await Subscription.find({
    "category": category,
  });
  //console.log(categorySubscription)
  
  //if(categorySubscription=='One(1)-Month'){
   // flag=1;
  //}
  //one+=flag;
  
  
  

  for (let i = 0; i < categorySubscription.length; i++) {
    var a='One(1)-Month';
    if(categorySubscription.category==a){
      console.log('yes'); 
    }
    one+=categorySubscription[i].category.length;
    
    //for (let j = 0; j < categoryOrders[i].products.length; j++) {
      //subb +=
        //categorySubscription[i].category.length;
        //categoryOrders[i].products[j].quantity *
        //categoryOrders[i].products[j].product.price;
    //}
  //}
  return one;
}
}*/







 module.exports =adminRouter;