# {{ yandexart-name }} overview

{{ yandexart-name }} is a generative neural network that creates images based on a text request. {{ yandexart-name }} uses the cascaded diffusion method to iteratively elaborate the images from noise.

In addition to a text description, you need to specify a special parameter called _seed_ to generate an image. A seed is any number from 0 to 2^63^-1. It serves as a starting point for image generation from noise and allows to achieve repeatability. Thus, with the same prompt and seed, the generation result will be the same. To change the generated image, change the seed value or the description.

You can also specify the format of the final image in the `mime_type` parameter. Currently the supported value is `image/jpeg`.


## Recommendations on creating prompts for {{ yandexart-name }} {#tips}

{% include [yandexart-prompts-tips](../../../_includes/foundation-models/yandexart/yandexart-prompts-tips.md) %}