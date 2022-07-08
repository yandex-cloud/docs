# Список поддерживаемых фонем в SSML

Языки, для которых поддерживается использование фонем в SSML (тег [`<phoneme>`](ssml.md#phoneme)):

* [Русский](#ru-ru) (`ru-RU`)
* [Английский](#en-us) (`en-US`)

## Русский {#ru-ru}

Список поддерживаемых фонем при использовании русского языка (`ru-RU`). [Подробнее о русской фонологии](https://en.wikipedia.org/wiki/Russian_phonology).

{% include [phonemes-ru-ru_untranslatable](../../_includes/speechkit/phonemes-ru-ru_untranslatable.md) %}

## Английский {#en-us}

Список поддерживаемых фонем при использовании американского английского языка (`en-US`). [Подробнее об английской фонологии](https://en.wikipedia.org/wiki/English_phonology).

{% note tip %}

Рекомендуем всегда расставлять ударения в английском языке, иначе произношение может быть неверным. Ударение ставится в начале слога.

{% endnote %}

{% include [phonemes-en-us_untranslatable](../../_includes/speechkit/phonemes-en-us_untranslatable.md) %}

{% if audience == "test" %}

## Турецкий {#tr-tr}

Список поддерживаемых фонем при использовании турецкого языка (`tr-TR`). [Подробнее о турецкой фонологии](https://en.wikipedia.org/wiki/Turkish_phonology).

{% include [phonemes-tr-tr_untranslatable](../../_includes/speechkit/phonemes-tr-tr_untranslatable.md) %}

{% endif %}