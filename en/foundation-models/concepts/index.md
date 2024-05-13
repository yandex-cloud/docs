---
title: "About {{ foundation-models-full-name }}"
description: "{{ foundation-models-full-name }} is a service that provides access to the APIs of large neural networks that can generate high-quality texts and images. {{ yagpt-full-name }} can generate product descriptions, articles, news stories, newsletters, blog posts, and many other types of texts. {{ yandexart-name }} can create an image by description. The quality of the neural network's response depends directly on the accuracy of the instructions you provide. With a more specific request, you are more likely to get the result you expect."
---

# About {{ foundation-models-full-name }}

{% include notitle [preview-stage](../../_includes/foundation-models/yandexgpt/preview.md) %}

{{ foundation-models-full-name }} comprises several large generative neural networks and allows you to leverage their capabilities for your business development.

The {{ yagpt-name }} neural network is geared to address various needs related to creating text content. {{ yagpt-full-name }} can generate product descriptions, articles, news stories, newsletters, blog posts, and many other things. The quality of the neural network's response depends directly on the accuracy of the instructions you provide. With a more specific prompt, you are more likely to get the result you expect.

{{ foundation-models-name }} provides the [API](../embeddings/api-ref/index.md) to work with _embeddings_, i.e., vector representations of text. It can be used to classify information, compare and match texts, or search through a knowledge base of your own. For more information on embeddings and the Embeddings API, see [{#T}](./embeddings.md).

The {{ yandexart-name }} neural network will help you create detailed and realistic images based on a text prompt. You can see prompt examples in the {{ yandexart-name }} prompt library.

The service is dynamically evolving with constant enhancements and refinements to its functionality.

For information on the {{ foundation-models-name }} restrictions, refer to [{#T}](limits.md).

## {{ foundation-models-name }} working modes {#working-mode}

In {{ foundation-models-name }}, you can use models in either _synchronous_ or _asynchronous_ mode. In synchronous mode, the model will process your request and respond to it directly upon receipt. You may opt for this mode if you need to maintain a chatbot dialog. In asynchronous mode, the model will receive your request and return its ID, which you can later use to get your response. In asynchronous mode, the result usually takes longer to generate, but the responses are cheaper and better quality. Use asynchronous mode if you do not need an urgent response.

Different models support different operating modes.

Generative models are managed using _prompts_. A good prompt should contain the context of your request to the model (instruction) and the actual task the model should complete based on the provided context. The more specific your prompt, the more accurate will be the results returned by the model.

Apart from the prompt, other request parameters will impact the model's output too. Use {{ foundation-models-name }} Playground in the [management console]({{ link-console-main }}) to test your requests.
