---
title: "About {{ yagpt-full-name }}"
description: "{{ yagpt-full-name }} is the API of a neural network geared to address various needs related to creating text content. {{ yagpt-name }} can generate product descriptions, articles, news stories, newsletters, blog posts, and many other types of texts. The quality of the neural network's response depends directly on the accuracy of the instructions you provide. With a more specific request, you are more likely to get the result you expect."
---

# About {{ foundation-models-full-name }}

{{ foundation-models-full-name }} combines various large generative neural networks and helps you leverage them for your business tasks.

The {{ yagpt-name }} neural network is geared to address various needs related to creating text content. {{ yagpt-full-name }} can generate product descriptions, articles, news stories, newsletters, blog posts, and many other types of texts. The quality of the neural network's response depends directly on the accuracy of the instructions you provide. With a more specific request, you are more likely to get the result you expect.

The service is dynamically evolving with constant enhancements and refinements to its functionality.

For information on {{ foundation-models-name }} restrictions, refer to [{#T}](limits.md).

## {{ foundation-models-name }} working modes {#working-mode}

In {{ foundation-models-name }}, you can use models in _synchronous_ or _asynchronous_ mode. In synchronous mode, the model will process your request and respond to it immediately upon receipt. You may opt for this mode if you need to maintain a chatbot dialog. In asynchronous mode, the model will receive a request and immediately return its ID, which you can use later to get a response. As a rule, it may take longer to generate the result in asynchronous mode, but the responses will be more cost-effective and of higher quality. Use asynchronous mode if you do not need an urgent response.

Different models support different working modes.

To manage generative models, one uses _prompts_. A good prompt should have the request context, or instruction, for the model, and the task itself that the model should solve based on the provided context. With a more specific prompt, the model delivers more accurate result.

Apart from the prompt, there are other request parameters that determine the generation result. Access {{ foundation-models-name }} Playground in the [management console]({{ link-console-main }}) to test your requests.

## {{ yagpt-full-name }} {#yandexgpt}

In {{ foundation-models-name }} Playground, you can send synchronous requests to {{ yagpt-full-name }} models. You can work with the models in one of these two modes:

* **Prompt mode** allows you to send a ready-to-use prompt to the model and get the result. The model treats each new question as a stand-alone task without saving the context of previous requests. In this mode, you can use the summing-up models, {{ gpt-lite}} and {{ gpt-pro }}, in the management console.

* With **chat** mode, you can chat with the model, making your tasks more specific and adding more information to your messages. The communication context is transmitted in every message and maintained during the current session until you explicitly start a new one. To work in chat mode, use the {{ gpt-pro }} model.

You can also use API for both [prompt](../operations/yandexgpt/create-prompt.md) and [chat](../operations/yandexgpt/create-chat.md) messages.

To learn more about the {{ yagpt-full-name }} models, see [{#T}](yandexgpt/models.md).

## Text vectorization {#embeddings}

{{ foundation-models-name }} provides [API](../embeddings/api-ref/index.md) to work with _embeddings_ that enable text visualization with vectors. This can help you classify information, compare texts, or enable knowledge base search.

For more information on embeddings and the Embeddings API, see [{#T}](./embeddings.md).