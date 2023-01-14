const express = require('express');
const mysql = require("../database");
const router = express.Router();
//app.use(bodyparser.json());

//Primera Ruta por el metodo get
/*app.get('/',(req,res)=>{
    res.send('Bienvenidos a la API de TWOT')
});*/

//Leer ReportInventario DATOS

router.get(["/reporteI/","/LeerReportI"],(req, res)=>{
    const sql = `CALL PROC_REPORTINVENTARIO('?','?','?','?',4,'')`
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

router.get('/reporteI/LeerReportI/:cod',(req, res)=>{
    const {cod}= req.params
    const sql=`CALL PROC_REPORTINVENTARIO('?','?','?','?',5,${cod})`
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

router.post('/reporteI/nuevaReportI',(req,res)=>{
    const objReportInventario ={
        COD_PRODUCTO: req.body.COD_PRODUCTO,
        NOM_PRODUCTO: req.body.NOM_PRODUCTO,
        COD_INV: req.body.COD_INV,
        CATEGORIAS: req.body.CATEGORIAS,
        OPERACION: req.body.OPERACION,
        FILA: req.body.FILA
    }
    const sql = `CALL PROC_REPORTINVENTARIO(${objReportInventario.COD_PRODUCTO},${objReportInventario.NOM_PRODUCTO},${objReportInventario.COD_INV},${objReportInventario.CATEGORIAS},${objReportInventario.OPERACION},${objReportInventario.FILA})`
    mysql.query(sql, error=>{
        if(error) throw error;
        res.send('Los datos se insertaron correctamente')
    })
    console.log('Datos insertados correctamente');
});
//actualizar
router.put('/reporteI/actualizarReportI/:id',(req,res)=>{
    const  {id}= req.params;
    const objReportInventario ={
        COD_PRODUCTO: req.body.COD_PRODUCTO,
        NOM_PRODUCTO: req.body.NOM_PRODUCTO,
        COD_INV: req.body.COD_INV,
        CATEGORIAS: req.body.CATEGORIAS
    }
    const sql = `CALL PROC_REPORTINVENTARIO(${objReportInventario.COD_PRODUCTO},${objReportInventario.NOM_PRODUCTO},${objReportInventario.COD_INV},${objReportInventario.CATEGORIAS},2,${id})`
    mysql.query(sql, error=>{
        if(error) throw error;
        res.send('Los datos se actualizaron correctamente')
    })
    console.log('Datos actualizados correctamente');
});

router.delete('/reporteI/borrarReportI/:id',(req,res)=>{
    const{id}= req.params;
    const sql=`CALL PROC_REPORTINVENTARIO('?','?','?','?',3,${id})`
    mysql.query(sql, error=>{
        if(error) throw error;
        res.send('Los datos fueron borrados correctamente')
    })
    console.log('Datos borrados correctamente');
});

module.exports=router;