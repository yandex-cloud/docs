# Обработчик запросов функции на Python

_Обработчик запросов_ — это метод, который используется для обработки каждого вызова функции на Python. При создании версии функции необходимо указать точку входа, которая состоит из имени файла и имени обработчика запросов, например `main.handler`. В названии файла с обработчиком не должно быть символа `.` до расширения, например `.handler.py`.

{% note info %}

В каждый момент времени один экземпляр функции обрабатывает только один запрос. Это позволяет использовать глобальные переменные без необходимости обеспечивать контроль целостности данных.

{% endnote %}

При вызове обработчика среда выполнения передает следующие аргументы:
1. Тело запроса (параметр `event`):
    * Если тело запроса — [JSON-документ](../../concepts/function-invoke.md#request), то оно будет преобразовано в `dict` с помощью метода `json.loads`.
    * Если функция была вызвана с параметром строки запроса `?integration=raw`, тело HTTP-запроса передается в функцию как есть, без обработки.
1. [Контекст вызова](context.md) (параметр `context`). 

    Контекст содержит необходимую информацию о версии функции. Структура этого объекта описана в разделе [{#T}](context.md).
    
## Виды обработчика {#type}

Функция может использовать как синхронный, так и асинхронный обработчик.

## Синхронный обработчик {#sync}

Чтобы вернуть результат выполнения, используйте оператор `return` или сигнализируйте об исключении с помощью оператора `raise`. Синхронная функция обязана возвращать результат или завершаться исключением.

## Асинхронный обработчик {#async}

Обработчик может быть асинхронной функцией `async def`. В этом случае вы можете использовать следующие операторы: 
* `return` — возвращает ответ функции.
* `raise` — сообщает среде выполнения об ошибке.
* `await` — отслеживает выполнение вызова асинхронных функций.

{% note info %}

В качестве среды исполнения асинхронных функций поддерживается только библиотека `asyncio`. 

{% endnote %}

Подробнее о разработке с помощью `async/await` читайте в [соответствующем разделе документации](https://docs.python.org/3.7/library/asyncio.html).

## Примеры {#examples}

### Вывод структуры HTTP-запроса {#http-req}

Следующая функция выводит структуру запроса и контекста вызова одновременно и в журнал выполнения, и в ответ функции:

```python
import json


def handler(event, context):
    return {
        'statusCode': 200,
        'body': json.dumps(
            {
                'event': event,
                'context': context,
            }, 
            default=vars,
        ),
    }
```

Пример вызова функции:

```
curl --data '{"hello": "world"}' -H 'Content-Type: application/json' https://{{ sf-url }}/<идентификатор_функции>?param=one
```

Результат:

```bash
{
    "context": {
        "aws_request_id": "6e8356f9-489b-4c7b-8ba6-c8cd********",
        "deadline_ms": 1657713543198,
        "function_name": "d4eo2faf62**********",
        "function_version": "d4e3vrugh3**********",
        "invoked_function_arn": "d4eo2faf62**********",
        "log_group_name": "ckgjmanjlh**********",
        "log_stream_name": "d4e3vrugh3**********",
        "memory_limit_in_mb": 128,
        "request_id": "6e8356f9-489b-4c7b-8ba6-c8cd********",
        "token": {
            "access_token": "<IAM-токен>",
            "expires_in": 42299,
            "token_type": "Bearer"
        }
    },
    "event": {
        "body": "{\"hello\": \"world\"}",
        "headers": {
            "Accept": "*/*",
            "Content-Length": "18",
            "Content-Type": "application/json",
            "Host": "{{ sf-url }}",
            "User-Agent": "curl/7.64.1",
            "X-Forwarded-For": "109.252.148.209",
            "X-Real-Remote-Address": "[109.252.148.209]:2816",
            "X-Request-Id": "6e8356f9-489b-4c7b-8ba6-c8cd********",
            "X-Trace-Id": "e9fe9b05-c1aa-4fb8-94d8-a514********"
        },
        "httpMethod": "POST",
        "isBase64Encoded": false,
        "multiValueHeaders": {
            "Accept": [
                "*/*"
            ],
            "Content-Length": [
                "18"
            ],
            "Content-Type": [
                "application/json"
            ],
            "Host": [
                "{{ sf-url }}"
            ],
            "User-Agent": [
                "curl/7.64.1"
            ],
            "X-Forwarded-For": [
                "109.252.148.209"
            ],
            "X-Real-Remote-Address": [
                "[109.252.148.209]:2816"
            ],
            "X-Request-Id": [
                "6e8356f9-489b-4c7b-8ba6-c8cd********"
            ],
            "X-Trace-Id": [
                "e9fe9b05-c1aa-4fb8-94d8-a514********"
            ]
        },
        "multiValueParams": {},
        "multiValueQueryStringParameters": {
            "param": [
                "one"
            ]
        },
        "params": {},
        "pathParams": {},
        "queryStringParameters": {
            "param": "one"
        },
        "requestContext": {
            "httpMethod": "POST",
            "identity": {
                "sourceIp": "109.252.148.209",
                "userAgent": "curl/7.64.1"
            },
            "requestId": "6e8356f9-489b-4c7b-8ba6-c8cd********",
            "requestTime": "13/Jul/2022:11:58:59 +0000",
            "requestTimeEpoch": 1657713539
        },
        "url": ""
    }
}
```

