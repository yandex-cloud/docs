{% include [bash-windows-note-single](bash-windows-note-single.md) %}

This example shows how to translate two strings containing *Hello* and *World* into Russian. The text source language is recognized automatically.

1. Create a file with the request body, e.g., `body.json`:

    ```json
    {
        "folderId": "<folder_ID>",
        "texts": ["Hello", "World"],
        "targetLanguageCode": "ru"
    }
    ```

    Where:

    * `folderId`: Folder [ID](../../resource-manager/operations/folder/get-id.md) you got [before you started](#before-begin).
    * `texts`: Text to translate, as a list of strings.
    * `targetLanguageCode`: Target [language](../../translate/concepts/supported-languages.md). You can get the language code together with a [list of supported languages](../../translate/operations/list.md).

1. Submit the file for translation by running the command:

    {% include [translate-file](./translate-file.md) %}

    {% include [api-key-legend-desc](./api-key-legend-desc.md) %}

    The service will return the translated strings:

    {% include [any-language](../../_untranslatable/translate/any-language.md) %}
