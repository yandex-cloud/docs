# Overview of {{ foundation-models-full-name }} AI models

{{ foundation-models-full-name }} provides powerful capabilities for the use of generative models in business scenarios:

* Native and open-source [common instance](./models.md#generation) models [billed](../../pricing.md#rules-generating) based on consumed [tokens](./tokens.md).  
* {{ lora }}-based model [fine-tuning](../tuning/index.md).
* Out-of-the-box and tunable text [classification](../classifier/index.md) models.
* Large selection of [text](./models.md#text-batch) and [multimodal](./models.md#multimodels-batch) open-source models to batch-process large volumes of data with a [prepaid minimum amount of tokens](../../pricing.md#rules-generating).
* Dedicated model instances, if you are looking to process large volumes of data with guaranteed response time.

There are two interfaces you can use to work with models: {{ ai-playground }} in the management console and various APIs where you can [create agents](../agents/index.md) and access models directly.

## Native Yandex models {#yandex}

{{ model-gallery-name }} brings to you Yandex's text and image generation models you can use for your business. 

The smallest and fastest one among the text models, {{ gpt-lite }} excels at tasks that prioritize response speed over complex reasoning or in-depth knowledge of sophisticated subject areas. For example, you can use {{ gpt-lite }} to categorize incoming user messages, format texts, or summarize your meetings. 

{{ gpt-pro }} will perform well in more complex tasks: searching knowledge bases and generating results based on the output (RAG scenario), document analysis, reporting and analytics, data extraction and auto-population of fields, forms, and CRM databases. 

{{ alice-ai }}, Yandex's new flagship model, is not only head-to-head with {{ gpt-pro }} in complex tasks, but also a much better dialog partner in chat scenarios, capable of extracting information from the whole context. {{ alice-ai }} will be ideal for creating _human-oriented_ AI assistants.

Yandex text models can understand around 20 languages, including English and Japanese, their primary focus is to be an effective processing engine for texts in Russian. With Yandex's proprietary [tokenizer](./tokens.md), its models are more efficient with tokens than other models out there, thus saving you money. For an [example calculation](../../pricing.md#example-generating) of the cost of doing the same task using different models, see the [pricing page](../../pricing.md#text-sync-async).

Apart from text models, {{ model-gallery-name }} also features the {{ yandexart-name }} model, a generative neural network that creates images based on a text query. {{ yandexart-name }} uses the cascaded diffusion method to iteratively refine images from noise. You can specify the format of the final image in the `mime_type` parameter. Currently, the supported value is `image/jpeg`. By default, {{ yandexart-name }} generates an image of 1024 x 1024 pixels. This size may increase or decrease based on the specified aspect ratio, but by no more than 10%.

Yandex text models are available through the {{ openai }}-compatible Completions API and {{ responses-api }}, as well as a proprietary [REST](../../text-generation/api-ref/index.md) and [gRPC](../../text-generation/api-ref/grpc/index.md) text generation API.
{{ yandexart-name }} provides a proprietary image generation API, also available as [REST](../../image-generation/api-ref/index.md) and [gRPC](../../image-generation/api-ref/grpc/index.md).
 
Moreover, all the models can be reached through {{ ml-sdk-name }} and [{{ ai-playground }}]({{ link-console-main }}/link/ai-studio/). 

## {{ ai-studio-name }} operating modes {#working-mode}

In {{ ai-studio-name }}, you can use models in three modes: _synchronous_, _asynchronous_, or _batch_ mode. The modes have different response times and operating logic.

In synchronous mode, the model gets your request and returns the result immediately after processing. The response delay in synchronous mode is minimal but not instant: the model still needs some time, which depends on the model and system workload. With the `stream` option enabled, the model sends intermediate generation results during the process. You may opt for synchronous mode if you need to maintain a chatbot dialog. In synchronous mode, models are available in {{ ai-playground }}, {{ ml-sdk-name }}, via text generation APIs, and {{ openai }}-compatible APIs.

In asynchronous mode, the model responds to a request by sending an [Operation object](../../../api-design-guide/concepts/operation.md) containing the ID of the operation it is performing. You can use the ID to learn the status of the request and later get the result of it by submitting a request to a special output endpoint (its value depends on the model). Intermediate generation results are not available in asynchronous mode. In asynchronous mode, generation usually takes longer (from a couple of minutes to several hours) than in synchronous mode but is cheaper. Use asynchronous mode if you do not need an urgent response. In asynchronous mode, some models are available in {{ ml-sdk-name }}, via text generation APIs, and image generation APIs.

Batch processing mode allows you to process a large data array in a single request to the model. Input data is provided as a [dataset](../resources/dataset.md) whose type depends on the model. For each request, {{ foundation-models-name }} runs an individual instance of the model to process the dataset and then stops it. The result is saved as another dataset, which you can download in [Parquet](https://parquet.apache.org/) format or use immediately, e.g., to tune another model. It may take several hours to generate the result. You can process data in batch mode in the management console, using {{ ml-sdk-name }} , or via the Batch API. For the list of models available in batch mode, see [{#T}](./batch-processing.md).

#### See also {#see-also}

* [{#T}](./chain-of-thought.md)
* [{#T}](../../operations/generation/create-prompt.md)
* [{#T}](../../operations/generation/async-request.md)