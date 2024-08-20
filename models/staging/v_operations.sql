-- models/staging/operations.sql

{{ config(
    materialized='view'
) }}

with source_data as (
    select 
        codigodonegociador as investidorCode,
        to_date(datadaoperacao, 'DD/MM/YYYY') as OperationDate,
        tipotitulo as TypeStock,
        concat(tipotitulo, '-', to_date(vencimentodotitulo, 'DD/MM/YYYY')) as stock,
        to_date(vencimentodotitulo, 'DD/MM/YYYY') as duedate,
        cast(replace(quantidade, ',', '.') as float) as quantity,
        cast(replace(valordotitulo, ',', '.')as float) as valueStock,
        cast(replace(valordaoperacao, ',', '.')as float) as valueoperation,
        b.channelname,
        c.typeoperationname
    from  {{ source("tesouro", "operations") }} as a
    inner join {{ source("tesouro", "channel") }} as b on a.canaldaoperacao = b.channeltype
    inner join {{ source("tesouro", "TypeOperation") }} as c on a.tipodaoperacao = c.typeoperation
)

select * from source_data