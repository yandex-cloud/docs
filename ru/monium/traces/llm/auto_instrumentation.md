---
title: Автоматическая инструментация LLM-приложений
description: Руководство по подключению автоматической инструментации LLM-приложений для отправки трейсов в {{ traces-name }}.
---

# Автоматическая инструментация LLM-приложений

Автоматическая инструментация — самый быстрый способ начать отправлять LLM-трейсы в {{ traces-name }}. Библиотеки автоинструментации перехватывают вызовы к LLM-провайдерам и фреймворкам на уровне SDK и автоматически создают спаны с атрибутами GenAI: промпты, ответы модели, количество токенов, используемая модель. Менять код приложения почти не нужно — достаточно подключить библиотеку и вызвать одну функцию.

## Поддерживаемые фреймворки {#supported-frameworks}

Для популярных SDK агентов есть библиотеки автоинструментации. Установите пакет для своего SDK — и все вызовы к LLM будут автоматически покрыты трейсами:

* [OpenAI SDK](https://github.com/open-telemetry/opentelemetry-python-contrib/tree/main/instrumentation-genai/opentelemetry-instrumentation-openai-v2) — [`opentelemetry-instrumentation-openai-v2`](https://pypi.org/project/opentelemetry-instrumentation-openai-v2/);
* [OpenAI Agents SDK](https://github.com/open-telemetry/opentelemetry-python-contrib/blob/main/instrumentation-genai/opentelemetry-instrumentation-openai-agents-v2/README.rst) — [`opentelemetry-instrumentation-openai-agents`](https://pypi.org/project/opentelemetry-instrumentation-openai-agents/);
* [LangChain](https://docs.langchain.com/langsmith/trace-with-opentelemetry) — [`opentelemetry-instrumentation-langchain`](https://pypi.org/project/opentelemetry-instrumentation-langchain/).


## Пример настройки {#working-example}

Ниже приведен самодостаточный пример: простой AI-агент на базе OpenAI SDK (чат с вызовом инструментов), инструментированный для автоматического создания и отправки спанов в {{ traces-name }}.

Пример подготовлен в двух вариантах:
* с генеративной моделью OpenAI — доступность зависит от вашего местоположения;
* с генеративной моделью от [{{ ai-studio-full-name }}]({{ link-docs-ai }}), оплачивается согласно [правилам тарификации]({{ link-docs-ai }}ai-studio/pricing.md).

### Подготовьте окружение {#prepare-env}

#### Подготовьте инфраструктуру {#setup-yc}

{% list tabs group=instructions %}

- OpenAI {#openai}

  1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md) и назначьте ему [роль](*roles) `monium.traces.writer`.
  1. [Создайте API-ключ](../../../iam/operations/authentication/manage-api-keys.md#create-api-key) с [областью действия](*scope) `yc.monium.traces.write`.

- {{ ai-studio-full-name }} {#ai-studio}

  1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md) и назначьте ему следующие [роли](*roles):

      * `monium.traces.writer`
      * `ai.languageModels.user`
  1. [Создайте API-ключ](../../../iam/operations/authentication/manage-api-keys.md#create-api-key) со следующими [областями действия](*scope):

      * `yc.monium.traces.write`
      * `yc.ai.languageModels.execute`

{% endlist %}

#### Установите зависимости {#install-dependencies}

```bash
pip install openai \
    opentelemetry-sdk \
    opentelemetry-exporter-otlp-proto-grpc \
    opentelemetry-instrumentation-openai
```

#### Настройте переменные окружения {#set-env-variables}

{% list tabs group=instructions %}

- OpenAI {#openai}

  {% include [batch-run](../../../_includes/monium/llm-instrumentation-example-vars.md) %}

  * Создайте переменную, содержащую ваш API-ключ OpenAI:

      ```bash
      export OPENAI_API_KEY="<ваш_ключ_OpenAI>"
      ```

- {{ ai-studio-full-name }} {#ai-studio}

  {% include [batch-run](../../../_includes/monium/llm-instrumentation-example-vars.md) %}

  * Создайте переменную, содержащую API-ключ сервисного аккаунта, созданный ранее:

      ```bash
      export API_KEY="<ваш_API-ключ>"
      ```
  * Создайте переменную, содержащую [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md), в котором агент будет обращаться к генеративной модели {{ ai-studio-full-name }}:

      ```bash
      export YANDEX_FOLDER_ID="<идентификатор_каталога>"
      ```

{% endlist %}


### Создайте файл агента {#create-agent}

Сохраните следующий код в файл `agent.py`. Используется `SimpleSpanProcessor`: он отправляет каждый спан сразу после завершения, поэтому к моменту выхода из скрипта все трейсы уже уйдут в {{ traces-name }}.

{% list tabs group=instructions %}

- OpenAI {#openai}

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

- {{ ai-studio-full-name }} {#ai-studio}

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

  YANDEX_MODEL = "yandexgpt-lite"
  YANDEX_API_KEY = os.getenv("API_KEY")
  YANDEX_FOLDER_ID = os.getenv("YANDEX_FOLDER_ID")
  model=f"gpt://{YANDEX_FOLDER_ID}/{YANDEX_MODEL}"

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
      client = OpenAI(
          api_key=YANDEX_API_KEY,
          base_url="https://{{ api-host-llm }}/v1",
          project=YANDEX_FOLDER_ID
      )
      messages = [
          {"role": "system", "content": "Ты — полезный ассистент. Отвечай кратко. Используй инструмент get_weather для получения погоды."},
          {"role": "user", "content": user_query},
      ]
      while True:
          response = client.chat.completions.create(
              model=model,
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

{% endlist %}

### Запустите агента {#run-agent}

```bash
python agent.py
```

После выполнения скрипта в интерфейсе {{ traces-name }} появится трейс со спанами, отражающими работу агента: вызовы к модели, при необходимости — вызов инструмента и повторный запрос, финальный ответ. Для каждого спана генерации автоинструментация извлечет:

- промпты и ответы модели (если включен захват содержимого сообщений);
- используемую модель (`gen_ai.request.model`);
- количество входных и выходных токенов (`gen_ai.usage.input_tokens`, `gen_ai.usage.output_tokens`);
- время выполнения каждого шага.

Эти данные отобразятся в специализированном интерфейсе LLM-мониторинга в удобном формате. Подробнее о работе с интерфейсом — в разделе [{#T}](./traces.md).

## Ограничения {#limitations}

Автоинструментация удобна для быстрого старта, но работает по принципу «черного ящика» — она перехватывает только стандартизированные вызовы поддерживаемых библиотек. На практике это означает ряд ограничений.

**Отсутствие бизнес-контекста.** Автоинструментация не знает о вашей предметной области. Если вам важно привязать трейс к конкретному пользователю, ID сессии чата, версии промпта или A/B-эксперименту — эти атрибуты придется добавлять вручную.

**Невидимая логика между вызовами.** Всё, что происходит между обращениями к LLM — предобработка входных данных, постобработка ответов, маршрутизация между агентами, обращение к базе данных — остается за пределами автоматически созданных спанов.

**Кастомные инструменты (tools).** Автоинструментация создает спаны для вызовов LLM, но если ваш агент вызывает собственные функции (обращение к внешнему API, поиск в базе знаний, выполнение кода), их выполнение не будет детально размечено.

**Ограниченная настройка.** Набор собираемых атрибутов и структура спанов определяются библиотекой автоинструментации. Изменить именование спанов, добавить произвольные атрибуты или изменить иерархию вложенности спанов невозможно без ручного вмешательства.

Если вам нужен полный контроль над трейсами — добавить бизнес-атрибуты, разметить собственную логику агента или инструментировать неподдерживаемый фреймворк — используйте ручную инструментацию.

[*roles]: Роль — это набор разрешений, который определяет допустимые операции с ресурсами в {{ yandex-cloud }}. Подробнее читайте в разделе [{#T}](../../../iam/concepts/access-control/roles.md).

[*scope]: Область действия — совокупность разрешенных сервисному аккаунту действий с ресурсами сервиса. API-ключ с заданными областями действия нельзя использовать в других сервисах или областях действия. Подробнее читайте в разделе [{#T}](../../../iam/concepts/authorization/api-key.md#scoped-api-keys).