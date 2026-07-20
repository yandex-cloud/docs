[Документация Yandex Cloud](../../../index.md) > [Monium](../../index.md) > [Трейсы](../index.md) > LLM-мониторинг > Ручная инструментация LLM-приложений

# Ручная инструментация LLM-приложений

Ручная инструментация LLM-приложений дает полный контроль над трейсами. Вы можете выбирать, какие операции размечать спанами, какие атрибуты добавлять и как выстраивать иерархию вызовов.

Ручная инструментация полезна в следующих случаях:

- Фреймворк не поддерживается [автоинструментацией](auto_instrumentation.md).
- Нужно добавить бизнес-контекст: ID пользователя, ID сессии, версию промпта, параметры A/B-теста.
- Требуется разметить сложную логику агента: маршрутизацию между LLM, предобработку данных, постобработку ответов.
- Необходимо инструментировать модифицированные инструменты (tools), не покрытые автоинструментацией.

Для ручной инструментации используется [OpenTelemetry SDK](https://opentelemetry.io/docs/languages/) и [семантические конвенции OpenTelemetry для GenAI](https://github.com/open-telemetry/semantic-conventions-genai). В этом разделе приведены примеры разметки для Python.

## Основные соглашения {#conventions}

Следуйте этим соглашениям для корректного отображения трейсов:

1. **Стандарт OpenTelemetry.** Используйте атрибуты из [стандарта OpenTelemetry для GenAI](https://github.com/open-telemetry/semantic-conventions-genai).
2. **Изоляция сервисов.** Каждый LLM-агент должен отправлять спаны с уникальным значением атрибута `service.name`. Это важно для корректной фильтрации данных в системе мониторинга.
3. **Обязательные атрибуты.** Часть атрибутов обязательна для корректной визуализации в интерфейсе — они перечислены в [таблице ниже](#required-attributes).

## Обязательные атрибуты спанов генерации {#required-attributes}

Чтобы трейсы корректно отображались в специализированном интерфейсе LLM-мониторинга Monium Traces, укажите перечисленные ниже атрибуты. По таблице можно понять, какие данные нужны для отображения каждого элемента интерфейса.

#|
|| **Какие данные** | **Атрибут** | **Тип** | **Комментарий** ||
|| Количество токенов во входных данных | `gen_ai.usage.input_tokens` | int | ||
|| Количество токенов в ответе | `gen_ai.usage.output_tokens` | int | ||
|| Входные сообщения (промпты, история диалога, результаты вызова инструментов) | `gen_ai.input.messages` | JSON array | Формат — подробнее в [разделе «Формат сообщений»](#messages-format) ||
|| Системный промпт | `gen_ai.system_instructions` или элемент с `role == system` в `gen_ai.input.messages` | JSON / string | Системное сообщение отдельно от истории чата. При использовании `gen_ai.input.messages` передавайте в элементе с `role == system` и полем `parts` ||
|| Ответ модели | `gen_ai.output.messages` | JSON array | Формат — подробнее в [разделе «Формат сообщений»](#messages-format) ||
|| Тип операции | `gen_ai.operation.name` | string | Определяет отображение спана. Допустимые значения: `chat`, `text_completion`, `create_agent`, `invoke_agent`, `execute_tool`, `embeddings`, `generate_content` ||
|| Название ответившей модели | `gen_ai.response.model` | string | ||
|| Список доступных инструментов (tools) | `gen_ai.tool.definitions` | JSON array | Сигнатуры тулов для LLM. В интерфейсе отображается блок «Доступные инструменты» ||
|#

Кроме указанных атрибутов в стандарте OpenTelemetry описаны и другие полезные атрибуты для GenAI-спанов, такие как `gen_ai.system`, `gen_ai.request.model`, `gen_ai.tool.definitions` и другие. Полный список с описаниями приведен в [конвенции OpenTelemetry для GenAI](https://github.com/open-telemetry/semantic-conventions-genai).

### Формат сообщений {#messages-format}

Атрибуты `gen_ai.input.messages` и `gen_ai.output.messages` содержат JSON, сериализованный в строку. Не упрощайте структуру до `{role, content}` — используйте поле `parts` с указанием `type`.

**Системный промпт** можно передать двумя способами: элементом с `role == system` внутри `gen_ai.input.messages` (примеры ниже) или отдельным атрибутом `gen_ai.system_instructions` (JSON-массив с объектами `{ "type": "text", "content": "..." }`).

**Входные сообщения** (`gen_ai.input.messages`):

```
[{
    "role": "user",
    "parts": [
      {
        "type": "text",
        "content": "Weather in Paris?"
      }
    ]
  },
  {
    "role": "assistant",
    "parts": [
      {
        "type": "tool_call",
        "id": "call_VSPygqKTWdrhaFErNvMV18Yl",
        "name": "get_weather",
        "arguments": {
          "location": "Paris"
        }
      }
    ]
  },
  {
    "role": "tool",
    "parts": [
      {
        "type": "tool_call_response",
        "id": " call_VSPygqKTWdrhaFErNvMV18Yl",
        "result": "rainy, 57°F"
      }
    ]
  }
]
```
Подробная JSON Schema для входных сообщений доступна в [документации OpenTelemetry](https://github.com/open-telemetry/semantic-conventions-genai/blob/main/model/gen-ai/gen-ai-input-messages.json).

**Выходные сообщения** (`gen_ai.output.messages`):

```json
[
  {
    "role": "assistant",
    "parts": [
      {
        "type": "text",
        "content": "The weather in Paris is currently rainy with a temperature of 57°F."
      }
    ],
    "finish_reason": "stop"
  }
]
ИЛИ
[
  {
    "role": "assistant",
    "parts": [
      {
        "type": "tool_call",
        "id": "call_VSPygqKTWdrhaFErNvMV18Yl",
        "name": "get_weather",
        "arguments": {
          "location": "Paris"
        }
      }
    ],
    "finish_reason": "tool_call"
  }
]
```
Подробная JSON Schema для выходных сообщений доступна в [документации OpenTelemetry](https://github.com/open-telemetry/semantic-conventions-genai/blob/main/model/gen-ai/gen-ai-output-messages.json).

Если модель вызывает инструмент, выходное сообщение должно содержать `parts` с типом `tool_call`:

```json
[
  {
    "role": "assistant",
    "parts": [
      {
        "type": "tool_call",
        "id": "call_abc123",
        "name": "get_weather",
        "arguments": {
          "location": "Paris"
        }
      }
    ],
    "finish_reason": "tool_call"
  }
]
```

Результат выполнения инструмента передается в следующем запросе к модели в `gen_ai.input.messages` с `role == tool`:

```json
[
  {
    "role": "tool",
    "parts": [
      {
        "type": "tool_call_response",
        "id": "call_abc123",
        "response": "rainy, 18°C"
      }
    ]
  }
]
```

{% cut "Пример отображения спана с диалогом с LLM-агентом" %}
       
![image](../../../_assets/monium/llm-span-example.png)
       
{% endcut %}


### Изображения в спанах {#images}

Изображения из диалога с моделью автоматически отображаются в спане, если они корректно описаны в атрибутах `gen_ai.input.messages` и `gen_ai.output.messages`. Отдельные спаны для изображений не нужны, так как изображения уже входят в историю сообщений.

Изображение описывается в форме объекта, входящего в массив `parts` наряду с текстовыми запросами, ответами модели, вызовами инструментов и их ответами. Изображение может входить в состав как запроса пользователя (`gen_ai.input.messages`), так и ответа модели (`gen_ai.output.messages`).

Структура фрагмента массива `parts` с изображением:

```json
"parts": [
  ...
  {
    "type": "uri",
    "modality": "image",
    "uri": "https://cdn.example.com/some_image.jpg",
    "mime_type": "image/jpeg"
  },
  ...
]
```

Где:

* `type` — для объектов с описанием изображения значение всегда `uri`.
* `modality` — для объектов с описанием изображения значение всегда `image`.
* `uri` — прямая ссылка на изображение со схемой `https://`.
* `mime_type` — [MIME-тип](https://ru.wikipedia.org/wiki/Список_MIME-типов) файла:

    * `image/jpeg`;
    * `image/png`;
    * `image/webp`;
    * `image/gif`;
    * `image/svg+xml`.

{% note info %}

Все четыре параметра являются обязательными.

{% endnote %}

Одно сообщение может содержать несколько частей разных типов, например текст и изображение. В интерфейсе Monium все части отобразятся в спане в той последовательности, в которой они указаны в массиве `parts`. При этом изображения автоматически отображаются внутри спана в виде превью в тот момент, когда соответствующий спан попадает в область видимости на экране. Чтобы открыть полноразмерную версию изображения, нажмите на превью.

#### Требования к ссылке на изображение {#image-link-format}

Monium не проксирует изображения, передаваемые в LLM-трейсах. Браузер пользователя загружает их напрямую из источника, указанного в ссылке. Поэтому URL изображений должны соответствовать следующим требованиям:

* **Схема URL**: допускается только `https://`.

    Ссылки со схемой `http://` браузер заблокирует как `mixed content`. Ссылки на изображения со схемой `data:` и кодированием [Base64](https://ru.wikipedia.org/wiki/Base64) не поддерживаются `Monium`.

    {% note tip %}

    Получить ссылку со схемой `https://` вы можете, загрузив изображение в [бакет](*buckets) Yandex Object Storage или на [ресурс](*cdn_resource) Yandex Cloud CDN.

    {% endnote %}

* **Доступность из браузера пользователя**: если браузер не имеет доступа к изображению, изображение не отобразится в спане Monium. Например, ссылка на ресурс в интранете не откроется в браузере компьютера, не подключенного к этому интранету.

    [Подписанные URL](*signed_url) будут открываться до тех пор, пока не истечет срок действия подписи.

#### Примеры сообщений с изображениями {#image-containing-examples}

{% list tabs %}

- Изображение в запросе пользователя

  gen_ai.input.messages:

  ```json
  [
    {
      "role": "user",
      "parts": [
        {
          "type": "text",
          "content": "Что изображено на этой картинке?"
        },
        {
          "type": "uri",
          "modality": "image",
          "uri": "https://example.com/photo.jpg",
          "mime_type": "image/jpeg"
        }
      ]
    }
  ]
  ```

  gen_ai.output.messages:

  ```json
  [
    {
      "role": "assistant",
      "parts": [
        {
          "type": "text",
          "content": "На картинке изображен закат над морем с силуэтами яхт."
        }
      ],
      "finish_reason": "stop"
    }
  ]
  ```

- Изображение в ответе агента

  gen_ai.input.messages:

  ```json
  [
    {
      "role": "user",
      "parts": [
        {
          "type": "text",
          "content": "Нарисуй интерфейс идеальной системы Observability"
        }
      ]
    }
  ]
  ```

  gen_ai.output.messages:

  ```json
  [
    {
      "role": "assistant",
      "parts": [
        {
          "type": "uri",
          "modality": "image",
          "uri": "https://cdn.ya.ru/generated/monium.png",
          "mime_type": "image/png"
        }
      ],
      "finish_reason": "stop"
    }
  ]
  ```

{% endlist %}

## Спаны вызова инструментов {#tool-spans}

Для каждого вызова инструмента (tool) создавайте дочерний спан с `gen_ai.operation.name="execute_tool"`. Это позволяет видеть в интерфейсе полную цепочку: запрос → модель решила вызвать tool → tool выполнился → модель получила результат → финальный ответ.

Рекомендуемые атрибуты спана вызова инструмента:

#|
|| **Атрибут** | **Описание** | **Пример** ||
|| `gen_ai.operation.name` | Тип операции. Для спанов инструментов должен быть `execute_tool` | `execute_tool` ||
|| `gen_ai.tool.name` | Имя вызываемого инструмента | `get_weather` ||
|| `gen_ai.tool.description` | Описание функции инструмента | `Get current weather for a city` ||
|| `gen_ai.tool.definitions` | JSON-массив с описанием инструмента в формате JSON Schema (сериализованный в строку) | Пример в коде ||
|| `gen_ai.tool.call.arguments` | Аргументы вызова (сериализованные в строку через `json.dumps()`) | `{"location": "Paris"}` ||
|| `gen_ai.tool.call.result` | Результат выполнения (сериализованный в строку через `json.dumps()`) | `{"temperature": 18, "condition": "cloudy"}` ||
|#

Дополнительные примеры правильной инструментации различных сценариев (вызовы инструментов, стриминг, мультимодальность) приведены в разделе [Examples: LLM Calls](https://github.com/open-telemetry/semantic-conventions-genai/blob/b028dceecdad117461a785c3af35315e7184e813/docs/gen-ai/non-normative/examples-llm-calls.md) документации OpenTelemetry.

{% cut "Пример отображения спана с вызовом инструмента" %}
       
![image](../../../_assets/monium/llm-span-tool-example.png)
       
{% endcut %}


## Пример кода {#example}

Ниже — минимальный рабочий пример ручной инструментации: агент на базе [OpenAI API](https://platform.openai.com/docs/api-reference) с одним инструментом (погода). Цикл вызова модели и инструмента реализован явно, чтобы в коде были видны все атрибуты из [таблицы спанов генерации](#required-attributes) и [таблицы спанов инструментов](#tool-spans).

### Установите зависимости

```bash
pip install opentelemetry-sdk opentelemetry-exporter-otlp-proto-grpc openai
```

### Настройте переменные окружения

Установите переменные для подключения к Monium Traces и ключ OpenAI. Выполняйте команды по одной, подставляя свои значения:

```bash
export OTEL_EXPORTER_OTLP_ENDPOINT="ingest.monium.yandex.cloud:443"
```

```bash
export OTEL_EXPORTER_OTLP_HEADERS="Authorization=Api-Key <ваш_API-ключ>,x-monium-project=<имя_проекта>,x-monium-service=my-ai-agent"
```

```bash
export OTEL_SERVICE_NAME="my-ai-agent"
```

```bash
export OPENAI_API_KEY="<ваш_ключ_OpenAI>"
```

Где:
- `<ваш_API-ключ>` — API-ключ сервисного аккаунта с ролью `monium.traces.writer`.
- `<имя_проекта>` — имя проекта в формате `folder__<идентификатор_каталога>`, например `folder__b1g2e3abc4def5ghij6k`.

Подробнее о специальных заголовках Monium в разделе [Заголовки](../../collector/otlp-protocol.md#headers).


### Код агента

Сохраните код в файл `agent.py`. В коде по шагам показано, какие атрибуты задавать для спана генерации (диалог) и для спана вызова инструмента.

```python
import json
from openai import OpenAI
from opentelemetry import trace
from opentelemetry.trace import Status, StatusCode
from opentelemetry.sdk.trace import TracerProvider
from opentelemetry.sdk.trace.export import BatchSpanProcessor
from opentelemetry.exporter.otlp.proto.grpc.trace_exporter import OTLPSpanExporter

provider = TracerProvider()
provider.add_span_processor(BatchSpanProcessor(OTLPSpanExporter()))
trace.set_tracer_provider(provider)
tracer = trace.get_tracer("my_ai_agent")

TOOL_DEF = {
    "type": "function",
    "name": "get_weather",
    "description": "Get current weather for a city",
    "parameters": {"type": "object", "properties": {"city": {"type": "string"}}, "required": ["city"]},
}


def get_weather(city: str) -> dict:
    return {"temperature": 18, "condition": "cloudy", "city": city}


def to_otel_messages(messages: list) -> list:
    """Формат gen_ai.input.messages / output: parts с type text | tool_call | tool_call_response."""
    out = []
    for m in messages:
        role, content = m["role"], m.get("content") or ""
        if role in ("system", "user"):
            out.append({"role": role, "parts": [{"type": "text", "content": content}]})
        elif role == "assistant":
            parts = [{"type": "text", "content": content}] if content else []
            for tc in m.get("tool_calls", []):
                fn = tc["function"]
                args = json.loads(fn["arguments"]) if isinstance(fn["arguments"], str) else fn["arguments"]
                parts.append({"type": "tool_call", "id": tc["id"], "name": fn["name"], "arguments": args})
            out.append({"role": "assistant", "parts": parts})
        elif role == "tool":
            out.append({"role": "tool", "parts": [{"type": "tool_call_response", "id": m["tool_call_id"], "response": m["content"]}]})
    return out


def run_agent(user_query: str, messages: list | None = None) -> str:
    client = OpenAI()
    model = "gpt-4o-mini"
    tools_spec = [{"type": "function", "function": {"name": "get_weather", "description": TOOL_DEF["description"], "parameters": TOOL_DEF["parameters"]}}]
    if messages is None:
        messages = [
            {"role": "system", "content": "You are a helpful assistant. Use get_weather for weather questions."},
            {"role": "user", "content": user_query},
        ]
    else:
        messages.append({"role": "user", "content": user_query})

    while True:
        with tracer.start_as_current_span("gen_ai.chat") as span:
            span.set_attribute("gen_ai.operation.name", "chat")
            span.set_attribute("gen_ai.system", "openai")
            span.set_attribute("gen_ai.request.model", model)
            span.set_attribute("gen_ai.input.messages", json.dumps(to_otel_messages(messages)))
            span.set_attribute("gen_ai.tool.definitions", json.dumps([TOOL_DEF]))
            try:
                resp = client.chat.completions.create(model=model, messages=messages, tools=tools_spec)
            except Exception as e:
                span.record_exception(e)
                span.set_status(Status(StatusCode.ERROR, str(e)))
                return ""

            msg = resp.choices[0].message
            usage = resp.usage
            span.set_attribute("gen_ai.response.model", resp.model)
            span.set_attribute("gen_ai.usage.input_tokens", usage.prompt_tokens)
            span.set_attribute("gen_ai.usage.output_tokens", usage.completion_tokens)
            out_msg = [{"role": "assistant", "parts": [], "finish_reason": "stop"}]
            if msg.content:
                out_msg[0]["parts"].append({"type": "text", "content": msg.content})
            for tc in msg.tool_calls or []:
                args = json.loads(tc.function.arguments) if isinstance(tc.function.arguments, str) else tc.function.arguments
                out_msg[0]["parts"].append({"type": "tool_call", "id": tc.id, "name": tc.function.name, "arguments": args})
            if out_msg[0]["parts"] and out_msg[0]["parts"][-1].get("type") == "tool_call":
                out_msg[0]["finish_reason"] = "tool_call"
            span.set_attribute("gen_ai.output.messages", json.dumps(out_msg))

            if not msg.tool_calls:
                messages.append({"role": "assistant", "content": msg.content or ""})
                return (msg.content or "").strip()

            # Следующий запрос к API — ответ модели и результаты tool
            messages.append({
                "role": "assistant",
                "content": msg.content or "",
                "tool_calls": [{"id": t.id, "type": "function", "function": {"name": t.function.name, "arguments": t.function.arguments}} for t in msg.tool_calls],
            })
            for tc in msg.tool_calls:
                args = json.loads(tc.function.arguments) if isinstance(tc.function.arguments, str) else tc.function.arguments
                with tracer.start_as_current_span("gen_ai.execute_tool") as tool_span:
                    tool_span.set_attribute("gen_ai.operation.name", "execute_tool")
                    tool_span.set_attribute("gen_ai.tool.name", tc.function.name)
                    tool_span.set_attribute("gen_ai.tool.description", TOOL_DEF["description"])
                    tool_span.set_attribute("gen_ai.tool.definitions", json.dumps([TOOL_DEF]))
                    tool_span.set_attribute("gen_ai.tool.call.arguments", json.dumps(args))
                    try:
                        result = get_weather(args.get("city", ""))
                        tool_span.set_attribute("gen_ai.tool.call.result", json.dumps(result))
                    except Exception as e:
                        tool_span.record_exception(e)
                        tool_span.set_status(Status(StatusCode.ERROR, str(e)))
                        raise
                messages.append({"role": "tool", "tool_call_id": tc.id, "content": json.dumps(result)})


if __name__ == "__main__":
    history = [
        {"role": "system", "content": "You are a helpful assistant. Use get_weather for weather questions."},
    ]
    with tracer.start_as_current_span("agent.demo"):
        print("Ответ:", run_agent("Привет! Кто ты?", history))
        print("Погода:", run_agent("Какая погода в Париже?", history))
```

### Запустите агента

```bash
python agent.py
```

После выполнения в интерфейсе Monium Traces появится один трейс с корневым спаном `agent.demo`: внутри него — спаны генерации (диалог) и при запросе погоды — дочерние спаны вызова инструмента. В атрибуте `gen_ai.input.messages` последнего спана генерации будет вся накопленная история диалога (системный промпт, оба запроса пользователя и ответы модели). Подробнее о работе с интерфейсом — в разделе [Просмотр и анализ LLM-трейсов](traces.md).

## Совместимость с автоинструментацией {#compatibility}

Ручные спаны корректно объединяются с автоматически созданными спанами в рамках одного трейса. Это позволяет комбинировать подходы: использовать автоинструментацию для базового покрытия и добавлять ручные спаны в местах, где нужен дополнительный контекст.

Например, если ваш агент использует OpenAI SDK с автоинструментацией, вы можете создать корневой спан вручную для всей операции агента, а вызовы к LLM будут автоматически размечены дочерними спанами. Это обеспечит полную картину работы агента от запроса пользователя до финального ответа.

[*buckets]: Бакет — это часть хранилища Yandex Object Storage, выделенная для данных пользователя. Подробнее читайте в разделе [Бакет в Object Storage](../../../storage/concepts/bucket.md).

[*cdn_resource]: Ресурс — это основная логическая сущность сервиса Yandex Cloud CDN, позволяющая настраивать и управлять распространением контента из источников через точки присутствия. Подробнее читайте в разделе [CDN-ресурс](../../../cdn/concepts/resource.md).

[*signed_url]: Подписанный URL — это URL, содержащий в своих параметрах данные для авторизации запроса. Подробнее о реализации подписанных ссылок в сервисе Yandex Object Storage читайте в разделе [Подписанные (pre-signed) URL](../../../storage/concepts/pre-signed-urls.md).

[*cors_cdn]: Yandex Cloud CDN поддерживает кросс-доменные запросы по механизму CORS (cross-origin resource sharing). Подробнее читайте в разделе [CORS в Cloud CDN](../../../cdn/concepts/cors.md).

[*cors]: CORS — это стандарт, позволяющий предоставлять веб-страницам доступ к объектам на сторонних интернет-ресурсах. Сторонним считается любой интернет-ресурс, который отличается от текущего схемой, доменом или портом. Подробнее читайте в разделе [CORS и принцип одинакового источника](../../../glossary/cors.md).