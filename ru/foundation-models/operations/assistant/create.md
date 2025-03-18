---
title: Создать простого ассистента
description: Следуя этой инструкции, вы сможете создать простого ассистента с помощью {{ assistant-api }}.
---

# Создать простого ассистента

{% include [assistants-preview-stage](../../../_includes/foundation-models/assistants-preview-stage.md) %}

{{ assistant-api }} — это инструмент создания [AI-ассистентов](../../concepts/assistant/index.md). С его помощью можно создать персонализированных помощников, реализовывать сценарий генеративного ответа с учетом информации из внешних источников (RAG, Retrieval Augmented Generation), а также сохранять контекст запросов к модели.

## Перед началом работы {#before-begin}

Чтобы воспользоваться примерами:

{% list tabs group=programming_language %}

- SDK {#sdk}

  {% include [sdk-before-begin-assistants](../../../_includes/foundation-models/sdk-before-begin-assistants.md) %}

{% endlist %}

## Создайте ассистента {#create-assistant}

Этот пример показывает, как создать [ассистента](../../concepts/assistant/index.md), который будет хранить переписку с моделью {{ gpt-pro }} RC.

{% list tabs group=programming_language %}

- SDK {#sdk}

  1. Создайте файл `simple-assistant.py` и добавьте в него следующий код:

      {% include [simple-assistant](../../../_includes/foundation-models/examples/simple-assistant.md) %}

      Где:

      {% include [sdk-code-legend](../../../_includes/foundation-models/examples/sdk-code-legend.md) %}

  1. Выполните созданный файл:

      ```bash
      python3 simple-assistant.py
      ```

      В примере реализован простейший вариант чата: вводите с клавиатуры запросы ассистенту и получайте ответы на них. Чтобы прекратить диалог, введите `exit`.

      {% cut "Примерный результат выполнения" %}

      ```text
      new thread=Thread(id='fvt67i1ettn5********', expiration_config=ExpirationConfig(ttl_days=5, expiration_policy=<ExpirationPolicy.STATIC: 1>), name='SimpleAssistant', description=None, created_by='ajegtlf2q28a********', created_at=datetime.datetime(2024, 12, 15, 21, 5, 33, 8133), updated_by='ajegtlf2q28a********', updated_at=datetime.datetime(2024, 12, 15, 21, 5, 33, 8133), expires_at=datetime.datetime(2024, 12, 20, 21, 5, 33, 8133), labels=None)
      Введите ваш вопрос ассистенту: Привет!
      run=Run(id='fvtm4n1o2hla********', assistant_id='fvthtngdnlkq********', thread_id='fvt67i1ettn5********', created_by='ajegtlf2q28a********', created_at=datetime.datetime(2024, 12, 15, 21, 5, 53, 312504), labels=None, custom_temperature=None, custom_max_tokens=None, custom_max_prompt_tokens=None)
      run result=RunResult(status=<RunStatus.COMPLETED: 4>, error=None, _message=Message(id='fvtburadn35c********', parts=('Здравствуйте! Чем могу помочь?',), thread_id='fvt67i1ettn5********', created_by='ajegtlf2q28a********', created_at=datetime.datetime(2024, 12, 15, 21, 5, 53, 728330), labels=None, author=Author(id='fvthtngdnlkq********', role='ASSISTANT')), usage=Usage(input_text_tokens=12, completion_tokens=6, total_tokens=18))
      Answer: Здравствуйте! Чем могу помочь?
      Введите ваш вопрос ассистенту: Сколько будет 2 + 2?
      run=Run(id='fvt2eajhkqnb********', assistant_id='fvthtngdnlkq********', thread_id='fvt67i1ettn5********', created_by='ajegtlf2q28a********', created_at=datetime.datetime(2024, 12, 15, 21, 7, 36, 751185), labels=None, custom_temperature=None, custom_max_tokens=None, custom_max_prompt_tokens=None)
      run result=RunResult(status=<RunStatus.COMPLETED: 4>, error=None, _message=Message(id='fvtnmfeavsm1********', parts=('2 + 2 = 4.',), thread_id='fvt67i1ettn5********', created_by='ajegtlf2q28a********', created_at=datetime.datetime(2024, 12, 15, 21, 7, 37, 294861), labels=None, author=Author(id='fvthtngdnlkq********', role='ASSISTANT')), usage=Usage(input_text_tokens=36, completion_tokens=9, total_tokens=45))
      Answer: 2 + 2 = 4.
      Введите ваш вопрос ассистенту: А 15234 - 265?
      run=Run(id='fvt55e1qr4d0********', assistant_id='fvthtngdnlkq********', thread_id='fvt67i1ettn5********', created_by='ajegtlf2q28a********', created_at=datetime.datetime(2024, 12, 15, 21, 7, 59, 483141), labels=None, custom_temperature=None, custom_max_tokens=None, custom_max_prompt_tokens=None)
      run result=RunResult(status=<RunStatus.COMPLETED: 4>, error=None, _message=Message(id='fvtujctocrak********', parts=('15234 − 265 = 14969.',), thread_id='fvt67i1ettn5********', created_by='ajegtlf2q28a********', created_at=datetime.datetime(2024, 12, 15, 21, 8, 0, 244274), labels=None, author=Author(id='fvthtngdnlkq********', role='ASSISTANT')), usage=Usage(input_text_tokens=68, completion_tokens=19, total_tokens=87))
      Answer: 15234 − 265 = 14969.
      Введите ваш вопрос ассистенту: exit
      Вывод всей истории сообщений при выходе из чата:
          message=Message(id='fvtujctocrak********', parts=('15234 − 265 = 14969.',), thread_id='fvt67i1ettn5********', created_by='ajegtlf2q28a********', created_at=datetime.datetime(2024, 12, 15, 21, 8, 0, 244274), labels=None, author=Author(id='fvthtngdnlkq********', role='ASSISTANT'))
          message.text='15234 − 265 = 14969.'

          message=Message(id='fvthbaqg1rep********', parts=('А 15234 - 265?',), thread_id='fvt67i1ettn5********', created_by='ajegtlf2q28a********', created_at=datetime.datetime(2024, 12, 15, 21, 7, 59, 375702), labels=None, author=Author(id='fvt82v4kgb7i********', role='USER'))
          message.text='А 15234 - 265?'

          message=Message(id='fvtnmfeavsm1********', parts=('2 + 2 = 4.',), thread_id='fvt67i1ettn5********', created_by='ajegtlf2q28a********', created_at=datetime.datetime(2024, 12, 15, 21, 7, 37, 294862), labels=None, author=Author(id='fvthtngdnlkq********', role='ASSISTANT'))
          message.text='2 + 2 = 4.'

          message=Message(id='fvtdd4fbb4n8********', parts=('Сколько будет 2 + 2?',), thread_id='fvt67i1ettn5********', created_by='ajegtlf2q28a********', created_at=datetime.datetime(2024, 12, 15, 21, 7, 36, 625764), labels=None, author=Author(id='fvt82v4kgb7i********', role='USER'))
          message.text='Сколько будет 2 + 2?'

          message=Message(id='fvtburadn35c********', parts=('Здравствуйте! Чем могу помочь?',), thread_id='fvt67i1ettn5********', created_by='ajegtlf2q28a********', created_at=datetime.datetime(2024, 12, 15, 21, 5, 53, 728331), labels=None, author=Author(id='fvthtngdnlkq********', role='ASSISTANT'))
          message.text='Здравствуйте! Чем могу помочь?'

          message=Message(id='fvt9apvs2au9********', parts=('Привет!',), thread_id='fvt67i1ettn5********', created_by='ajegtlf2q28a********', created_at=datetime.datetime(2024, 12, 15, 21, 5, 53, 136965), labels=None, author=Author(id='fvt82v4kgb7i********', role='USER'))
          message.text='Привет!'
      ```

      {% endcut %}

      {% note info %}

      При выполнении запросов к ассистенту вы можете [получать](./request-chunked-response.md) промежуточные результаты генерации до завершения формирования моделью окончательного ответа.

      {% endnote %}

{% endlist %}

#### См. также {#see-also}

* [{#T}](./create-with-searchindex.md)
* [{#T}](./request-chunked-response.md)
* [{#T}](../../tutorials/pdf-searchindex-ai-assistant.md)
* Примеры работы с {{ ml-sdk-name }} на [GitHub](https://github.com/yandex-cloud/yandex-cloud-ml-sdk/tree/master/examples/sync/assistants)