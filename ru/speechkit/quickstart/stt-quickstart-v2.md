# Как распознать короткие аудиофайлы в {{ speechkit-short-name }}

Сервис позволяет распознавать речь [различными способами](../stt/index.md#stt-ways). В этом разделе вы распознаете короткий аудио-файл с помощью [синхронного распознавания](../stt/request.md).

{% note info %}

В сервисе установлены ограничения на длительность аудио и размер файла:

* Максимальная длительность аудио – {{ stt-short-audioLength }}.
* Максимальный размер файла — {{ stt-short-fileSize }}.

{% endnote %}

Отправьте [запрос](../stt/request.md) на распознавание речи:

```bash
export FOLDER_ID=<идентификатор каталога>
export IAM_TOKEN=<IAM-токен>
curl -X POST \
   -H "Authorization: Bearer ${IAM_TOKEN}" \
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
