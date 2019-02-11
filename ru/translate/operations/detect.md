# Определить язык текста

Чтобы определить, на каком языке написан текст, воспользуйтесь методом [detectLanguage](../api-ref/v2/Translation/detectLanguage).

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

В этом примере мы определим, на каком языке написана фраза <q>Hello, world</q>.

1. Чтобы определить, на каком языке написан текст, передайте его в теле запроса [detectLanguage](../api-ref/v2/Translation/detectLanguage):
    ```bash
    $ export FOLDER_ID=b1gvmob95yysaplct532
    $ export IAM_TOKEN=CggaATEVAgA...
    $ export TEXT="Hello, world"
    $ curl -X POST \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer ${IAM_TOKEN}" \
        -d "{\"folder_id\": \"${FOLDER_ID}\", \"text\": \"${TEXT}\"}" \
        "https://translate.api.cloud.yandex.net/translate/v2/detect"
    ```

    В ответе сервис вернет код языка, на котором написан текст:

    ```json
    {
        "languageCode": "en"
    }
    ```
1. Узнайте, какому языку соответствует полученный код, с помощью метода [listLanguages](../api-ref/v2/Translation/listLanguages):

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
            {
            "code": "az",
            "name": "azərbaycan"
            },
            {
            "code": "sq",
            "name": "shqip"
            },
            {
            "code": "am",
            "name": "አማርኛ"
            },
            {
            "code": "en",
            "name": "English"
            },
            ...
        ]
    }
    ```

### Укажите наиболее вероятные языки

В некоторых языках одно и то же слово пишется одинаково, например слово <q>рука</q> пишется одинаково в английском, немецком, шведском и голландском языках — <q>hand</q>. Если переданный текст состоит из таких слов, то SpeechKit может ошибиться при определении языка текста.

Чтобы избежать ошибки, вы можете указать языки в поле `languageCodeHints`, которым надо отдать приоритет при определении языка текста:

```json
{
    "folder_id": "b1gvmob95yysaplct532",
    "languageCodeHints":["ru", "de"],
    "text": "hand"
}
```

Сохраните тело запроса в файле, например `body.json`, и передайте его с помощью метода [detectLanguage](../api-ref/v2/Translation/detectLanguage):

```bash
$ export IAM_TOKEN=CggaATEVAgA...
$ curl -X POST \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer ${IAM_TOKEN}" \
    -d @body.json \
    "https://translate.api.cloud.yandex.net/translate/v2/detect"

{
    "languageCode": "de"
}
```