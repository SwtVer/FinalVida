const express = require('express');
const productRouter = express.Router();
const auth = require('../middlewares/auth');
const {Product} = require("../model/product");
//api/product
productRouter.get('/api/products',auth,async(req,res)=>{
    try{
        console.log(req.query.category)
     const products= await Product.find({category:req.query.category});
     res.json(products);
    }catch(e){
      res.status(500).json({error:e.message});
    }
   });
   //get request api to search and get them
   //api/products/search/
   //:name to get the content typped in the searchBar
   //regex is used for search pattern
   productRouter.get("/api/products/search/:name", auth, async (req, res) => {
    try {
      const products = await Product.find({
        name: { $regex: req.params.name, $options: "i" },
      });
  
      res.json(products);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  });
  //create a post request route for rating
  //how delete an object from an array in js
  productRouter.post("/api/rate-product", auth, async (req, res) => {
    try {
      const { id, rating } = req.body;
      let product = await Product.findById(id);
        //add and remove rating
      for (let i = 0; i < product.ratings.length; i++) {
        if (product.ratings[i].userId == req.user) {
          product.ratings.splice(i, 1); 
          break;
        }
      }
  
      const ratingSchema = {
        userId: req.user,
        rating,
      };
  
      product.ratings.push(ratingSchema);
      product = await product.save();
      res.json(product);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  });
  //highest rated product
  productRouter.get("/admin/deal-of-day", auth, async (req, res) => {
    try {
      let products = await Product.find({});
  //clalculating  rating of each product and then arrange in ascending order and displaying the highest rated product
      products = products.sort((a, b) => {// a and b are the varieables like product1 and product2
        let aSum = 0;
        let bSum = 0;
  
        for (let i = 0; i < a.ratings.length; i++) {
          aSum += a.ratings[i].rating;
        }
  
        for (let i = 0; i < b.ratings.length; i++) {
          bSum += b.ratings[i].rating;
        }
        return aSum < bSum ? 1 : -1;//1 is for asum and -1 is for bsum
      });
  
      res.json(products[0]);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  });




module.exports =productRouter;