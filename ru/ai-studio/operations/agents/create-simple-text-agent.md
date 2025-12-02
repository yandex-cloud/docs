---
title: Создать простого текстового агента в {{ foundation-models-full-name }}
description: Следуя этой инструкции, вы сможете создать простого текстового агента с помощью {{ responses-api }} в {{ foundation-models-full-name }}.
---

# Создать простого текстового агента

В {{ foundation-models-full-name }} вы можете создать текстового [агента](../../concepts/agents/index.md), способного взаимодействовать с пользователем в текстовом формате и поддерживать диалог, близкий к естественному человеческому общению.

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

## Реализуйте чат {#develop-chat}

{% list tabs group=programming_language %}

- Python {#python}

  1. Создайте файл `index.py` и добавьте в него код:

      ```python
      import openai

      YANDEX_CLOUD_MODEL = "yandexgpt"

      client = openai.OpenAI(
          api_key=YANDEX_CLOUD_API_KEY,
          base_url="https://rest-assistant.{{ api-host }}/v1",
          project=YANDEX_CLOUD_FOLDER
      )

      response = client.responses.create(
          prompt={
              "id": "........",
              "variables": {
                  "city": "Чита",
                  "friends_number": "0"
              }
          },
          input="Куда пойти вечером? Где понюхать багульник?",
      )

      print(response.output[0].content[0].text)
      ```

  1. Сохраните данные для аутентификации в переменные окружения:

      ```bash
      export YANDEX_CLOUD_FOLDER=<идентификатор_каталога>
      export YANDEX_CLOUD_API_KEY=<API-ключ>
      ```

  1. Выполните созданный файл:

      ```bash
      python index.py
      ```

      Пример ответа:

      ```text
      Вечер в Чите можно провести интересно — вот несколько вариантов:

      **1. Куда пойти вечером:**
      - **Арт-завод «Острог»** — современное пространство с выставками, мастер-классами, концертами, летними вечерами часто проходят тематические вечеринки.
      - **Иркутская улица** и **Центр города** — пройдитесь по пешеходному участку Ленинградской улицы: здесь приятные кафе, бары («Кружка», «Сибирский Брой», Craft Pub, «Мамина комната Суши») и интересная городская атмосфера.
      - **Набережная реки Чита** — отличное место для вечерней прогулки, красивые виды, тихо и спокойно.
      - **Кафе с видом**: попробуйте ужин на верхнем (ресторанном) этаже Кристал Плаза или в ресторане «Белый Медведь» — отличный вид на город, приятная атмосфера.

      ---

      **2. Где понюхать багульник:**
      - В Читинском ботаническом саду Дальневосточного отделения РАН (улица Журавлёва, 100) – тут растёт багульник (на самом деле растение называется рододендрон даурский, а название «багульник» народное), сезон цветения — конец мая — начало июня. Можно узнать актуальную информацию у администрации сада.
      - В окрестностях города: багульник цветёт в пригородных лесах, особенно много его в районе Арахлея и озёрной группы Читинского района (например, рядом с озером Татхолей). Можно съездить на машине или взять однодневную экскурсию.
      - На Восточном и Центральном хребтах в окрестностях Читы с мая цветут целые поля от багульника — красивые фото и насыщенный аромат.

      **Важно:** при сборе/нюханьи багульника не ломайте ветки и цветы — это ценный для региона ресурс и редкое растение!

      Если интересны конкретные экскурсии по багульнику или бронирование вечерних мест — уточните предпочтения, помогу подобрать!
      ```

{% endlist %}

#### См. также {#see-also}

* [{#T}](../../concepts/generation/index.md)