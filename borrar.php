<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
    </head>
    <body><?php
        require 'auxiliar.php';

        if (!isset($_POST['id'])):
            header("Location: index.php");
            return;
        endif;

        $id = trim($_POST['id']);

        $con = conectar();

        $res = pg_query_params($con, "delete from socios
                                       where id::text = $1", array($id));

        if (pg_affected_rows($res) == 1): ?>
            <h3>Socio borrado correctamente.</h3><?php
        else: ?>
            <h3>No ha sido posible borrar el socio.</h3><?php 
        endif; ?>
        <a href="index.php"><input type="button" value="Volver" /></a>
    </body>
</html>