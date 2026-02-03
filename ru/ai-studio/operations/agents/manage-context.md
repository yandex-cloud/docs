---
title: Управление контекстом диалога в {{ ai-studio-name }}
description: Следуя этой инструкции, вы сможете управлять контекстом диалога с агентом в {{ ai-studio-full-name }} тремя разными способами.
---

# Управление контекстом диалога

При работе с Responses API в {{ ai-studio-full-name }} есть три способа передавать контекст в многошаговом диалоге с [агентом](../../concepts/agents/index.md):

* [Conversations API](#conversations-api) — вариант предполагает сохранение диалога в объект с уникальным идентификатором.
* [Связывание ответов](#previous-response) — вариант реализует чат в режиме реального времени, связывая ответы с помощью параметра `previous_response_id`.
* [Ручное управление контекстом](#manual) — вариант дает возможность редактировать историю диалога, передаваемую агенту.

## Перед началом работы {#before-begin}

Чтобы воспользоваться примерами:

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

## Управление контекстом с помощью Conversations API {#conversations-api}

С помощью [Conversations API](../../concepts/agents/conversations-api.md) создается объект `conversation`, который передается в следующие запросы, чтобы сохранять состояние и разделять контекст между ответами. Диалог хранится как долгоживущий объект с уникальным идентификатором.

{% list tabs group=programming_language %}

- Python {#python}

  1. Создайте файл `dialogue.py` и добавьте в него код:
  
     ```py
     import openai
   
     YC_MODEL = "yandexgpt"
     
     def print_conversation(conv_id):
         print(f"\nConversation {conv_id}")
         items = client.conversations.items.list(conversation_id=conv_id)
         print(f"\nFound {len(items.data)} items in conversation:")
         
         for item in items.data:
             print(f"\nItem: {item}")
         print("-" * 80)
     
     
     client = openai.OpenAI(
         api_key=YC_API_KEY,
         base_url="https://ai.{{ api-host }}/v1",
         project=YC_FOLDER_ID
     )
     
     # 1) создаём conversation
     conv = client.conversations.create()
     print("conversation id:", conv.id)
     print_conversation(conv.id)
     
     # 2) первое сообщение с системной инструкцией и пользовательским вводом
     r1 = client.responses.create(
         model=f"gpt://{YC_FOLDER_ID}/{YC_MODEL}",
         conversation=conv.id,
         input=[
             {"role": "developer", "content": "Ты мой ассистент."},
             {"role": "user", "content": "Привет! Запомни: я живу в Серпухове."}
         ]
     )
     print("assistant:", r1.output_text)
     print_conversation(conv.id)
     
     
     # 3) продолжаем в том же conversation
     r2 = client.responses.create(
         model=f"gpt://{YC_FOLDER_ID}/{YC_MODEL}",
         conversation=conv.id,
         input="В каком городе я живу?"
     )
     print("assistant:", r2.output_text)
     print_conversation(conv.id)
     
     
     # 4) вызов инструмента web_search
     r3 = client.responses.create(
         model=f"gpt://{YC_FOLDER_ID}/{YC_MODEL}",
         conversation=conv.id,
         input="Какая погода будет на выходных?",
         tools=[{
             "type": "web_search",
         }]
     )
     print("assistant:", r3.output_text)
     print_conversation(conv.id)
     ```

  1. Сохраните данные для аутентификации в переменные окружения:

      ```bash
      export YC_FOLDER_ID=<идентификатор_каталога>
      export YC_API_KEY=<API-ключ>
      ```

  1. Выполните созданный файл:

      ```bash
      python dialogue.py
      ```

     {% cut "Фрагмент ответа" %}
     
     ```text
     assistant: На выходных в Серпухове ожидается следующая погода:
     
     - **Суббота, 31 января**:
       - Ночь: -9°C, ощущается как -15°C
       - Утро: -10°C, ощущается как -17°C
       - День: -5°C, ощущается как -10°C
       - Вечер: -7°C, ощущается как -13°C
     
     - **Воскресенье, 1 февраля**:
       - Ночь: -21°C, ощущается как -27°C
       - Утро: -21°C, ощущается как -27°C
       - День: -19°C, ощущается как -25°C
       - Вечер: -20°C, ощущается как -26°C
     ```
     
     {% endcut %}

{% endlist %}

{% note info %}

Редактирование элементов и обнуление диалога в настоящий момент не поддерживаются. Чтобы начать новый диалог, создайте новый объект `conversation`.

{% endnote %}

## Управление контекстом через связывание ответов {#previous-response}

Параметр `previous_response_id` позволяет связывать ответы между собой и строить диалог от выбранной точки.

{% list tabs group=programming_language %}

- Python {#python}

  1. Создайте файл `dialogue.py` и добавьте в него код:

     ```py
     import openai     

     YC_MODEL = "yandexgpt"
     
     previous_id = None  # параметр для сохранения ID последнего ответа ассистента
     
     client = openai.OpenAI(
         api_key=YC_API_KEY,
         project=YC_FOLDER_ID,
         base_url="https://ai.{{ api-host }}/v1",
     )
     
     print("Чат с агентом (введите 'выход' для выхода)\n")
     
     while True:
         user_input = input("Вы: ")
         if user_input.lower() in ("exit", "quit", "выход"):
             print("Чат завершён.")
             break
     
         response = client.responses.create(
             model=f"gpt://{YC_FOLDER_ID}/{YC_MODEL}",
             input=user_input,
             instructions="Ты — текстовый агент, который ведёт диалог и даёт информативные ответы на вопросы пользователя.",
             previous_response_id=previous_id  # передаем контекст, если он есть
         )
     
         # сохраняем ID для следующего шага
         previous_id = response.id
     
         # выводим ответ агента
         print("Агент:", response.output_text)
     ```

  1. Сохраните данные для аутентификации в переменные окружения:

      ```bash
      export YC_FOLDER_ID=<идентификатор_каталога>
      export YC_API_KEY=<API-ключ>
      ```

  1. Выполните созданный файл:

      ```bash
      python dialogue.py
      ```

     Запустится чат, в котором вы сможете разговаривать с агентом в режиме реального времени с сохранением контекста.

     {% cut "Пример диалога" %}

     ```text     
     Чат с агентом (введите 'выход' для выхода)
     
     Вы: Привет! Запомни: мою кошку зовут Мяфка, ей в этом месяце исполнится год.
     Агент: Привет! Хорошо, запомнил: вашу кошку зовут Мяфка, и в этом месяце ей исполнится год. Если у вас есть ещё какие-либо вопросы или вам нужна помощь, пожалуйста, обращайтесь!
     Вы: Сколько лет кошке Мяфке?
     Агент: Кошке Мяфке в этом месяце исполнится один год.
     ```
     
     {% endcut %}

{% endlist %}

## Ручное управление состоянием диалога {#manual}

Для максимального контроля за состоянием диалога можно хранить историю на стороне приложения и явно передавать нужные сообщения в `input` каждого запроса Responses API. Это особенно полезно, когда нужно реализовать гибкую очистку или сжатие контекста, а также редактировать передаваемую историю.

{% list tabs group=programming_language %}

- Python {#python}

  1. Создайте файл `dialogue.py` и добавьте в него код:

     ```py
     import openai     

     YC_MODEL = "yandexgpt"
     
     client = openai.OpenAI(
         api_key=YC_API_KEY,
         base_url="https://ai.{{ api-host }}/v1",
         project=YC_FOLDER_ID,
     )
     
     response = client.responses.create(
         model=f"gpt://{YC_FOLDER_ID}/{YC_MODEL}",
         input=[
             {"role": "user", "content": "Привет! Помоги с выбором подарка самому себе."},
             {"role": "assistant", "content": "Привет! Расскажи о себе"},
             {"role": "user", "content": "Меня зовут Глеб."},
             {"role": "user", "content": "Я люблю путешествовать."},
             {"role": "user", "content": "Увлекаюсь аниме и дизайном."},
         ],
     )
     
     print(response.output_text)
     ```

  1. Сохраните данные для аутентификации в переменные окружения:

      ```bash
      export YC_FOLDER_ID=<идентификатор_каталога>
      export YC_API_KEY=<API-ключ>
      ```

  1. Выполните созданный файл:

      ```bash
      python dialogue.py
      ```

      {% cut "Пример ответа:" %}
      
      ```text
      Вот несколько идей подарков, которые могут тебе понравиться:
      
      1. **Аксессуары для путешествий.** Например, качественный рюкзак или сумка для ручной клади, компактный набор для гигиены, универсальный адаптер для розеток разных стандартов.
      
      2. **Книги по дизайну.** Можно выбрать как классические труды по теории дизайна, так и современные книги с примерами и рекомендациями от известных дизайнеров.
      
      3. **Фигурки и merchandise с аниме.** Если ты увлекаешься каким-то конкретным аниме, можно найти фигурки, постеры, одежду или другие товары с его символикой.
      
      4. **Графический планшет.** Если ты интересуешься дизайном и хочешь развивать свои навыки, графический планшет может стать полезным инструментом для рисования и создания цифровых иллюстраций.
      
      5. **Фотоаппарат или аксессуары для него.** Если ты любишь фотографировать во время путешествий, можно рассмотреть подарок в виде фотоаппарата, дополнительного объектива или другого аксессуара.
      
      6. **Обучающие курсы.** Курсы по дизайну, фотографии, анимации или другим направлениям могут помочь тебе развить свои навыки и узнать что-то новое.
      
      7. **Подписка на стриминговые сервисы с аниме.** Это позволит тебе наслаждаться любимыми аниме в высоком качестве и без рекламы.
      
      Надеюсь, эти идеи помогут тебе выбрать подарок!
      ```
      
      {% endcut %}

{% endlist %}