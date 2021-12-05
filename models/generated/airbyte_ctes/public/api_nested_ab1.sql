{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('public', var('raw_table')) }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as {{ adapter.quote('id') }},
    {{ json_extract_scalar('_airbyte_data', ['arr'], ['arr']) }} as arr,
    {{ json_extract_scalar('_airbyte_data', ['name'], ['name']) }} as {{ adapter.quote('name') }},
    {{ json_extract_scalar('_airbyte_data', ['avatar'], ['avatar']) }} as avatar,
    {{ json_extract('table_alias', '_airbyte_data', ['profile'], ['profile']) }} as profile,
    {{ json_extract_array('_airbyte_data', ['knownIps'], ['knownIps']) }} as knownips,
    {{ json_extract_scalar('_airbyte_data', ['username'], ['username']) }} as username,
    {{ json_extract_scalar('_airbyte_data', ['createdAt'], ['createdAt']) }} as createdat,
    {{ json_extract_array('_airbyte_data', ['otherData'], ['otherData']) }} as otherdata,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('public', var('raw_table')) }} as table_alias
-- api_nested
where 1 = 1

