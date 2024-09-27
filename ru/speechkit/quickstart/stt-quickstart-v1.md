# Как распознать короткие аудиофайлы в {{ speechkit-short-name }}

Сервис позволяет распознавать речь [различными способами](../stt/index.md#stt-ways). В примере ниже аудиофайл распознается с помощью API [синхронного распознавания](../stt/request.md). В этом API действуют ограничения:

* максимальная длительность аудио — {{ stt-short-audioLength }};
* максимальный размер файла — {{ stt-short-fileSize }}.

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

* `FOLDER_ID` — идентификатор каталога, полученный [перед началом работы](index.md#before-you-begin).
* `IAM_TOKEN` — IAM-токен, полученный [перед началом работы](index.md#before-you-begin).
* `lang` — [язык](../stt/models.md#languages) распознавания.
* `speech.ogg` – аудиофайл с речью.

В ответе сервис вернет распознанный текст:

```json
{
   "result":"Я яндекс спичкит я могу превратить любой текст в речь теперь вы можете"
}
```

#### Дополнительная информация {#tutorials}

* [{#T}](../stt/api/request-api.md)
* [{#T}](../stt/api/request-examples.md)
* [{#T}](../stt/api/transcribation-api.md)
