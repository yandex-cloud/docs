# Создать текстового агента с поиском по файлам

В {{ foundation-models-full-name }} вы можете создать текстового [агента](../../concepts/agents/index.md), который будет [использовать информацию](../../concepts/agents/tools/filesearch.md) из ваших файлов для формирования ответа.

## Перед началом работы {#before-begin}

Чтобы воспользоваться примером:

{% list tabs group=programming_language %}

- Python {#python}

  1. [Создайте](../../../iam/operations/sa/create.md) сервисный аккаунт и [назначьте](../../../iam/operations/sa/assign-role-for-sa.md) ему [роли](../../security/index.md#service-roles) `ai.assistants.editor` и `ai.languageModels.user`.
  1. [Получите](../get-api-key.md#run-client) и сохраните [API-ключ](../../../iam/concepts/authorization/api-key.md) сервисного аккаунта, указав для него [область действия](../../../iam/concepts/authorization/api-key.md#scoped-api-keys) `yc.ai.foundationModels.execute`.

      {% include [sdk-windows-wsl-notice](../../../_includes/ai-studio/sdk-windows-wsl-notice.md) %}

  1. {% include [sdk-before-begin-step3](../../../_includes/ai-studio/sdk-before-begin-step3.md) %}
  1. {% include [sdk-before-begin-step4](../../../_includes/ai-studio/sdk-before-begin-step4.md) %}
  1. {% include [sdk-before-begin-step5](../../../_includes/ai-studio/sdk-before-begin-step5.md) %}
  1. Установите [библиотеку](https://github.com/openai/openai-python) OpenAI для Python:

      ```bash
      pip install openai
      ```

{% endlist %}

## Создайте агента {#create-agent}

{% list tabs group=programming_language %}

- Python {#python}

  1. [Создайте поисковый индекс](./manage-searchindex.md#create-index).
  1. Создайте файл `index.py` и добавьте в него код:

     ```python
     import openai
     import json
     
     YANDEX_CLOUD_MODEL = "yandexgpt"

     client = openai.OpenAI(
         api_key=YANDEX_CLOUD_API_KEY,
         base_url="https://rest-assistant.api.cloud.yandex.net/v1",
         project=YANDEX_CLOUD_FOLDER
     )
     
     response = client.responses.create(
         model=f"gpt://{YANDEX_CLOUD_FOLDER}/{YANDEX_CLOUD_MODEL}",
         instructions="Ты — умный ассистент. Если спрашивают про отдых — ищи в подключенном индексе",
         tools=[{
             "type": "file_search",
             "vector_store_ids": [VECTOR_STORE_ID]
         }],
         input="Где мне отдохнуть?"
     )
     
     # Ответ для пользователя
     print("Текст ответа:")
     print(response.output_text)
     print("\n" + "=" * 50 + "\n")
     
     # Полный ответ
     print("Полный ответ (JSON):")
     print(json.dumps(response.model_dump(), indent=2, ensure_ascii=False))
     ```

  1. Сохраните данные для аутентификации в переменные окружения:

      ```bash
      export YANDEX_CLOUD_FOLDER=<идентификатор_каталога>
      export YANDEX_CLOUD_API_KEY=<API-ключ>
      export VECTOR_STORE_ID=<идентификатор_поискового_индекса>
      ```

  1. Выполните созданный файл:

      ```bash
      python index.py
      ```

      {% cut "Пример короткого ответа" %}

      ```text
      Текст ответа:
      Вы можете рассмотреть два варианта для отдыха:
      
      1. **Бали** — райский уголок с прекрасными пляжами, уникальной культурой и гостеприимными жителями. Для поездки потребуется оформить визу, предоставив необходимые документы, такие как загранпаспорт, фотографии, подтверждение бронирования отеля, билеты туда и обратно, а также заполненную анкету на английском языке.
      
      2. **Казахстан** — удивительная страна, где встречаются Восток и Запад. Здесь вы сможете насладиться бескрайними степями, величественными горами и историческими памятниками. Для поездки в Казахстан из России вам потребуются загранпаспорт, миграционная карта и медицинская страховка (не обязательна, но рекомендуется).
      ```

      {% endcut %}

      {% cut "Пример полного ответа" %}

      ```json
      Полный ответ (JSON):
      {
        "id": "b9516128-9eab-4bdc-902e-3228********",
        "created_at": 1762862921074.0,
        "error": null,
        "incomplete_details": null,
        "instructions": "ты умный ассистент. если спрашивают про отдых - ищи в подключенном индексе",
        "metadata": null,
        "model": "gpt://b1go3el0d8fs********/yandexgpt",
        "object": "response",
        "output": [
          {
            "id": "b82092d2-dfad-45e6-b5a6-39a7********",
            "queries": [
              "отдых"
            ],
            "status": "completed",
            "type": "file_search_call",
            "results": [
              {
                "attributes": {},
                "file_id": "fvt28d2vl3ep********",
                "filename": "bali.txt",
                "score": 0.5,
                "text": "**Бали — райский уголок, где вас ждут незабываемые впечатления!**\n\nПриглашаем вас провести незабываемый отпуск на Бали! Этот волшебный остров в Индонезии славится своими прекрасными пляжами, уникальной культурой и гостеприимными жителями. Здесь вы сможете насладиться красотой природы, попробовать местную кухню и познакомиться с новыми людьми. **Что нужно для поездки?** Для въезда на территорию Индонезии вам потребуется виза. Вот список документов, которые необходимы для её оформления:\n* Загранпаспорт, срок действия которого составляет не менее 6 месяцев на момент въезда в страну. * Две фотографии, соответствующие требованиям консульства. * Подтверждение бронирования отеля или письмо другого жилья. * Бронь или билеты туда и обратно. * Анкета, заполненная на английском языке. Обратите внимание, что требования могут меняться, поэтому перед поездкой рекомендуется проверить актуальную информацию на сайте консульства или визового центра. Стоимость визы 300 рублей. Не упустите возможность посетить этот прекрасный остров и получить массу положительных эмоций! Бронируйте свой отдых на Бали уже сегодня! **Мы ждём вас!**",
                "valid": true
              },
              {
                "attributes": {},
                "file_id": "fvtgngs87ueo********",
                "filename": "kazakhstan.txt",
                "score": 0.49999997,
                "text": "**Казахстан: путешествие в сердце Евразии**\n\nОткройте для себя Казахстан — удивительную страну, где встречаются Восток и Запад. Здесь вы сможете насладиться бескрайними степями, величественными горами, историческими памятниками и гостеприимством местных жителей. **Что нужно для поездки?** Чтобы попасть в Казахстан из России, вам потребуются следующие документы:\n* Загранпаспорт, срок действия которого составляет не менее 3 месяцев на момент окончания поездки. * Миграционная карта (выдаётся в самолете или на границе). * Медицинская страховка (не обязательна, но рекомендуется). Не упустите возможность посетить эту прекрасную страну и получить массу положительных эмоций! Бронируйте свой отдых в Казахстане уже сегодня! **Мы ждём вас!**",
                "valid": true
              }
            ],
            "valid": true
          },
          {
            "id": "c21d9c45-1c10-4dbb-af49-c0d7********",
            "content": [
              {
                "annotations": [
                  {
                    "file_id": "fvt28d2vl3ep********",
                    "filename": "bali.txt",
                    "index": 0,
                    "type": "file_citation",
                    "valid": true
                  },
                  {
                    "file_id": "fvtgngs87ueo********",
                    "filename": "kazakhstan.txt",
                    "index": 0,
                    "type": "file_citation",
                    "valid": true
                  }
                ],
                "text": "Вы можете рассмотреть два варианта для отдыха:\n\n1. **Бали** — райский уголок с прекрасными пляжами, уникальной культурой и гостеприимными жителями. Для поездки потребуется оформить визу, предоставив необходимые документы, такие как загранпаспорт, фотографии, подтверждение бронирования отеля, билеты туда и обратно, а также заполненную анкету на английском языке.\n\n2. **Казахстан** — удивительная страна, где встречаются Восток и Запад. Здесь вы сможете насладиться бескрайними степями, величественными горами и историческими памятниками. Для поездки в Казахстан из России вам потребуются загранпаспорт, миграционная карта и медицинская страховка (не обязательна, но рекомендуется).",
                "type": "output_text",
                "logprobs": null,
                "valid": true
              }
            ],
            "role": "assistant",
            "status": "completed",
            "type": "message",
            "valid": true
          }
        ],
        "parallel_tool_calls": true,
        "temperature": null,
        "tool_choice": "auto",
        "tools": [
          {
            "type": "file_search",
            "vector_store_ids": [
              "fvtbstlb8tkr********"
            ],
            "filters": null,
            "max_num_results": null,
            "ranking_options": null,
            "valid": true
          }
        ],
        "top_p": null,
        "background": false,
        "conversation": null,
        "max_output_tokens": null,
        "max_tool_calls": null,
        "previous_response_id": null,
        "prompt": null,
        "prompt_cache_key": null,
        "reasoning": null,
        "safety_identifier": null,
        "service_tier": null,
        "status": "completed",
        "text": null,
        "top_logprobs": null,
        "truncation": null,
        "usage": {
          "input_tokens": 0,
          "input_tokens_details": {
            "cached_tokens": 0,
            "valid": true
          },
          "output_tokens": 0,
          "output_tokens_details": {
            "reasoning_tokens": 0,
            "valid": true
          },
          "total_tokens": 0,
          "valid": true
        },
        "user": "",
        "valid": true
      }      
      ```

      {% endcut %}

{% endlist %}

#### См. также {#see-also}

* [{#T}](./create-prechunked-search-agent.md)