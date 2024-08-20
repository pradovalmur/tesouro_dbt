{{ config(materialized="table", schema="datavault") }}

with
    source_data as (
        select 
            {{ generate_hash(['STOCK']) }} as hkstock, 
            CURRENT_TIMESTAMP() as load_dts,
            'stock' as rec_src
        from {{ ref("v_stock") }}
    )

select * from source_data
