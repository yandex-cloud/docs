# Как начать работать с {{ vision-short-name }}

Этот раздел описывает, как начать использовать {{ vision-short-name }} API для анализа изображений.

## Перед началом {#before-you-begin}

{% include [curl](../_includes/curl.md) %}

{% include [ai-before-beginning](../_includes/vision/ai-before-beginning.md) %}

## Проанализируйте изображение {#analyze-image}

Вы можете использовать любые возможности для анализа из [списка](concepts/index.md#features). Для примера, воспользуемся возможностью [Распознавание текста](concepts/ocr/index.md):

{% include [text-detection-steps](../_includes/vision/text-detection-steps.md) %}

#### Что дальше {#what-is-next}

* [Узнайте обо всех возможностях сервиса](concepts/index.md)
* [Узнайте про способы аутентификации в API](api-ref/authentication.md)
* [Найдите лица на фото](operations/face-detection/index.md)
* [Оцените качество изображения](operations/classification/quality.md)
* [Модерируйте изображения](operations/classification/moderation.md)
