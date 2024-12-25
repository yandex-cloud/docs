# {{ yandexart-name }} overview

{{ yandexart-name }} is a generative neural network that creates images based on a text request. {{ yandexart-name }} uses the cascaded diffusion method to iteratively refine images from noise.

To generate an image, apart from a text description, you need to provide a special parameter called _seed_. A seed is any number from 0 to 2^63^-1. It serves as a starting point for image generation from noise and allows to achieve repeatability. Thus, with the same prompt and seed, the generation result will be the same. To change the generated image, change the seed value or the description.

You can also specify the format of the final image in the `mime_type` parameter. Currently, the supported value is `image/jpeg`.

To use the {{ yandexart-name }} image generation models, you need the `ai.imageGeneration.user` [role](../../security/index.md#imageGeneration-user) or higher for the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder).


## Recommendations on creating prompts for {{ yandexart-name }} {#tips}

{% include [yandexart-prompts-tips](../../../_includes/foundation-models/yandexart/yandexart-prompts-tips.md) %}