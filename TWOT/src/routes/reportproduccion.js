const express = require('express');
const mysql = require("../database");
const router = express.Router();
//app.use(bodyparser.json());

//Primera Ruta por el metodo get
/*app.get('/',(req,res)=>{
    res.send('Bienvenidos a la API de TWOT')
});*/

//Leer ReportProduccion DATOS

router.get(["/reportePro/","/LeerReportPro"],(req, res)=>{
    const sql = `CALL PROC_REPORTPRODUCCION('?','?','?','?','?','?',4,'')`
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

router.get('/reportePro/LeerReportPro/:cod',(req, res)=>{
    const {cod}= req.params
    const sql=`CALL PROC_REPORTPRODUCCION('?','?','?','?','?','?',5,${cod})`
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

router.post('/reportePro/nuevaReportPro',(req,res)=>{
    const objReportProduccion ={
        COD_ARTICULO: req.body.COD_ARTICULO,
        NOM_PRODUCTO: req.body.NOM_PRODUCTO,
        COD_EMPRESA: req.body.COD_EMPRESA,
        PROVEEDORES: req.body.PROVEEDORES,
        COD_INV: req.body.COD_INV, 
        CATEGORIAS: req.body.CATEGORIAS,
        OPERACION: req.body.OPERACION,
        FILA: req.body.FILA
    }
    const sql = `CALL PROC_REPORTPRODUCCION(${objReportProduccion.COD_ARTICULO},${objReportProduccion.NOM_PRODUCTO},${objReportProduccion.COD_EMPRESA},${objReportProduccion.PROVEEDORES},${objReportProduccion.COD_INV},${objReportProduccion.CATEGORIAS},${objReportProduccion.OPERACION},${objReportProduccion.FILA})`
    mysql.query(sql, error=>{
        if(error) throw error;
        res.send('Los datos se insertaron correctamente')
    })
    console.log('Datos insertados correctamente');
});
//actualizar
router.put('/reportePro/actualizarReportPro/:id',(req,res)=>{
    const  {id}= req.params;
    const objReportProduccion ={
        COD_ARTICULO: req.body.COD_ARTICULO,
        NOM_PRODUCTO: req.body.NOM_PRODUCTO,
        COD_EMPRESA: req.body.COD_EMPRESA,
        PROVEEDORES: req.body.PROVEEDORES,
        COD_INV: req.body.COD_INV, 
        CATEGORIAS: req.body.CATEGORIAS
    }
    const sql = `CALL PROC_REPORTPRODUCCION(${objReportProduccion.COD_ARTICULO},${objReportProduccion.NOM_PRODUCTO},${objReportProduccion.COD_EMPRESA},${objReportProduccion.PROVEEDORES},${objReportProduccion.COD_INV},${objReportProduccion.CATEGORIAS},2,${id})`
    mysql.query(sql, error=>{
        if(error) throw error;
        res.send('Los datos se actualizaron correctamente')
    })
    console.log('Datos actualizados correctamente');
});

router.delete('/reportePro/borrarReportPro/:id',(req,res)=>{
    const{id}= req.params;
    const sql=`CALL PROC_REPORTPRODUCCION('?','?','?','?','?','?',3,${id})`
    mysql.query(sql, error=>{
        if(error) throw error;
        res.send('Los datos fueron borrados correctamente')
    })
    console.log('Datos borrados correctamente');
});

module.exports=router;