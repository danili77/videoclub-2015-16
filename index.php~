<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <title>Videoclub</title>
    </head>
    <body><?php
        require 'auxiliar.php';

        function selected($value, $col)
        {    
            return ($value == $col) ? 'selected=on' : '';
        }

        $columnas = array(
            'numero'           => array(
                                    'bonito'   => 'Número',
                                    'criterio' => 'numero',
                                    'exacto'   => TRUE
            ),
            'dni'              => array(
                                    'bonito'   => 'DNI',
                                    'criterio' => 'dni',
                                    'exacto'   => TRUE
            ),
            'nombre'           => array(
                                    'bonito'   => 'Nombre',
                                    'criterio' => 'nombre'
            ),
            'direccion'        => array(
                                    'bonito'   => 'Dirección',
                                    'criterio' => 'direccion'
            ),
            'poblacion_nombre' => array(
                                    'bonito'   => 'Población',
                                    'criterio' => 'poblacion_nombre'
            ),
            'provincia_nombre' => array(
                                    'bonito'   => 'Provincia',
                                    'criterio' => 'provincia_nombre'
            ),
            'codpostal'        => array(
                                    'bonito'   => 'Código Postal',
                                    'criterio' => 'codpostal',
                                    'exacto'   => TRUE
            )
        );

        $criterio = isset($_GET['criterio']) ? trim($_GET['criterio']) : ''; 
        $columna  = isset($_GET['columna'])  ? trim($_GET['columna'])  : ''; ?>
        <div style="margin-bottom:15px;">
            <form action="index.php" method="get">
                <label for="criterio">Buscar:</label>
                <select name="columna"><?php
                    foreach ($columnas as $v): 
                        if (isset($v['criterio'])): ?>
                            <option value="<?= $v['criterio'] ?>" 
                                <?= selected($v['criterio'], $columna) ?> >
                                <?= $v['bonito'] ?>
                            </option><?php
                        endif;
                    endforeach; ?>
                </select>
                <input type="text" name="criterio" value="<?= $criterio ?>" />
                <input type="submit" value="Buscar" />
            </form>
        </div><?php
            
        $con = conectar();

        if ($criterio != ""):
            if (isset($columnas[$columna]['exacto'])):
                $where = "$columna::text = $1";
            else:
                $where = "formato($columna) like formato('%' || $1 || '%')";
            endif;
            $pqp   = array($criterio);
        else:
            $where = "true";
            $pqp   = array();
        endif;

        $res = pg_query_params($con, "select * from v_socios
                                      where $where", $pqp);

        if (pg_num_rows($res) > 0): ?>
            <div>
                <table border="1" style="margin: auto">
                    <thead><?php
                        foreach ($columnas as $v): ?>
                            <th> <?= $v['bonito'] ?></th><?php
                        endforeach; ?>
                        <th>Borrar</th>
                    </thead>
                    <tbody><?php
                        for ($i = 0; $i < pg_num_rows($res); $i++): 
                            $fila = pg_fetch_assoc($res, $i); ?>
                            <tr><?php
                                foreach ($columnas as $k => $v): ?>
                                    <td> <?= $fila[$k] ?> </td><?php
                                endforeach; ?>
                                <td>
                                    <form action="conf_borrar.php" method="get">
                                        <input type="hidden" name="id" value="<?= $fila['id'] ?>" />
                                        <input type="submit" value="Borrar" />
                                    </form>
                                </td>
                            </tr><?php
                        endfor; ?>
                    </tbody>
                </table>
            <div><?php
        endif; ?>
    </body>
</html>