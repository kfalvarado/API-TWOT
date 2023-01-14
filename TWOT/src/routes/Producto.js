const express = require('express');
const mysql = require("../database");
const router = express.Router();


router.get(["/producto/", "/leer"], (req, res) => {
    const sql = `CALL PROC_PRODUCTO('?','?', '?', '?', '?', '?', 4, '')` 
    mysql.query(sql, (error, results) => {
        if (error) throw error;
        if (results.length > 0) {
            res.json(results[0]);
        } else {
            res.send('No se pudo obtener resultados')
        }
    });
    console.log('Datos leidos correctamente');
});

////////LEER DATOS POR ID O FILA DE LA TABLA PRODUCTO///////////////

router.get('/producto/:cod', (req, res) => {
    const { cod } = req.params
    const sql = `CALL PROC_PRODUCTO('?','?', '?', '?', '?', '?', 5,${cod})` 
    mysql.query(sql, (error, results) => {
        if (error) throw error;
        if (results.length > 0) {
            res.json(results[0]); //SE LE AGREGA UN 0
        } else {
            res.send('No se pudo obtener resultados')
        }
    })
    console.log('Datos borrados correctamente');
});

////////INSERTAR DATOS DE LA TABLA PRODUCTO///////////////


router.post('/producto/insertar', (req, res) => {
    const objproducto ={
        COD_EMPRESA:  req.body.COD_EMPRESA,
        NOM_PRODUCTO: req.body.NOM_PRODUCTO,
        PROVEEDOR:    req.body.PROVEEDOR,
        MARCA:        req.body.MARCA,
        PRECIO:       req.body.PRECIO,
        UNIDADES:     req.body.UNIDADES,
    }
    const sql = `CALL PROC_PRODUCTO(${objproducto.COD_EMPRESA},${objproducto.NOM_PRODUCTO},${objproducto.PROVEEDOR},${objproducto.MARCA},${objproducto.PRECIO},${objproducto.UNIDADES},'1','')`
    mysql.query(sql, error => {
        if (error) throw error;
        res.send('Los datos se insertaron correctamente')
    })
    console.log('Datos insertados correctamente');
});

////////ACTUALIZAR DATOS DE LA TABLA PRODUCTO///////////////


router.put('/producto/actualizar/:id', (req, res) => {
    const { id } = req.params;
    const objproducto = {
        COD_EMPRESA:  req.body.COD_EMPRESA,
        NOM_PRODUCTO: req.body.NOM_PRODUCTO,
        PROVEEDOR:    req.body.PROVEEDOR,
        MARCA:        req.body.MARCA,
        PRECIO:       req.body.PRECIO,
        UNIDADES:     req.body.UNIDADES,
    }
    const sql = `CALL PROC_PRODUCTO(${objproducto.COD_EMPRESA},${objproducto.NOM_PRODUCTO},${objproducto.PROVEEDOR},${objproducto.MARCA},${objproducto.PRECIO},${objproducto.UNIDADES},'2',${id})`
    mysql.query(sql, error => {
        if (error) throw error;
        res.send('Los datos se actualizaron correctamente')
    })
    console.log('Datos actualizados correctamente');
});

////////BORRAR DATOS DE LA TABLA PRODUCTO///////////////

router.delete('/producto/borrar/:id', (req, res) => {
    const { id } = req.params;
    const sql = `CALL PROC_PRODUCTO('?','?', '?', '?', '?', '?', 3,${id})` 
    mysql.query(sql, error => {
        if (error) throw error;
        res.send('Los datos fueron borrados correctamente')
    })
    console.log('Datos borrados correctamente');
});


module.exports = router;