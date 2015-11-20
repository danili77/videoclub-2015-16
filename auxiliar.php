<?php
function conectar()
{
    return pg_connect("host=localhost dbname=datos user=usuario 
                       password=usuario");    
}