const express = require('express');
const mysql = require("../database");
const router = express.Router();


//Leer ReportVenta DATOS

router.get(["/reporteV/","/LeerReportV"],(req, res)=>{
    const sql = `CALL PROC_REPORTVENTA('?','?','?','?','?','?','?',4,'')`
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

router.get('/reporteV/LeerReportV/:cod',(req, res)=>{
    const {cod}= req.params
    const sql=`CALL PROC_REPORTVENTA('?','?','?','?','?','?','?',5,${cod})`
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

router.post('/reporteV/nuevaReportV',(req,res)=>{
    const objReportVenta ={
        COD_VENTA: req.body.COD_VENTA,
        COD_INV: req.body.COD_INV,
        CATEGORIAS: req.body.CATEGORIAS,
        COD_PERSONA: req.body.COD_PERSONA,
        NOM_PERSONA: req.body.NOM_PERSONA,
        COD_PRODUCTO: req.body.COD_PRODUCTO,
        NOM_PRODUCTO: req.body.NOM_PRODUCTO,
        OPERACION: req.body.OPERACION,
        FILA: req.body.FILA
    }
    const sql = `CALL PROC_REPORTVENTA(${objReportVenta.COD_VENTA},${objReportVenta.COD_INV},${objReportVenta.CATEGORIAS},${objReportVenta.COD_PERSONA},${objReportVenta.NOM_PERSONA},${objReportVenta.COD_PRODUCTO},${objReportVenta.NOM_PRODUCTO},${objReportVenta.OPERACION},${objReportVenta.FILA})`
    mysql.query(sql, error=>{
        if(error) throw error;
        res.send('Los datos se insertaron correctamente')
    })
    console.log('Datos insertados correctamente');
});
//actualizar
router.put('/reporteV/actualizarReportV/:id',(req,res)=>{
    const  {id}= req.params;
    const objReportVenta ={
        COD_VENTA: req.body.COD_VENTA,
        COD_INV: req.body.COD_INV,
        CATEGORIAS: req.body.CATEGORIAS,
        COD_PERSONA: req.body.COD_PERSONA,
        NOM_PERSONA: req.body.NOM_PERSONA,
        COD_PRODUCTO: req.body.COD_PRODUCTO,
        NOM_PRODUCTO: req.body.NOM_PRODUCTO,
    }
    const sql = `CALL PROC_REPORTVENTA(${objReportVenta.COD_VENTA},${objReportVenta.COD_INV},${objReportVenta.CATEGORIAS},${objReportVenta.COD_PERSONA},${objReportVenta.NOM_PERSONA},${objReportVenta.COD_PRODUCTO},${objReportVenta.NOM_PRODUCTO},2,${id})`
    mysql.query(sql, error=>{
        if(error) throw error;
        res.send('Los datos se actualizaron correctamente')
    })
    console.log('Datos actualizados correctamente');
});

router.delete('/reporteV/borrarReportV/:id',(req,res)=>{
    const{id}= req.params;
    const sql=`CALL PROC_REPORTVENTA('?','?','?','?','?','?','?',3,${id})`
    mysql.query(sql, error=>{
        if(error) throw error;
        res.send('Los datos fueron borrados correctamente')
    })
    console.log('Datos borrados correctamente');
});

module.exports=router;