{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "public",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('api_nested_ab3') }}
select
    {{ adapter.quote('id') }},
    arr,
    {{ adapter.quote('name') }},
    avatar,
    profile,
    knownips,
    username,
    createdat,
    otherdata,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_api_nested_hashid
from {{ ref('api_nested_ab3') }}
-- api_nested from {{ source('public', '_airbyte_raw_api_nested') }}
where 1 = 1

