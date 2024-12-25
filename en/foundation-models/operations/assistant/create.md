# Creating a simple assistant

{% include [assistants-preview-stage](../../../_includes/foundation-models/assistants-preview-stage.md) %}

{{ assistant-api }} is a tool for creating [AI assistants](../../concepts/assistant/index.md). It can be used to create personalized assistants, implement a generative response scenario adapted based on external information (known as _retrieval augmented generation_, or RAG), and save the model's request context.

## Getting started {#before-begin}

To use the examples:

{% list tabs group=programming_language %}

- SDK {#sdk}

  {% include [sdk-before-begin-assistants](../../../_includes/foundation-models/sdk-before-begin-assistants.md) %}

{% endlist %}

## Create an assistant {#create-assistant}

This example shows how to create an [assistant](../../concepts/assistant/index.md) to store your conversations with {{ gpt-pro }} RC.

{% list tabs group=programming_language %}

- SDK {#sdk}

  1. Create a file named `simple-assistant.py` and paste the following code into it:

      {% include [simple-assistant](../../../_includes/foundation-models/examples/simple-assistant.md) %}

      Where:

      {% include [sdk-code-legend](../../../_includes/foundation-models/examples/sdk-code-legend.md) %}

  1. Run the created file:

      ```bash
      python3 simple-assistant.py
      ```

      The example implements the simplest chat possible: enter your requests to the assistant from your keyboard and get answers. To end the dialog, enter `exit`.

      {% cut "Estimated result" %}

      ```text
      new thread=Thread(id='fvt4n5lkst29********', expiration_config=ExpirationConfig(ttl_days=5, expiration_policy=<ExpirationPolicy.STATIC: 1>), name='SimpleAssistant', description=None, created_by='aje62tfcd0oj********', created_at=datetime.datetime(2024, 12, 5, 7, 42, 5, 399924), updated_by='aje62tfcd0oj********', updated_at=datetime.datetime(2024, 12, 5, 7, 42, 5, 399924), expires_at=datetime.datetime(2024, 12, 10, 7, 42, 5, 399924), labels=None)
      Enter your question to the assistant:
      Hi!
      run=Run(id='fvtckgtjuv37********', assistant_id='fvtc6cl9s021********', thread_id='fvt4n5lkst29********', created_by='aje62tfcd0oj********', created_at=datetime.datetime(2024, 12, 5, 7, 42, 9, 893587), labels=None, custom_temperature=None, custom_max_tokens=None, custom_max_prompt_tokens=None)
      run result=RunResult(status=<RunStatus.COMPLETED: 4>, error=None, _message=Message(id='fvt07vgru2q4********', parts=('Hello! What can I do for you?',), thread_id='fvt4n5lkst29********', created_by='aje62tfcd0oj********', created_at=datetime.datetime(2024, 12, 5, 7, 42, 10, 975585), labels=None, author=Author(id='fvtc6cl9s021********', role='ASSISTANT')), usage=Usage(input_text_tokens=12, completion_tokens=6, total_tokens=18))
      Answer: Hello! What can I do for you?
      Enter your question to the assistant:
      How much is 2 + 2?
      run=Run(id='fvtp4fvk60be********', assistant_id='fvtc6cl9s021********', thread_id='fvt4n5lkst29********', created_by='aje62tfcd0oj********', created_at=datetime.datetime(2024, 12, 5, 7, 42, 34, 472706), labels=None, custom_temperature=None, custom_max_tokens=None, custom_max_prompt_tokens=None)
      run result=RunResult(status=<RunStatus.COMPLETED: 4>, error=None, _message=Message(id='fvtmagied4nq********', parts=('2 + 2 = 4.',), thread_id='fvt4n5lkst29********', created_by='aje62tfcd0oj********', created_at=datetime.datetime(2024, 12, 5, 7, 42, 35, 527779), labels=None, author=Author(id='fvtc6cl9s021********', role='ASSISTANT')), usage=Usage(input_text_tokens=36, completion_tokens=9, total_tokens=45))
      Answer: 2 + 2 = 4.
      Enter your question to the assistant:
      How about 15,234 - 265?
      run=Run(id='fvta2i4su9pm********', assistant_id='fvtc6cl9s021********', thread_id='fvt4n5lkst29********', created_by='aje62tfcd0oj********', created_at=datetime.datetime(2024, 12, 5, 7, 42, 49, 209323), labels=None, custom_temperature=None, custom_max_tokens=None, custom_max_prompt_tokens=None)
      run result=RunResult(status=<RunStatus.COMPLETED: 4>, error=None, _message=Message(id='fvt7q3rm6dq8l46l9sot', parts=('15234 − 265 = 14969.',), thread_id='fvt4n5lkst29********', created_by='aje62tfcd0oj********', created_at=datetime.datetime(2024, 12, 5, 7, 42, 50, 436048), labels=None, author=Author(id='fvtc6cl9s021********', role='ASSISTANT')), usage=Usage(input_text_tokens=68, completion_tokens=19, total_tokens=87))
      Answer: 15,234 − 265 = 14,969.
      Enter your question to the assistant:
      exit
      Outputting the whole message history when exiting the chat:
          message=Message(id='fvt7q3rm6dq8********', parts=('15234 − 265 = 14969.',), thread_id='fvt4n5lkst29********', created_by='aje62tfcd0oj********', created_at=datetime.datetime(2024, 12, 5, 7, 42, 50, 436048), labels=None, author=Author(id='fvtc6cl9s021********', role='ASSISTANT'))
          message.text='15234 − 265 = 14969.'

          message=Message(id='fvtghlkq0rou********', parts=('How about 15,234 - 265?',), thread_id='fvt4n5lkst29********', created_by='aje62tfcd0oj********', created_at=datetime.datetime(2024, 12, 5, 7, 42, 49, 109687), labels=None, author=Author(id='fvtvdtrvhbct********', role='USER'))
          message.text='How about 15,234 - 265?'

          message=Message(id='fvtmagied4nq********', parts=('2 + 2 = 4.',), thread_id='fvt4n5lkst29********', created_by='aje62tfcd0oj********', created_at=datetime.datetime(2024, 12, 5, 7, 42, 35, 527780), labels=None, author=Author(id='fvtc6cl9s021********', role='ASSISTANT'))
          message.text='2 + 2 = 4.'

          message=Message(id='fvtaqjvafdl1********', parts=('How much is 2 + 2?',), thread_id='fvt4n5lkst29********', created_by='aje62tfcd0oj********', created_at=datetime.datetime(2024, 12, 5, 7, 42, 34, 330088), labels=None, author=Author(id='fvtvdtrvhbct********', role='USER'))
          message.text='How much is 2 + 2?'

          message=Message(id='fvt07vgru2q4********', parts=('Hello! What can I do for you?',), thread_id='fvt4n5lkst29********', created_by='aje62tfcd0oj********', created_at=datetime.datetime(2024, 12, 5, 7, 42, 10, 975586), labels=None, author=Author(id='fvtc6cl9s021********', role='ASSISTANT'))
          message.text='Hello! What can I do for you?'

          message=Message(id='fvtjnb5mljhv********', parts=('Hi!',), thread_id='fvt4n5lkst29********', created_by='aje62tfcd0oj********', created_at=datetime.datetime(2024, 12, 5, 7, 42, 9, 686746), labels=None, author=Author(id='fvtvdtrvhbct********', role='USER'))
          message.text='Hi!'
      ```

      {% endcut %}


{% endlist %}

#### See also {#see-also}

* [{#T}](./create-with-searchindex.md)
* Examples of working with ML SDK on [GitHub](https://github.com/yandex-cloud/yandex-cloud-ml-sdk/tree/master/examples/sync/assistants) 