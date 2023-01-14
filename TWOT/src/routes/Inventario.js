const express = require('express');
const mysql = require("../database");
const router = express.Router();
////////LEER DATOS DE LA TABLA INVENTARIO///////////////
router.get(["/inventario/", "/leer"], (req, res) => {
    const sql = `CALL PROC_INVENTARIO('?','?', '?', '?', '?', '?', '?', 4, '')`
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

////////LEER DATOS POR ID O FILA DE LA TABLA INVENTARIO///////////////

router.get('/inventario/:cod', (req, res) => {
    const { cod } = req.params
    const sql = `CALL PROC_INVENTARIO('?','?', '?', '?', '?', '?', '?', 5, ${cod})`
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

////////INSERTAR DATOS DE LA TABLA INVENTARIO///////////////


router.post('/inventario/insertar', (req, res) => {
    const objinventario = {
        COD_PRODUCTO: req.body.COD_PRODUCTO,
        COD_EMPRESA: req.body.COD_EMPRESA,
        NOM_PRODUCTOS: req.body.NOM_PRODUCTOS,
        PROVEEDORES:   req.body.PROVEEDORES,
        MARCA:         req.body.MARCA,
        UNIDADES:      req.body.UNIDADES,
        CATEGORIAS:    req.body.CATEGORIAS,
    }
    const sql = `CALL PROC_INVENTARIO(${objinventario.COD_PRODUCTO},${objinventario.COD_EMPRESA},${objinventario.NOM_PRODUCTOS},${objinventario.PROVEEDORES},${objinventario.MARCA},${objinventario.UNIDADES},${objinventario.CATEGORIAS},'1','')`
    mysql.query(sql, error => {
        if (error) throw error;
        res.send('Los datos se insertaron correctamente')
    })
    console.log('Datos insertados correctamente');
});

////////ACTUALIZAR DATOS DE LA TABLA INVENTARIO///////////////


router.put('/inventario/actualizar/:id', (req, res) => {
    const { id } = req.params;
    const objinventario = {
        COD_PRODUCTO: req.body.COD_PRODUCTO,
        COD_EMPRESA: req.body.COD_EMPRESA,
        NOM_PRODUCTOS: req.body.NOM_PRODUCTOS,
        PROVEEDORES:   req.body.PROVEEDORES,
        MARCA:         req.body.MARCA,
        UNIDADES:      req.body.UNIDADES,
        CATEGORIAS:    req.body.CATEGORIAS,
    }
    const sql = `CALL PROC_INVENTARIO(${objinventario.COD_PRODUCTO},${objinventario.COD_EMPRESA},${objinventario.NOM_PRODUCTOS},${objinventario.PROVEEDORES},${objinventario.MARCA},${objinventario.UNIDADES},${objinventario.CATEGORIAS},'2',${id})`
    mysql.query(sql, error => {
        if (error) throw error;
        res.send('Los datos se actualizaron correctamente')
    })
    console.log('Datos actualizados correctamente');
});

////////BORRAR DATOS DE LA TABLA INVENTARIO///////////////

router.delete('/inventario/borrar/:id', (req, res) => {
    const { id } = req.params;
    const sql = `CALL PROC_INVENTARIO('?','?', '?', '?', '?', '?', '?', 3, ${id})`
    mysql.query(sql, error => {
        if (error) throw error;
        res.send('Los datos fueron borrados correctamente')
    })
    console.log('Datos borrados correctamente');
});


module.exports = router;