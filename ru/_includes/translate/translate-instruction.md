## Перед началом {#before-begin}

{% include [ai-before-beginning](../../_includes/ai-before-beginning.md) %}

## Перевести текст с любого языка {#any-language}

В этом примере показано, как перевести на русский язык две строки с текстом: <q>Hello</q> и <q>World</q>. Язык текста будет определен автоматически.

1. Создайте файл с телом запроса, например `body.json`.
    В `folderId` укажите [идентификатор каталога](../../resource-manager/operations/folder/get-id.md). Строки текста для перевода перечислите в поле `texts`.

    В поле `targetLanguageCode` укажите язык перевода в формате [ISO 639-1](https://en.wikipedia.org/wiki/ISO_639-1). Для русского языка это `ru`. Код языка можно получить вместе со [списком поддерживаемых языков](../../translate/operations/list.md).

    ```json
    {
        "folderId": "b1gvmob95yysaplct532",
        "texts": ["Hello", "World"],
        "targetLanguageCode": "ru"
    }
    ```
1. Передайте файл на перевод с помощью метода [translate](../../translate/api-ref/Translation/translate):

    {% include [translate-file](../../_includes/translate/translate-file.md) %}

    В ответе сервис вернет переведенные строки текста:
    ```json
    {
        "translations": [
            {
            "text": "Привет",
            "detectedLanguageCode": "en"
            },
            {
            "text": "Мир",
            "detectedLanguageCode": "en"
            }
        ]
    }
    ```