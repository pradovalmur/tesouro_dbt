{{ config(materialized="table", schema="datavault") }}

with
    source_data as (
        select 
            {{ generate_hash(['INVESTIDORCODE', 'DATEACCESSION']) }} as hkInvestidors,
            CURRENT_TIMESTAMP() as load_dts,
            MaritalStatus,
            Gender,
            Age,
            occupation
        from {{ ref("v_investidor") }}
    )

select * from source_data