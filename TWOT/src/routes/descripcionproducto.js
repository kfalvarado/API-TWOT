//Actualizar datos

const express = require('express');
const mysql = require("../database");
const router = express.Router();


//Leer Descprod DATOS

router.get(["/descripcionproducto/","Leer"],(req, res)=>{
    const sql = `CALL PROC_DESCPRODUCT('?','?','?','?','?','?',4,'')`
    mysql.query(sql,(error,results)=>{
        if(error) throw error;
        if(results.length>0){
            res.json(results[0]);
        }else{
            res.send('No se pudo obtener resultados')
        }
    });  
    console.log('Datos leidos correctamente');
});

router.get('/descripcionproducto/:cod',(req, res)=>{
    const {cod}= req.params
    const sql=`CALL PROC_DESCPRODUCT('?','?','?','?','?','?',5,${cod})`
    mysql.query(sql,(error,results)=>{
        if(error) throw error;
        if(results.length>0){
            res.json(results[0]); //SE LE AGREGA UN 0
        }else{
            res.send('No se pudo obtener resultados')
        }
    });
    console.log('Datos leidos correctamente con el id');
});

//agregar
router.post('/descripcionproducto/nuevaDescprod',(req,res)=>{
    const objDescriprod ={
        
        COD_PRODUCTO  : req.body.COD_PRODUCTO ,
        nombreproduct : req.body.nombreproduct ,
        precioproduct : req.body.precioproduct  ,
        cantidadproduct : req.body.cantidadproduct ,
        color : req.body.color ,
        tamano : req.body.tamano ,
        opcion : req.body.opcion ,
        fila : req.body.fila 
    }
    const sql = `CALL PROC_DESCPRODUCT(${objDescriprod.COD_PRODUCTO},${objDescriprod.nombreproduct},${objDescriprod.precioproduct},${objDescriprod.cantidadproduct},${objDescriprod.color},${objDescriprod.tamano},1,'')`
    mysql.query(sql, error=>{
        if(error) throw error;
        res.send('Los datos se insertaron correctamente')
    })
    console.log('Datos insertados correctamente');
});


//actualizar
router.put('/descripcionproducto/actualizar/:cod',(req,res)=>{
    const  {cod}= req.params;
    const objDescriprod ={

        COD_PRODUCTO : req.body.COD_PRODUCTO,
        nombreproduct : req.body.nombreproduct ,
        precioproduct : req.body.precioproduct  ,
        cantidadproduct : req.body.cantidadproduct ,
        color : req.body.color ,
        tamano : req.body.tamano ,
        opcion : req.body.opcion ,
        fila : req.body.fila 
        
    }
   const sql = `CALL PROC_DESCPRODUCT(${objDescriprod.COD_PRODUCTO},${objDescriprod.nombreproduct},${objDescriprod.precioproduct},${objDescriprod.cantidadproduct},${objDescriprod.color},${objDescriprod.tamano},2,${cod})`
    mysql.query(sql, error=>{
        if(error) throw error;
        res.send('Los datos se actualizaron correctamente')
    })
    console.log('Datos actualizados correctamente');
});

//borrar
router.delete('/descripcionproducto/borrar/:cod',(req,res)=>{
    const{cod}= req.params;
    const sql=`CALL PROC_DESCPRODUCT('?','?','?','?','?','?',3,${cod})`
    mysql.query(sql, error=>{
        if(error) throw error;
        res.send('Los datos fueron borrados correctamente')
    })
    console.log('Datos borrados correctamente');
});

module.exports=router;