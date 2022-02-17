# Как начать работать cо {{ speechkit-short-name }}

Если вы хотите попробовать, как сервис синтезирует или распознает речь, воспользуйтесь демо на [странице сервиса](https://cloud.yandex.ru/services/speechkit#demo).

В этом разделе вы научитесь использовать {{ speechkit-short-name }} API. Сначала вы создадите аудиофайл из текста, а потом попробуете его распознать.

О стоимости использования сервиса {{ speechkit-name }} см. [{#T}](pricing.md).

## Перед началом {#before-you-begin}

{% include [ai-before-beginning](../_includes/ai-before-beginning.md) %}

## Преобразование текста в речь {#text-to-speech}

С помощью [синтеза речи](tts/index.md) вы сможете превратить текст в речь и сохранить ее в аудиофайл.

Передайте текст в поле `text` в теле [запроса](tts/request.md), используя URL-кодирование. В параметре `lang` укажите язык текста, в `voice` — [голос](tts/voices.md) для синтеза речи, а в `folderId` — идентификатор каталога, полученный [перед началом](#before-begin). Ответ запишите в файл:

```bash
read -r -d '' TEXT << EOM
> Я Яндекс Спичк+ит.
> Я могу превратить любой текст в речь.
> Теперь и в+ы - можете!
> EOM
export FOLDER_ID=<идентификатор каталога>
export IAM_TOKEN=CggaATEVAgA...
curl -X POST \
   -H "Authorization: Bearer ${IAM_TOKEN}" \
   --data-urlencode "text=${TEXT}" \
   -d "lang=ru-RU&voice=filipp&folderId=${FOLDER_ID}" \
   "https://tts.api.cloud.yandex.net/speech/v1/tts:synthesize" > speech.ogg
```

{% note info %}

Для передачи слов-омографов используйте `+` перед ударной гласной: `з+амок`, `зам+ок`. Чтобы отметить паузу между словами, используйте `-`. Ограничение на длину строки: 500 символов.
 
{% endnote %}

Синтезированная речь будет записана в файл `speech.ogg` в директории, из которой вы выполнили эту команду.

По умолчанию аудио создается в формате [OggOpus](https://wiki.xiph.org/OggOpus). Прослушать созданный файл можно в браузере, например в [Яндекс.Браузере](https://browser.yandex.ru) или [Mozilla Firefox](http://www.mozilla.org).

[Подробнее про формат запроса](tts/request.md) на синтез речи.

## Распознавание речи {#speech-recognition}

Сервис позволяет распознавать речь [различными способами](stt/index.md#stt-ways). В этом разделе используется [синхронное распознавание](stt/request.md).

Передайте двоичное содержимое аудиофайла в теле [запроса](stt/request.md). В query-параметрах укажите язык распознавания (`lang`) и идентификатор каталога (`folderId`). В ответе сервис вернет распознанный текст:

```bash
curl -X POST \
   -H "Authorization: Bearer ${IAM_TOKEN}" \
   --data-binary "@speech.ogg" \
   "https://stt.api.cloud.yandex.net/speech/v1/stt:recognize?folderId=${FOLDER_ID}&lang=ru-RU"

{"result":"Я яндекс спичкит я могу превратить любой текст в речь теперь вы можете"}
```

#### Что дальше {#what-is-next}

* [Подробнее про синтез речи](tts/index.md)
* [Подробнее про распознавание речи](stt/index.md)
* [Узнайте про способы аутентификации в API](concepts/auth.md)
* [Узнайте, как интегрировать телефонию](concepts/ivr-integration)
