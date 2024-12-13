# Как синтезировать речь в {{ speechkit-short-name }} API v1

[Синтез речи](../tts/index.md) преобразует текст в речь и сохраняет ее в аудиофайл. В этом разделе вы научитесь синтезировать речь из текста с помощью {{ speechkit-short-name }} [API v1](../tts/request.md) (REST).

Для работы с API в примере используется утилита [cURL](https://curl.se/).

## Аутентификация для работы с API {#auth}

{% include [ai-before-beginning](../../_includes/speechkit/ai-before-beginning.md) %}

В примере ниже аутентификация выполняется от имени аккаунта на Яндексе.

## Выполните запрос {#execute}

Отправьте запрос на преобразование текста в речь:

```bash
read -r -d '' TEXT << EOM
Я Яндекс Спичк+ит.
Я могу превратить любой текст в речь.
Теперь и в+ы — можете!
EOM
export FOLDER_ID=<идентификатор_каталога>
export IAM_TOKEN=<IAM-токен>
curl 
  --request POST \
  --header "Authorization: Bearer ${IAM_TOKEN}" \
  --data-urlencode "text=${TEXT}" \
  --data "lang=ru-RU&voice=filipp&folderId=${FOLDER_ID}" \
  "https://tts.{{ api-host }}/speech/v1/tts:synthesize" > speech.ogg
```

Где:

* `FOLDER_ID` — идентификатор каталога, полученный [ранее](#auth).
* `IAM_TOKEN` — IAM-токен, полученный [ранее](#auth).
* `TEXT` — текст с примененным URL-кодированием, который нужно распознать.
* `lang` — [язык](../tts/index.md#langs) текста.
* `voice` — [голос](../tts/voices.md) для синтеза речи.
* `speech.ogg` – файл, в который будет записан ответ.

{% note info %}

Для передачи слов-омографов используйте `+` перед ударной гласной: `з+амок`, `зам+ок`. Чтобы отметить паузу между словами, используйте `-`. Ограничение на длину строки: 5000 символов.

{% endnote %}

Синтезированная речь будет записана в файл `speech.ogg` в папке, из которой вы выполнили эту команду.

По умолчанию аудио создается в формате [OggOpus](https://wiki.xiph.org/OggOpus). Прослушать созданный файл можно в браузере, например в [Яндекс Браузере](https://browser.yandex.ru) или [Mozilla Firefox](http://www.mozilla.org).

См. подробнее [описание формата запроса на синтез речи](../tts/request.md).

#### Практические руководства {#tutorials}

* [{#T}](../tts/api/tts-ogg.md)
* [{#T}](../tts/api/tts-ssml.md)
* [{#T}](../tts/api/tts-wav.md)
