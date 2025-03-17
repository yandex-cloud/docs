---
title: Создать ассистента с получением промежуточных результатов генерации ответа
description: Следуя этой инструкции, с помощью {{ assistant-api }} вы сможете создать AI-ассистента с получением промежуточных результатов генерации ответа.
---

# Создать ассистента с получением промежуточных результатов генерации ответа

{% include [assistants-preview-stage](../../../_includes/foundation-models/assistants-preview-stage.md) %}

{{ assistant-api }} — это инструмент создания [AI-ассистентов](../../concepts/assistant/index.md). С его помощью можно создать персонализированных помощников, реализовывать сценарий генеративного ответа с учетом информации из внешних источников (RAG, Retrieval Augmented Generation), а также сохранять контекст запросов к модели. При выполнении запросов к ассистенту вы можете получать промежуточные результаты генерации по мере формирования моделью ответа.

## Перед началом работы {#before-begin}

Чтобы воспользоваться примерами:

{% list tabs group=programming_language %}

- SDK {#sdk}

  {% include [sdk-before-begin-assistants](../../../_includes/foundation-models/sdk-before-begin-assistants.md) %}

{% endlist %}

## Создайте ассистента {#create-assistant}

Этот пример показывает, как создать [ассистента](../../concepts/assistant/index.md), который будет хранить переписку с моделью {{ gpt-pro }} RC, а при обращении к модели будет выводить промежуточные результаты генерации по мере формирования моделью ответа.

{% list tabs group=programming_language %}

- SDK {#sdk}

  1. Создайте файл `simple-assistant.py` и добавьте в него следующий код:

      {% include [assistant-in-chunks](../../../_includes/foundation-models/examples/assistant-in-chunks.md) %}

      Где:

      {% include [sdk-code-legend](../../../_includes/foundation-models/examples/sdk-code-legend.md) %}

  1. Выполните созданный файл:

      ```bash
      python3 simple-assistant.py
      ```

      В примере реализован простейший вариант чата: вводите с клавиатуры запросы ассистенту и получайте ответы на них. Чтобы прекратить диалог, введите `exit`.

      {% cut "Примерный результат выполнения" %}

      ```text
      Задайте вопрос ассистенту ("exit" — для выхода): Привет!
      ('Здравствуйте',)
      ('Здравствуйте! Чем могу помочь?',)
      ('Здравствуйте! Чем могу помочь?',)
      run event=RunStreamEvent(status=<StreamEvent.DONE: 3>, error=None, _message=Message
      (id='fvtbkt2tbf7a********', parts=('Здравствуйте! Чем могу помочь?',), thread_id='fvt50ma5302n********', 
      created_by='ajegtlf2q28a********', created_at=datetime.datetime(2025, 3, 13, 17, 51, 22, 146833), 
      labels=None, author=Author(id='fvtle31p6lv2********', role='ASSISTANT'), citations=()))
      Задайте ваш вопрос ассистенту ("exit" — для выхода): Сколько планет в Солнечной системе?
      ('В',)
      ('В Солнечной системе **восемь планет**: Меркурий, Венера, Земля, Марс, Юпитер, Сатур',)
      ('В Солнечной системе **восемь планет**: Меркурий, Венера, Земля, Марс, Юпитер, Сатурн, Уран и Нептун.',)
      ('В Солнечной системе **восемь планет**: Меркурий, Венера, Земля, Марс, Юпитер, Сатурн, Уран и Нептун.',)
      run event=RunStreamEvent(status=<StreamEvent.DONE: 3>, error=None, _message=Message
      (id='fvt4f3p6ddue********', parts=('В Солнечной системе **восемь планет**: Меркурий, Венера, Земля, 
      Марс, Юпитер, Сатурн, Уран и Нептун.',), thread_id='fvt50ma5302n********', 
      created_by='ajegtlf2q28a********', created_at=datetime.datetime(2025, 3, 13, 17, 51, 33, 36643), 
      labels=None, author=Author(id='fvtle31p6lv2********', role='ASSISTANT'), citations=()))
      Задайте ваш вопрос ассистенту ("exit" — для выхода): Как далеко от Солнца до Земли?
      ('Среднее',)
      ('Среднее расстояние от Земли до Солнца составляет приблизительно 149,6 миллиона километров. Это 
      расстояние',)
      ('Среднее расстояние от Земли до Солнца составляет приблизительно 149,6 миллиона километров. Это 
      расстояние также известно как астрономическая единица (АЕ).',)
      ('Среднее расстояние от Земли до Солнца составляет приблизительно 149,6 миллиона километров. Это 
      расстояние также известно как астрономическая единица (АЕ).',)
      run event=RunStreamEvent(status=<StreamEvent.DONE: 3>, error=None, _message=Message
      (id='fvtees4295mr********', parts=('Среднее расстояние от Земли до Солнца составляет приблизительно 149,
      6 миллиона километров. Это расстояние также известно как астрономическая единица (АЕ).',), 
      thread_id='fvt50ma5302n********', created_by='ajegtlf2q28a********', created_at=datetime.datetime(2025, 
      3, 13, 17, 51, 44, 33797), labels=None, author=Author(id='fvtle31p6lv2********', role='ASSISTANT'), 
      citations=()))
      Задайте ваш вопрос ассистенту ("exit" — для выхода): Exit
      Вывод всей истории сообщений при выходе из чата:
          message=Message(id='fvtees4295mr********', parts=('Среднее расстояние от Земли до Солнца составляет 
          приблизительно 149,6 миллиона километров. Это расстояние также известно как астрономическая единица 
          (АЕ).',), thread_id='fvt50ma5302n********', created_by='ajegtlf2q28a********', created_at=datetime.
          datetime(2025, 3, 13, 17, 51, 44, 33798), labels=None, author=Author(id='fvtle31p6lv2********', 
          role='ASSISTANT'), citations=())
          message.text='Среднее расстояние от Земли до Солнца составляет приблизительно 149,6 миллиона 
          километров. Это расстояние также известно как астрономическая единица (АЕ).'

          message=Message(id='fvto6b4rdg0o********', parts=('Как далеко от Солнца до Земли?',), 
          thread_id='fvt50ma5302n********', created_by='ajegtlf2q28a********', created_at=datetime.datetime
          (2025, 3, 13, 17, 51, 42, 941742), labels=None, author=Author(id='fvtjnthkl0g5********', 
          role='USER'), citations=())
          message.text='Как далеко от Солнца до Земли?'

          message=Message(id='fvt4f3p6ddue********', parts=('В Солнечной системе **восемь планет**: Меркурий, 
          Венера, Земля, Марс, Юпитер, Сатурн, Уран и Нептун.',), thread_id='fvt50ma5302n********', 
          created_by='ajegtlf2q28a********', created_at=datetime.datetime(2025, 3, 13, 17, 51, 33, 36644), 
          labels=None, author=Author(id='fvtle31p6lv2********', role='ASSISTANT'), citations=())
          message.text='В Солнечной системе **восемь планет**: Меркурий, Венера, Земля, Марс, Юпитер, Сатурн, 
          Уран и Нептун.'

          message=Message(id='fvtme86dsuju********', parts=('Сколько планет в Солнечной системе?',), 
          thread_id='fvt50ma5302n********', created_by='ajegtlf2q28a********', created_at=datetime.datetime
          (2025, 3, 13, 17, 51, 32, 139), labels=None, author=Author(id='fvtjnthkl0g5********', role='USER'), 
          citations=())
          message.text='Сколько планет в Солнечной системе?'

          message=Message(id='fvtbkt2tbf7a********', parts=('Здравствуйте! Чем могу помочь?',), 
          thread_id='fvt50ma5302n********', created_by='ajegtlf2q28a********', created_at=datetime.datetime
          (2025, 3, 13, 17, 51, 22, 146834), labels=None, author=Author(id='fvtle31p6lv2********', 
          role='ASSISTANT'), citations=())
          message.text='Здравствуйте! Чем могу помочь?'

          message=Message(id='fvtemh1qqc50********', parts=('Привет!',), thread_id='fvt50ma5302n********', 
          created_by='ajegtlf2q28a********', created_at=datetime.datetime(2025, 3, 13, 17, 51, 21, 359885), 
          labels=None, author=Author(id='fvtjnthkl0g5********', role='USER'), citations=())
          message.text='Привет!'
      ```

      {% endcut %}

{% endlist %}

#### См. также {#see-also}

* [{#T}](./create.md)
* [{#T}](./create-with-searchindex.md)
* Примеры работы с ML SDK на [GitHub](https://github.com/yandex-cloud/yandex-cloud-ml-sdk/tree/master/examples/sync/assistants)