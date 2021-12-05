{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('api_nested_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        adapter.quote('id'),
        'arr',
        adapter.quote('name'),
        'avatar',
        'profile',
        array_to_string('knownips'),
        'username',
        'createdat',
        array_to_string('otherdata'),
    ]) }} as _airbyte_api_nested_hashid,
    tmp.*
from {{ ref('api_nested_ab2') }} tmp
-- api_nested
where 1 = 1

