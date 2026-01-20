---
title: Как отправить запрос к модели в {{ foundation-models-full-name }} в синхронном режиме
description: Следуя данной инструкции, вы научитесь использовать {{ responses-api }} в {{ foundation-models-full-name }}, чтобы отправить запрос к {{ gpt-lite }} в синхронном режиме.
---

# Отправить запрос в синхронном режиме

При выполнении задач генерации текста, которые предусматривают короткий ответ или использование модели генерации текста [в режиме чата](./create-chat.md), наиболее эффективным является _синхронный режим запросов_.

Если у вас объемная задача по генерации текста, в которой требуется, например, обработка больших документов, более удобным может оказаться [фоновый режим запросов](./background-request.md).

## Перед началом работы {#before-begin}

Чтобы воспользоваться примером:

{% list tabs group=programming_language %}

- Python {#python}

  1. [Создайте](../../../iam/operations/sa/create.md) сервисный аккаунт и [назначьте](../../../iam/operations/sa/assign-role-for-sa.md) ему [роль](../../security/index.md#languageModels-user) `ai.languageModels.user`.
  1. [Получите](../get-api-key.md#run-client) и сохраните [API-ключ](../../../iam/concepts/authorization/api-key.md) сервисного аккаунта.
  
        {% note info %}
        
        Если вы используете ОС [Windows](https://ru.wikipedia.org/wiki/Windows), рекомендуем предварительно [установить](https://learn.microsoft.com/ru-ru/windows/wsl/install) оболочку [WSL](https://ru.wikipedia.org/wiki/Windows_Subsystem_for_Linux) и выполнять дальнейшие действия в этой оболочке.
        
        {% endnote %}

  1. {% include [sdk-before-begin-step3](../../../_includes/ai-studio/sdk-before-begin-step3.md) %}
  1. {% include [sdk-before-begin-step4](../../../_includes/ai-studio/sdk-before-begin-step4.md) %}
  1. {% include [sdk-before-begin-step5](../../../_includes/ai-studio/sdk-before-begin-step5.md) %}
  1. Установите [библиотеку](https://github.com/openai/openai-python) OpenAI для Python:

      ```bash
      pip install openai
      ```

{% endlist %}


## Выполните запрос к модели {#request}

{% list tabs group=programming_language %}

- Python {#python}

  1. Создайте файл `index.py` и добавьте в него код:

      ```python
      import openai

      YANDEX_CLOUD_MODEL = "yandexgpt-lite"

      client = openai.OpenAI(
          api_key=YANDEX_CLOUD_API_KEY,
          base_url="https://ai.{{ api-host }}/v1",
          project= YANDEX_CLOUD_FOLDER
      )

      response = client.responses.create(
          model=f"gpt://{YANDEX_CLOUD_FOLDER}/{YANDEX_CLOUD_MODEL}",
          input="Придумай 3 необычные идеи для стартапа в сфере путешествий.",
          temperature=0.8,
          max_output_tokens=1500
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
      1. **Платформа для поиска и организации путешествий с учётом астрологических факторов.** Сервис поможет путешественникам выбрать направление, даты поездки и активности, основываясь на их астрологическом знаке или индивидуальной натальной карте. Это может включать рекомендации по лучшим периодам для путешествий, местам с энергетикой, соответствующей знаку, и даже подбор культурных и природных достопримечательностей, соответствующих астрологическим предпочтениям.

      2. **Виртуальный гид-путешественник с элементами дополненной реальности.** Это приложение или сервис, который позволит пользователям «встретить» виртуального гида в любом месте, где они находятся, через дополненную реальность (AR). Гид может рассказать интересные факты о местности, показать скрытые достопримечательности и предложить маршруты для прогулок. Пользователь может «задать вопрос» гиду и получить ответ в режиме реального времени, используя AR-технологию для визуализации ответов.

      3. **Сервис для организации путешествий с помощью искусственного интеллекта.** Платформа, которая использует алгоритмы искусственного интеллекта для персонализации путешествий. ИИ может анализировать предпочтения пользователя, его бюджет, время года и предлагать оптимальные маршруты, включая перелёты, транспорт, места для ночлега и активности. Сервис также может предлагать альтернативные варианты в случае изменений в расписании или других непредвиденных обстоятельств.
      ```

{% endlist %}


#### См. также {#see-also}

* [{#T}](./background-request.md)
* [{#T}](../../concepts/generation/index.md)
* Примеры работы с {{ ml-sdk-name }} на [GitHub](https://github.com/yandex-cloud/yandex-cloud-ml-sdk/tree/master/examples/sync/completions)
