# Инсталляции Solomon

В данном разделе описаны инсталляции Solomon, развернутые в «большом» Яндексе и в Яндекс.Облаке, приведены адреса веб-интерфейса и API, а также даны базовые рекомендации по выбору инсталляции.

Инсталляции Solomon могут эксплуатироваться в двух режимах: однодатацентровом и геораспределенном (кросс-датацентровом). В однодатацентровом режиме Solomon не предоставляет гарантий на сохранность пользовательских данных (загруженных метрик). В кросс-датацентровом режиме инсталляция Solomon состоит из двух полностью независимых дублирующих друг друга реплик, каждая из которых обрабатывает и сохраняет полный поток входящих данных. В Таблице 1 приведены сравнительных характеристики геораспределенных инсталляций Solomon.

<small>Таблица 1 — Сравнительные характеристики геораспределенных инсталляций Solomon. Данные актуальны на октябрь 2020 года.</small>

Характеристика | Solomon Production | Solomon Cloud Prod
---------------|--------------------|-------------------
Количество записываемых данных | 750 000 000 точек/секунду | 11 000 000 точек/секунду
Количество хранимых данных | 45 000 000 000 метрик | 325 000 000 метрик
Количество алертов | 1 500 000 алертов | 10 000 алертов
Количество опрашиваемых URL в Pull-режиме | 1 000 000 URL/15 секунд | 60 000 URL/15 секунд
Количество Push-запросов | 5 000 запросов/секунду | 9 000 запросов/секунду
Количество серверов | 329 | 16
Количество Hyper Threading ядер | 18 424 | 936
Объем оперативной памяти| 165,5 TiB | 3,6 TiB

Адреса инсталляций делятся на:
- **публичные** — веб-интерфейс или API, которыми могут пользоваться внешние по отношению к Яндексу пользователи Яндекс.Облака;
- **приватные** — веб-интерфейс или API, которыми могут пользоваться только сотрудники Яндекса и/или Яндекс.Облака.

## Инсталляции Solomon в «большом» Яндексе {#yandex-clusters}

### Solomon Production {#yandex-production}

Геораспределенная инсталляция Solomon Production развернута в датацентрах VLA и SAS и является основной инсталляцией, рекомендованной для использования любыми production сервисами Яндекса, [кроме сервисов Яндекс.Облака](#yandex-cloud-clusters).

<small>Таблица 2 — Адреса для инсталляции Solomon Production.</small>

Адрес | URL
------------|----
Приватный веб-интерфейс | [solomon.yandex-team.ru](https://solomon.yandex-team.ru)
Приватный REST API | `https://solomon.yandex.net/api/v2`
Приватный gRPC API | `solomon.yandex.net:443`

### Solomon Prestable {#yandex-prestable}

Однодатацентровая инсталляция Solomon Prestable развернута в датацентре MAN и является тестовой инсталляцией, которая используется:
* командой Solomon для проверки функциональности и регрессионного тестирования при релизе очередной версии;
* пользователями Solomon для тестов и отладки новых процессов, подключаемых к Solomon.

{% note warning %}

Для инсталляции Solomon Prestable не гарантируется сохранность пользовательских данных.

{% endnote %}

<small>Таблица 3 — Адреса для инсталляции Solomon Prestable.</small>

Адрес | URL
------------|----
Приватный веб-интерфейс | [solomon-prestable.yandex-team.ru](https://solomon-prestable.yandex-team.ru)
Приватный REST API | `https://solomon-prestable.yandex.net/api/v2`
Приватный gRPC API | `solomon-pre.yandex.net:443`


### Solomon Testing {#yandex-testing}

Однодатацентровая инсталляция Solomon Testing развернута в датацентре SAS и является тестовой инсталляцией, которая используется командами Solomon и YDB для проверки совместимости между новыми версиями Solomon и YDB. Пользователям Solomon не рекомендуется пользоваться данной инсталляцией.

{% note warning %}

Для инсталляции Solomon Testing не гарантируется сохранность пользовательских данных.

{% endnote %}

<small>Таблица 4 — Адреса для инсталляции Solomon Testing.</small>

Адрес | URL
------------|----
Приватный веб-интерфейс | [solomon-test.yandex-team.ru](https://solomon-test.yandex-team.ru)
Приватный REST API | `https://solomon-test.yandex.net/api/v2`
Приватный gRPC API | `solomon-test.yandex.net:443`

## Инсталляции Solomon в Яндекс.Облаке {#yandex-cloud-clusters}

Сервисы Яндекса.Облака проходят обязательную [сертификацию](https://cloud.yandex.ru/security#standards) на соответствие требованиям стандартов ISO-270x, PCI DSS и требованиям ФЗ-152 «О персональных данных». Для выполнения этих требований, инсталляции Solomon для сервисов Яндекс.Облака отделены от инсталляций в «большом» Яндексе.

### Solomon Cloud Prod {#cloud-prod}

Геораспределенная инсталляция Solomon Cloud Prod развернута в production окружении Яндекс.Облака в зонах доступности ru-central1-a (VLA) и ru-central1-b (SAS). Для соответствия требованиям стандарта PCI DSS, production окружение Яндекс.Облака изолированно от других окружений, поэтому инсталляция Solomon Cloud Prod подходит для единственного сценария: сбор метрик сервисов Яндекс.Облака из production окружения. Для сбора метрик сервисов, развернутых в других окружениях – preprod, testing, private, testing, hw-lab – следует использовать инсталляцию [{#T}](#cloud-preprod).

<small>Таблица 5 — Адреса для инсталляции Solomon Cloud Prod.</small>

Адрес | URL
------------|----
Приватный веб-интерфейс | [solomon.cloud.yandex-team.ru](https://solomon.cloud.yandex-team.ru)
Приватный REST API | `https://solomon.cloud.yandex-team.ru/api/v2`
Приватный gRPC API | `monitoring.private-api.cloud.yandex.net:443`
Публичный веб-интерфейс | [monitoring.cloud.yandex.ru](https://monitoring.cloud.yandex.ru)
Публичный REST API | `https://monitoring.api.cloud.yandex.net/monitoring/v2`
Публичный gRPC API | `monitoring.api.cloud.yandex.net:443`

### Solomon Cloud Preprod {#cloud-preprod}

Инсталляция Solomon Cloud Preprod развернута в preprod окружении Яндекс.Облака и предназначен для сбора метрик сервисов Яндекс.Облака из любых окружений, кроме production и private-gpn.

<small>Таблица 6 — Адреса для инсталляции Solomon Cloud Preprod.</small>

Адрес | URL
------------|----
Приватный веб-интерфейс  | [solomon.cloud-preprod.yandex-team.ru](https://solomon.cloud-preprod.yandex-team.ru)
Приватный REST API | `https://solomon.cloud-preprod.yandex-team.ru/api/v2`
Приватный gRPC API | `monitoring.private-api.cloud-preprod.yandex.net:443`
Публичный веб-интерфейс | [monitoring-preprod.cloud.yandex.ru](https://monitoring-preprod.cloud.yandex.ru)
Публичный REST API | `https://monitoring.api.cloud-preprod.yandex.net/monitoring/v2`
Публичный gRPC API | `monitoring.api.cloud-preprod.yandex.net:443`

### Solomon Cloud IL {#cloud-il}

Инсталляция Solomon Cloud IL развернута в окружении Яндекс.Облака в Израиле и подходит для единственного сценария: сбор метрик сервисов Яндекс.Облака в израильском окружении.

{% note warning %}

В инсталляции Solomon Cloud IL поддерживается только два [метода уведомлений](../concepts/alerting/index.md#channel-methods) от алертинга: Email и Juggler.

{% endnote %}

<small>Таблица 7 — Адреса для инсталляции Solomon Cloud IL.</small>

Адрес | URL
------------|----
Приватный веб-интерфейс | [solomon.yandexcloud.co.il](https://solomon.yandexcloud.co.il)
Приватный REST API | `https://monitoring.private-api.yandexcloud.co.il/api/v2`
Приватный gRPC API | `monitoring.private-api.yandexcloud.co.il:443`
Публичный веб-интерфейс | [monitoring.cloudil.co.il](https://monitoring.cloudil.co.il)

{% note warning %}

Приватный веб-интерфейс доступен только для пользователей федерации YandexTeam (yc.yandex-team.federation). Перед первым использованием веб-интерфейса необходимо зарегистрироваться в федерации, перейдя [по ссылке](https://console.cloudil.co.il/federations/yc.yandex-team.federation) и указав свой e-mail в домене yandex-team.ru.

{% endnote %}
