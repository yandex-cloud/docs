* `modelUri` — [идентификатор модели](../../../foundation-models/concepts/generation/models.md), которая будет использоваться для генерации ответа. Параметр содержит [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md) {{ yandex-cloud }} или идентификатор [дообученной](../../../foundation-models/concepts/tuning/index.md) модели.
* `completionOptions` — параметры конфигурации запроса:

    * `stream` — включает потоковую передачу частично сгенерированного текста. Принимает значения `true` или `false`.
    * `temperature` — чем выше значение этого параметра, тем более креативными и случайными будут ответы модели. Принимает значения от `0` (включительно) до `1` (включительно). Значение по умолчанию: `0.3`.
    * `maxTokens` — устанавливает ограничение на выход модели в [токенах](../../../foundation-models/concepts/generation/tokens.md). Максимальное число токенов генерации зависит от модели. Подробнее см. в разделе [{#T}](../../../foundation-models/concepts/limits.md).
    * `reasoningOptions.mode` — параметры [режима рассуждений](../../../foundation-models/concepts/generation/chain-of-thought.md). Необязательный параметр. Значение по умолчанию — `DISABLED`. Возможные значения:

        * `DISABLED` — режим рассуждений выключен.
        * `ENABLED_HIDDEN` — режим рассуждений включен. При этом модель самостоятельно принимает решение о необходимости использования этого режима для каждого конкретного запроса.

{% include [the-messages-parameter](./the-messages-parameter.md) %}