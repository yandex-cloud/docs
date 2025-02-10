---
title: Creating a simple assistant
description: Follow this guide to create a simple assistant using {{ assistant-api }}.
---

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

      {% cut "Approximate result" %}

      ```text
      new thread=Thread(id='fvt67i1ettn5********', expiration_config=ExpirationConfig(ttl_days=5, expiration_policy=<ExpirationPolicy.STATIC: 1>), name='SimpleAssistant', description=None, created_by='ajegtlf2q28a********', created_at=datetime.datetime(2024, 12, 15, 21, 5, 33, 8133), updated_by='ajegtlf2q28a********', updated_at=datetime.datetime(2024, 12, 15, 21, 5, 33, 8133), expires_at=datetime.datetime(2024, 12, 20, 21, 5, 33, 8133), labels=None)
      Enter your question to the assistant: Hi!
      run=Run(id='fvtm4n1o2hla********', assistant_id='fvthtngdnlkq********', thread_id='fvt67i1ettn5********', created_by='ajegtlf2q28a********', created_at=datetime.datetime(2024, 12, 15, 21, 5, 53, 312504), labels=None, custom_temperature=None, custom_max_tokens=None, custom_max_prompt_tokens=None)
      run result=RunResult(status=<RunStatus.COMPLETED: 4>, error=None, _message=Message(id='fvtburadn35c********', parts=('Hello! What can I do for you?',), thread_id='fvt67i1ettn5********', created_by='ajegtlf2q28a********', created_at=datetime.datetime(2024, 12, 15, 21, 5, 53, 728330), labels=None, author=Author(id='fvthtngdnlkq********', role='ASSISTANT')), usage=Usage(input_text_tokens=12, completion_tokens=6, total_tokens=18))
      Answer: Hello! What can I do for you?
      Enter your question to the assistant: How much is 2 + 2?
      run=Run(id='fvt2eajhkqnb********', assistant_id='fvthtngdnlkq********', thread_id='fvt67i1ettn5********', created_by='ajegtlf2q28a********', created_at=datetime.datetime(2024, 12, 15, 21, 7, 36, 751185), labels=None, custom_temperature=None, custom_max_tokens=None, custom_max_prompt_tokens=None)
      run result=RunResult(status=<RunStatus.COMPLETED: 4>, error=None, _message=Message(id='fvtnmfeavsm1********', parts=('2 + 2 = 4.',), thread_id='fvt67i1ettn5********', created_by='ajegtlf2q28a********', created_at=datetime.datetime(2024, 12, 15, 21, 7, 37, 294861), labels=None, author=Author(id='fvthtngdnlkq********', role='ASSISTANT')), usage=Usage(input_text_tokens=36, completion_tokens=9, total_tokens=45))
      Answer: 2 + 2 = 4.
      Enter your question to the assistant: How about 15,234 - 265?
      run=Run(id='fvt55e1qr4d0********', assistant_id='fvthtngdnlkq********', thread_id='fvt67i1ettn5********', created_by='ajegtlf2q28a********', created_at=datetime.datetime(2024, 12, 15, 21, 7, 59, 483141), labels=None, custom_temperature=None, custom_max_tokens=None, custom_max_prompt_tokens=None)
      run result=RunResult(status=<RunStatus.COMPLETED: 4>, error=None, _message=Message(id='fvtujctocrak********', parts=('15234 − 265 = 14969.',), thread_id='fvt67i1ettn5********', created_by='ajegtlf2q28a********', created_at=datetime.datetime(2024, 12, 15, 21, 8, 0, 244274), labels=None, author=Author(id='fvthtngdnlkq********', role='ASSISTANT')), usage=Usage(input_text_tokens=68, completion_tokens=19, total_tokens=87))
      Answer: 15,234 − 265 = 14,969.
      Enter your question to the assistant: exit
      Outputting the whole message history when exiting the chat:
          message=Message(id='fvtujctocrak********', parts=('15234 − 265 = 14969.',), thread_id='fvt67i1ettn5********', created_by='ajegtlf2q28a********', created_at=datetime.datetime(2024, 12, 15, 21, 8, 0, 244274), labels=None, author=Author(id='fvthtngdnlkq********', role='ASSISTANT'))
          message.text='15234 − 265 = 14969.'

          message=Message(id='fvthbaqg1rep********', parts=('And 15234 - 265?',), thread_id='fvt67i1ettn5********', created_by='ajegtlf2q28a********', created_at=datetime.datetime(2024, 12, 15, 21, 7, 59, 375702), labels=None, author=Author(id='fvt82v4kgb7i********', role='USER'))
          message.text='How about 15,234 - 265?'

          message=Message(id='fvtnmfeavsm1********', parts=('2 + 2 = 4.',), thread_id='fvt67i1ettn5********', created_by='ajegtlf2q28a********', created_at=datetime.datetime(2024, 12, 15, 21, 7, 37, 294862), labels=None, author=Author(id='fvthtngdnlkq********', role='ASSISTANT'))
          message.text='2 + 2 = 4.'

          message=Message(id='fvtdd4fbb4n8********', parts=('How much is 2 + 2?',), thread_id='fvt67i1ettn5********', created_by='ajegtlf2q28a********', created_at=datetime.datetime(2024, 12, 15, 21, 7, 36, 625764), labels=None, author=Author(id='fvt82v4kgb7i********', role='USER'))
          message.text='How much is 2 + 2?'

          message=Message(id='fvtburadn35c********', parts=('Hello! What can I do for you?',), thread_id='fvt67i1ettn5********', created_by='ajegtlf2q28a********', created_at=datetime.datetime(2024, 12, 15, 21, 5, 53, 728331), labels=None, author=Author(id='fvthtngdnlkq********', role='ASSISTANT'))
          message.text='Hello! What can I do for you?'

          message=Message(id='fvt9apvs2au9********', parts=('Hi!',), thread_id='fvt67i1ettn5********', created_by='ajegtlf2q28a********', created_at=datetime.datetime(2024, 12, 15, 21, 5, 53, 136965), labels=None, author=Author(id='fvt82v4kgb7i********', role='USER'))
          message.text='Hi!'
      ```

      {% endcut %}


{% endlist %}

#### See also {#see-also}

* [{#T}](./create-with-searchindex.md)
* Examples of working with ML SDK on [GitHub](https://github.com/yandex-cloud/yandex-cloud-ml-sdk/tree/master/examples/sync/assistants) 