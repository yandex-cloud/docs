# {{ yagpt-full-name }} overview

{{ yagpt-full-name }} allows you to quickly create text content, e.g., product descriptions, articles, news stories, newsletters, blog posts, and various other things. The quality of the neural network's response depends directly on the accuracy of the instructions you provide. With a more specific request, you are more likely to get the result you expect.

The model understands prompts both in Russian and English; however, Russian texts are its first priority. In addition to a text description, prompts must contain a special parameter called _temperature_ that determines the variability of the model's response: the higher the temperature value, the less predictable the model's output is going to be.

There are two interfaces for {{ yagpt-full-name }} in {{ yandex-cloud }}. You can send requests to [{{ foundation-models-name }} Playground]({{ link-console-main }}/link/foundation-models/) or integrate the model into your applications using the API. You can use the [REST](../../text-generation/api-ref/index.md) and [gRPC](../../text-generation/api-ref/grpc/index.md) interfaces for integration.

{{ foundation-models-name }} Playground is a good option for introduction and testing: use it to send synchronous requests to {{ yagpt-full-name }} models. You can communicate with a model in these two formats:

* In **Prompt mode**, you submit a ready-made prompt to the model and get the result. The model treats each new question as a stand-alone task without saving the context of the previous request. In this format, you can choose between the summary models, {{ gpt-lite }} and {{ gpt-pro }}, in the management console.

* In **Chat** mode, you can chat with the model to update your instructions and elaborate on your previous inputs. The communication context is transmitted in every message and maintained throughout the current session until you explicitly start a new one. To work in chat mode, use the {{ gpt-pro }} model.

Both [prompt](../../operations/yandexgpt/create-prompt.md) and [chat](../../operations/yandexgpt/create-chat.md) messages are available if using the API. You can also use the API to work with models in the [asynchronous mode](../../operations/yandexgpt/async-request.md).

To learn more about the {{ yagpt-full-name }} models, see [{#T}](models.md).
