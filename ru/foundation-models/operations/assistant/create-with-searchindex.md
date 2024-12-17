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
      Введите ваш вопрос ассистенту: Сколько стоит виза на Бали?
      Answer: 300 рублей.
      Введите ваш вопрос ассистенту: А в Казахстан нужна виза?
      Answer: В приведённом тексте говорится о том, что для въезда в Казахстан из России необходим загранпаспорт. О визе в контексте поездки в Казахстан не упоминается.

      Ответ: в приведённом контексте нет информации о стоимости и необходимости визы для въезда в Казахстан, но уточняется, что нужен действующий загранпаспорт.
      Введите ваш вопрос ассистенту: Спасибо!
      Answer: Пожалуйста! Я могу помочь вам с чем-то ещё?
      Введите ваш вопрос ассистенту: exit
      Вывод всей истории сообщений при выходе из чата:
          message=Message(id='fvtaegenk534********', parts=('Пожалуйста! Я могу помочь вам с чем-то ещё?',), thread_id='fvtm560nq0a5********', created_by='ajegtlf2q28a********', created_at=datetime.datetime(2024, 12, 15, 21, 23, 15, 874678), labels=None, author=Author(id='fvtdo7i9cjot********', role='ASSISTANT'))
          message.text='Пожалуйста! Я могу помочь вам с чем-то ещё?'

          message=Message(id='fvtrpbdnn8ar********', parts=('Спасибо!',), thread_id='fvtm560nq0a5********', created_by='ajegtlf2q28a********', created_at=datetime.datetime(2024, 12, 15, 21, 23, 14, 896935), labels=None, author=Author(id='fvtjg25ejkk0********', role='USER'))
          message.text='Спасибо!'

          message=Message(id='fvt1jbftbspp********', parts=('В приведённом тексте говорится о том, что для въезда в Казахстан из России необходим загранпаспорт. О визе в контексте поездки в Казахстан не упоминается.\n\nОтвет: в приведённом контексте нет информации о стоимости и необходимости визы для въезда в Казахстан, но уточняется, что нужен действующий загранпаспорт.',), thread_id='fvtm560nq0a5********', created_by='ajegtlf2q28a********', created_at=datetime.datetime(2024, 12, 15, 21, 22, 42, 310047), labels=None, author=Author(id='fvtdo7i9cjot********', role='ASSISTANT'))
          message.text='В приведённом тексте говорится о том, что для въезда в Казахстан из России необходим загранпаспорт. О визе в контексте поездки в Казахстан не упоминается.\n\nОтвет: в приведённом контексте нет информации о стоимости и необходимости визы для въезда в Казахстан, но уточняется, что нужен действующий загранпаспорт.'

          message=Message(id='fvt1ugupmhe4********', parts=('А в Казахстан нужна виза?',), thread_id='fvtm560nq0a5********', created_by='ajegtlf2q28a********', created_at=datetime.datetime(2024, 12, 15, 21, 22, 39, 789471), labels=None, author=Author(id='fvtjg25ejkk0********', role='USER'))
          message.text='А в Казахстан нужна виза?'

          message=Message(id='fvtif8psp9ve363c5irj', parts=('300 рублей.',), thread_id='fvtm560nq0a5********', created_by='ajegtlf2q28a********', created_at=datetime.datetime(2024, 12, 15, 21, 22, 27, 546395), labels=None, author=Author(id='fvtdo7i9cjot********', role='ASSISTANT'))
          message.text='300 рублей.'

          message=Message(id='fvt82ggg27ui********', parts=('Сколько стоит виза на Бали?',), thread_id='fvtm560nq0a5********', created_by='ajegtlf2q28a********', created_at=datetime.datetime(2024, 12, 15, 21, 22, 26, 794009), labels=None, author=Author(id='fvtjg25ejkk0********', role='USER'))
          message.text='Сколько стоит виза на Бали?'
      ```

      {% endcut %}

{% endlist %}

#### См. также {#see-also}

* [{#T}](./create.md)
* Примеры работы с ML SDK на [GitHub](https://github.com/yandex-cloud/yandex-cloud-ml-sdk/tree/master/examples/sync/assistants)