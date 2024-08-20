{{ config(materialized="table", schema="datavault") }}

with
    source_data as (
        select
            {{ generate_hash(['OPERATIONDATE', 'INVESTIDORCODE', 'QUANTITY']) }} as hkTransaction,
            {{ generate_hash(['STOCK']) }} as hkStock, 
            {{ generate_hash(['INVESTIDORCODE']) }} as hkAccount,
            CURRENT_TIMESTAMP() as load_dts 
        from {{ ref("v_operations") }}
    )

select * from source_data