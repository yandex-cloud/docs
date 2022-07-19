# Как начать работать со {{ speechkit-short-name }}

Если вы хотите попробовать, как сервис синтезирует или распознает речь, воспользуйтесь демо на [странице сервиса](https://cloud.yandex.ru/services/speechkit#demo).

В этом разделе вы научитесь использовать {{ speechkit-short-name }} API. Сначала вы создадите аудиофайл из текста, а потом попробуете его распознать.

О стоимости использования сервиса {{ speechkit-name }} см. [{#T}](pricing.md).

## Перед началом работы {#before-you-begin}

{% include [ai-before-beginning](../_includes/ai-before-beginning.md) %}

## Преобразование текста в речь {#text-to-speech}

С помощью [синтеза речи](tts/index.md) вы сможете превратить текст в речь и сохранить ее в аудиофайл.

Отправьте [запрос](tts/request.md) на преобразование текста в речь:

```bash
read -r -d '' TEXT << EOM
> Я Яндекс Спичк+ит.
> Я могу превратить любой текст в речь.
> Теперь и в+ы — можете!
EOM
export FOLDER_ID=<идентификатор каталога>
export IAM_TOKEN=<IAM-токен>
curl -X POST \
   -H "Authorization: Bearer ${IAM_TOKEN}" \
   --data-urlencode "text=${TEXT}" \
   -d "lang=ru-RU&voice=filipp&folderId=${FOLDER_ID}" \
   "https://tts.{{ api-host }}/speech/v1/tts:synthesize" > speech.ogg
```

Где:

* `TEXT` — текст c примененным URL-кодированием, который нужно распознать.
* `FOLDER_ID` — идентификатор каталога, полученный [перед началом работы](#before-begin).
* `IAM_TOKEN` — IAM-токен, полученный [перед началом работы](#before-begin).
* `lang` — [язык](tts/index.md#langs) текста.
* `voice` — [голос](tts/voices.md) для синтеза речи.
* `speech.ogg` – файл, в который будет записан ответ.

{% note info %}

Для передачи слов-омографов используйте `+` перед ударной гласной: `з+амок`, `зам+ок`. Чтобы отметить паузу между словами, используйте `-`. Ограничение на длину строки: 500 символов.
 
{% endnote %}

Синтезированная речь будет записана в файл `speech.ogg` в директории, из которой вы выполнили эту команду.

По умолчанию аудио создается в формате [OggOpus](https://wiki.xiph.org/OggOpus). Прослушать созданный файл можно в браузере, например в [Яндекс.Браузере](https://browser.yandex.ru) или [Mozilla Firefox](http://www.mozilla.org).

[Подробнее про формат запроса](tts/request.md) на синтез речи.

## Распознавание речи {#speech-recognition}

Сервис позволяет распознавать речь [различными способами](stt/index.md#stt-ways). В этом разделе используется [синхронное распознавание](stt/request.md).

Передайте двоичное содержимое аудиофайла в теле [запроса](stt/request.md), указав в параметрах запроса:

* `lang` — нужный вам [язык](stt/models.md#tags) распознавания.
* `folderId` — идентификатор каталога, полученный [перед началом](#before-begin).

```bash
curl -X POST \
   -H "Authorization: Bearer ${IAM_TOKEN}" \
   --data-binary "@speech.ogg" \
   "https://stt.{{ api-host }}/speech/v1/stt:recognize?folderId=${FOLDER_ID}&lang=ru-RU"
```

В ответе сервис вернет распознанный текст:

```
{"result":"Я яндекс спичкит я могу превратить любой текст в речь теперь вы можете"}
```

#### Что дальше {#what-is-next}

* [Подробнее про синтез речи](tts/index.md)
* [Подробнее про распознавание речи](stt/index.md)
* [Узнайте про способы аутентификации в API](concepts/auth.md)
* [Узнайте, как интегрировать телефонию](concepts/ivr-integration)
