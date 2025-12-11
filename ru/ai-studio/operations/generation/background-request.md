---
title: Как отправлять запросы на генерацию текста в фоновом режиме
description: Следуя данной инструкции, вы научитесь отправлять к моделям {{ foundation-models-full-name }} запросы на генерацию текста в фоновом режиме.
---

# Отправить запрос в фоновом режиме

При выполнении объемных задач генерации текста, например, в которых требуется обработка больших документов, наиболее эффективным может оказаться _фоновый режим запросов_.

В фоновом режиме {{ responses-api }} в ответ на запрос не дожидается от модели результата генерации, а получает идентификатор задачи, после чего соединение разрывается. После этого вы можете с нужной вам периодичностью проверять статус задачи по ее идентификатору и, дождавшись выполнения, получить результат генерации.

Если у вас небольшой запрос, предусматривающий короткий ответ, или вы используете модель генерации текста [в режиме чата](./create-chat.md) используйте [синхронный режим запросов](./create-prompt.md).

Чтобы воспользоваться примером, [создайте](../get-api-key.md#run-client) сервисный аккаунт с [ролью](../../security/index.md#languageModels-user) `ai.languageModels.user` и получите для него API-ключ с областью действия `yc.ai.foundationModels.execute`.

{% list tabs group=programming_language %}

- Python {#python}

  ```python
  import openai
  import time

  YANDEX_CLOUD_API_KEY = "<API-ключ>"
  YANDEX_FOLDER_ID = "<идентификатор_каталога>"
  YANDEX_CLOUD_MODEL = "yandexgpt"

  client = openai.OpenAI(
      api_key=YANDEX_CLOUD_API_KEY,
      base_url="https://rest-assistant.{{ api-host }}/v1",
      project=YANDEX_FOLDER_ID,
  )

  # --- 1. Создаем ответ в фоне
  resp = client.responses.create(
      model=f"gpt://{YANDEX_FOLDER_ID}/{YANDEX_CLOUD_MODEL}",
      input="Сделай краткое резюме текста: 'На платформе Yandex AI Studio доступно более 20 развёрнутых в облаке моделей в разных режимах работы. Самыми популярными по потреблению остаются модели семейства YandexGPT — на них приходится 62,7% от общего трафика на облачной платформе. Такой высокий спрос позволил снизить цены на собственные модели компании, сделав их более доступными. На втором и третьем местах — опенсорсные модели Qwen3‑235b от Alibaba Group (30,9%) и GPT‑OSS от OpenAI (5,7%).'",
      background=True,  # запускаем в фоне
  )

  print("Задача отправлена:", resp.id)

  # --- 2. Опрашиваем статус
  while True:
      status = client.responses.retrieve(resp.id)
      print("Статус:", status.status)
      if status.status in ["completed", "failed", "cancelled"]:
          break
      time.sleep(2)

  # --- 3. Получаем результат
  if status.status == "completed":
      print("Готовый ответ:", status.output_text)
  else:
      print("Ошибка:", status.status)
  ```

{% endlist %}

Где:

* `YANDEX_API_KEY` — полученный [API-ключ](../../../iam/concepts/authorization/api-key.md) сервисного аккаунта.
* `YANDEX_FOLDER_ID` — [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md) сервисного аккаунта.
* `resp` — объект с результатами запроса на генерацию ответа.

  Возможные статусы результата генерации:

  * `queued` — задание находится в очереди на выполнение.
  * `in_progress` — задание выполняется.
  * `failed` — выполнение задания завершилось ошибкой.
  * `cancelled` — выполнение задания было отменено.
  * `completed` — задание успешно выполнено.

  Результат генерации сохранится в поле `status.output_text` при переходе  в статус `completed`.


Пример результата:

```text
Задача отправлена: 1e5ee267-2d01-49d7-abf9-94b9********
Статус: queued
Статус: completed
Готовый ответ: В Yandex AI Studio доступно более 20 облачных моделей. Лидеры по популярности — модели YandexGPT (62,7% трафика), за ними следуют Qwen3‑235b (30,9%) и GPT‑OSS (5,7%). Высокий спрос на YandexGPT позволил снизить цены на модели компании.
```

#### См. также {#see-also}

* [{#T}](./create-prompt.md)
* [{#T}](../../concepts/generation/index.md)