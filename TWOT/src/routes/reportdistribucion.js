const express = require('express');
const mysql = require("../database");
const router = express.Router();
//app.use(bodyparser.json());

//Primera Ruta por el metodo get
/*app.get('/',(req,res)=>{
    res.send('Bienvenidos a la API de TWOT')
});*/

//Leer ReportDistribucion DATOS

router.get(["/reporteD/","/LeerReportD"],(req, res)=>{
    const sql = `CALL PROC_REPORTDISTRIBUCION('?','?','?','?','?','?','?','?','?',4,'')`
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

router.get('/reporteD/LeerReportD/:cod',(req, res)=>{
    const {cod}= req.params
    const sql=`CALL PROC_REPORTDISTRIBUCION('?','?','?','?','?','?','?','?','?',5,${cod})`
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

router.post('/reporteD/nuevaReportD',(req,res)=>{
    const objReportDistribucion ={
        COD_PERSONA: req.body.COD_PERSONA, 
        NOM_PERSONA: req.body.NOM_PERSONA,
        COD_VENTA: req.body.COD_VENTA,
        COD_PRODUCTO: req.body.COD_PRODUCTO,
        NOM_PRODUCTO: req.body.NOM_PRODUCTO,
        COD_INV: req.body.COD_INV,
        CATEGORIAS: req.body.CATEGORIAS,
        COD_ARTICULO: req.body.COD_ARTICULO,
        cod_descproducto: req.body.cod_descproducto,
        OPERACION: req.body.OPERACION,
        FILA: req.body.FILA
    }
    const sql = `CALL PROC_REPORTDISTRIBUCION(${objReportDistribucion.COD_PERSONA},${objReportDistribucion.NOM_PERSONA},${objReportDistribucion.COD_VENTA},${objReportDistribucion.COD_PRODUCTO},${objReportDistribucion.NOM_PRODUCTO},${objReportDistribucion.COD_INV},${objReportDistribucion.CATEGORIAS},${objReportDistribucion.COD_ARTICULO},${objReportDistribucion.cod_descproducto},${objReportDistribucion.OPERACION},${objReportDistribucion.FILA})`
    mysql.query(sql, error=>{
        if(error) throw error;
        res.send('Los datos se insertaron correctamente')
    })
    console.log('Datos insertados correctamente');
});
//actualizar
router.put('/reporteD/actualizarReportD/:id',(req,res)=>{
    const  {id}= req.params;
    const objReportDistribucion ={
        COD_PERSONA: req.body.COD_PERSONA, 
        NOM_PERSONA: req.body.NOM_PERSONA,
        COD_VENTA: req.body.COD_VENTA,
        COD_PRODUCTO: req.body.COD_PRODUCTO,
        NOM_PRODUCTO: req.body.NOM_PRODUCTO,
        COD_INV: req.body.COD_INV,
        CATEGORIAS: req.body.CATEGORIAS,
        COD_ARTICULO: req.body.COD_ARTICULO,
        cod_descproducto: req.body.cod_descproducto
    }
    const sql = `CALL PROC_REPORTDISTRIBUCION(${objReportDistribucion.COD_PERSONA},${objReportDistribucion.NOM_PERSONA},${objReportDistribucion.COD_VENTA},${objReportDistribucion.COD_PRODUCTO},${objReportDistribucion.NOM_PRODUCTO},${objReportDistribucion.COD_INV},${objReportDistribucion.CATEGORIAS},${objReportDistribucion.COD_ARTICULO},${objReportDistribucion.cod_descproducto},2,${id})`
    mysql.query(sql, error=>{
        if(error) throw error;
        res.send('Los datos se actualizaron correctamente')
    })
    console.log('Datos actualizados correctamente');
});

router.delete('/reporteD/borrarReportD/:id',(req,res)=>{
    const{id}= req.params;
    const sql=`CALL PROC_REPORTDISTRIBUCION('?','?','?','?','?','?','?','?','?',3,${id})`
    mysql.query(sql, error=>{
        if(error) throw error;
        res.send('Los datos fueron borrados correctamente')
    })
    console.log('Datos borrados correctamente');
});

module.exports=router;