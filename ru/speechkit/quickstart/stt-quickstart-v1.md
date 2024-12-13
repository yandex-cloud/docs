# Как распознать короткие аудиофайлы в {{ speechkit-short-name }}

Сервис позволяет распознавать речь [различными способами](../stt/index.md#stt-ways). В примере ниже аудиофайл распознается с помощью API [синхронного распознавания](../stt/request.md). В этом API действуют ограничения:

* максимальная длительность аудио — {{ stt-short-audioLength }};
* максимальный размер файла — {{ stt-short-fileSize }}.

Чтобы выполнить пример, подготовьте аудиофайл в одном из [поддерживаемых форматов](../formats.md) с учетом указанных выше ограничений.

Для работы с API в примере используется утилита [cURL](https://curl.se/).

## Аутентификация для работы с API {#auth}

{% include [ai-before-beginning](../../_includes/speechkit/ai-before-beginning.md) %}

В примере ниже аутентификация выполняется от имени аккаунта на Яндексе.

## Выполните запрос {#execute}

Отправьте [запрос](../stt/request.md) на распознавание речи:

```bash
export FOLDER_ID=<идентификатор_каталога>
export IAM_TOKEN=<IAM-токен>
curl \
  --request POST \
  --header "Authorization: Bearer ${IAM_TOKEN}" \
  --data-binary "@speech.ogg" \
  "https://stt.{{ api-host }}/speech/v1/stt:recognize?folderId=${FOLDER_ID}&lang=ru-RU"
```

Где:

* `FOLDER_ID` — идентификатор каталога, полученный [ранее](#auth).
* `IAM_TOKEN` — IAM-токен, полученный [ранее](#auth).
* `lang` — [язык](../stt/models.md#languages) распознавания.
* `speech.ogg` – подготовленный ранее аудиофайл с речью.

В ответе сервис вернет распознанный текст, например:

```json
{
   "result":"Я яндекс спичкит я могу превратить любой текст в речь теперь вы можете"
}
```

#### Дополнительная информация {#tutorials}

* [{#T}](../stt/api/request-api.md)
* [{#T}](../stt/api/request-examples.md)
* [{#T}](../stt/api/transcribation-api.md)
