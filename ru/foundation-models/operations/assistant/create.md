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
      new thread=Thread(id='fvt4n5lkst29********', expiration_config=ExpirationConfig(ttl_days=5, expiration_policy=<ExpirationPolicy.STATIC: 1>), name='SimpleAssistant', description=None, created_by='aje62tfcd0oj********', created_at=datetime.datetime(2024, 12, 5, 7, 42, 5, 399924), updated_by='aje62tfcd0oj********', updated_at=datetime.datetime(2024, 12, 5, 7, 42, 5, 399924), expires_at=datetime.datetime(2024, 12, 10, 7, 42, 5, 399924), labels=None)
      Введите ваш вопрос ассистенту:
      Привет!
      run=Run(id='fvtckgtjuv37********', assistant_id='fvtc6cl9s021********', thread_id='fvt4n5lkst29********', created_by='aje62tfcd0oj********', created_at=datetime.datetime(2024, 12, 5, 7, 42, 9, 893587), labels=None, custom_temperature=None, custom_max_tokens=None, custom_max_prompt_tokens=None)
      run result=RunResult(status=<RunStatus.COMPLETED: 4>, error=None, _message=Message(id='fvt07vgru2q4********', parts=('Здравствуйте! Чем могу помочь?',), thread_id='fvt4n5lkst29********', created_by='aje62tfcd0oj********', created_at=datetime.datetime(2024, 12, 5, 7, 42, 10, 975585), labels=None, author=Author(id='fvtc6cl9s021********', role='ASSISTANT')), usage=Usage(input_text_tokens=12, completion_tokens=6, total_tokens=18))
      Answer: Здравствуйте! Чем могу помочь?
      Введите ваш вопрос ассистенту:
      Сколько будет 2 + 2?
      run=Run(id='fvtp4fvk60be********', assistant_id='fvtc6cl9s021********', thread_id='fvt4n5lkst29********', created_by='aje62tfcd0oj********', created_at=datetime.datetime(2024, 12, 5, 7, 42, 34, 472706), labels=None, custom_temperature=None, custom_max_tokens=None, custom_max_prompt_tokens=None)
      run result=RunResult(status=<RunStatus.COMPLETED: 4>, error=None, _message=Message(id='fvtmagied4nq********', parts=('2 + 2 = 4.',), thread_id='fvt4n5lkst29********', created_by='aje62tfcd0oj********', created_at=datetime.datetime(2024, 12, 5, 7, 42, 35, 527779), labels=None, author=Author(id='fvtc6cl9s021********', role='ASSISTANT')), usage=Usage(input_text_tokens=36, completion_tokens=9, total_tokens=45))
      Answer: 2 + 2 = 4.
      Введите ваш вопрос ассистенту:
      А 15234 - 265?
      run=Run(id='fvta2i4su9pm********', assistant_id='fvtc6cl9s021********', thread_id='fvt4n5lkst29********', created_by='aje62tfcd0oj********', created_at=datetime.datetime(2024, 12, 5, 7, 42, 49, 209323), labels=None, custom_temperature=None, custom_max_tokens=None, custom_max_prompt_tokens=None)
      run result=RunResult(status=<RunStatus.COMPLETED: 4>, error=None, _message=Message(id='fvt7q3rm6dq8l46l9sot', parts=('15234 − 265 = 14969.',), thread_id='fvt4n5lkst29********', created_by='aje62tfcd0oj********', created_at=datetime.datetime(2024, 12, 5, 7, 42, 50, 436048), labels=None, author=Author(id='fvtc6cl9s021********', role='ASSISTANT')), usage=Usage(input_text_tokens=68, completion_tokens=19, total_tokens=87))
      Answer: 15234 − 265 = 14969.
      Введите ваш вопрос ассистенту:
      exit
      Вывод всей истории сообщений при выходе из чата:
          message=Message(id='fvt7q3rm6dq8********', parts=('15234 − 265 = 14969.',), thread_id='fvt4n5lkst29********', created_by='aje62tfcd0oj********', created_at=datetime.datetime(2024, 12, 5, 7, 42, 50, 436048), labels=None, author=Author(id='fvtc6cl9s021********', role='ASSISTANT'))
          message.text='15234 − 265 = 14969.'

          message=Message(id='fvtghlkq0rou********', parts=('А 15234 - 265?',), thread_id='fvt4n5lkst29********', created_by='aje62tfcd0oj********', created_at=datetime.datetime(2024, 12, 5, 7, 42, 49, 109687), labels=None, author=Author(id='fvtvdtrvhbct********', role='USER'))
          message.text='А 15234 - 265?'

          message=Message(id='fvtmagied4nq********', parts=('2 + 2 = 4.',), thread_id='fvt4n5lkst29********', created_by='aje62tfcd0oj********', created_at=datetime.datetime(2024, 12, 5, 7, 42, 35, 527780), labels=None, author=Author(id='fvtc6cl9s021********', role='ASSISTANT'))
          message.text='2 + 2 = 4.'

          message=Message(id='fvtaqjvafdl1********', parts=('Сколько будет 2 + 2?',), thread_id='fvt4n5lkst29********', created_by='aje62tfcd0oj********', created_at=datetime.datetime(2024, 12, 5, 7, 42, 34, 330088), labels=None, author=Author(id='fvtvdtrvhbct********', role='USER'))
          message.text='Сколько будет 2 + 2?'

          message=Message(id='fvt07vgru2q4********', parts=('Здравствуйте! Чем могу помочь?',), thread_id='fvt4n5lkst29********', created_by='aje62tfcd0oj********', created_at=datetime.datetime(2024, 12, 5, 7, 42, 10, 975586), labels=None, author=Author(id='fvtc6cl9s021********', role='ASSISTANT'))
          message.text='Здравствуйте! Чем могу помочь?'

          message=Message(id='fvtjnb5mljhv********', parts=('Привет!',), thread_id='fvt4n5lkst29********', created_by='aje62tfcd0oj********', created_at=datetime.datetime(2024, 12, 5, 7, 42, 9, 686746), labels=None, author=Author(id='fvtvdtrvhbct********', role='USER'))
          message.text='Привет!'
      ```

      {% endcut %}


{% endlist %}

#### См. также {#see-also}

* [{#T}](./create-with-searchindex.md)
* Примеры работы с ML SDK на [GitHub](https://github.com/yandex-cloud/yandex-cloud-ml-sdk/tree/master/examples/sync/assistants) 