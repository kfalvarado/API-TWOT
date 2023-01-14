const express = require('express');
const mysql = require("../database");
const router = express.Router();


//Leer ReportCompra DATOS

router.get(["/reporteC/","/LeerReportC"],(req, res)=>{
    const sql = `CALL PROC_REPORTCOMPRA('?','?','?','?','?','?','?','?',4,'')`
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

router.get('/reporteC/LeerReportC/:cod',(req, res)=>{
    const {cod}= req.params
    const sql=`CALL PROC_REPORTCOMPRA('?','?','?','?','?','?','?','?',5,${cod})`
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

router.post('/reporteC/nuevaReportC',(req,res)=>{
    const objReportCompra ={
        COD_COMPRA: req.body.COD_COMPRA,
        COD_INV: req.body.COD_INV,
        CATEGORIAS: req.body.CATEGORIAS,
        COD_PERSONA: req.body.COD_PERSONA,
        NOM_PERSONA: req.body.NOM_PERSONA,
        COD_VENTA: req.body.COD_PERSONA,
        COD_PRODUCTO: req.body.COD_PRODUCTO,
        NOM_PRODUCTO: req.body.NOM_PRODUCTO,
        OPERACION: req.body.OPERACION,
        FILA: req.body.FILA
    }
    const sql = `CALL PROC_REPORTCOMPRA(${objReportCompra.COD_COMPRA},${objReportCompra.COD_INV},${objReportCompra.CATEGORIAS},${objReportCompra.COD_PERSONA},${objReportCompra.NOM_PERSONA},${objReportCompra.COD_VENTA},${objReportCompra.COD_PRODUCTO},${objReportCompra.NOM_PRODUCTO},${objReportCompra.OPERACION},${objReportCompra.FILA})`
    mysql.query(sql, error=>{
        if(error) throw error;
        res.send('Los datos se insertaron correctamente')
    })
    console.log('Datos insertados correctamente');
});
//actualizar
router.put('/reporteC/actualizarReportC/:id',(req,res)=>{
    const  {id}= req.params;
    const objReportCompra ={
        COD_COMPRA: req.body.COD_COMPRA,
        COD_INV: req.body.COD_INV,
        CATEGORIAS: req.body.CATEGORIAS,
        COD_PERSONA: req.body.COD_PERSONA,
        NOM_PERSONA: req.body.NOM_PERSONA,
        COD_VENTA: req.body.COD_PERSONA,
        COD_PRODUCTO: req.body.COD_PRODUCTO,
        NOM_PRODUCTO: req.body.NOM_PRODUCTO
    }
    const sql = `CALL PROC_REPORTCOMPRA(${objReportCompra.COD_COMPRA},${objReportCompra.COD_INV},${objReportCompra.CATEGORIAS},${objReportCompra.COD_PERSONA},${objReportCompra.NOM_PERSONA},${objReportCompra.COD_VENTA},${objReportCompra.COD_PRODUCTO},${objReportCompra.NOM_PRODUCTO},2,${id})`
    mysql.query(sql, error=>{
        if(error) throw error;
        res.send('Los datos se actualizaron correctamente')
    })
    console.log('Datos actualizados correctamente');
});

router.delete('/reporteC/borrarReportC/:id',(req,res)=>{
    const{id}= req.params;
    const sql=`CALL PROC_REPORTCOMPRA('?','?','?','?','?','?','?','?',3,${id})`
    mysql.query(sql, error=>{
        if(error) throw error;
        res.send('Los datos fueron borrados correctamente')
    })
    console.log('Datos borrados correctamente');
});

module.exports=router;