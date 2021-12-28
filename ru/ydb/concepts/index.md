
{% include [concepts/index/intro.md](_includes/index/intro.md) %}

{% if audience == "external" %}

## YDB в Yandex.Cloud

Вы можете создать базу данных в бессерверной (Serverless) конфигурации или с выделенными серверами (Dedicated). Подробнее о различиях в конфигурациях читайте в разделе [Serverless и Dedicated режимы работы](serverless_and_dedicated.md).

Для сервиса действует [соглашение об уровне обслуживания](https://yandex.ru/legal/cloud_sla). Уровень обслуживания сервиса определен в документе [Уровень обслуживания Yandex Database](https://yandex.ru/legal/cloud_sla_ydb).

{% endif %}

{% include [concepts/index/when_use.md](_includes/index/when_use.md) %}

{% if audience == "internal" or audience == "tech" %}

## YDB в Yandex

Взаимодействие SDK с серверами YDB построено на базе протокола gRPC. Спецификация протокола взаимодействия с {{ ydb-short-name }} открыта. Это позволяет реализовать SDK для любого языка программирования.{% if oss != true %} В дополнение к перечисленным выше OpenSource SDK внутри Yandex доступен [C++ SDK](../operations/start_cpp.md).{% endif %}

{% endif %}


