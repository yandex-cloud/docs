{% include [bash-windows-note-single](bash-windows-note-single.md) %}

В этом примере показано, как выполнить перевод на русский язык двух строк с текстом: <q>Hello</q> и <q>World</q>. Язык исходного текста будет определен автоматически.

1. Создайте файл с телом запроса (например, `body.json`):

    ```json
    {
        "folderId": "<идентификатор_каталога>",
        "texts": ["Hello", "World"],
        "targetLanguageCode": "ru"
    }
    ```

    Где:

    * `folderId` — идентификатор каталога, полученный [перед началом работы](#before-begin).
    * `texts` — текст для перевода в виде списка из строк.
    * `targetLanguageCode` — [язык](../../translate/concepts/supported-languages.md), на который переводится текст. Вы можете узнать код языка вместе со [списком поддерживаемых языков](../../translate/operations/list.md).

1. Передайте файл на перевод, выполнив команду:

    {% include [translate-file](translate-file.md) %}

    Где `IAM_TOKEN` — IAM-токен, полученный [перед началом работы](#before-begin).

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