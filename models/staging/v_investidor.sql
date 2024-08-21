-- models/staging/investidors.sql

{{ config(
    materialized='view'
) }}

with source_data as (
    select 
        a.codigodonegociador as InvestidorCode,
        to_date(a.datadaadesao, 'DD/MM/YYYY') as DateAccession,
        a.estadocivil as MaritalStatus,
        g.gendername as Gender,
        a.profissao as occupation,
        to_numeric(a.idade) as Age,
        u.name as StateName,
        a.cidadedonegociador as city,
        a.paisnegociador as country,
        a.situacaodaconta as account_status
    from  {{ source("tesouro", "investidors") }} as a
    inner join {{ source("tesouro", "Gender") }} as g on a.genero = GenderId
    inner join {{ source("tesouro","uf") }} as u on a.ufdonegociador = u.uf
)

select * from source_data