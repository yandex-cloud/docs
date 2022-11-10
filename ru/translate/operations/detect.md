# Определение языка текста с помощью {{ translate-name }}

Чтобы определить, на каком языке написан текст, воспользуйтесь методом [detectLanguage](../api-ref/Translation/detectLanguage).

## Перед началом {#before-you-begin}

{% include [ai-before-beginning](../../_includes/ai-before-beginning.md) %}

## Распознать язык фразы {#simple-example}

В этом примере мы определим, на каком языке написана фраза <q>Hello, world</q>.

Чтобы определить, на каком языке написан текст, передайте его в теле запроса [detectLanguage](../api-ref/Translation/detectLanguage):
```bash
export FOLDER_ID=b1gvmob95yysaplct532
export IAM_TOKEN=CggaATEVAgA...
export TEXT="Hello, world"
curl -X POST \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer ${IAM_TOKEN}" \
    -d "{\"folderId\": \"${FOLDER_ID}\", \"text\": \"${TEXT}\"}" \
    "https://translate.{{ api-host }}/translate/v2/detect"
```

В ответе сервис вернет код языка, на котором написан текст. Код языка указывается в формате [ISO 639-1](https://en.wikipedia.org/wiki/ISO_639-1):

```json
{
    "languageCode": "en"
}
```

## Указать наиболее вероятные языки {#specify-language}

В некоторых языках одно и то же слово пишется одинаково. Например, слово <q>рука</q> пишется одинаково в английском, немецком, шведском и голландском языках — <q>hand</q>. Если переданный текст состоит из таких слов, то {{ translate-short-name }} может ошибиться при определении языка текста.

Чтобы избежать ошибки, вы можете указать языки в поле `languageCodeHints`, которым надо отдать приоритет при определении языка текста:

```json
{
    "folderId": "b1gvmob95yysaplct532",
    "languageCodeHints":["ru", "de"],
    "text": "hand"
}
```

Сохраните тело запроса в файле, например `body.json`, и передайте его с помощью метода [detectLanguage](../api-ref/Translation/detectLanguage):

```bash
export IAM_TOKEN=CggaATEVAgA...
curl -X POST \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer ${IAM_TOKEN}" \
    -d '@body.json' \
    "https://translate.{{ api-host }}/translate/v2/detect"

{
    "languageCode": "de"
}
```