# Перевести текст

Чтобы перевести текст, воспользуйтесь методом [translate](../api-ref/v2/Translation/translate).

## Примеры

### Перед началом

Чтобы воспользоваться примерами в этом разделе:

1. Получите идентификатор каталога, к которому у вас есть доступ, например из URL страницы каталога в консоли управления:
    ```
    https://console.cloud.yandex.ru/folders/b5gfc3ntettogerelqed7p
    ```
    `b5gfc3ntettogerelqed7p` — это идентификатор каталога.
1. Получите IAM-токен:
    * [Инструкция](../../iam/operations/iam-token/create.md) для аккаунта на Яндексе.
    * [Инструкция](../../iam/operations/iam-token/create-for-sa.md) для сервисного аккаунта.
1. Убедитесь, что у вас установлена утилита [cURL](https://curl.haxx.se), используемая в примерах.

### Hello, world

В этом примере мы переведем на русский язык две строки с текстом: <q>Hello</q> и <q>World</q>.

1. Узнайте код языка, на который вы хотите перевести текст, с помощью метода [listLanguages](../api-ref/v2/Translation/listLanguages):

    ```bash
    curl -X POST \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer ${IAM_TOKEN}" \
        -d "{\"folder_id\": \"${FOLDER_ID}\"}" \
        "https://translate.api.cloud.yandex.net/translate/v2/languages"
    ```

    Ответ будет содержать список языков с названиями на соответствующем языке:

    ```json
    {
        "languages": [
            ...
            {
            "code": "ru",
            "name": "русский"
            },
            ...
        ]
    }
    ```
2. Создайте файл с телом запроса, например `body.json`.
    Строки текста для перевода перечислите в поле `texts`. В поле `targetLanguageCode` укажите язык, на который необходимо перевести текст.

    ```json
    {
        "folder_id": "b1gvmob03goohplct641",
        "texts": ["Hello", "World"],
        "targetLanguageCode": "ru"
    }
    ```
3. Передайте файл на перевод с помощью метода [translate](../api-ref/v2/Translation/translate):
    ```bash
    $ export IAM_TOKEN=CggaATEVAgA...
    $ curl -X POST \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer ${IAM_TOKEN}" \
        -d @body.json \
        "https://translate.api.cloud.yandex.net/translate/v2/translate"
    ```

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