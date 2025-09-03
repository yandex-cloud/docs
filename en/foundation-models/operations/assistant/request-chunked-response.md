---
title: Creating an assistant with intermediate response generation results
description: Follow this guide to make {{ assistant-api }} create your AI assistant with intermediate response generation results.
---

# Creating a RAG assistant with intermediate response generation results

{% include [assistants-preview-stage](../../../_includes/foundation-models/assistants-preview-stage.md) %}

{{ assistant-api }} is a {{ foundation-models-name }} tool for creating [AI assistants](../../concepts/assistant/index.md). It can be used to create personalized assistants, implement a generative response scenario with access to information from external sources (known as _retrieval augmented generation_, or [RAG](https://en.wikipedia.org/wiki/Retrieval-augmented_generation)), and save the model's request context. When making requests to the assistant, you can get intermediate generation results as the model is generating a response.

## Getting started {#before-begin}

To use the examples:

{% list tabs group=programming_language %}

- SDK {#sdk}

  {% include [sdk-before-begin-assistants](../../../_includes/foundation-models/sdk-before-begin-assistants.md) %}

{% endlist %}

## Create an assistant {#create-assistant}

This example shows how to create an [assistant](../../concepts/assistant/index.md) to store your conversations with {{ gpt-pro }} RC. When you access the model, your assistant will output intermediate generation results as the model is generating a response.

{% list tabs group=programming_language %}

- SDK {#sdk}

  1. Create a file named `simple-assistant.py` and paste the following code into it:

      {% include [assistant-in-chunks](../../../_includes/foundation-models/examples/assistant-in-chunks.md) %}

      Where:

      {% include [sdk-code-legend](../../../_includes/foundation-models/examples/sdk-code-legend.md) %}

  1. Run the file you created:

      ```bash
      python3 simple-assistant.py
      ```

      The example implements the simplest chat possible: enter your requests to the assistant from your keyboard and get answers. To end the dialog, enter `exit`.

      {% cut "Approximate result" %}

      ```text
      Ask the assistant a question (or "exit" to exit): Hi!
      ('Hello',)
      ('Hello! What can I do for you?',)
      ('Hello! What can I do for you?',)
      run event=RunStreamEvent(status=<StreamEvent.DONE: 3>, error=None, _message=Message
      (id='fvtbkt2tbf7a********', parts=('Hello! What can I do for you?',), thread_id='fvt50ma5302n********', 
      created_by='ajegtlf2q28a********', created_at=datetime.datetime(2025, 3, 13, 17, 51, 22, 146833), 
      labels=None, author=Author(id='fvtle31p6lv2********', role='ASSISTANT'), citations=()))
      Ask your question to the assistant (or "exit" to exit): How many planets are there in the Solar System?
      ('In',)
      ('In the Solar System, there are **eight planets**: Mercury, Venus, Earth, Mars, Jupiter, Saturn',)
      ('In the Solar System, there are **eight planets**: Mercury, Venus, Earth, Mars, Jupiter, Saturn, Uranus, and Neptune.',)
      ('In the Solar System, there are **eight planets**: Mercury, Venus, Earth, Mars, Jupiter, Saturn, Uranus, and Neptune.',)
      run event=RunStreamEvent(status=<StreamEvent.DONE: 3>, error=None, _message=Message
      (id='fvt4f3p6ddue********', parts=('In the Solar System, there are **eight planets**: Mercury, Venus, Earth, 
      Mars, Jupiter, Saturn, Uranus, and Neptune.',), thread_id='fvt50ma5302n********', 
      created_by='ajegtlf2q28a********', created_at=datetime.datetime(2025, 3, 13, 17, 51, 33, 36643), 
      labels=None, author=Author(id='fvtle31p6lv2********', role='ASSISTANT'), citations=()))
      Ask your question to the assistant (or "exit" to exit): How far is it from the Sun to the Earth?
      ('The average',)
      ('The average distance from the Earth to the Sun is approximately 149.6 million kilometers. This 
      distance',)
      ('The average distance from the Earth to the Sun is approximately 149.6 million kilometers. This 
      distance is also known as the astronomical unit (AU).',)
      ('The average distance from the Earth to the Sun is approximately 149.6 million kilometers. This 
      distance is also known as the astronomical unit (AU).',)
      run event=RunStreamEvent(status=<StreamEvent.DONE: 3>, error=None, _message=Message
      (id='fvtees4295mr********', parts=('The average distance from the Earth to the Sun is approximately 149.
      6 million kilometers. This distance is also known as the astronomical unit (AU).',), 
      thread_id='fvt50ma5302n********', created_by='ajegtlf2q28a********', created_at=datetime.datetime(2025, 
      3, 13, 17, 51, 44, 33797), labels=None, author=Author(id='fvtle31p6lv2********', role='ASSISTANT'), 
      citations=()))
      Ask your question to the assistant (or "exit" to exit): Exit
      Outputting the whole message history when exiting the chat:
          message=Message(id='fvtees4295mr********', parts=('The average distance from the Earth to the Sun is 
          approximately 149.6 million kilometers. This distance is also known as the astronomical unit 
          (AU).',), thread_id='fvt50ma5302n********', created_by='ajegtlf2q28a********', created_at=datetime.
          datetime(2025, 3, 13, 17, 51, 44, 33798), labels=None, author=Author(id='fvtle31p6lv2********', 
          role='ASSISTANT'), citations=())
          message.text='The average distance from the Earth to the Sun is approximately 149.6 million 
          kilometers. This distance is also known as the astronomical unit (AU).'

          message=Message(id='fvto6b4rdg0o********', parts=('How far is it from the Sun to the Earth?',), 
          thread_id='fvt50ma5302n********', created_by='ajegtlf2q28a********', created_at=datetime.datetime
          (2025, 3, 13, 17, 51, 42, 941742), labels=None, author=Author(id='fvtjnthkl0g5********', 
          role='USER'), citations=())
          message.text='How far is it from the Sun to the Earth?'

          message=Message(id='fvt4f3p6ddue********', parts=('In the Solar System, there are **eight planets**: Mercury, 
          Venus, Earth, Mars, Jupiter, Saturn, Uranus, and Neptune.',), thread_id='fvt50ma5302n********', 
          created_by='ajegtlf2q28a********', created_at=datetime.datetime(2025, 3, 13, 17, 51, 33, 36644), 
          labels=None, author=Author(id='fvtle31p6lv2********', role='ASSISTANT'), citations=())
          message.text='In the Solar System, there are **eight planets**: Mercury, Venus, Earth, Mars, Jupiter, Saturn, 
          Uranus, and Neptune.'

          message=Message(id='fvtme86dsuju********', parts=('How many planets are there in the Solar System?' 
          thread_id='fvt50ma5302n********', created_by='ajegtlf2q28a********', created_at=datetime.datetime
          (2025, 3, 13, 17, 51, 32, 139), labels=None, author=Author(id='fvtjnthkl0g5********', role='USER'), 
          citations=())
          message.text='How many planets are there in the Solar System?'

          message=Message(id='fvtbkt2tbf7a********', parts=('Hello! What can I do for you?',), 
          thread_id='fvt50ma5302n********', created_by='ajegtlf2q28a********', created_at=datetime.datetime
          (2025, 3, 13, 17, 51, 22, 146834), labels=None, author=Author(id='fvtle31p6lv2********', 
          role='ASSISTANT'), citations=())
          message.text='Hello! What can I do for you?'

          message=Message(id='fvtemh1qqc50********', parts=('Hi!',), thread_id='fvt50ma5302n********', 
          created_by='ajegtlf2q28a********', created_at=datetime.datetime(2025, 3, 13, 17, 51, 21, 359885), 
          labels=None, author=Author(id='fvtjnthkl0g5********', role='USER'), citations=())
          message.text='Hi!'
      ```

      {% endcut %}

{% endlist %}

#### See also {#see-also}

* [{#T}](./create.md)
* [{#T}](./create-with-searchindex.md)
* [{#T}](./create-with-websearch.md)
* [{#T}](../../concepts/assistant/tools/index.md)
* Examples of working with ML SDK on [GitHub](https://github.com/yandex-cloud/yandex-cloud-ml-sdk/tree/master/examples/sync/assistants)