---
sourcePath: en/_sdk-ref/sdk-ref/retry.md
---
# Request retries

Some general info about how retries works

## Retries configuration

### *class* yandex\_cloud\_ml\_sdk.\_retry.**RetryPolicy**{#yandex_cloud_ml_sdk._retry.RetryPolicy}

A class that defines a retry policy for network operations.

**max\_attempts**\: *[int](https://docs.python.org/3/library/functions.html#int)* = *5*{#yandex_cloud_ml_sdk._retry.RetryPolicy.max_attempts}

the maximum number of retry attempts

**initial\_backoff**\: *[float](https://docs.python.org/3/library/functions.html#float)* = *1*{#yandex_cloud_ml_sdk._retry.RetryPolicy.initial_backoff}

the initial backoff time (in seconds)

**max\_backoff**\: *[float](https://docs.python.org/3/library/functions.html#float)* = *10*{#yandex_cloud_ml_sdk._retry.RetryPolicy.max_backoff}

the maximum backoff time (in seconds)

**backoff\_multiplier**\: *[float](https://docs.python.org/3/library/functions.html#float)* = *1.5*{#yandex_cloud_ml_sdk._retry.RetryPolicy.backoff_multiplier}

the multiplier applied to the backoff after each attempt

**jitter**\: *[float](https://docs.python.org/3/library/functions.html#float)* = *1*{#yandex_cloud_ml_sdk._retry.RetryPolicy.jitter}

the maximum amount of jitter to add to the backoff

**retriable\_codes**\: *[Iterable](https://docs.python.org/3/library/typing.html#typing.Iterable)[[StatusCode](https://grpc.github.io/grpc/python/grpc.html#grpc.StatusCode)*] = *(StatusCode.UNAVAILABLE, StatusCode.RESOURCE\_EXHAUSTED)*{#yandex_cloud_ml_sdk._retry.RetryPolicy.retriable_codes}

the grpc status codes that are considered retriable

**get\_interceptors**(){#yandex_cloud_ml_sdk._retry.RetryPolicy.get_interceptors}

#|
|| Return type | [tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[*ClientInterceptor*](https://grpc.github.io/grpc/python/grpc_asyncio.html#grpc.aio.ClientInterceptor), …] ||
|#

*async* **sleep**(*attempt*, *deadline*){#yandex_cloud_ml_sdk._retry.RetryPolicy.sleep}

#|
|| Parameters | 

- **attempt** ([*int*](https://docs.python.org/3/library/functions.html#int))
- **deadline** ([*float*](https://docs.python.org/3/library/functions.html#float) *\| None*) ||
|| Return type | None ||
|#

## Interceptors impletentation

### *class* yandex\_cloud\_ml\_sdk.\_retry.**UnaryUnaryRetryInterceptor**{#yandex_cloud_ml_sdk._retry.UnaryUnaryRetryInterceptor}

#|
|#

### *class* yandex\_cloud\_ml\_sdk.\_retry.**UnaryStreamRetryInterceptor**{#yandex_cloud_ml_sdk._retry.UnaryStreamRetryInterceptor}

#|
|#