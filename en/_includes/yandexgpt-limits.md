#### Quotas {#yandexgpt-quotas}

##### Text vectorization {#yandexgpt-quotas-vectorization}

| Type of limit | Value |
----- | -----
| Number of text vectorization requests per second | 10 |

##### Text generation {#yandexgpt-quotas-generation}

| Type of limit | {{ yagpt-name }} | {{ yagpt-name }} Lite and fine-tuned models |
----- | ----- | -----
| Number of concurrent generations | 0 | 1 |
| Number of requests per hour, [synchronous mode](../yandexgpt/concepts/index.md#working-mode) | 0^1^ | 100 |
| Number of requests per second, [asynchronous mode](../yandexgpt/concepts/index.md#working-mode) (request) | 10 | 10 |
| Number of requests per second, asynchronous mode (getting a response) | 50 | 50 |
| Number of requests per hour, asynchronous mode (request) | 5,000 | 5,000 |
| Number of tokenization requests per second | 50 | 50 |

^1^ Before you request a quota increase for using {{ yagpt-name }} in synchronous mode, please test it on your task in [asynchronous mode](../yandexgpt/operations/async-request.md).

#### Limits {#yandexgpt-limits}

##### Text vectorization {#yandexgpt-limits-vectorization}

| Type of limit | Value |
----- | -----
| Number of input tokens | 2,000 |

##### Text generation {#yandexgpt-limits-generation}

| Type of limit | {{ yagpt-name }} | {{ yagpt-name }} Lite and fine-tuned models |
----- | ----- | -----
| Number of tokens per response | 2,000 | 2,000 |
| Total number of tokens | {{ yagpt-max-tokens }} | {{ yagpt-max-tokens }} |
