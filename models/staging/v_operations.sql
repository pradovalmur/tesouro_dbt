-- models/operations.sql

{{ config(
    materialized='view'
) }}

with source_data as (
    select 
        codigodonegociador as CodigoNegociador,
        to_date(datadaoperacao, 'DD/MM/YYYY') as DataOperacao,
        tipotitulo as TipoTitulo,
        concat(tipotitulo, '-', to_date(vencimentodotitulo, 'DD/MM/YYYY')) as titulo,
        to_date(vencimentodotitulo, 'DD/MM/YYYY') as VencimentoTitulo,
        cast(replace(quantidade, ',', '.') as float) as quantidade,
        cast(replace(valordotitulo, ',', '.')as float) as ValorTitulo,
        cast(replace(valordaoperacao, ',', '.')as float) as ValorOperacao,
        b.channelname,
        c.typeoperationname
    from  {{ source("tesouro", "operations") }} as a
    inner join {{ source("tesouro", "channel") }} as b on a.canaldaoperacao = b.channeltype
    inner join {{ source("tesouro", "type_operation") }} as c on a.tipodaoperacao = c.typeoperation
)

select * from source_data