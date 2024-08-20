-- models/staging/v_stock.sql
{{ config(
    materialized='view'
) }}

with source_data as (
    SELECT 
        concat(tipotitulo, '-', to_date(vencimentodotitulo, 'DD/MM/YYYY')) as stock,
        to_date(concat('01/',mesestoque), 'DD/MM/YYYY') as mesestoque,
        tipotitulo,
        to_date(vencimentodotitulo, 'DD/MM/YYYY') as vencimentotitulo,
        pu,
        quantidade,
        valorestoque
    FROM  {{ source("tesouro", "stock") }} as a

),

min_stock_value as (
                    select 
                    STOCK,
                    min(MESESTOQUE) as min_mes_estoque
                    from source_data
                    group by stock
)

select 
   a.STOCK,
   TIPOTITULO as type,
   vencimentotitulo as DueDate,
   PU as stockvalue,
   QUANTIDADE as Quantity,
   VALORESTOQUE as stocktotalvalue,
   MESESTOQUE as StockDate
from source_data as a
inner join min_stock_value as b on a.STOCK = b.stock and a.mesestoque = b.min_mes_estoque

