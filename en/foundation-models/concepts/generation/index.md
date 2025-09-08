# Models overview

{{ foundation-models-full-name }} provides access to large text models which can quickly generate text content, e.g., product descriptions, articles, news stories, newsletters, blog posts, and more. The quality of the neural network's response depends directly on the accuracy of the instructions you provide. With a more specific prompt, you are more likely to get the result you expect. You can increase the accuracy of answers to some requests by activating the [reasoning mode](./chain-of-thought.md).

To interact with text generation models in {{ yandex-cloud }}, there are two interfaces available. You can submit requests to [{{ ai-playground }}]({{ link-console-main }}/link/foundation-models/) or integrate the model into your applications using the API. You can use the [REST](../../text-generation/api-ref/index.md) and [gRPC](../../text-generation/api-ref/grpc/index.md) interfaces for integration. You can also use the API to work with models in [asynchronous mode](../index.md#working-mode). You can view the examples of working with {{ yagpt-name }} via the API in [Step-by-step guides for {{ foundation-models-full-name }}](../../operations/index.md#yandexgpt-api).

{{ ai-playground }} is a good option for introduction and testing: use it to submit synchronous requests to different models, set up parameters, and choose prompts. When communicating, the model saves the dialog context, but you can also create a new experiment if you need to change the context.

{{ yagpt-name }} models understand prompts in more than 20 languages, including English and Japanese; however, Russian texts are its first priority. In addition to a text description, prompts must contain a special parameter called _temperature_ that determines the variability of the model's response: the higher the temperature value, the less predictable the model's output is going to be.

All the roles required to work with models are listed in the [{#T}](../../security/index.md).

# {{ yandexart-name }} overview

{{ yandexart-name }} is a generative neural network that creates images based on a text request. {{ yandexart-name }} uses the cascaded diffusion method to iteratively refine images from noise.

To generate an image, apart from a text description, you need to provide a special parameter called _seed_. A seed is any number from 0 to 2^63^-1. It serves as a starting point for image generation from noise and allows to achieve repeatability. Thus, with the same prompt and seed, the generation result will be the same. To change the generated image, change the seed value or the description.

You can also specify the format of the final image in the `mime_type` parameter. Currently, the supported value is `image/jpeg`.

By default, {{ yandexart-name }} generates an image of 1024 × 1024 pixels. This size may increase or decrease based on the specified aspect ratio, but by no more than 10%.


#### See also {#see-also}

* 
* [{#T}](./chain-of-thought.md)
* [{#T}](../../operations/generation/create-prompt.md)
* [{#T}](../../operations/generation/create-chat.md)
* [{#T}](../../operations/generation/async-request.md)