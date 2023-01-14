const express = require('express');
const mysql = require("../database");
const router = express.Router();


////////LEER DATOS DE LA TABLA DISTRIBPRODUCT///////////////

router.get(["/distribucionproducto/","/leer"],(req, res)=>{
    const sql = `CALL PROC_DISTRIBPRODUCT('?','?','?','?','?','?',4,'')`
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


////////LEER DATOS POR ID O FILA DE LA TABLA DISTRIBPRODUCT///////////////

router.get('/distribucionproducto/:cod',(req, res)=>{
    const {cod}= req.params
    const sql= `CALL PROC_DISTRIBPRODUCT('?','?','?','?','?','?',5,${cod})`
    mysql.query(sql,(error,results)=>{
        if(error) throw error;
        if(results.length>0){
            res.json(results[0]); //SE LE AGREGA UN 0
        }else{
            res.send('No se pudo obtener resultados')
        }
    })
    console.log('Datos leidos correctamente');
});

////////INSERTAR DATOS DE LA TABLA DISTRIBPRODUCT///////////////


router.post('/distribucionproducto/nuevo',(req,res)=>{
    const objdistrib ={


        COD_PERSONA: req.body.COD_PERSONA,
        COD_PRODUCTO: req.body.COD_PRODUCTO,
        COD_VENTA: req.body.COD_VENTA,
         nombreDepart: req.body.nombreDepart,
         lugar_entrega: req.body.lugar_entrega,
         nombre: req.body.nombre,
       
         
         OPERACION: req.body.OPERACION,
         FILA: req.body.FILA
    }
    const sql = `CALL PROC_DISTRIBPRODUCT(${objdistrib.COD_PERSONA},${objdistrib.COD_PRODUCTO},${objdistrib.COD_VENTA},${objdistrib.nombreDepart},${objdistrib.lugar_entrega},${objdistrib.nombre},1,'')`
    mysql.query(sql, error=>{
        if(error) throw error;
        res.send('Los datos se insertaron correctamente')
    })
    console.log('Datos insertados correctamente');
    });


    ////////AUTIALIZAR DATOS DE LA TABLA DISTRIBPRODUCT///////////////


router.put('/distribucionproducto/actualizar/:cod',(req,res)=>{
    const  {cod}= req.params;
    const objdistrib ={

        COD_PERSONA: req.body.COD_PERSONA,
        COD_PRODUCTO: req.body.COD_PRODUCTO,
        COD_VENTA: req.body.COD_VENTA,
       
        nombreDepart: req.body.nombreDepart,
        lugar_entrega: req.body.lugar_entrega,
        nombre: req.body.nombre,
       
    }
    const sql = `CALL PROC_DISTRIBPRODUCT(${objdistrib.COD_PERSONA},${objdistrib.COD_PRODUCTO},${objdistrib.COD_VENTA},${objdistrib.nombreDepart},${objdistrib.lugar_entrega},${objdistrib.nombre},2,${cod})`
    mysql.query(sql, error=>{
        if(error) throw error;
        res.send('Los datos se actualizaron correctamente')
    })
    console.log('Datos actualizados correctamente');
    });

      ////////BORRAR DATOS DE LA TABLA DISTRIBPRODUCT///////////////

      router.delete('/distribucionproducto/borrar/:cod',(req,res)=>{
        const{cod}= req.params;
        const sql= `CALL PROC_DISTRIBPRODUCT('?','?','?','?','?','?',3,${cod})`
        mysql.query(sql, error=>{
            if(error) throw error;
            res.send('Los datos fueron borrados correctamente')
        })
        console.log('Datos borrados correctamente');
    });
    



module.exports=router; 