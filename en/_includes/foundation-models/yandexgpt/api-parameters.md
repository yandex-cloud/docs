* `modelUri`: [ID of the model](../../../foundation-models/concepts/yandexgpt/models.md) that will be used to generate the response. The parameter contains the {{ yandex-cloud }} [folder ID](../../../resource-manager/operations/folder/get-id.md) or the ID of the [tuned model](../../../foundation-models/concepts/tuning/index.md).
* `completionOptions`: Request configuration options:

  * `stream`: Enables streaming of partially generated text. It can either be `true` or `false`.
  * `temperature`: With a higher temperature, you get more creative and randomized responses from the model. Its values range from `0` to `1`, inclusive. The default value is `0.3`.
  * `maxTokens`: Sets a limit on the model's output in [tokens](../../../foundation-models/concepts/yandexgpt/tokens.md). The maximum number of tokens per generation depends on the model. For more information, see [{#T}](../../../foundation-models/concepts/limits.md).

{% include [the-messages-parameter](./the-messages-parameter.md) %}
