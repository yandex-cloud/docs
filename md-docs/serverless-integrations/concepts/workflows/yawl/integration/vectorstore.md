[Документация Yandex Cloud](../../../../../index.md) > [Yandex Serverless Integrations](../../../../index.md) > [Концепции](../../../index.md) > Workflows > [Спецификация YaWL](../index.md) > Интеграционные шаги > VectorStore

# VectorStore

{% note info %}

На данный момент Workflows поддерживается в двух интерфейсах — [Yandex Cloud](https://console.yandex.cloud/link/serverless-integrations/workflows/workflows) и [Yandex AI Studio](https://aistudio.yandex.ru/platform/link//workflows). При этом:

* рабочие процессы, [созданные в интерфейсе Yandex Cloud](../../../../operations/workflows/workflow/create-constructor.md), автоматически _доступны_ в интерфейсе AI Studio;
* рабочие процессы, созданные в интерфейсе AI Studio, _недоступны_ в интерфейсе Yandex Cloud.

С 3 сентября 2026 года Workflows перестанет поддерживаться в интерфейсе Yandex Cloud. Для создания рабочих процессов и управления ими используйте интерфейс AI Studio.

{% endnote %}

Взаимодействие с векторным хранилищем.

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](../../templating.md) | Описание
--- | --- | --- | --- | --- | ---
`uploadFile` | [UploadFile](#uploadfile) | Да | Нет | Нет | Описание действия загрузки файла в векторное хранилище.

## UploadFile {#uploadfile}

Поля `textFile`, `urlFile` и `objectStorage` — взаимоисключающие, можно использовать только одно из них.

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](../../templating.md) | Описание
--- | --- | --- | --- | --- | ---
`vectorStoreId` | `string` | Да | Нет | Нет | Идентификатор векторного хранилища.
`textFile` | [TextFile](#textfile) | Нет | Нет | Нет | Содержимое файла в виде текста.
`urlFile` | [UrlFile](#urlfile) | Нет | Нет | Нет | Содержимое файла по публичному URL.
`objectStorage` | [ObjectStorage](#objectstorage) | Нет | Нет | Нет | Содержимое файла из [бакета](../../../../../storage/concepts/bucket.md) Object Storage.
`attributes` | `map<string,string>` | Нет | Нет | Да | Дополнительные атрибуты файла (метаданные) в формате ключ-значение.

## TextFile {#textfile}

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](../../templating.md) | Описание
--- | --- | --- | --- | --- | ---
`text` | `string` | Да | Нет | Да | Текстовое содержимое файла.
`fileName` | `string` | Да | Нет | Да | Имя файла, под которым он будет сохранен.

## UrlFile {#urlfile}

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](../../templating.md) | Описание
--- | --- | --- | --- | --- | ---
`url` | `string` | Да | Нет | Да | Публичный URL, по которому доступен файл.
`fileName` | `string` | Да | Нет | Да | Имя файла, под которым он будет сохранен.

## ObjectStorage {#objectstorage}

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](../../templating.md) | Описание
--- | --- | --- | --- | --- | ---
`bucket` | `string` | Да | Нет | Нет | Имя бакета Object Storage, в котором находится файл.
`object` | `string` | Да | Нет | Да | Имя объекта (например, `prefix/subprefix/data.json`).