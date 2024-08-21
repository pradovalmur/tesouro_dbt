{{ config(materialized="table", schema="datavault") }}

with
    source_data as (
        select 
            {{ generate_hash(['INVESTIDORCODE', 'DATEACCESSION']) }} as hkInvestidors,
            CURRENT_TIMESTAMP() as load_dts,
            StateName,
            city,
            country
        from {{ ref("v_investidor") }}
    )

select * from source_data