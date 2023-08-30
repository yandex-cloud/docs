# Пример использования API синхронного распознавания

Пример показывает, как с помощью [API v1](request-api.md) распознать речь, записанную в аудиофайле формата [OggOpus](../../formats.md#OggOpus), в режиме синхронного распознавания.

В примере заданы следующие параметры:

* [язык](../index.md#langs) — русский;
* остальные параметры оставлены по умолчанию.

Формирование и отправка запроса к серверу, выполняющему распознавание, происходит с помощью утилиты [cURL](https://curl.haxx.se).

Аутентификация происходит от имени аккаунта на Яндексе или федеративного аккаунта с помощью [IAM-токена](../../../iam/concepts/authorization/iam-token.md). Если вы используете сервисный аккаунт, передавать в запросе идентификатор каталога не нужно. Подробнее об [аутентификации в API {{speechkit-name}}](../../concepts/auth.md).

## Пример запроса {#request_examples}

{% list tabs %}

- POST-запрос

  Отправьте [запрос](../request.md) на преобразование речи в текст: 

    ```httpget
    POST /speech/v1/stt:recognize?topic=general&lang=ru-RU&folderId={<идентификатор каталога>} HTTP/1.1
    Host: stt.{{ api-host }}
    Authorization: Bearer <IAM-токен>

    ... (двоичное содержимое аудиофайла)
    ```

    Где:

    * `topic` — [языковая модель](../models.md).
    * `lang` — [язык](../index.md#langs), для которого будет выполнено распознавание.
    * `folderId` — [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md).
    * `<IAM-токен>` — [IAM-токен](../../../iam/concepts/authorization/iam-token.md).

- cURL

  Отправьте [запрос](../request.md) на преобразование речи в текст:

    ```bash
    export FOLDER_ID=<идентификатор каталога>
    export IAM_TOKEN=<IAM-токен>
    curl -X POST \
         -H "Authorization: Bearer ${IAM_TOKEN}" \
         --data-binary "@speech.ogg" \
         "https://stt.{{ api-host }}/speech/v1/stt:recognize?topic=general&folderId=${FOLDER_ID}"
    ```

    Где:

    * `FOLDER_ID` — [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md).
    * `IAM_TOKEN` — [IAM-токен](../../../iam/concepts/authorization/iam-token.md).
    * `--data-binary` — имя аудиофайла для распознавания.
    * `topic` — [языковая модель](../models.md).

- Python 3

  Отправьте [запрос](../request.md) на преобразование речи в текст:

    ```python
    import urllib.request
    import json

    FOLDER_ID = "<идентификатор каталога>" # Идентификатор каталога
    IAM_TOKEN = "<IAM-токен>" # IAM-токен

    with open("speech.ogg", "rb") as f:
        data = f.read()

    params = "&".join([
        "topic=general",
        "folderId=%s" % FOLDER_ID,
        "lang=ru-RU"
    ])

    url = urllib.request.Request("https://stt.{{ api-host }}/speech/v1/stt:recognize?%s" % params, data=data)
    url.add_header("Authorization", "Bearer %s" % IAM_TOKEN)

    responseData = urllib.request.urlopen(url).read().decode('UTF-8')
    decodedData = json.loads(responseData)

    if decodedData.get("error_code") is None:
        print(decodedData.get("result"))
    ```

    Где:

    * `FOLDER_ID` — [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md).
    * `IAM_TOKEN` — [IAM-токен](../../../iam/concepts/authorization/iam-token.md).
    * `speech.ogg` — имя аудиофайла для распознавания.
    * `topic` — [языковая модель](../models.md).
    * `lang` — [язык](../index.md#langs), для которого будет выполнено распознавание.

- PHP

  Отправьте [запрос](../request.md) на преобразование речи в текст:

    ```php
    <?php

    $token = '<IAM-токен>'; # IAM-токен
    $folderId = "<идентификатор каталога>"; # Идентификатор каталога
    $audioFileName = "speech.ogg";

    $file = fopen($audioFileName, 'rb');

    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, "https://stt.{{ api-host }}/speech/v1/stt:recognize?lang=ru-RU&folderId=${folderId}&format=oggopus");
    curl_setopt($ch, CURLOPT_HTTPHEADER, array('Authorization: Bearer ' . $token));
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_POST, true);
    curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
    curl_setopt($ch, CURLOPT_BINARYTRANSFER, true);

    curl_setopt($ch, CURLOPT_INFILE, $file);
    curl_setopt($ch, CURLOPT_INFILESIZE, filesize($audioFileName));
    $res = curl_exec($ch);
    curl_close($ch);
    $decodedResponse = json_decode($res, true);
    if (isset($decodedResponse["result"])) {
        echo $decodedResponse["result"];
    } else {
        echo "Error code: " . $decodedResponse["error_code"] . "\r\n";
        echo "Error message: " . $decodedResponse["error_message"] . "\r\n";
    }

    fclose($file);
    ```

    Где:

    * `token` — [IAM-токен](../../../iam/concepts/authorization/iam-token.md).
    * `folderId` — [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md).
    * `audioFileName` — имя аудиофайла для распознавания.
    * `lang` — [язык](../index.md#langs), для которого будет выполнено распознавание.
    * `format` — [формат](../../formats.md) передаваемого аудио.

{% endlist %}

## Пример ответа {#response_examples}

```text
HTTP/1.1 200 OK
YaCloud-Billing-Units: 15
{
  "result": "твой номер 212-85-06"
}
```

#### См. также {#see-also}

* [{#T}](request-api.md)
* [{#T}](../../concepts/auth.md)
* [{#T}](../../sdk/python/request.md)
