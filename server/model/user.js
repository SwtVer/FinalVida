const mongoose = require('mongoose');
const { productSchema } = require('./product');


const userSchema=mongoose.Schema({
  name:{
    required:true,
    type:String,
    trim:true,
    validate:{
        validator:(value)=>{
            const re =
            /^[A-Za-z]+$/;
             return value.match(re);
        },
        message:'Enter valid name',
    } 
},
  
   email:{
    required:true,
    type:String,
    trim:true,
    validate:{
        validator:(value)=>{
            const re =
            /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
             return value.match(re);
        },
        message:'Enter valid email address',
    }
   }, 
   phone:{
    required:true,
    type:String,
    //trim:true,
    validate:{
        validator:(value)=>{
            const rex='^(?:[+0][1-9])?[0-9]{10,12}$';///((\+*)((0[ -]*)*|((91 )*))((\d{12})+|(\d{10})+))|\d{5}([- ]*)\d{6}/;  // r'^[9][6-9]\d{8}';///^([+|\d])+([\s|\d])+([\d])$/;
            return value.match(rex);
        },
        message:'Enter valid phone number',
    }
   },
  password:{
    required:true,
    
    type:String,
    trim:true,
    validate:{
        validator:(value)=>{
         return value.length > 6;   
        },
        message:'Enter valid password',
    }
   },
   
   address:{
    required:true,
    default:'',
    type:String,
    trim:true,
   },
   type:{
    type:String,
    default:'user',
   },
   cart:[
    {
        product:productSchema,
        quantity:{
            type:Number,
            required:true,
        },
    },
   ],

   

});
const User=mongoose.model("User",userSchema);
module.exports=User;
