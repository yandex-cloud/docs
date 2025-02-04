# Начало работы со {{ speechkit-name }}

Вы можете протестировать распознавание и синтез речи в сервисе {{ speechkit-name }} на [странице демо](https://yandex.cloud/ru/services/speechkit#demo). О стоимости использования сервиса читайте в разделе [{#T}](../pricing.md).

## Перед началом работы {#before-you-begin}

1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь, если вы еще не зарегистрированы. О том, как начать работать с {{ yandex-cloud }}, см. в документе [Начало работы с {{ yandex-cloud }}](../../getting-started/).
1. Примите пользовательское соглашение.
1. В сервисе [{{ billing-name }}]({{ link-console-billing }}) убедитесь, что у вас подключен [платежный аккаунт](../../billing/concepts/billing-account.md) и он находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md#create_billing_account).

## Распознавание речи с помощью Playground {#stt-playground}

Чтобы распознать речь из аудиофайла через интерфейс {{ speechkit-name }} Playground:

1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы будете работать с сервисом.
1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_speechkit }}**.
1. Перейдите на вкладку **{{ ui-key.yacloud.yagpt.speechkit.services.stt.title }}**.
1. В поле **{{ ui-key.yacloud.speechkit.speech-to-text.field_language }}** выберите нужный язык или оставьте значение `{{ ui-key.yacloud.speechkit.speech-to-text.label_language-auto }}`.
1. Нажмите **Выбрать файл** или перетащите аудиофайл в зону загрузки.
1. Нажмите кнопку ![TriangleRight](../../_assets/console-icons/triangle-right.svg) **{{ ui-key.yacloud.speechkit.speech-to-text.label_button_start-recognition }}**, чтобы распознать речь в аудиофайле.

Подробную инструкцию см. на странице [{#T}](../operations/stt-playground.md).

{{ speechkit-name }} Playground предоставляет базовые возможности распознавания речи. Более гибкие настройки распознавания доступны только через [API](#stt-quickstart).

## Синтез речи с помощью Playground {#tts-playground}

Чтобы преобразовать текст в аудио через интерфейс {{ speechkit-name }} Playground: 

1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы будете работать с сервисом.
1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_speechkit }}**.
1. Перейдите на вкладку **{{ ui-key.yacloud.yagpt.speechkit.services.speech-synthesys.title }}**.
1. В блоке настроек в левой части окна:
   * **{{ ui-key.yacloud.speechkit.help-speech-synthesis.context_pauses-title }}** — выберите длительность пауз между словами или задайте ее самостоятельно.
   * **{{ ui-key.yacloud.speechkit.help-speech-synthesis.context_word-title }}** — расставьте акценты на нужных словах.
   * **{{ ui-key.yacloud.speechkit.help-speech-synthesis.context_word-stress-title }}** — обозначьте ударные гласные, чтобы уточнить корректный вариант произношения слов.
   * **{{ ui-key.yacloud.speechkit.help-speech-synthesis.context_phonemes-title }}** — контролируйте правильность произношения слов с помощью фонем.
1. В блоке **{{ ui-key.yacloud.speechkit.speech-synthesis.label_synthesis-settings }}** в правой части окна:
   * **{{ ui-key.yacloud.speechkit.speech-synthesis.field_language }}** — выберите язык диктора.
   * **{{ ui-key.yacloud.speechkit.speech-synthesis.field_voice }}** — укажите голос диктора.
   * **{{ ui-key.yacloud.speechkit.speech-synthesis.field_role }}** — выберите амплуа диктора.
   * **{{ ui-key.yacloud.speechkit.speech-synthesis.field_speed }}** — задайте скорость речи диктора.
   * **{{ ui-key.yacloud.speechkit.speech-synthesis.field_pitch-shift }}** — скорректируйте высоту голоса диктора.
   * **{{ ui-key.yacloud.speechkit.speech-synthesis.field_audio }}** — выберите необходимый формат аудио.
1. Нажмите кнопку ![TriangleRight](../../_assets/console-icons/triangle-right.svg) **{{ ui-key.yacloud.speechkit.speech-synthesis.label_button_playback }}**, чтобы синтезировать речь.
1. Чтобы скачать результат, нажмите ![image](../../_assets/console-icons/arrow-down-to-line.svg).

Подробную инструкцию см. на странице [{#T}](../operations/tts-playground.md).

{{ speechkit-name }} Playground предоставляет базовые возможности синтеза речи. Более гибкие настройки синтеза доступны только через [API](#tts-quickstart).

## Распознавание речи через API {#stt-quickstart}

Узнайте, как распознать [короткие](stt-quickstart-v1.md) и [длинные](stt-quickstart-v2.md) предзаписанные аудиофайлы в {{ speechkit-name }}. Также сервис позволяет распознать голос в [режиме реального времени](../stt/api/streaming-examples-v3.md).

## Синтез речи через API {#tts-quickstart}

Узнайте, как преобразовать текст в аудио с помощью [API v1](tts-quickstart-v1.md) и [API v3](tts-quickstart-v3.md) {{ speechkit-name }}. API v3 позволяет более гибко настроить синтез. Подробнее о различиях версий API в разделе [{#T}](../tts/index.md#features).

#### См. также {#see-also}

* [Подробнее про распознавание речи](../stt/index.md)
* [Подробнее про синтез речи](../tts/index.md)
* [Поддерживаемые форматы аудио](../formats.md)
* [Необходимые роли для выполнения операций](../security/index.md)
* [Все примеры интеграции {{ speechkit-name }}](../tutorials/index.md)