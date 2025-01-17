1. Создайте файл `generate-text.py` и добавьте в него следующий код:

    {% include [yandexgpt-sdk](../examples/yandexgpt-sdk.md) %}

    Где:

    {% note info %}

    {% include [sdk-input-format](../../../_includes/foundation-models/sdk-input-format.md) %}

    {% endnote %}

    {% include [the-messages-parameter](../../../_includes/foundation-models/yandexgpt/the-messages-parameter.md) %}

    {% include [sdk-code-legend](../examples/sdk-code-legend.md) %}

    {% include [yandexgpt-model-version-sdk-info](./yandexgpt-model-version-sdk-info.md) %}

1. Выполните созданный файл:

    ```bash
    python3 generate-text.py
    ```

    Результат выполнения:

    ```text
    Alternative(role='assistant', text='Ламинат подойдёт для укладки на кухне или в детской комнате. Он не боится влаги и механических повреждений благодаря защитному слою из облицованных меламиновых плёнок толщиной 0,2 мм и обработанным воском замкам.', status=<AlternativeStatus.FINAL: 3>)
    ```