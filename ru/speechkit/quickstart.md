# Как начать работать cо [!KEYREF speechkit-short-name]

В этом разделе вы научитесь использовать [!KEYREF speechkit-short-name] API. Сначала вы создадите аудиофайл из текста, а потом попробуете его распознать.

## Перед началом {#before-begin}

1. Убедитесь, что у вас установлена утилита [cURL](https://curl.haxx.se), используемая в примерах.
1. [Получите идентификатор каталога](../resource-manager/operations/folder/get-id.md), на который у вас есть роль `editor` или выше. Идентификатор каталога используется для авторизации. Подробнее в разделе [Управление доступом](security/index.md).
1. Получите IAM-токен, необходимый для аутентификации в API ([о других способах аутентификации](concepts/auth.md)):

    ---

    **[!TAB CLI]**

    ```
    $ yc iam create-token
    ```

    **[!TAB API]**

    [!INCLUDE [create-iam-token-api-steps](../_includes/iam/create-iam-token-api-steps.md)]

    ---

## Преобразование текста в речь

С помощью [синтеза речи](tts/index.md) вы сможете превратить текст в речь и сохранить ее в аудиофайл.

Сервис поддерживает следующие языки:
* `ru-RU` - русский;
* `en-US` — английский;
* `tr-TR` — турецкий.

Передайте текст в поле `text` в теле [запроса](tts/request.md), используя URL-кодирование. В параметре `lang` укажите язык текста, а в `folderId` — идентификатор каталога, полученный [перед началом](#before-begin). Ответ запишите в файл:

```bash
$ export TEXT="Hello world!"
$ export FOLDER_ID=b1gvmob95yysaplct532
$ export IAM_TOKEN=CggaATEVAgA...
$ curl -X POST \
     -H "Authorization: Bearer ${IAM_TOKEN}" \
     --data-urlencode "text=Hello World" \
     -d "lang=en-US&folderId=${FOLDER_ID}" \
     "https://tts.api.cloud.yandex.net/speech/v1/tts:synthesize" > speech.ogg
```

Синтезированная речь будет записана в файл `speech.ogg` в директории, из которой вы выполнили эту команду.

По умолчанию аудио создается в формате [OggOpus](https://wiki.xiph.org/OggOpus). Прослушать созданный файл можно в браузере, например в [Яндекс.Браузере](https://browser.yandex.ru) или [Mozilla Firefox](http://www.mozilla.org).

[Подробнее про формат запроса](tts/request.md) на синтез речи.

## Распознавание речи

Сервис позволяет распознавать речь [тремя различными способами](stt/index.md#stt-ways). В этом разделе используется [распознавание коротких аудиозаписей](stt/request.md).

Передайте двоичное содержимое аудиофайла в теле [запроса](stt/request.md). В Query-параметрах укажите язык распознавания (`lang`) и идентификатор каталога (`folderId`). В ответе сервис вернет распознанный текст:

```bash
$ curl -X POST \
     -H "Authorization: Bearer ${IAM_TOKEN}" \
     --data-binary "@speech.ogg" \
     "https://stt.api.cloud.yandex.net/speech/v1/stt:recognize?folderId=${FOLDER_ID}"

{"result":"Hello world"}
```

#### Что дальше

* [Подробнее про синтез речи](tts/index.md)
* [Подробнее про распознавание речи](stt/index.md)
* [Узнайте про другие способы аутентификации в API](concepts/auth.md)
* [Узнайте, как интегрировать телефонию](concepts/ivr-integration)