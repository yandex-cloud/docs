---
title: "About {{ yagpt-full-name }}"
description: "{{ yagpt-full-name }} is the API of a neural network that can solve different tasks related to creating text content. {{ yagpt-name }} can generate product descriptions, articles, news stories, newsletters, blog posts, and many other types of texts. The quality of the neural network's response directly depends on the accuracy of provided instructions. With a more specific request, you are more likely to get the expected result."
---

# About {{ yagpt-full-name }}

{% include notitle [preview-stage](../../_includes/yandexgpt/preview.md) %}

{{ foundation-models-full-name }} combines several large generative neural networks and helps you leverage their capabilities for your business tasks.

The {{ yagpt-name }} neural network is geared to solve various tasks related to creation of text content. {{ yagpt-full-name }} can generate product descriptions, articles, news stories, newsletters, blog posts, and many other types of texts. The quality of the neural network's response directly depends on the accuracy of provided instructions. With a more specific request, you are more likely to get the expected result.

The service is dynamically evolving with constant enhancements and refinements to its functionality. Currently, you can use {{ yagpt-full-name }} to create such text content as product descriptions, articles, news stories, newsletters, blog posts, and many other texts. Going forward, we will enhance the service with other features, including data analysis and process automation.

## {{ yagpt-full-name }} operating modes {#working-mode}

In {{ yagpt-full-name }}, you can send requests in synchronous and asynchronous modes. In synchronous mode, the service will handle your request and respond to it immediately after its receipt. This mode is suitable if you need to maintain a chat bot dialog. In asynchronous mode, the service will receive a request and immediately return its ID that you can get a response by. It will take longer to generate text but responses will be cheaper and of higher quality. Use asynchronous mode if your tasks do not require an urgent response.

Neither mode can currently process unlimited amounts of data. As of now, the maximum total number of [tokens](tokens.md) allowed per user request and model response is {{ yagpt-max-tokens }}. For more information about {{ yagpt-name }} limits, see [{#T}](limits.md).

In the [management console]({{ link-console-main }}), you can access {{ yagpt-name }} Playground. It allows you to try the {{ yagpt-name }} Lite model by sending two types of synchronous requests to it:

* **Prompt mode**, where you send a prepared _prompt_ (i.e., an instruction and a request) to the model and receive a response. The model treats each new question as a stand-alone task without saving the context of previous requests.

* **Chat** mode, where you chat with the model, specifying tasks and supplementing your previous remarks. The communication context is transmitted in every message and maintained during the current session until you explicitly start a new one.

You can send both prompt-mode messages and chat-mode messages via the updated API.
