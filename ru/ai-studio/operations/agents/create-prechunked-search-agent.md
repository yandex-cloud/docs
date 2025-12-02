---
title: Создать AI-агента с поиском по заданным текстовым фрагментам
description: Следуя этой инструкции, вы сможете создать в {{ foundation-models-full-name }} текстового агента, использующего поиск информации по предварительно подготовленным и загруженным фрагментам файлов базы знаний.
---

# Создать агента с поиском по заданным текстовым фрагментам

При работе с [{{ vector-store-name }}](../../concepts/search/vectorstore.md) вы можете загружать в поисковый индекс не только целые файлы, но и предварительно подготовленные фрагменты информации в формате [JSONL](https://jsonlines.org/). Такой подход предоставляет вам полный контроль над структурой данных и позволяет повысить точность поиска и генеративных ответов, исключив возможные потери смысла при автоматической фрагментации документов.

## Перед началом работы {#before-begin}

Чтобы воспользоваться примером:

{% list tabs group=programming_language %}

- Python {#python}

  1. [Создайте](../../../iam/operations/sa/create.md) сервисный аккаунт и [назначьте](../../../iam/operations/sa/assign-role-for-sa.md) ему [роли](../../security/index.md#service-roles) `ai.assistants.editor` и `ai.languageModels.user`.
  1. [Получите](../get-api-key.md#run-client) и сохраните [API-ключ](../../../iam/concepts/authorization/api-key.md) сервисного аккаунта с заданной [областью действия](../../../iam/concepts/authorization/api-key.md#scoped-api-keys) `yc.ai.foundationModels.execute`.

      {% include [sdk-windows-wsl-notice](../../../_includes/ai-studio/sdk-windows-wsl-notice.md) %}

  1. {% include [sdk-before-begin-step3](../../../_includes/ai-studio/sdk-before-begin-step3.md) %}
  1. {% include [sdk-before-begin-step4](../../../_includes/ai-studio/sdk-before-begin-step4.md) %}
  1. {% include [sdk-before-begin-step5](../../../_includes/ai-studio/sdk-before-begin-step5.md) %}
  1. Установите [библиотеку](https://github.com/openai/openai-python) OpenAI для Python:

      ```bash
      pip install openai
      ```

{% endlist %}

## Разбейте информацию на фрагменты {#fragment-info}

Разбейте на подходящие фрагменты информацию, которую вы хотите загрузить в поисковый индекс. Получившиеся фрагменты сохраните в формате JSON Lines в виде пар `"body":"<содержимое_фрагмента>"`. Например:

```json
{ "body": "Как восстановить пароль? Перейдите на страницу восстановления и введите email." }
{ "body": "Можно ли работать офлайн? Да, приложение поддерживает офлайн-режим." }
```

Сохраните получившиеся фрагменты текста в файл `chunks.jsonl`

## Загрузите файл в {{ vector-store-name }} {#upload-file}

Прежде чем создавать поисковый индекс, загрузите в {{ vector-store-name }} полученный файл в формате JSON Lines:

{% list tabs group=programming_language %}

- Python {#python}

  1. Создайте файл `upload.py` и добавьте в него следующий код:

      ```python
      import pathlib
      import openai
      from openai import OpenAI

      YANDEX_API_KEY = "<API-ключ>"
      YANDEX_FOLDER_ID = "<идентификатор_каталога>"
      filename = "chunks.jsonl"


      # Локальный файл для индексации
      def local_path(path: str) -> pathlib.Path:
          return pathlib.Path(__file__).parent / path


      def main():
          client = OpenAI(
              api_key=YANDEX_API_KEY,
              base_url="https://rest-assistant.{{ api-host }}/v1",
              project=YANDEX_FOLDER_ID,
          )

          print("Загружаем файл...")

          with open(local_path(filename), "rb") as file:
              f = client.files.create(
                  file=(filename, file, "application/jsonlines"),
                  purpose="assistants",
                  expires_after=openai.types.file_create_params.ExpiresAfter(
                      anchor="created_at", seconds=3600
                  ),
                  extra_body={"format": "chunks"},
              )

          print(f"Файл {filename} загружен:", f.id)


      if __name__ == "__main__":
          main()
      ```

      Где:

      * `YANDEX_API_KEY` — полученный перед началом работы [API-ключ](../../../iam/concepts/authorization/api-key.md) сервисного аккаунта.
      * `YANDEX_FOLDER_ID` — [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md), в котором выполняются операции с {{ vector-store-name }} API.

  1. Выполните созданный файл:

      ```bash
      python3 upload.py
      ```

      Результат:

      ```text
      Загружаем файл...
      Файл chunks.jsonl загружен: fvtnmsqdn2pq********
      ```

      Сохраните полученный идентификатор загруженного файла — он понадобится при создании поискового индекса.

{% endlist %}

## Создайте поисковый индекс {{ vector-store-name }} {#create-index}

Создайте поисковый индекс из загруженного на предыдущем шаге файла:

{% list tabs group=programming_language %}

- Python {#python}

  1. Создайте файл `index.py` и добавьте в него следующий код:

      ```python
      import time
      from openai import OpenAI

      YANDEX_API_KEY = "<API-ключ>"
      YANDEX_FOLDER_ID = "<идентификатор_каталога>"
      input_file_ids = ["<идентификатор_файла>"]


      def main():
          client = OpenAI(
              api_key=YANDEX_API_KEY,
              base_url="https://rest-assistant.{{ api-host }}/v1",
              project=YANDEX_FOLDER_ID,
          )

          # Создаем поисковый индекс с несколькими файлами
          print("Создаем поисковый индекс...")
          vector_store = client.vector_stores.create(
              # Говорящее название индекса
              name="База знаний поддержки",
              # Ваши метки для файлов
              metadata={"key": "value"},
              # Время жизни индекса
              # last_active_at - после последней активности
              expires_after={"anchor": "last_active_at", "days": 1},
              # или created_at - после создания
              # expires_after={"anchor": "created_at", "days": 1},
              file_ids=input_file_ids,  # <- список файлов
          )
          vector_store_id = vector_store.id
          print("Vector store создан:", vector_store_id)

          # Ждем готовности поискового индекса
          while True:
              vector_store = client.vector_stores.retrieve(vector_store_id)
              print("Статус vector store:", vector_store.status)
              if vector_store.status == "completed":
                  break
              time.sleep(2)

          print("Vector store готов к работе.")


      if __name__ == "__main__":
          main()
      ```

      Где `input_file_ids` — список идентификаторов загруженных файлов-источников. В приведенном примере в массив добавляется полученный на предыдущем шаге идентификатор единственного файла-источника.

  1. Выполните созданный файл:

      ```bash
      python3 index.py
      ```

      Результат:

      ```text
      Создаем поисковый индекс...
      Vector store создан: fvtol0geat8g********
      Статус vector store: in_progress
      Статус vector store: in_progress
      Статус vector store: in_progress
      Статус vector store: in_progress
      Статус vector store: in_progress
      Статус vector store: completed
      Vector store готов к работе.
      ```

      Сохраните полученный идентификатор созданного индекса — он понадобится при выполнении поискового запроса.

{% endlist %}

## Выполните поиск по индексу {#search-index}

Чтобы выполнить поисковый запрос в индексе, передайте в API идентификатор индекса и текст вашего запроса:

{% list tabs group=programming_language %}

- Python {#python}

  1. Создайте файл `query.py` и добавьте в него следующий код:

      ```python
      from openai import OpenAI

      YANDEX_API_KEY = "<API-ключ>"
      YANDEX_FOLDER_ID = "<идентификатор_каталога>"
      index_id = "<идентификатор_поискового_индекса>"
      query = "Как восстановить пароль?"


      def main():
          client = OpenAI(
              api_key=YANDEX_API_KEY,
              base_url="https://rest-assistant.{{ api-host }}/v1",
              project=YANDEX_FOLDER_ID,
          )


          # Поиск по индексу
          print(f"Ищем по запросу: {query}")
          results = client.vector_stores.search(index_id, query=query)
          for r in results:
              print("Результат:", r)


      if __name__ == "__main__":
          main()
      ```

      Где `index_id` — идентификатор поискового индекса {{ vector-store-name }}, полученный на предыдущем шаге.

  1. Выполните созданный файл:

      ```bash
      python3 query.py
      ```

      Результат:

      ```text
      Ищем по запросу: Как восстановить пароль?
      Результат: VectorStoreSearchResponse(attributes={}, content=[Content(text='Как восстановить пароль? 
      Перейдите на страницу восстановления и введите email.', type='text', valid=True)], 
      file_id='fvtl42llljc1********', filename='chunks.jsonl', score=0.9999999987809698, valid=True)
      Результат: VectorStoreSearchResponse(attributes={}, content=[Content(text='Можно ли работать офлайн? 
      Да, приложение поддерживает офлайн-режим.', type='text', valid=True)], file_id='fvtl42llljc1********', 
      filename='chunks.jsonl', score=0.0, valid=True)
      ```

      В результате сервис вернет текстовые фрагменты с указанием имени и идентификатора файла, а также оценку релевантности поисковому запросу для каждого фрагмента.

{% endlist %}


#### См. также {#see-also}

* [{#T}](./create-filesearch-text-agent.md)