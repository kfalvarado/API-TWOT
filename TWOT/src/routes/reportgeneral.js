const express = require('express');
const mysql = require("../database");
const router = express.Router();
//app.use(bodyparser.json());

//Primera Ruta por el metodo get
/*app.get('/',(req,res)=>{
    res.send('Bienvenidos a la API de TWOT')
});*/

//Leer ReportGeneral DATOS

router.get(["/reporteG/","/LeerReportG/"],(req, res)=>{
    const sql = `CALL PROC_REPORTGENERAL('?','?','?','?','?','?','?','?','?',4,'')`
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

router.get('/reporteG/LeerReportG/:cod',(req, res)=>{
    const {cod}= req.params
    const sql=`CALL PROC_REPORTGENERAL('?','?','?','?','?','?','?','?','?',5,${cod})`
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

router.post('/reporteG/nuevaReportG',(req,res)=>{
    const objReportGeneral ={
        COD_REPORTPERSONAS: req.body.COD_REPORTPERSONAS,
        NOM_PERSONA: req.body.NOM_PERSONA,
        COD_REPORTPRODUCCION: req.body.COD_REPORTPERSONAS, 
        PROVEEDORES: req.body.PROVEEDORES, 
        COD_REPORTINVENTARIO: req.body.COD_REPORTINVENTARIO, 
        CATEGORIAS: req.body.CATEGORIAS,
        COD_REPORTVENTA: req.body.COD_REPORTVENTA, 
        COD_REPORTCOMPRA: req.body.COD_REPORTCOMPRA, 
        COD_REPORTDISTRIBUCION: req.body.COD_REPORTDISTRIBUCION, 
        OPERACION: req.body.OPERACION,
        FILA: req.body.FILA
    }
    const sql = `CALL PROC_REPORTGENERAL(${objReportGeneral.COD_REPORTPERSONAS},${objReportGeneral.NOM_PERSONA},${objReportGeneral.COD_REPORTPRODUCCION},${objReportGeneral.PROVEEDORES},${objReportGeneral.COD_REPORTINVENTARIO},${objReportGeneral.CATEGORIAS},${objReportGeneral.COD_REPORTVENTA},${objReportGeneral.COD_REPORTCOMPRA},${objReportGeneral.COD_REPORTDISTRIBUCION},${objReportGeneral.OPERACION},${objReportGeneral.FILA})`
    mysql.query(sql, error=>{
        if(error) throw error;
        res.send('Los datos se insertaron correctamente')
    })
    console.log('Datos insertados correctamente');
});
//actualizar
router.put('/reporteG/actualizarReportG/:id',(req,res)=>{
    const  {id}= req.params;
    const objReportGeneral ={
        COD_REPORTPERSONAS: req.body.COD_REPORTPERSONAS,
        NOM_PERSONA: req.body.NOM_PERSONA,
        COD_REPORTPRODUCCION: req.body.COD_REPORTPERSONAS, 
        PROVEEDORES: req.body.PROVEEDORES, 
        COD_REPORTINVENTARIO: req.body.COD_REPORTINVENTARIO, 
        CATEGORIAS: req.body.CATEGORIAS,
        COD_REPORTVENTA: req.body.COD_REPORTVENTA, 
        COD_REPORTCOMPRA: req.body.COD_REPORTCOMPRA, 
        COD_REPORTDISTRIBUCION: req.body.COD_REPORTDISTRIBUCION
    }
    const sql = `CALL PROC_REPORTGENERAL(${objReportGeneral.COD_REPORTPERSONAS},${objReportGeneral.NOM_PERSONA},${objReportGeneral.COD_REPORTPRODUCCION},${objReportGeneral.PROVEEDORES},${objReportGeneral.COD_REPORTINVENTARIO},${objReportGeneral.CATEGORIAS},${objReportGeneral.COD_REPORTVENTA},${objReportGeneral.COD_REPORTCOMPRA},${objReportGeneral.COD_REPORTDISTRIBUCION},2,${id})`
    mysql.query(sql, error=>{
        if(error) throw error;
        res.send('Los datos se actualizaron correctamente')
    })
    console.log('Datos actualizados correctamente');
});

router.delete('/reporteG/borrarReportG/:id',(req,res)=>{
    const{id}= req.params;
    const sql=`CALL PROC_REPORTGENERAL('?','?','?','?','?','?','?','?','?',3,${id})`
    mysql.query(sql, error=>{
        if(error) throw error;
        res.send('Los datos fueron borrados correctamente')
    })
    console.log('Datos borrados correctamente');
});

module.exports=router;