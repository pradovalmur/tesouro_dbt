{{ config(materialized="table", schema="datavault") }}

with
    source_data as (
        select 
            {{ generate_hash(['STOCK']) }} as hkstock, 
            CURRENT_TIMESTAMP() as load_dts,
            type,
            stock,
            DueDate,
            stockValue,
            stockDate
        from {{ ref("v_stock") }}
    )

select * from source_data