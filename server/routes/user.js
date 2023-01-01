const express = require('express');
const userRouter = express.Router();
const auth = require('../middlewares/auth');
const Order = require("../model/order");
const { Product } = require("../model/product");
const {Subscription} = require("../model/subscription");
const User = require("../model/user");

userRouter.post("/api/add-to-cart", auth, async (req, res) => {
    try {
      const { id } = req.body;
      const product = await Product.findById(id);
      let user = await User.findById(req.user);//saving crat in user model
  
      if (user.cart.length == 0) {
        user.cart.push({ product, quantity: 1 });
      } else {
        let isProductFound = false;//falg to find the product
        for (let i = 0; i < user.cart.length; i++) {//if product above  is alreaddy in the cart increment the quantity
          if (user.cart[i].product._id.equals(product._id)) {
            isProductFound = true;
          }
        }
  
        if (isProductFound) {//if found increment the quantity or else add it in the cart
          let producttt = user.cart.find((productt) =>//finding the product that matches this creteria
            productt.product._id.equals(product._id)
          );
          producttt.quantity += 1;
        } else {
          user.cart.push({ product, quantity: 1 });
        }
      }
      user = await user.save();
      res.json(user);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  });
  userRouter.delete("/api/remove-from-cart/:id", auth, async (req, res) => {
    try {
      const { id } = req.params;
      const product = await Product.findById(id);
      let user = await User.findById(req.user);
  
      for (let i = 0; i < user.cart.length; i++) {
        if (user.cart[i].product._id.equals(product._id)) {
          if (user.cart[i].quantity == 1) {
            user.cart.splice(i, 1);//if quantity becomes zero simple deleting the product from cart
          } else {
            user.cart[i].quantity -= 1;//decresing by one
          }
        }
      }
      user = await user.save();
      res.json(user);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  });

  //save the user address
  userRouter.post("/api/save-user-address", auth, async (req, res) => {
    try {
      const {address } = req.body;
      let user = await User.findById(id);
      //console.log(user);
      user.address = address;
      //console.log(user.address);
      user = await user.save();
      //console.log(user);
      res.json(user);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  });
  
  

  //oder product
  userRouter.post("/api/order", auth, async (req, res) => {
    try {
      const { cart, totalPrice,address,category,images } = req.body;
      let products = [];
  
      for (let i = 0; i < cart.length; i++) {
        let product = await Product.findById(cart[i].product._id);
        if (product.quantity >= cart[i].quantity) {
          product.quantity -= cart[i].quantity;
          products.push({ product, quantity: cart[i].quantity });
          await product.save();//product keep changing so saved as soon as received
        } else {
          return res
            .status(400)
            .json({ msg: `${product.name} is out of stock!` });
        }
      }
     // after order cart is empty
      let user = await User.findById(req.user);
      user.cart = [];
      user = await user.save();

      //creating new order
  
      let order = new Order({
        products,
        totalPrice,
        address,
        userId: req.user,
        orderedAt: new Date().getTime(),
        category,
        images
      });
      order = await order.save();
      res.json(order);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  });
  //displaying order of user
  userRouter.get("/api/orders/me", auth, async (req, res) => {
    try {
      const orders = await Order.find({ userId: req.user });
      res.json(orders);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  });
  //adding subscription
  userRouter.post('/api/add-subscription',auth,async(req,res)=>{
    try{
      
        //name should match with that in subscription.dart
       const{description,userId,images,category,orderedAt}=req.body;
       
      
      const existingUser= await  Subscription.findOne({userId});
       if(existingUser){
        return res
         .status(400)
        .json({msg:"Subscription alredy exist"});
     }
       // let so that these fields are changed
       let subscription = new Subscription({
        
        description,
        images,
        category,
        userId,
        orderedAt
        
    
    });
    subscription = await subscription.save();
    res.json(subscription);
    }catch(e){
        res.status(500).json({
            error:e.message
        });
    }
 });

  // Get all subscription
  userRouter.get('/api/get-subscription',auth,async(req,res)=>{
    try{
     const subscription= await Subscription.find({userId: req.user});
     res.json(subscription);
    }catch(e){
      res.status(500).json({error:e.message});
    }
   });

   //delete subscription
   userRouter.post('/api/delete-subscription',auth,async(req,res)=>{
    try{
     const {id}=req.body;
     let product = await Subscription.findByIdAndDelete(id);
 
     res.json(product);
 
    }catch(e){
     res.status(500).json({error:e.message});
   }
  })
  //delete order
   userRouter.post('/api/delete-order',auth,async(req,res)=>{
    try{
     const {id}=req.body;
     let product = await Order.findByIdAndDelete(id);
 
     res.json(product);
 
    }catch(e){
     res.status(500).json({error:e.message});
   }
  })
  

  //update address
  userRouter.patch("/api/save/:name", auth, async (req, res) => {
    
    try{
      const name = req.params.name;
      const updated = req.body;
      const options={new:true};
      const result=await User.findOneAndUpdate(name,update,options)
      res.send(result)

    }catch(e){
      res.status(500).json({error:e.message});
    }
  })


  module.exports=userRouter;