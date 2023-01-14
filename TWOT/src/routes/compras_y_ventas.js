const express = require('express');
const mysql = require("../database");
const router = express.Router();


//Leer venta DATOS

router.get(["/Ventas", "/Leer"],(req, res)=>{
    const sql = `CALL PROC_VENTA('?','?','?','?','?','?','?','?','?','?',4,'')`
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

router.get(["/Ventas/Leer/:cod"],(req, res)=>{
    const {cod}= req.params
    const sql=`CALL PROC_VENTA('?','?','?','?','?','?','?','?','?','?',5,${cod})`
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

router.post('/Ventas/agregar',(req,res)=>{
    const objVentas ={
        COD_INV: req.body.COD_INV,
        COD_PERSONA : req.body.COD_PERSONA,
        COD_PRODUCTO: req.body.COD_PRODUCTO,
        NOM_PRODUCTO: req.body.NOM_PRODUCTO,
        CANT_PRODUCTO: req.body.CANT_PRODUCTO,
        PREC_UNITARIO: req.body.PREC_UNITARIO ,
        TOTAL_BRUTO: req.body.TOTAL_BRUTO,
        DESTINO_VENTA: req.body.DESTINO_VENTA,
        IMPUE_TOTAL: req.body.IMPUE_TOTAL,
        TOTAL_VENTA: req.body.TOTAL_VENTA,
        OPERACION: req.body.OPERACION,
        FILA: req.body.FILA
    }
    const sql = `CALL PROC_VENTA(${objVentas.COD_INV},${objVentas.COD_PERSONA},${objVentas.COD_PRODUCTO},${objVentas.NOM_PRODUCTO},${objVentas.CANT_PRODUCTO},${objVentas.PREC_UNITARIO},${objVentas.TOTAL_BRUTO},${objVentas.DESTINO_VENTA},${objVentas.IMPUE_TOTAL},${objVentas.TOTAL_VENTA},1,'')`
    mysql.query(sql, error=>{
        if(error) throw error;
        res.send('Los datos se insertaron correctamente')
    })
    console.log('Datos insertados correctamente');
});
//actualizar
router.put('/ventas/actualizar/:cod',(req,res)=>{
    const  {cod}= req.params;
    const objVentas ={
        COD_INV: req.body.COD_INV,
        COD_PERSONA : req.body.COD_PERSONA,
        COD_PRODUCTO: req.body.COD_PRODUCTO,
        NOM_PRODUCTO: req.body.NOM_PRODUCTO,
        CANT_PRODUCTO: req.body.CANT_PRODUCTO,
        PREC_UNITARIO: req.body.PREC_UNITARIO ,
        TOTAL_BRUTO: req.body.TOTAL_BRUTO,
        DESTINO_VENTA: req.body.DESTINO_VENTA,
        IMPUE_TOTAL: req.body.IMPUE_TOTAL,
        TOTAL_VENTA: req.body.TOTAL_VENTA
    }
    const sql = `CALL PROC_VENTA(${objVentas.COD_INV},${objVentas.COD_PERSONA},${objVentas.COD_PRODUCTO},${objVentas.NOM_PRODUCTO},${objVentas.CANT_PRODUCTO},${objVentas.PREC_UNITARIO},${objVentas.TOTAL_BRUTO},${objVentas.DESTINO_VENTA},${objVentas.IMPUE_TOTAL},${objVentas.TOTAL_VENTA},2,${cod})`
    mysql.query(sql, error=>{
        if(error) throw error;
        res.send('Los datos se actualizaron correctamente')
    })
    console.log('Datos actualizados correctamente');
});

router.delete('/ventas/borrar/:cod',(req,res)=>{
    const{cod}= req.params;
    const sql=`CALL PROC_VENTA('?','?','?','?','?','?','?','?','?','?',3,${cod})`
    mysql.query(sql, error=>{
        if(error) throw error;
        res.send('Los datos fueron borrados correctamente')
    })
    console.log('Datos borrados correctamente');
})


router.put('/ventas/inventario/:cod',(req,res)=>{
    const  {cod}= req.params;
    const objinv ={
        UNIDADES:req.body.UNIDADES
    }
    const sql = `CALL PROC_UPDATEINVENTARIO(${cod},${objinv.UNIDADES},1)`
    mysql.query(sql, error=>{
        if(error) throw error;
        res.send('Se actulizo en el inventario')
    })
    console.log('El dato se actualizo en la tabla de inventario');
}
)
router.get('/ventas/selinventario/:cod',(req,res)=>{
    const {cod}= req.params
    const sql=`CALL PROC_UPDATEINVENTARIO(${cod},'?',2)`
    mysql.query(sql,(error,results)=>{
        if(error) throw error;
        if(results.length>0){
            res.json(results[0]); //SE LE AGREGA UN 0
        }else{
            res.send('No se pudo obtener resultados')
        }
    });
    console.log('Datos se selecciono correctamente en el inventario');
})
/*---------------------------------------------------------------------------------------------------- */
//insertar datos en la tabla compra

router.get(["/compras", "/Leer"],(req, res)=>{
    const sql = `CALL PROC_COMPRA( '?','?','?','?', '?','?','?', '?', '?', 4, '?');`
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

router.get('/compras/Leer/:cod',(req, res)=>{
    const {cod}= req.params
    const sql=`CALL PROC_COMPRA('?','?','?', '?','?','?','?', '?', '?', 5,${cod} );`
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
//Insertar Venta

router.post('/compras/nuevaCompra',(req,res)=>{
    const objVentas ={
        
        COD_EMPRESA: req.body.COD_EMPRESA,
        COD_PERSONA: req.body.COD_PERSONA,
        NOM_PROD: req.body.NOM_PROD,
        DEST_PROD: req.body.DEST_PROD,
        DEST_CATEG: req.body.DEST_CATEG,
        DISP_PROD: req.body.DISP_PROD,
        CANT_PROD: req.body.CANT_PROD,
        PREC_COMP: req.body.PREC_COMP ,   
        IMPUE_COMP: req.body.IMPUE_COMP,
        TOTAL_COMP: req.body.TOTAL_COMP,
        OPERACION: req.body.OPERACION,
        FILA: req.body.FILA
    }
    const sql = `CALL PROC_COMPRA(${objVentas.COD_EMPRESA},${objVentas.COD_PERSONA},${objVentas.NOM_PROD},${objVentas.DEST_PROD},${objVentas.DEST_CATEG},${objVentas.CANT_PROD},${objVentas.PREC_COMP},${objVentas.IMPUE_COMP},${objVentas.TOTAL_COMP},1,'?')`
    mysql.query(sql, error=>{
        if(error) throw error;
        res.send('Los datos se insertaron correctamente')
    })
    console.log('Datos insertados correctamente');
});

//actualizar
router.put('/compras/actualizar/:cod',(req,res)=>{
    const  {cod}= req.params;
    const objVentas ={
        
        COD_EMPRESA: req.body.COD_EMPRESA,
        COD_PERSONA: req.body.COD_PERSONA,
        NOM_PROD: req.body.NOM_PROD,
        DEST_PROD: req.body.DEST_PROD,
        DEST_CATEG: req.body.DEST_CATEG,
        DISP_PROD: req.body.DISP_PROD,
        CANT_PROD: req.body.CANT_PROD,
        PREC_COMP: req.body.PREC_COMP ,   
        IMPUE_COMP: req.body.IMPUE_COMP,
        TOTAL_COMP: req.body.TOTAL_COMP,
        OPERACION: req.body.OPERACION,
        FILA: req.body.FILA
    }
    const sql = `CALL PROC_COMPRA(${objVentas.COD_EMPRESA},${objVentas.COD_PERSONA},${objVentas.NOM_PROD},${objVentas.DEST_PROD},${objVentas.DEST_CATEG},${objVentas.CANT_PROD},${objVentas.PREC_COMP},${objVentas.IMPUE_COMP},${objVentas.TOTAL_COMP},2,${cod})`
    mysql.query(sql, error=>{
        if(error) throw error;
        res.send('Los datos se actualizaron correctamente')
    })
    console.log('Datos insertados correctamente');
});
router.delete('/compras/borrar/:cod',(req,res)=>{
    const{cod}= req.params;
    const sql=`CALL PROC_COMPRA('?','?','?', '?','?','?','?', '?', '?', 3,${cod} );`
    mysql.query(sql, error=>{
        if(error) throw error;
        res.send('Los datos fueron borrados correctamente')
    })
    console.log('Datos borrados correctamente');
});

module.exports=router;