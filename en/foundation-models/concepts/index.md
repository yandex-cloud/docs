---
title: "About {{ yagpt-full-name }}"
description: "{{ yagpt-full-name }} is the API of a neural network geared to address various needs related to creating text content. {{ yagpt-name }} can generate product descriptions, articles, news stories, newsletters, blog posts, and many other types of texts. The quality of the neural network's response depends directly on the accuracy of the instructions you provide. The more specific your request, the more likely you are to get the result you anticipate."
---

# About {{ foundation-models-full-name }}

{{ foundation-models-full-name }} comprises several large generative neural networks and allows you to leverage their capabilities for your business development.

The {{ yagpt-name }} neural network is geared to address various needs related to creating text content. {{ yagpt-full-name }} can generate product descriptions, articles, news stories, newsletters, blog posts, and many other types of texts. The quality of the neural network's response is directly dependent on the accuracy of the instructions you provide: the more accurate the input, the more likely you are to get the result you expect.

The service is dynamically evolving with constant enhancements and refinements to its functionality.

For information on {{ foundation-models-name }} restrictions, refer to [{#T}](limits.md).

## {{ foundation-models-name }} working modes {#working-mode}

In {{ foundation-models-name }}, you can use models in either _synchronous_ or _asynchronous_ mode. In synchronous mode, the model will process your request and respond to it directly upon receipt. You may opt for this mode if you need to maintain a chatbot dialog. In asynchronous mode, the model will receive your request and return its ID, which you can later use to get your response. In asynchronous mode, the result usually takes longer to generate, but the responses are cheaper and better quality. Use asynchronous mode if you do not need an urgent response.

Different models support different operating modes.

Generative models are managed using _prompts_. A good prompt should contain the context of your request to the model (instruction) and the actual task the model should complete based on the provided context. The more specific your prompt, the more accurate will be the results returned by the model.

Apart from the prompt, other request parameters will impact the model's output too. Use {{ foundation-models-name }} Playground in the [management console]({{ link-console-main }}) to test your requests.

## {{ yagpt-full-name }} {#yandexgpt}

In {{ foundation-models-name }} Playground, you can send synchronous requests to {{ yagpt-full-name }} models. You can communicate with a model in these two formats:

* In **Prompt mode**, you submit a ready-made prompt to the model and get the result. The model treats each new question as a stand-alone task without saving the context of the previous request. In this format, you can choose between the the summary models, {{ gpt-lite}} and {{ gpt-pro }}, in the management console.

* In **Chat** mode, you can chat with the model to update your instructions and elaborate on your previous inputs. The communication context is transmitted in every message and maintained throughout the current session until you explicitly start a new one. To work in chat mode, use the {{ gpt-pro }} model.

Both [prompt](../operations/yandexgpt/create-prompt.md) and [chat](../operations/yandexgpt/create-chat.md) messages are available if working via the API.

To learn more about the {{ yagpt-full-name }} models, see [{#T}](yandexgpt/models.md).

## Text vectorization {#embeddings}

{{ foundation-models-name }} provides the [API](../embeddings/api-ref/index.md) to work with _embeddings_, i.e., vector representations of text. It can be used to classify information, compare and match texts, or search through a knowledge base of your own.

For more information on embeddings and the Embeddings API, see [{#T}](./embeddings.md).