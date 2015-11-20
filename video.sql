drop table if exists provincias cascade;

create table provincias (
    id     int         constraint pk_provincias primary key,
    nombre varchar(50) not null
);

insert into provincias (id, nombre)
values (0, 'Desconocida'),
       (1, 'Araba'),
       (2, 'Albacete'),
       (3, 'Alacant'),
       (4, 'Almería'),
       (5, 'Ávila'),
       (6, 'Badajoz'),
       (7, 'Balears'),
       (8, 'Barcelona'),
       (9, 'Burgos'),
       (10, 'Cáceres'),
       (11, 'Cádiz');

drop table if exists poblaciones cascade;

create table poblaciones (
    id           bigserial    constraint pk_poblaciones primary key,
    nombre       varchar(100) not null,
    provincia_id int          default 0 not null constraint fk_poblaciones_provincias 
                                                 references provincias (id) 
                                                 on delete set default 
                                                 on update cascade
);

insert into poblaciones (nombre, provincia_id)
values ('Sanlúcar de Barrameda', 11),
       ('Chipiona', 11);
       
drop table if exists socios cascade;

create table socios (
    id           bigserial    constraint pk_socios primary key,
    numero       numeric(13)  not null constraint uq_socios_numero unique,
    dni          char(9),
    nombre       varchar(100) not null,
    direccion    varchar(150),
    poblacion_id bigint       constraint fk_socios_poblaciones 
                              references poblaciones (id) 
                              on delete set null 
                              on update cascade,
    codpostal    numeric(5)
);

insert into socios (numero, dni, nombre, direccion, poblacion_id, codpostal)
values (1000, '11111111A', 'Juan Rodríguez', 'C/ Falsa 123', 1, 11540),
       (1001, '22222222B', 'María González', 'C/ Ancha 23', 2, 11550);
       
drop function if exists formato(cadena text) cascade;

create function formato(cadena text) returns text as $$
    begin
        return translate(upper(cadena), 'ÁÉÍÓÚ', 'AEIOU');
    end;
$$ language plpgsql;

create view v_socios as
select s.*, po.nombre as poblacion_nombre, pr.nombre as provincia_nombre
  from socios s left join poblaciones po
    on poblacion_id = po.id 
  join provincias pr 
    on provincia_id = pr.id;
    


