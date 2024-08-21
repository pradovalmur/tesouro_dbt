{{ config(materialized="table", schema="datavault") }}

with
    source_data as (
        select 
            {{ generate_hash(['INVESTIDORCODE', 'DATEACCESSION']) }} as hkAccount,
            CURRENT_TIMESTAMP() as load_dts,
            DateAccession,
            account_status
        from {{ ref("v_investidor") }}
    )

select * from source_data