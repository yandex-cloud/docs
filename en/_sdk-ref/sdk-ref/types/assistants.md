# Expiration types

yandex\_ai\_studio\_sdk.\_types.expiration.**ExpirationProtoTypeT** = *TypeVar(ExpirationProtoTypeT, bound=Union)*{#yandex_ai_studio_sdk._types.expiration.ExpirationProtoTypeT}

**Type:**[**TypeVar**](https://docs.python.org/3/library/typing.html#typing.TypeVar)

Invariant [**TypeVar**](https://docs.python.org/3/library/typing.html#typing.TypeVar) bound to [**typing.Union**](https://docs.python.org/3/library/typing.html#typing.Union)[**yandex.cloud.ai.assistants.v1.searchindex.search\_index\_pb2.SearchIndex**, **yandex.cloud.ai.files.v1.file\_pb2.File**].

## *class* yandex\_ai\_studio\_sdk.\_types.expiration.**ExpirationPolicy**{#yandex_ai_studio_sdk._types.expiration.ExpirationPolicy}

**STATIC** = *1*{#yandex_ai_studio_sdk._types.expiration.ExpirationPolicy.STATIC}

**SINCE\_LAST\_ACTIVE** = *2*{#yandex_ai_studio_sdk._types.expiration.ExpirationPolicy.SINCE_LAST_ACTIVE}

## *class* yandex\_ai\_studio\_sdk.\_types.expiration.**ExpirationConfig**{#yandex_ai_studio_sdk._types.expiration.ExpirationConfig}

ExpirationConfig(ttl\_days: ‘int | None’ = None, expiration\_policy: ‘ExpirationPolicy | None’ = None)

**ttl\_days**\: *[int](https://docs.python.org/3/library/functions.html#int) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_ai_studio_sdk._types.expiration.ExpirationConfig.ttl_days}

**expiration\_policy**\: *[ExpirationPolicy](#yandex_ai_studio_sdk._types.expiration.ExpirationPolicy) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_ai_studio_sdk._types.expiration.ExpirationConfig.expiration_policy}

*classmethod* **coerce**(*ttl\_days*, *expiration\_policy*){#yandex_ai_studio_sdk._types.expiration.ExpirationConfig.coerce}

#|
|| Parameters | 

- **ttl\_days** ([*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](other.md#yandex_ai_studio_sdk._types.misc.Undefined))
- **expiration\_policy** ([*ExpirationPolicy*](#yandex_ai_studio_sdk._types.expiration.ExpirationPolicy) *\|* [*Literal*](https://docs.python.org/3/library/typing.html#typing.Literal)*[1, 2] \| ~typing.Literal['STATIC', 'SINCE\_LAST\_ACTIVE'] \| ~typing.Literal['static', 'since\_last\_active'] \| ~yandex\_ai\_studio\_sdk.\_types.misc.Undefined*) ||
|| Return type | [*ExpirationConfig*](#yandex_ai_studio_sdk._types.expiration.ExpirationConfig) ||
|#

**to\_proto**(){#yandex_ai_studio_sdk._types.expiration.ExpirationConfig.to_proto}

#|
|| Return type | *ExpirationConfig* \| None ||
|#

**\_\_init\_\_**(*ttl\_days=None*, *expiration\_policy=None*){#yandex_ai_studio_sdk._types.expiration.ExpirationConfig.__init__i}

#|
|| Parameters | 

- **ttl\_days** ([*int*](https://docs.python.org/3/library/functions.html#int) *\| None*)
- **expiration\_policy** ([*ExpirationPolicy*](#yandex_ai_studio_sdk._types.expiration.ExpirationPolicy) *\| None*) ||
|| Return type | None ||
|#

yandex\_ai\_studio\_sdk.\_types.expiration.**ExpirationPolicyAlias**{#yandex_ai_studio_sdk._types.expiration.ExpirationPolicyAlias}

alias of [**ExpirationPolicy**](#yandex_ai_studio_sdk._types.expiration.ExpirationPolicy) | [**Literal**](https://docs.python.org/3/library/typing.html#typing.Literal)[1, 2] | [**Literal**](https://docs.python.org/3/library/typing.html#typing.Literal)[‘STATIC’, ‘SINCE\_LAST\_ACTIVE’] | [**Literal**](https://docs.python.org/3/library/typing.html#typing.Literal)[‘static’, ‘since\_last\_active’]

## *class* yandex\_ai\_studio\_sdk.\_types.expiration.**ExpirationPolicyAlias**{#yandex_ai_studio_sdk._types.expiration.yandex_ai_studio_sdk._types.expiration.ExpirationPolicyAlias}