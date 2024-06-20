Where:

* `modelUri`: {{ yandexart-name }} [model](../../../foundation-models/concepts/yandexart/models.md) ID which contains a {{ yandex-cloud }} [folder ID](../../../resource-manager/operations/folder/get-id.md).
* `seed`: [Generation seed](../../../foundation-models/concepts/yandexart/index.md).
* `text`: Text description of the image to use for generation.
* `weight`: Text description weight. If a request contains more than one description, their individual impact will be calculated based on weight, with the sum of all weights equal to 1.
* `aspectRatio`: (Optional) Aspect ratio of the generated image:
   * `widthRatio`: Width (default value: 1).
   * `heightRatio`: Height (default value: 1).
