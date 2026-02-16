---
title: Как синтезировать речь через интерфейс {{ speechkit-full-name }} Playground
description: Следуя данной инструкции, вы сможете преобразовать текст в человеческую речь через интерфейс {{ speechkit-name }} Playground.
---

# Синтез речи с помощью Playground

Чтобы преобразовать текст в аудио через {{ speechkit-name }} Playground:

{% list tabs group=instructions %}

- Консоль управления {#console}
  
  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы будете работать с сервисом.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_speechkit }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/dice-3.svg) **{{ ui-key.yacloud.speechkit.label_playground }}**.
  1. Перейдите на вкладку **{{ ui-key.yacloud.yagpt.speechkit.services.speech-synthesys.title }}**.
  1. Вставьте текст длиною до 5000 символов в центральную часть окна.
  1. В блоке настроек в левой части окна:
  
     * **{{ ui-key.yacloud.speechkit.help-speech-synthesis.context_pauses-title }}** — настройте фиксированные [паузы](../tts/markup/tts-markup.md#pause) между словами тегами `<[small]>`, `<[large]>` и другими. Чтобы задать паузу определенной длины, используйте тег `sil<[t]>`, где `t` — длительность паузы в миллисекундах. Максимальное значение — 7 000.
     * **{{ ui-key.yacloud.speechkit.help-speech-synthesis.context_word-title }}** — поставьте [акцент](../tts/markup/tts-markup.md#accent) на слове с помощью тега `<[accented]>` или заключите слово в звездочки `** **`.
     * **{{ ui-key.yacloud.speechkit.help-speech-synthesis.context_word-stress-title }}** — обозначьте в омографах [ударную](../tts/markup/tts-markup.md#a) гласную, поставив перед ней символ `+`.
     * **{{ ui-key.yacloud.speechkit.help-speech-synthesis.context_phonemes-title }}** — выделяйте слова блоком `[[]]`, чтобы контролировать правильность произношения с помощью [фонем](../tts/markup/tts-supported-phonemes.md).
  
  1. В блоке **{{ ui-key.yacloud.speechkit.speech-synthesis.label_synthesis-settings }}** в правой части окна:
  
     * **{{ ui-key.yacloud.speechkit.speech-synthesis.field_language }}** — задайте язык диктора.
     * **{{ ui-key.yacloud.speechkit.speech-synthesis.field_voice }}** — выберите голос диктора.
     * **{{ ui-key.yacloud.speechkit.speech-synthesis.field_role }}** — контролируйте характер и эмоциональное произношение с помощью выбора амплуа диктора.
     * **{{ ui-key.yacloud.speechkit.speech-synthesis.field_speed }}** — задайте темп речи диктора в диапазоне от `0.1` до `3.0`, где `1.0` — средняя скорость человеческой речи.
     * **{{ ui-key.yacloud.speechkit.speech-synthesis.field_pitch-shift }}** — скорректируйте высоту голоса диктора. Чем выше значение, тем больше интонационный контур синтезированного аудио в Гц.
     * **{{ ui-key.yacloud.speechkit.speech-synthesis.field_audio }}** — выберите необходимый формат аудио.  

  1. Чтобы начать синтез, нажмите ![TriangleRight](../../_assets/console-icons/triangle-right.svg) **{{ ui-key.yacloud.speechkit.speech-synthesis.label_button_playback }}**.
  1. Чтобы скачать результат, нажмите ![image](../../_assets/console-icons/arrow-down-to-line.svg).

  ![screen](../../_assets/speechkit/tts-playground.png)
  
  {{ speechkit-name }} Playground предоставляет базовые возможности синтеза речи. Более гибкие настройки синтеза доступны только через [API](../tts/index.md).

{% endlist %}