# Создать ассистента с поисковым индексом

{% include [assistants-preview-stage](../../../_includes/foundation-models/assistants-preview-stage.md) %}

{{ assistant-api }} — это инструмент создания [AI-ассистентов](../../concepts/assistant/index.md). С его помощью можно создать персонализированных помощников, реализовывать сценарий генеративного ответа с учетом информации из внешних источников (RAG, Retrieval Augmented Generation), а также сохранять контекст запросов к модели.

## Перед началом работы {#before-begin}

Чтобы воспользоваться примерами:

{% list tabs group=programming_language %}

- SDK {#sdk}

  {% include [sdk-before-begin-assistants](../../../_includes/foundation-models/sdk-before-begin-assistants.md) %}

{% endlist %}

## Создайте ассистента {#create-assistant}

Этот пример показывает, как создать [ассистента](../../concepts/assistant/index.md), который для ответов использует информацию из файлов. В примере будет создан индекс для полнотекстового поиска и реализован простейший вариант чата.

{% list tabs group=programming_language %}

- SDK {#sdk}

  1. Скачайте и распакуйте [архив](https://storage.yandexcloud.net/doc-files/tours-example.zip) с примерами файлов, которые будут использоваться как дополнительный источник информации. В файлах содержатся рекламные тексты для туров на Бали и в Казахстан, сгенерированные {{ gpt-pro }}.
  1. Создайте файл `search-assistant.py` и добавьте в него следующий код:

      {% include [searchindex-assistant](../../../_includes/foundation-models/examples/searchindex-assistant.md) %}

      Где:

      * `mypath` — переменная, содержащая путь к директории, в которой сохранены скачанные ранее файлы. Например: `/Users/myuser/tours-example/`.

      {% include [sdk-code-legend](../../../_includes/foundation-models/examples/sdk-code-legend.md) %}

  1. Выполните созданный файл:

      ```bash
      python3 search-assistant.py
      ```

      В примере реализован простейший вариант чата: вводите с клавиатуры запросы ассистенту и получайте ответы на них. Чтобы прекратить диалог, введите `exit`.

      {% cut "Примерный результат выполнения" %}

      ```text
      Введите ваш вопрос ассистенту:
      Сколько стоит виза на Бали?
      Answer: 300 рублей.
      Введите ваш вопрос ассистенту:
      А в Казахстан нужна виза?
      Answer: В приведённом тексте сказано, что для въезда в Казахстан из России необходим загранпаспорт. О визе в контексте поездки в Казахстан не упоминается.

      Ответ: информации о том, нужна ли виза для въезда в Казахстан, в тексте нет. Но для посещения этой страны нужен загранпаспорт.
      Введите ваш вопрос ассистенту:
      Спасибо!
      Answer: Пожалуйста! Если у вас есть ещё вопросы, я постараюсь помочь.
      Введите ваш вопрос ассистенту:
      exit
      Вывод всей истории сообщений при выходе из чата:
          message=Message(id='fvt6lh2ng3r2********', parts=('Пожалуйста! Если у вас есть ещё вопросы, я постараюсь помочь.',), thread_id='fvt4rk62dcic********', created_by='aje62tfcd0oj********', created_at=datetime.datetime(2024, 12, 5, 8, 0, 4, 189394), labels=None, author=Author(id='fvtdvgoissl2********', role='ASSISTANT'))
          message.text='Пожалуйста! Если у вас есть ещё вопросы, я постараюсь помочь.'

          message=Message(id='fvt8mmj7t3bs********', parts=('Спасибо!',), thread_id='fvt4rk62dcic********', created_by='aje62tfcd0oj********', created_at=datetime.datetime(2024, 12, 5, 8, 0, 2, 500379), labels=None, author=Author(id='fvtcqfte9ih3********', role='USER'))
          message.text='Спасибо!'

          message=Message(id='fvte2e8sl7be********', parts=('В приведённом тексте сказано, что для въезда в Казахстан из России необходим загранпаспорт. О визе в контексте поездки в Казахстан не упоминается.\n\nОтвет: информации о том, нужна ли виза для въезда в Казахстан, в тексте нет. Но для посещения этой страны нужен загранпаспорт.',), thread_id='fvt4rk62dcic********', created_by='aje62tfcd0oj********', created_at=datetime.datetime(2024, 12, 5, 7, 59, 38, 449794), labels=None, author=Author(id='fvtdvgoissl2********', role='ASSISTANT'))
          message.text='В приведённом тексте сказано, что для въезда в Казахстан из России необходим загранпаспорт. О визе в контексте поездки в Казахстан не упоминается.\n\nОтвет: информации о том, нужна ли виза для въезда в Казахстан, в тексте нет. Но для посещения этой страны нужен загранпаспорт.'

          message=Message(id='fvtm404ffbo9********', parts=('А в Казахстан нужна виза?',), thread_id='fvt4rk62dcicf81e5g5c', created_by='aje62tfcd0oj********', created_at=datetime.datetime(2024, 12, 5, 7, 59, 35, 300522), labels=None, author=Author(id='fvtcqfte9ih3********', role='USER'))
          message.text='А в Казахстан нужна виза?'

          message=Message(id='fvtljfirc36m********', parts=('300 рублей.',), thread_id='fvt4rk62dcic********', created_by='aje62tfcd0oj********', created_at=datetime.datetime(2024, 12, 5, 7, 59, 17, 736961), labels=None, author=Author(id='fvtdvgoissl2********', role='ASSISTANT'))
          message.text='300 рублей.'

          message=Message(id='fvt3rc4oat2m********', parts=('Сколько стоит виза на Бали?',), thread_id='fvt4rk62dcic********', created_by='aje62tfcd0oj********', created_at=datetime.datetime(2024, 12, 5, 7, 59, 16, 599110), labels=None, author=Author(id='fvtcqfte9ih3********', role='USER'))
          message.text='Сколько стоит виза на Бали?'
      ```

      {% endcut %}

{% endlist %}

#### См. также {#see-also}

* [{#T}](./create.md)
* Примеры работы с ML SDK на [GitHub](https://github.com/yandex-cloud/yandex-cloud-ml-sdk/tree/master/examples/sync/assistants)