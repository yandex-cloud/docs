# Начало работы со {{ speechkit-name }}

Вы можете протестировать распознавание и синтез речи в сервисе {{ speechkit-name }} на [странице демо](https://yandex.cloud/ru/services/speechkit#demo). О стоимости использования сервиса читайте в разделе [{#T}](../pricing.md).

## Перед началом работы {#before-you-begin}

1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь, если вы еще не зарегистрированы. О том, как начать работать с {{ yandex-cloud }}, см. в документе [Начало работы с {{ yandex-cloud }}](../../getting-started/).
1. Примите пользовательское соглашение.
1. В сервисе [{{ billing-name }}]({{ link-console-billing }}) убедитесь, что у вас подключен [платежный аккаунт](../../billing/concepts/billing-account.md) и он находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md#create_billing_account).

## Синтез речи с помощью Playground {#tts-playground}

Чтобы преобразовать текст в аудио через интерфейс {{ speechkit-name }} Playground: 

1. Откройте [консоль управления]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_speechkit }}**.
1. На панели справа нажмите **{{ ui-key.yacloud.speechkit.label_playground }}**.
1. В блоке **{{ ui-key.yacloud.speechkit.speech-synthesis.label_synthesis-settings }}**:
   * **{{ ui-key.yacloud.speechkit.help-speech-synthesis.context_pauses-title }}** — выберите длительность пауз между словами или задайте ее самостоятельно.
   * **{{ ui-key.yacloud.speechkit.help-speech-synthesis.context_word-title }}** — расставьте акценты на нужных словах.
   * **{{ ui-key.yacloud.speechkit.help-speech-synthesis.context_word-stress-title }}** — обозначьте ударные гласные, чтобы уточнить корректный вариант произношения слов.
   * **{{ ui-key.yacloud.speechkit.help-speech-synthesis.context_phonemes-title }}** — контролируйте правильность произношения слов с помощью фонем.
1. В блоке **{{ ui-key.yacloud.speechkit.speech-synthesis.label_synthesis-settings }}**:
   * **{{ ui-key.yacloud.speechkit.speech-synthesis.field_language }}** — выберите язык диктора.
   * **{{ ui-key.yacloud.speechkit.speech-synthesis.field_voice }}** — укажите голос диктора.
   * **{{ ui-key.yacloud.speechkit.speech-synthesis.field_role }}** — выберите амплуа диктора.
   * **{{ ui-key.yacloud.speechkit.speech-synthesis.field_speed }}** — задайте скорость речи диктора.
   * **{{ ui-key.yacloud.speechkit.speech-synthesis.field_pitch-shift }}** — скорректируйте высоту голоса диктора.
   * **{{ ui-key.yacloud.speechkit.speech-synthesis.field_audio }}** — выберите необходимый формат аудио.
1. Чтобы синтезировать текст, нажмите **{{ ui-key.yacloud.speechkit.speech-synthesis.label_button_playback }}**.
1. Чтобы скачать результат, нажмите ![image](../../_assets/console-icons/arrow-down-to-line.svg).

{{ speechkit-name }} Playground предоставляет базовые возможности синтеза речи. Более гибкие настройки синтеза доступны только через API.

## Аутентификация для работы с API {#auth}

{% include [ai-before-beginning](../../_includes/speechkit/ai-before-beginning.md) %}

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
