<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
    </head>
    <body><?php
        require 'auxiliar.php';
            if (!isset($_GET['id'])):
                header("Location: index.php");
                return;
            endif;
        $con = conectar();

        $id = trim($_GET['id']);

        $fila = pg_query_params($con, "select * from socios where id::text = $1", array($id));
        
        $a = pg_fetch_assoc($fila);
        ?>  
        <h3>¿Está seguro de que quiere borrar el socio siguiente?</h3>
        <p>Número: <?= $a['numero'] ?></p>
        <p>Nombre: <?= $a['nombre'] ?></p>
        <form action="borrar.php" method="post">
            <input type="hidden" name="id" value="<?= $id ?>" />
            <input type="submit" value="Sí" />
            <a href="index.php"><input type="button" value="No" /></a>
        </form>
    </body>
</html>