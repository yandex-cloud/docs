---
title: Reasoning mode in generative {{ foundation-models-name }}
description: In this tutorial, you will learn how to use the reasoning mode to improve the accuracy of generative models in {{ foundation-models-full-name }}.
---

# Reasoning mode in generative models

Generative models do not always cope equally well with tasks that require reasoning, i.e., breaking the task into steps and performing a chain of successive computations, where the results of the previous computation provide the input data for the next one.

You can improve the accuracy of the model's responses by forcing the model to reason and generate based on such chains of intermediate computations. You can do this using a prompt or a special [generation parameter](../../text-generation/api-ref/TextGeneration/completion.md#yandex.cloud.ai.foundation_models.v1.ReasoningOptions).

You can configure the reasoning mode using the `reasoning_options` parameter by [accessing](./models.md#addressing-models) the models that support this parameter through the API. The `reasoning_options` parameter can take the following values:
* `DISABLED`: Reasoning mode is disabled. Default. If the `reasoning_options` parameter is not specified in the request, the reasoning mode is disabled.
* `ENABLED_HIDDEN`: Reasoning mode is enabled. Different models decide differently whether to use this mode for each particular request. Even if the model uses reasoning when generating a response, the response will not contain the model's actual chain of reasoning.



The reasoning mode may increase the amount of computations and the total number of resulting request [tokens](./tokens.md): if reasoning was used, the model's response will contain the `reasoningTokens` field with a non-zero value.

The reasoning mode is available in the {{ gpt-pro }} model.

