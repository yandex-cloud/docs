---
title: Управлять поисковым индексом {{ vector-store-name }}
description: Следуя этой инструкции, с помощью {{ vector-store-name }} API вы сможете создать, изменить и удалить поисковый индекс, который позволит реализовать сценарий генеративного ответа (RAG) с использованием инструмента {{ retrieval-tool-name }}.
---

# Управлять поисковым индексом {{ vector-store-name }}

[AI-агенты](../../concepts/agents/index.md) в своей работе могут использовать семантический поиск по контексту, получаемому из файлов внешних баз знаний. Такой дополнительный контекст хранится в [поисковых индексах](../../concepts/search/vectorstore.md) {{ vector-store-name }} — специальных векторных хранилищах {{ foundation-models-full-name }}, которые создаются с помощью {{ vector-store-name }} API и в которых документы представлены в виде векторов ([эмбеддингов](../../concepts/embeddings.md)).

## Перед началом работы {#before-begin}

Чтобы воспользоваться примерами:

{% list tabs group=programming_language %}

- Python {#python}

  1. [Создайте](../../../iam/operations/sa/create.md) сервисный аккаунт и [назначьте](../../../iam/operations/sa/assign-role-for-sa.md) ему [роли](../../security/index.md#service-roles) `ai.assistants.editor` и `ai.languageModels.user`.
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

## Загрузить файлы-источники {#upload-files}

Прежде чем создавать поисковый индекс, загрузите в {{ vector-store-name }} файлы, которые требуется проиндексировать:

{% list tabs group=programming_language %}

- Python {#python}

  1. {% include [download-context-file-step](../../../_includes/ai-studio/assistants/download-context-file-step.md) %}
  1. Создайте файл `upload.py` и добавьте в него следующий код:

      ```python
      import os
      import pathlib
      import time
      from openai import OpenAI

      YANDEX_API_KEY = "<API-ключ>"
      YANDEX_FOLDER_ID = "<идентификатор_каталога>"


      # Локальный файл для индексации
      def local_path(path: str) -> pathlib.Path:
          return pathlib.Path(__file__).parent / path


      def main():
          client = OpenAI(
              api_key=YANDEX_API_KEY,
              base_url="https://rest-assistant.{{ api-host }}/v1",
              project=YANDEX_FOLDER_ID,
          )

          # Загружаем несколько файлов
          file_names = ["bali.md", "kazakhstan.md"]
          file_ids = []

          print("Загружаем файлы...")
          for fname in file_names:
              f = client.files.create(
                  file=open(local_path(fname), "rb"),
                  # Значение assistants используется для всех файлов, которые должны подключаться
                  # к Vector Store API
                  purpose="assistants",
              )
              print(f"Файл {fname} загружен:", f.id)
              file_ids.append(f.id)


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
      Загружаем файлы...
      Файл bali.md загружен: fvt5ajp8l83v********
      Файл kazakhstan.md загружен: fvtbq10jv46r********
      ```

      Сохраните полученные идентификаторы загруженных файлов — они понадобятся при создании поискового индекса.

{% endlist %}

## Создать поисковый индекс {{ vector-store-name }} {#create-index}

Создайте поисковый индекс из предварительно загруженных файлов:

{% list tabs group=programming_language %}

- Python {#python}

  1. Создайте файл `index.py` и добавьте в него следующий код:

      ```python
      import os
      import pathlib
      import time
      from openai import OpenAI

      YANDEX_API_KEY = "<API-ключ>"
      YANDEX_FOLDER_ID = "<идентификатор_каталога>"


      def main():
          client = OpenAI(
              api_key=YANDEX_API_KEY,
              base_url="https://rest-assistant.{{ api-host }}/v1",
              project=YANDEX_FOLDER_ID,
          )

          input_file_ids = ["<идентификатор_файла_1>", "<идентификатор_файла_2>"]

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
              # in_progress — индекс строится (файлы загружаются, делятся на фрагменты, считаются эмбеддинги).
              # completed — все готово, можно искать.
              # failed — что-то пошло не так при построении индекса.
              if vector_store.status == "completed":
                  break
              time.sleep(2)

          print("Vector store готов к работе.")


      if __name__ == "__main__":
          main()
      ```

      Где `input_file_ids` — список идентификаторов загруженных файлов-источников.

  1. Выполните созданный файл:

      ```bash
      python3 index.py
      ```

      Результат:

      ```text
      Создаем поисковый индекс...
      Vector store создан: fvt9ef7q28n5b2c9quh8
      Статус vector store: in_progress
      Статус vector store: in_progress
      Статус vector store: in_progress
      Статус vector store: in_progress
      Статус vector store: completed
      Vector store готов к работе.
      ```

      Сохраните полученный идентификатор созданного индекса — он понадобится при выполнении поискового запроса.

{% endlist %}

## Искать информацию в индексе {{ vector-store-name }} {#search-index}

Чтобы выполнить поисковый запрос в индексе, передайте в {{ vector-store-name }} API идентификатор индекса и текст вашего запроса:

{% list tabs group=programming_language %}

- Python {#python}

  1. Создайте файл `query.py` и добавьте в него следующий код:

      ```python
      import os
      import pathlib
      import time
      from openai import OpenAI

      YANDEX_API_KEY = "<API-ключ>"
      YANDEX_FOLDER_ID = "<идентификатор_каталога>"


      def main():
          client = OpenAI(
              api_key=YANDEX_API_KEY,
              base_url="https://rest-assistant.{{ api-host }}/v1",
              project=YANDEX_FOLDER_ID,
          )

          index_id = "<идентификатор_поискового_индекса>"

          # Поиск по индексу
          query = "Стоимость поездки на Бали"
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
      Ищем по запросу: Стоимость поездки на Бали
      Результат: VectorStoreSearchResponse(attributes={}, content=[Content(text='**Бали — райский уголок, где 
      вас ждут незабываемые впечатления!**\n\nПриглашаем вас провести незабываемый отпуск на Бали! Этот 
      волшебный остров в Индонезии славится своими прекрасными пляжами, уникальной культурой и гостеприимными 
      жителями. Здесь вы сможете насладиться красотой природы, попробовать местную кухню и познакомиться с 
      новыми людьми. **Что нужно для поездки?** Для въезда на территорию Индонезии вам потребуется виза. Вот 
      список документов, которые необходимы для её оформления:\n* Загранпаспорт, срок действия которого 
      составляет не менее 6 месяцев на момент въезда в страну. * Две фотографии, соответствующие требованиям 
      консульства. * Подтверждение бронирования отеля или письмо другого жилья. * Бронь или билеты туда и 
      обратно. * Анкета, заполненная на английском языке. Обратите внимание, что требования могут меняться, 
      поэтому перед поездкой рекомендуется проверить актуальную информацию на сайте консульства или визового 
      центра. Стоимость визы 300 рублей. Не упустите возможность посетить этот прекрасный остров и получить 
      массу положительных эмоций! Бронируйте свой отдых на Бали уже сегодня! **Мы ждём вас!**', type='text', 
      valid=True)], file_id='fvt5ajp8l83v********', filename='bali.md', score=0.9999999979850982, valid=True)

      Результат: VectorStoreSearchResponse(attributes={}, content=[Content(text='**Казахстан: путешествие в 
      сердце Евразии**\n\nОткройте для себя Казахстан — удивительную страну, где встречаются Восток и Запад. 
      Здесь вы сможете насладиться бескрайними степями, величественными горами, историческими памятниками и 
      гостеприимством местных жителей. **Что нужно для поездки?** Чтобы попасть в Казахстан из России, вам 
      потребуются следующие документы:\n* Загранпаспорт, срок действия которого составляет не менее 3 месяцев 
      на момент окончания поездки. * Миграционная карта (выдаётся в самолете или на границе). * Медицинская 
      страховка (не обязательна, но рекомендуется). Не упустите возможность посетить эту прекрасную страну и 
      получить массу положительных эмоций! Бронируйте свой отдых в Казахстане уже сегодня! **Мы ждём вас!**', 
      type='text', valid=True)], file_id='fvtbq10jv46r********', filename='kazakhstan.md', score=0.0, 
      valid=True)
      ```

      В результате {{ vector-store-name }} API вернет текстовые фрагменты с указанием имени и идентификатора файла, а также оценку релевантности поисковому запросу для каждого фрагмента.

{% endlist %}

## Удалить из индекса один из файлов-источников {#remove-file}

Чтобы удалить файл-источник из поискового индекса, передайте в {{ vector-store-name }} API идентификаторы индекса и этого файла:

{% list tabs group=programming_language %}

- Python {#python}

  1. Создайте файл `remove_file.py` и добавьте в него следующий код:

      ```python
      import os
      import pathlib
      import time
      from openai import OpenAI

      YANDEX_API_KEY = "<API-ключ>"
      YANDEX_FOLDER_ID = "<идентификатор_каталога>"


      def main():
          client = OpenAI(
              api_key=YANDEX_API_KEY,
              base_url="https://rest-assistant.{{ api-host }}/v1",
              project=YANDEX_FOLDER_ID,
          )

          index_id = "<идентификатор_поискового_индекса>"

          file_to_delete = "<идентификатор_файла_на_удаление>"

          # Удаление одного файла из индекса
          print("Удаляем один файл из поискового индекса...")
          deleted_file = client.vector_stores.files.delete(
              file_to_delete, vector_store_id=index_id
          )
          print(f"Файл {file_to_delete} удален из индекса:", deleted_file)


      if __name__ == "__main__":
          main()
      ```

      Где:

      * `index_id` — идентификатор поискового индекса {{ vector-store-name }}, полученный ранее.
      * `file_to_delete` — идентификатор файла, который требуется удалить. Идентификаторы были получены ранее при загрузке файлов и при выполнении поискового запроса.

  1. Выполните созданный файл:

      ```bash
      python3 remove_file.py
      ```

      Результат:

      ```text
      Удаляем один файл из поискового индекса...
      Файл fvt5ajp8l83v******** удален из индекса: VectorStoreFileDeleted(id='fvt5ajp8l83v********', deleted=True, object='vector_store.file.deleted', valid=True)
      ```

{% endlist %}

## Удалить поисковый индекс {{ vector-store-name }} {#delete-index}

Чтобы удалить весь поисковый индекс, передайте в {{ vector-store-name }} API его идентификатор:

{% list tabs group=programming_language %}

- Python {#python}

  1. Создайте файл `delete_index.py` и добавьте в него следующий код:

      ```python
      import os
      import pathlib
      import time
      from openai import OpenAI

      YANDEX_API_KEY = "<API-ключ>"
      YANDEX_FOLDER_ID = "<идентификатор_каталога>"


      def main():
          client = OpenAI(
              api_key=YANDEX_API_KEY,
              base_url="https://rest-assistant.{{ api-host }}/v1",
              project=YANDEX_FOLDER_ID,
          )

          index_id = "<идентификатор_поискового_индекса>"

          # Удаляем весь vector store
          deleted_store = client.vector_stores.delete(index_id)
          print("Vector store удален:", deleted_store)


      if __name__ == "__main__":
          main()
      ```

      Где `index_id` — идентификатор поискового индекса {{ vector-store-name }}, полученный ранее.

  1. Выполните созданный файл:

      ```bash
      python3 delete_index.py
      ```

      Результат:

      ```text
      Vector store удален: VectorStoreDeleted(id='fvt9ef7q28n5********', deleted=True, object='vector_store.deleted', valid=True)
      ```

{% endlist %}

#### См. также {#see-also}

* [{#T}](../../concepts/search/vectorstore.md)
* [{#T}](./create-filesearch-text-agent.md)