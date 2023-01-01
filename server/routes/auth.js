const express = require("express");
const User=require("../model/user");
const bcryptjs = require('bcryptjs');
const jwt = require('jsonwebtoken');
const auth = require("../middlewares/auth");

//import from other file
const authRouter=express.Router();


authRouter.post('/api/signup',async (req,res)=>{
    try{
      
      
        const {name,email,phone,password,address}=req.body;
        const existingUser= await  User.findOne({email});
        
       
        if(existingUser){
           return res
            .status(400)
           .json({msg:"User already exist"});
        }
        //salt
         const hashedPassword=await bcryptjs.
         hash(password,8); 
       
         let user=new User({
          name,
          email,
          password:hashedPassword,
          phone,
          address,
       
            
        }) ; 
        user = await user.save();
        res.json(user); 
    }catch (e){
        res.status(500).json({error: e.message});
    }

});
//login route
authRouter.post("/api/login", async (req, res) => {
    try {
      const { email, password } = req.body;
  
      const user = await User.findOne({ email });
      
      //guard clauses
      if (!user) {
        return res
          .status(400)
          .json({ msg: "User with this email does not exist!" });
      }
  
      const isMatch = await bcryptjs.compare(password, user.password);
      if (!isMatch) {
        return res.status(400).json({ msg: "Incorrect password." });
      }
      //users are who they are and not hacker.. auth usere
      const token = jwt.sign({ id: user._id }, "passwordKey");
      //user data acess anywhere in app
      //... is object destructuring
      res.json({ token, ...user._doc });
      //{
      //'name':swati
      //'email':swati@gmail.com
      //}
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  });
  //token for homepage
   authRouter.post("/tokenIsValid", async (req, res) => {
    try {
      const token = req.header("x-auth-token");
      if (!token) return res.json(false);
      const verified = jwt.verify(token, "passwordKey");
      if (!verified) return res.json(false);
  
      const user = await User.findById(verified.id);
      if (!user) return res.json(false);
      res.json(true);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  });
  
  // get user data
  authRouter.get("/", auth, async (req, res) => {
    const user = await User.findById(req.user);
    res.json({ ...user._doc, token: req.token });
  });
module.exports=authRouter;