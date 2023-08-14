# Как начать работать с {{ vision-short-name }}

Этот раздел описывает, как начать использовать {{ vision-short-name }} API для анализа изображений.

## Перед началом работы {#before-you-begin}

{% include [curl](../_includes/curl.md) %}

{% include [ai-before-beginning](../_includes/vision/ai-before-beginning.md) %}

## Проанализируйте изображение {#analyze-image}

Вы можете использовать любые возможности для анализа из [списка](concepts/index.md#features). Для примера, воспользуемся возможностью [Распознавание текста](concepts/ocr/index.md):

1. Подготовьте файл изображения, соответствующий требованиям:

    * Поддерживаемые форматы файлов: JPEG, PNG, PDF.
    * Максимальный размер файла: 1 МБ.
    * Размер изображения не должен превышать 20 мегапикселей (длина x ширина).

    {% note info %}

    Нужен пример изображения? Скачайте изображение дорожного знака, [предупреждающего о пингвинах](https://{{ s3-storage-host }}/vision/penguins_sample.jpg).

    {% endnote %}

{% include [text-detection-steps](../_includes/vision/text-detection-steps.md) %}

{% include [coordinate-definition-issue-note](../_includes/vision/coordinate-definition-issue-note.md) %}

#### Что дальше {#what-is-next}

* [Узнайте обо всех возможностях сервиса](concepts/index.md)
* [Узнайте про способы аутентификации в API](api-ref/authentication.md)
* [Найдите лица на фото](operations/face-detection/index.md)
* [Оцените качество изображения](operations/classification/quality.md)
* [Модерируйте изображения](operations/classification/moderation.md)
