* `modelUri`: [ID of the model](../../../foundation-models/concepts/generation/models.md) that will be used to generate the response. The parameter contains the {{ yandex-cloud }} [folder ID](../../../resource-manager/operations/folder/get-id.md) or the [tuned model's](../../../foundation-models/concepts/tuning/index.md) ID.
* `completionOptions`: Request configuration options:

    * `stream`: Enables streaming of partially generated text. It can either be `true` or `false`.
    * `temperature`: With a higher temperature, you get more creative and randomized responses from the model. Its values range from `0` to `1`, inclusive. The default value is `0.3`.
    * `maxTokens`: Sets a limit on the model's output in [tokens](../../../foundation-models/concepts/generation/tokens.md). The maximum number of tokens per generation depends on the model. For more information, see [{#T}](../../../foundation-models/concepts/limits.md).
    * `reasoningOptions.mode`: [Reasoning mode](../../../foundation-models/concepts/generation/chain-of-thought.md) parameters. This is an optional parameter. The default value is `DISABLED`. The possible values are:

        * `DISABLED`: Reasoning mode is disabled.
        * `ENABLED_HIDDEN`: Reasoning mode is enabled. The model will decide by itself whether or not to use this mode for each particular request.

{% include [the-messages-parameter](./the-messages-parameter.md) %}