---
title: Как распознать речь из аудиофайла через интерфейс {{ speechkit-full-name }} Playground
description: Следуя данной инструкции, вы сможете распознать аудиофайл через интерфейс {{ speechkit-name }} Playground.
---

# Распознавание речи с помощью Playground

Чтобы распознать речь из аудиофайла через интерфейс {{ speechkit-name }} Playground:

1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы будете работать с сервисом.
1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_speechkit }}**.
1. Перейдите на вкладку **{{ ui-key.yacloud.yagpt.speechkit.services.stt.title }}**.
1. В поле **{{ ui-key.yacloud.speechkit.speech-to-text.field_language }}** выберите нужный язык или оставьте значение `{{ ui-key.yacloud.speechkit.speech-to-text.label_language-auto }}`.
1. Нажмите **Выбрать файл** или перетащите аудиофайл в зону загрузки.

{% note tip %}

Заранее конвертируйте файл в поддерживаемый [аудиоформат](../formats.md): MP3, WAV или OGG с аудиокодеком OPUS. Максимальный размер файла — 60 МБ.

{% endnote %}

1. Нажмите кнопку ![TriangleRight](../../_assets/console-icons/triangle-right.svg) **{{ ui-key.yacloud.speechkit.speech-to-text.label_button_start-recognition }}**, чтобы распознать речь в аудиофайле.

   Распознавание может занять от нескольких секунд до нескольких минут в зависимости от размера аудиофайла.

1. Нажмите кнопку ![Copy](../../_assets/console-icons/copy.svg) **{{ ui-key.yacloud.speechkit.speech-to-text.label_button_copy-text }}**, чтобы скопировать распознанный текст.

{{ speechkit-name }} Playground предоставляет базовые возможности распознавания речи. Более гибкие настройки распознавания доступны только через [API](../stt/index.md).