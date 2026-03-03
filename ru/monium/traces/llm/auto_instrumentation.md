---
title: Инструментирование LLM-приложений автоматически
description: Руководство по подключению автоматической инструментации LLM-приложений для отправки трейсов в {{ traces-name }}.
---

# Инструментирование LLM-приложений: автоматически

Автоматическая инструментация — самый быстрый способ начать отправлять LLM-трейсы в {{ traces-name }}. Библиотеки автоинструментации перехватывают вызовы к LLM-провайдерам и фреймворкам на уровне SDK и автоматически создают спаны с атрибутами GenAI: промпты, ответы модели, количество токенов, используемая модель. Менять код приложения почти не нужно — достаточно подключить библиотеку и вызвать одну функцию.

## Поддерживаемые фреймворки

Для каждого популярного SDK для разработки агентов существует библиотека автоинструментации. Установите пакет, соответствующий вашему SDK — все вызовы к LLM будут автоматически покрыты трейсами.

#|
|| **Фреймворк** | **pip-пакет** | **Документация по OpenTelemetry** ||
|| OpenAI SDK | [`opentelemetry-instrumentation-openai-v2`](https://pypi.org/project/opentelemetry-instrumentation-openai-v2/) | https://github.com/open-telemetry/opentelemetry-python-contrib/tree/main/instrumentation-genai/opentelemetry-instrumentation-openai-v2 ||
|| OpenAI Agents SDK | [`opentelemetry-instrumentation-openai-agents`](https://pypi.org/project/opentelemetry-instrumentation-openai-agents/) | https://github.com/open-telemetry/opentelemetry-python-contrib/blob/main/instrumentation-genai/opentelemetry-instrumentation-openai-agents-v2/README.rst ||
|| LangChain | [`opentelemetry-instrumentation-langchain`](https://pypi.org/project/opentelemetry-instrumentation-langchain/) | LangSmith: Trace with OpenTelemetry: https://docs.langchain.com/langsmith/trace-with-opentelemetry ||
|#


## Полный пример

Ниже приведен самодостаточный пример: простой AI-агент на базе OpenAI SDK (чат с вызовом инструментов), инструментированный для автоматического создания и отправки спанов в {{ traces-name }}.

### 1. Установите зависимости

```bash
pip install openai \
    opentelemetry-sdk \
    opentelemetry-exporter-otlp-proto-grpc \
    opentelemetry-instrumentation-openai
```

### 2. Настройте переменные окружения

Установите обязательные переменные для подключения к {{ traces-name }}:

```bash
export OTEL_EXPORTER_OTLP_HEADERS="Authorization=Api-Key <ваш_API-ключ>,x-monium-project=<имя_проекта>,x-monium-service=my-ai-agent"
```
```bash
export OTEL_SERVICE_NAME="my-ai-agent"
```
```bash
export OTEL_EXPORTER_OTLP_ENDPOINT="{{ api-host-monium }}:443"
```
```bash
export OPENAI_API_KEY="<ваш_ключ_OpenAI>"
```

Где:
- `<ваш_API-ключ>` — API-ключ сервисного аккаунта с ролью `monium.traces.writer`.
- `<имя_проекта>` — имя проекта в формате `folder__<идентификатор_каталога>`, например `folder__b1g2e3abc4def5ghij6k`.

Подробнее о специальных заголовках {{ monium-name }} см. в разделе [{#T}](../../collector/otlp-protocol.md#headers).

Дополнительно установите переменную для захвата содержимого промптов и ответов модели:

```bash
export OTEL_INSTRUMENTATION_GENAI_CAPTURE_MESSAGE_CONTENT=true
```

Без этой переменной в трейсах будут записаны модель, количество токенов и время вызова, но не тексты промптов и ответов.


### 3. Создайте файл с кодом агента

Сохраните следующий код в файл `agent.py`. Используется `SimpleSpanProcessor`: он отправляет каждый спан сразу после завершения, поэтому к моменту выхода из скрипта все трейсы уже уйдут в {{ traces-name }}.

```python
import json
import os
from openai import OpenAI

from opentelemetry import trace
from opentelemetry.sdk.trace import TracerProvider
from opentelemetry.sdk.trace.export import SimpleSpanProcessor
from opentelemetry.exporter.otlp.proto.grpc.trace_exporter import OTLPSpanExporter
from opentelemetry.sdk.resources import Resource

from opentelemetry.instrumentation.openai import OpenAIInstrumentor

resource = Resource(attributes={"service.name": os.getenv("OTEL_SERVICE_NAME", "my-ai-agent")})
exporter = OTLPSpanExporter()
provider = TracerProvider(resource=resource)
provider.add_span_processor(SimpleSpanProcessor(exporter))
trace.set_tracer_provider(provider)
tracer = trace.get_tracer("my-ai-agent")

OpenAIInstrumentor().instrument()

TOOLS = [
    {
        "type": "function",
        "function": {
            "name": "get_weather",
            "description": "Возвращает текущую погоду в указанном городе.",
            "parameters": {"type": "object", "properties": {"city": {"type": "string"}}, "required": ["city"]},
        },
    }
]


def get_weather(city: str) -> str:
    """Возвращает текущую погоду в указанном городе."""
    return f"В городе {city} сейчас +18°C, облачно."


def run_agent(user_query: str) -> str:
    client = OpenAI()
    messages = [
        {"role": "system", "content": "Ты — полезный ассистент. Отвечай кратко. Используй инструмент get_weather для получения погоды."},
        {"role": "user", "content": user_query},
    ]
    while True:
        response = client.chat.completions.create(
            model="gpt-4o-mini",
            messages=messages,
            tools=TOOLS,
        )
        msg = response.choices[0].message
        if not msg.tool_calls:
            return (msg.content or "").strip()
        messages.append({
            "role": "assistant",
            "content": msg.content or "",
            "tool_calls": [
                {"id": t.id, "type": "function", "function": {"name": t.function.name, "arguments": t.function.arguments}}
                for t in msg.tool_calls
            ],
        })
        for tc in msg.tool_calls:
            args = json.loads(tc.function.arguments) if isinstance(tc.function.arguments, str) else tc.function.arguments
            result = get_weather(args.get("city", ""))
            messages.append({"role": "tool", "tool_call_id": tc.id, "content": result})


if __name__ == "__main__":
    with tracer.start_as_current_span("agent.run"):
        answer = run_agent("Какая сейчас погода в Москве?")
        print(answer)
    provider.shutdown()
```

### 4. Запустите агента

```bash
python agent.py
```

После выполнения скрипта в интерфейсе {{ traces-name }} появится трейс со спанами, отражающими работу агента: вызовы к модели, при необходимости — вызов инструмента и повторный запрос, финальный ответ. Для каждого спана генерации автоинструментация извлечет:

- промпты и ответы модели (если включен захват содержимого сообщений);
- используемую модель (`gen_ai.request.model`);
- количество входных и выходных токенов (`gen_ai.usage.input_tokens`, `gen_ai.usage.output_tokens`);
- время выполнения каждого шага.

Эти данные отобразятся в специализированном интерфейсе LLM-мониторинга в удобном формате. Подробнее о работе с интерфейсом — в разделе [{#T}](./traces.md).

## Ограничения автоинструментации

Автоинструментация удобна для быстрого старта, но работает по принципу «черного ящика» — она перехватывает только стандартизированные вызовы поддерживаемых библиотек. На практике это означает ряд ограничений.

**Отсутствие бизнес-контекста.** Автоинструментация не знает о вашей предметной области. Если вам важно привязать трейс к конкретному пользователю, ID сессии чата, версии промпта или A/B-эксперименту — эти атрибуты придется добавлять вручную.

**Невидимая логика между вызовами.** Всё, что происходит между обращениями к LLM — предобработка входных данных, постобработка ответов, маршрутизация между агентами, обращение к базе данных — остается за пределами автоматически созданных спанов.

**Кастомные инструменты (tools).** Автоинструментация создает спаны для вызовов LLM, но если ваш агент вызывает собственные функции (обращение к внешнему API, поиск в базе знаний, выполнение кода), их выполнение не будет детально размечено.

**Ограниченная настройка.** Набор собираемых атрибутов и структура спанов определяются библиотекой автоинструментации. Изменить именование спанов, добавить произвольные атрибуты или изменить иерархию вложенности спанов невозможно без ручного вмешательства.

Если вам нужен полный контроль над трейсами — добавить бизнес-атрибуты, разметить собственную логику агента или инструментировать неподдерживаемый фреймворк — используйте ручную инструментацию.