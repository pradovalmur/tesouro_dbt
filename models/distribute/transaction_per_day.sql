{{ config(materialized="view", schema="distribute") }}

with source_data as (
    select 
     c.date,
     sum(quantity),
     sum(valueOperation)
    from {{ ref("l_operations") }} as lo
    inner join {{ ref("s_operations") }} as st on lo.HKTRANSACTION = st.HKTRANSACTION
    inner join {{ source("tesouro", "calendar") }} as c on st.operationdate = c.date
    group by c.date
)
select * from source_data