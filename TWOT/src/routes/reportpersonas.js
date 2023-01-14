const express = require('express');
const mysql = require("../database");
const router = express.Router();
//app.use(bodyparser.json());

//Primera Ruta por el metodo get
/*app.get('/',(req,res)=>{
    res.send('Bienvenidos a la API de TWOT')
});*/

//Leer reportpersonas DATOS

router.get(["/reporteP/","/LeerReportP"],(req, res)=>{
    const sql = `CALL PROC_REPORTPERSONAS('?','?','?','?','?','?','?','?',4,'')`
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

router.get('/reporteP/LeerP/:cod',(req, res)=>{
    const {cod}= req.params
    const sql=`CALL PROC_REPORTPERSONAS('?','?','?','?','?','?','?','?',5,${cod})`
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

router.post('/reporteP/NuevaReportP',(req,res)=>{
    const objReportPersonas ={
        COD_ROL: req.body.COD_ROL,
        ROL_PER: req.body.ROL_PER,
        COD_PERSONA: req.body.COD_PERSONA,
        NOM_PERSONA: req.body.NOM_PERSONA,
        COD_TELEFONO: req.body.COD_TELEFONO,
        COD_DIR: req.body.COD_DIR,
        COD_COR: req.body.COD_COR,
        COD_USR: req.body.COD_USR,
        OPERACION: req.body.OPERACION,
        FILA: req.body.FILA
    }
    const sql = `CALL PROC_REPORTPERSONAS(${objReportPersonas.COD_ROL},${objReportPersonas.ROL_PER},${objReportPersonas.COD_PERSONA},${objReportPersonas.NOM_PERSONA},${objReportPersonas.COD_TELEFONO},${objReportPersonas.COD_DIR},${objReportPersonas.COD_COR},${objReportPersonas.COD_USR},${objReportPersonas.OPERACION},${objReportPersonas.FILA})`
    mysql.query(sql, error=>{
        if(error) throw error;
        res.send('Los datos se insertaron correctamente')
    })
    console.log('Datos insertados correctamente');
});
//actualizar
router.put('/reporteP/actualizarReportP/:id',(req,res)=>{
    const  {id}= req.params;
    const objReportPersonas ={
        COD_ROL: req.body.COD_ROL,
        ROL_PER: req.body.ROL_PER,
        COD_PERSONA: req.body.COD_PERSONA,
        NOM_PERSONA: req.body.NOM_PERSONA,
        COD_TELEFONO: req.body.COD_TELEFONO,
        COD_DIR: req.body.COD_DIR,
        COD_COR: req.body.COD_COR,
        COD_USR: req.body.COD_USR
    }
    const sql = `CALL PROC_REPORTPERSONAS(${objReportPersonas.COD_ROL},${objReportPersonas.ROL_PER},${objReportPersonas.COD_PERSONA},${objReportPersonas.NOM_PERSONA},${objReportPersonas.COD_TELEFONO},${objReportPersonas.COD_DIR},${objReportPersonas.COD_COR},${objReportPersonas.COD_USR},2,${id})`
    mysql.query(sql, error=>{
        if(error) throw error;
        res.send('Los datos se actualizaron correctamente')
    })
    console.log('Datos actualizados correctamente');
});

router.delete('/reporteP/borrarReportP/:id',(req,res)=>{
    const{id}= req.params;
    const sql=`CALL PROC_REPORTPERSONAS('?','?','?','?','?','?','?','?',3,${id})`
    mysql.query(sql, error=>{
        if(error) throw error;
        res.send('Los datos fueron borrados correctamente')
    })
    console.log('Datos borrados correctamente');
});

module.exports=router;