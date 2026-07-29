[Документация Yandex Cloud](../../../../../index.md) > [Yandex Serverless Integrations](../../../../index.md) > [Концепции](../../../index.md) > Workflows > [Спецификация YaWL](../index.md) > Интеграционные шаги > STT

# STT

{% note info %}

На данный момент Workflows поддерживается в двух интерфейсах — [Yandex Cloud](https://console.yandex.cloud/link/serverless-integrations/workflows/workflows) и [Yandex AI Studio](https://aistudio.yandex.ru/platform/link//workflows). При этом:

* рабочие процессы, [созданные в интерфейсе Yandex Cloud](../../../../operations/workflows/workflow/create-constructor.md), автоматически _доступны_ в интерфейсе AI Studio;
* рабочие процессы, созданные в интерфейсе AI Studio, _недоступны_ в интерфейсе Yandex Cloud.

С 3 сентября 2026 года Workflows перестанет поддерживаться в интерфейсе Yandex Cloud. Для создания рабочих процессов и управления ими используйте интерфейс AI Studio.

{% endnote %}

Распознавание речи в аудиофайлах с помощью [Yandex SpeechKit STT](https://aistudio.yandex.ru/docs/ru/speechkit/stt/).

Поля `base64`, `url`, `objectStorage` и `disk` — взаимоисключающие, можно использовать только одно из них.

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](../../templating.md) | Описание
--- | --- | --- | --- | --- | ---
`recognizeText` | [STT.RecognizeText](#STT-RecognizeText) | Да | Нет | Нет | Настройки распознавания речи.
`base64` | `string` | Нет | Нет | Да | Файл с аудио в кодировке Base64.
`url` | `string` | Нет | Нет | Да | Файл с аудио по публичному URL.
`objectStorage` | [STT.ObjectStorage](#STT-ObjectStorage) | Нет | Нет | Нет | Файл с аудио из [бакета](../../../../../storage/concepts/bucket.md) Object Storage.
`disk` | [STT.Disk](#STT-Disk) | Нет | Нет | Нет | Файл с аудио на Яндекс Диске.

## STT.RecognizeText {#STT-RecognizeText}

#|
|| **Имя поля** | **Тип** | **Обязательное** | **Значение по умолчанию** | **Поддерживается [шаблонизация](../../templating.md)** | **Описание** ||
|| `mimeType` | `string` | Да | Нет | Нет | Формат файла с аудио. Доступные форматы: `mp3`, `wav`, `ogg`. ||
|| `languageCodes` | `string[]` | Да | Нет | Нет | Языки для распознавания речи. 

{% cut "Доступные языки" %}

* `auto` — автоматическое определение языка
* `ru-RU` — русский
* `en-US` — английский
* `de-DE` — немецкий
* `es-ES` — испанский
* `fi-FI` — финский
* `fr-FR` — французский
* `he-IL` — иврит
* `it-IT` — итальянский
* `kk-KZ` — казахский
* `nl-NL` — нидерландский
* `pl-PL` — польский
* `pt-PT` — португальский
* `pt-BR` — бразильский португальский
* `sv-SE` — шведский
* `tr-TR` — турецкий
* `uz-UZ` — узбекский (латиница)

{% endcut %}

||
|| `model` | `string` | Да | Нет | Нет | Модель для распознавания речи. Доступная модель: `general` — общая модель распознавания. ||
|#

## STT.ObjectStorage {#STT-ObjectStorage}

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](../../templating.md) | Описание
--- | --- | --- | --- | --- | ---
`bucket` | `string` | Да | Нет| Нет | Имя бакета Object Storage, в котором находится файл с аудио.
`object` | `string` | Да | Нет | Да | Имя объекта (например, `prefix/subprefix/data.mp3`).

## STT.Disk {#STT-Disk}

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](../../templating.md) | Описание |
--- | --- | --- | --- | --- | ---
`oauthToken` | `string` | Да | Нет | Нет | [OAuth-токен](https://yandex.ru/dev/disk-api/doc/ru/concepts/quickstart#oauth), который будет использоваться для аутентификации при обращении к Яндекс Диску. |
`path` | `string` | Да | Нет | Да | Путь к файлу с аудио. |
`sharedDiskId` | `string` | Нет | Нет | Да | [Метка](https://yandex.ru/dev/disk-api/doc/ru/reference/content_shd#query) общего диска. |