# Термины и определения для {{ ydb-name }}

## База данных {#database}

[База данных {{ ydb-short-name }}]{% if lang == "ru" %}(https://ydb.tech/ru/docs/concepts/databases#database){% endif %}{% if lang == "en" %}(https://ydb.tech/en/docs/concepts/databases#database){% endif %} в {{ ydb-name }} может быть создана в [бессерверной](../operations/manage-databases.md#create-db-serverless) (Serverless) конфигурации или с [выделенными серверами](../operations/manage-databases.md#create-db-dedicated) (Dedicated). Подробнее о различиях в конфигурациях читайте в разделе [Serverless и Dedicated режимы работы](serverless-and-dedicated.md).

### Бессерверная база данных (Serverless) {#serverless}

Вычислительные ресурсы для бессерверных БД {{ ydb-short-name }} в {{ ydb-name }} предоставляются автоматически для выполнения запросов к БД. Оплата производится на основании расчета фактически использованных CPU и операций ввода-вывода, потребовавшихся для исполнения запроса к БД. Дополнительно оплачивается объем хранимых в БД данных.

### База данных на выделенных ресурсах (Dedicated) {#resource-presets}

БД {{ ydb-name }} предоставляется на виртуальных машинах на платформах, которые поддерживает {{ compute-full-name }}. Подробное смотрите в разделе [{#T}](../../compute/concepts/vm-platforms.md).

В {{ ydb-name }} доступны следующие конфигурации виртуальных машин:

{% if product == "yandex-cloud" %}

| Платформа | Имя конфигурации | Количество vCPU | Гарантированная доля vCPU | RAM, ГБ |
| ----- | ----- | ----- | ----- | ----- |
| **Intel Cascade Lake** | medium | 8 | 100% | 32 |
| **Intel Cascade Lake** | medium-m64 | 8 | 100% | 64 |
| **Intel Cascade Lake** | medium-m96 | 8 | 100% | 96 |
| **Intel Cascade Lake** | large | 12 | 100% | 48 |
| **Intel Cascade Lake** | xlarge | 16 | 100% | 64 |

{% endif %}

{% if product == "cloud-il" %}

| Платформа | Имя конфигурации | Количество vCPU | Гарантированная доля vCPU | RAM, ГБ |
| ----- | ----- | ----- | ----- | ----- |
| **Intel Ice Lake** | micro | 2 | 100% | 4 |
| **Intel Ice Lake** | small | 4 | 100% | 16 |
| **Intel Ice Lake** | medium | 8 | 100% | 32 |
| **Intel Ice Lake** | large | 12 | 100% | 48 |

{% endif %}

Оплата за БД на выделенных вычислительных ресурсах производится на почасовой основе. Дополнительно оплачивается объем хранилища данных под БД (см. [Группы хранения](#storage-groups) ниже).

## Кластер {#cluster}

Кластер {{ ydb-short-name }} — множество узлов {{ ydb-short-name }}, между которыми распределяется нагрузка.

В {{ ydb-name }} обслуживанием кластеров занимается команда сервиса, а разработчики приложений взаимодействуют напрямую с БД {{ ydb-short-name }}.

Подробнее о кластерах {{ ydb-short-name }} читайте в [документации]{% if lang == "ru" %}(https://ydb.tech/ru/docs/concepts/databases#cluster){% endif %}{% if lang == "en" %}(https://ydb.tech/en/docs/concepts/databases#cluster){% endif %}.

## Группы хранения {#storage-groups}

В {{ ydb-full-name }} используется по 3 диска в каждой из 3 зон доступности, как для БД на выделенных ресурсах, так и для бессерверных БД. Такая конфигурация гарантирует устойчивость при отказе одной из зон или отказе одного из дисков, а также обеспечивает избыточность с коэффициентом 3.

Подробнее о группах хранения {{ ydb-short-name }} читайте в [документации]{% if lang == "ru" %}(https://ydb.tech/ru/docs/concepts/databases#storage-groups){% endif %}{% if lang == "en" %}(https://ydb.tech/en/docs/concepts/databases#storage-groups){% endif %}.

## Регионы и зоны доступности {#regions-az}

Базы данных {{ ydb-name }} располагаются трех зонах доступности региона{% if product == "yandex-cloud" %} центральной России{% endif %} `{{ region-id }}`. Сервис {{ ydb-name }} обеспечивает полноценное продолжение работы баз данных при отказе одной из зон доступности.

Подробнее о географии {{ yandex-cloud }} читайте в разделе [{#T}](../../overview/concepts/geo-scope.md).
