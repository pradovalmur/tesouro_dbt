{{ config(materialized="table", schema="datavault") }}

with
    source_data as (
        select 
            {{ generate_hash(['INVESTIDORCODE', 'DATEACCESSION']) }} as hkAccount,
            {{ generate_hash(['INVESTIDORCODE', 'DATEACCESSION']) }} as hkInvestidor,
            CURRENT_TIMESTAMP() as load_dts
        from {{ ref("v_investidor") }}
    )

select * from source_data