---
title: Image generation models
description: In this tutorial, you will learn about the image generation models available in {{ foundation-models-name }}.
---

# {{ yandexart-name }} models

{{ foundation-models-full-name }} provides access to the {{ yandexart-name }} model that generates images based on a text prompt using the cascaded diffusion method to iteratively refine images from noise.

| **Target** | **URI** | **[Operating modes](../index.md#working-mode)** |
|---|---|---|
| Generating an image based on a text description | `art://<folder_ID>/yandex-art/latest` | Asynchronous |

## Accessing a model {#addressing-models}

You can access image generation models of in a number of ways.

{% list tabs group=programming_language %}

- SDK {#sdk}

  When operating an image generation model via [{{ ml-sdk-full-name }}](../../sdk/index.md), use one of the following formats:

  * **Model name**, provided as a string.

      ```python
      model = (
        sdk.models.image_generation("yandex-art")
      )
      ```

  * **Model name and version**, provided as strings in the `model_name` and `model_version` fields, respectively.

      ```python
      model = (
        sdk.models.image_generation(model_name="yandex-art", model_version="latest")
      )
      ```

  * **Model URI**, provided as a string containing the full URI of the model.

      ```python
      model = (
        sdk.models.image_generation("art://b1gt6g8ht345********/yandex-art/latest")
      )
      ```

- API {#curl}

  To [access](../../operations/yandexart/request.md) a model via the [REST API](../../image-generation/api-ref/index.md) or [gRPC API](../../image-generation/api-ref/grpc/index.md), specify the model's URI containing the [folder ID](../../../resource-manager/operations/folder/get-id.md) in the `modelUri` field of the request body. The `/latest` segment indicates the model version and is optional.

  **Example**:

  ```json
  {
    "modelUri": "art://b1gt6g8ht345********/yandex-art/latest"
    ...
  }
  ```

  To access the `Latest` version, you do not need to specify the model version explicitly because `Latest` is used by default.

{% endlist %}

#### See also {#see-also}

* [{#T}](../../operations/yandexart/request.md)