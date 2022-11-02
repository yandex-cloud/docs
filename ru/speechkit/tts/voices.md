# Список голосов

В этом разделе представлен список доступных голосов в сервисе и характеристики этого голоса:

* Основной язык, для которого голос создан. На этом языке разговаривал диктор при создании этого голоса.
* Пол, которому соответствует голос: мужской или женский.
* Доступные [амплуа](index.md#role) голоса.
{% if product == "yandex-cloud" %}* Поддерживаемая версия API.{% endif %}

Примеры голосов можно услышать на [странице сервиса]{% if lang == "ru" %}(https://cloud.yandex.ru/services/speechkit){% endif %}{% if lang == "en" %}(https://cloud.yandex.com/services/speechkit){% endif %}.

## Поддерживаемые голоса {#premium}

В таблице приведены характеристики поддерживаемых голосов, использующих глубокие нейронные сети для синтеза речи.

| Код языка | Язык | Голос | Пол | Амплуа | {% if product == "yandex-cloud" %}Версия API | {% endif %}
|---------| ---- | ---- | -- |--------|{% if product == "yandex-cloud" %}---|{% endif %}
| `de-DE` | немецкий | `lea` | Ж | — | {% if product == "yandex-cloud" %}v1, v3 |{% endif %}
| `en-US` | английский | `john` | М | — | {% if product == "yandex-cloud" %}v1, v3 |{% endif %}
| `kk-KK` | казахский | `amira` | Ж | — | {% if product == "yandex-cloud" %}v1, v3 |{% endif %}
| `kk-KK` | казахский | `madi` | М | — | {% if product == "yandex-cloud" %}v1, v3 |{% endif %}
| `ru-RU` |  русский | `alena` </br> (по умолчанию) | Ж | (по умолчанию) нейтральная — `neutral` </br> радостная — `good` </br> | {% if product == "yandex-cloud" %}v1, v3 |{% endif %}
| `ru-RU` | русский | `filipp` | M | — | {% if product == "yandex-cloud" %}v1, v3 |{% endif %}
| `ru-RU` | русский | `ermil` | M | (по умолчанию) нейтральный — `neutral` </br> радостный — `good` | {% if product == "yandex-cloud" %}v1, v3 |{% endif %}
| `ru-RU` | русский | `jane`  | Ж | (по умолчанию) нейтральная — `neutral` </br> радостная — `good` </br> раздраженная — `evil` | {% if product == "yandex-cloud" %}v1, v3 |{% endif %}
| `ru-RU` | русский | `madirus` | M | — | {% if product == "yandex-cloud" %}v1, v3 |{% endif %}
| `ru-RU` | русский | `omazh` | Ж  | (по умолчанию) нейтральная — `neutral` </br> раздраженная — `evil` | {% if product == "yandex-cloud" %}v1, v3 |{% endif %}
| `ru-RU` | русский | `zahar` | M | (по умолчанию) нейтральный — `neutral` </br> радостный — `good` | {% if product == "yandex-cloud" %}v1, v3 |{% endif %}
| `uz-UZ` | узбекский | `nigora` | Ж | — | {% if product == "yandex-cloud" %}v1, v3 |{% endif %}

{% if product == "yandex-cloud" %}
Голоса `oksana` и `alena` созданы на основе записей одного диктора. Голос `oksana` больше не представлен в списке поддерживаемых голосов, вместо него используйте голос `alena` в амплуа `good`. Для старых проектов поддержка `oksana` сохраняется.
{% endif %}

{% note tip %}

Если существующие голоса не подходят для вашего проекта, {{ speechkit-name }} может создать голос специально для вас. Подробнее о создании уникальных голосов см. в разделе [{{ brand-voice-full-name }}](brand-voice/index.md). 

{% endnote %}