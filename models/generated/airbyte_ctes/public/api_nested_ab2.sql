{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('api_nested_ab1') }}
select
    cast({{ adapter.quote('id') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('id') }},
    cast(arr as {{ dbt_utils.type_string() }}) as arr,
    cast({{ adapter.quote('name') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('name') }},
    cast(avatar as {{ dbt_utils.type_string() }}) as avatar,
    cast(profile as {{ type_json() }}) as profile,
    knownips,
    cast(username as {{ dbt_utils.type_string() }}) as username,
    cast(createdat as {{ dbt_utils.type_string() }}) as createdat,
    otherdata,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('api_nested_ab1') }}
-- api_nested
where 1 = 1

