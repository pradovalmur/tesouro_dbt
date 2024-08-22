{{ config(materialized="table", schema="datavault") }}

with
    source_data as (
        select
            {{ generate_hash(['OPERATIONDATE', 'INVESTIDORCODE', 'QUANTITY']) }} as hkTransaction,
             CURRENT_TIMESTAMP() as load_dts,
             OPERATIONDATE,
             QUANTITY,
             VALUEOPERATION,
             TYPEOPERATIONNAME,
             CHANNELNAME
        from {{ ref("v_operations") }}
    )

select * from source_data
