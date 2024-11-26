---
title: About {{ foundation-models-full-name }}
description: '{{ foundation-models-full-name }} is a service that provides access to the APIs of large neural networks that can generate high-quality texts and images. {{ yagpt-full-name }} can generate product descriptions, articles, news stories, newsletters, blog posts, and many other things. {{ yandexart-name }} can create an image based on a description. The quality of the neural network''s response depends directly on the accuracy of the instructions you provide. With a more specific prompt, you are more likely to get the result you expect.'
---

# About {{ foundation-models-full-name }}

{{ foundation-models-full-name }} comprises several large generative neural networks plus an efficient toolset you can use to leverage their capabilities to advance your business. {{ foundation-models-name }} is a part of {{ ai-studio-full-name }}.

[{{ yagpt-full-name }}](yandexgpt/index.md) offers text content generation models. You can use it to generate product descriptions, articles, news stories, newsletters, blog posts, and many other things. The quality of the neural network's response depends directly on the accuracy of the instructions you provide. With a more specific prompt, you are more likely to get the result you expect. For the full list of generative text models, see [{#T}](yandexgpt/models.md).

{{ foundation-models-name }} also provides the [API](../embeddings/api-ref/index.md) to work with _embeddings_, i.e., vector representations of text. It can be used to classify information, compare and match texts, or search through a knowledge base of your own. For more information on embeddings and the Embeddings API, see [{#T}](./embeddings.md).

With {{ yagpt-name }} classifiers, you can classify various texts. Special models are better at it than the {{ gpt-lite }}and {{ gpt-pro }} models, their API being tailored for classification tasks. For more information about the supported classification types, see [{#T}](classifier/index.md). 

To create images in {{ foundation-models-name }} use the {{ yandexart-name }} neural network that will help you create detailed and realistic images based on a text prompt. 

For information on the {{ foundation-models-name }} restrictions, refer to [{#T}](limits.md).

## {{ foundation-models-name }} working modes {#working-mode}

In {{ foundation-models-name }}, you can use models in either _synchronous_ or _asynchronous_ mode. The modes differ in response time and operation logic.

In synchronous mode, the model gets your request and returns the result immediately after processing. The response delay in synchronous mode is minimal but not instant: the model takes time to do the work. With the `stream` option enabled, the model sends intermediate generation results during the process. You may opt for synchronous mode if you need to maintain a chatbot dialog.

In asynchronous mode, the model responds to a request by sending an [Operation object](../../api-design-guide/concepts/operation.md) containing the ID of the operation it is performing. You can use the ID to learn the status of the request and later get the result of it by submitting a request to a special output endpoint. Intermediate generation results are not available in asynchronous mode. In asynchronous mode, generation usually takes longer (from a couple of minutes to several hours) than in synchronous mode but is cheaper. Use asynchronous mode if you do not need an urgent response.

Different models support different operating modes.

## Prompt {#prompt}

Generative models are managed using _prompts_. A good prompt should contain the context of your request to the model (instruction) and the actual task the model should complete based on the provided context. The more specific your prompt, the more accurate will be the results returned by the model.

Apart from the prompt, other request parameters will impact the model's output too. Use {{ foundation-models-name }} Playground available from the [management console]({{ link-console-main }}) to test your requests.
