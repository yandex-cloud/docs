### Инвентаризация APT-репозиториев ОС {#apt-sources}

#|
|| **kind** | **severity** | **ID** ||
|| inventory | low | inventory.apt-sources ||
|#

#### Описание

Это правило инвентаризации собирает информацию о настроенных APT-репозиториях на рабочих узлах с помощью агента инвентаризации.

Запросы:

all. Изменения всех apt-источников.

```SELECT name, release, source, base_uri, maintainer, components, architectures FROM apt_sources;```

all_s. Снимок всех apt-источников.

```SELECT name, release, source, base_uri, maintainer, components, architectures FROM apt_sources;```

external. Изменения внешних apt-источников (не Yandex или не secure Yandex).

```SELECT name, release, source, base_uri FROM apt_sources WHERE base_uri NOT IN ('http://common-secure.dist.yandex.ru/common','http://dist.yandex.ru/mdb-bionic-secure','http://dist.yandex.ru/mdb-jammy-secure','http://dist.yandex.ru/yandex-cloud-common-secure','http://dist.yandex.ru/yandex-cloud-secure','http://dist.yandex.ru/yandex-cloud-upstream-bionic-secure','http://yandex-cloud-common-focal-secure.dist.yandex.ru/yandex-cloud-common-focal-secure','http://yandex-cloud-common-secure.dist.yandex.ru/yandex-cloud-common-secure','http://yandex-cloud-focal-secure.dist.yandex.ru/yandex-cloud-focal-secure','http://yandex-cloud-secure.dist.yandex.ru/yandex-cloud-secure','http://yandex-cloud-secure.dist.yandex.ru/yandex-cloud','http://yandex-cloud-upstream-focal-secure.dist.yandex.ru/yandex-cloud-upstream-focal-secure','http://yandex-cloud-upstream-xenial-secure.dist.yandex.ru/yandex-cloud-upstream-xenial-secure','http://yandex-cloud-xenial-esm-secure.dist.yandex.ru/yandex-cloud-xenial-esm-secure','http://yandex-xenial-secure.dist.yandex.ru/yandex-xenial','https://common-secure.dist.yandex.ru/common','https://dist.yandex.ru/mdb-bionic-secure','https://dist.yandex.ru/mdb-jammy-secure','https://dist.yandex.ru/yandex-cloud-common-secure','https://dist.yandex.ru/yandex-cloud-secure','https://dist.yandex.ru/yandex-cloud-upstream-bionic-secure','https://yandex-cloud-common-focal-secure.dist.yandex.ru/yandex-cloud-common-focal-secure','https://yandex-cloud-common-secure.dist.yandex.ru/yandex-cloud-common-secure','https://yandex-cloud-focal-secure.dist.yandex.ru/yandex-cloud-focal-secure','https://yandex-cloud-secure.dist.yandex.ru/yandex-cloud-secure','https://yandex-cloud-secure.dist.yandex.ru/yandex-cloud','https://yandex-cloud-upstream-focal-secure.dist.yandex.ru/yandex-cloud-upstream-focal-secure','https://yandex-cloud-upstream-xenial-secure.dist.yandex.ru/yandex-cloud-upstream-xenial-secure','https://yandex-cloud-xenial-esm-secure.dist.yandex.ru/yandex-cloud-xenial-esm-secure','https://yandex-xenial-secure.dist.yandex.ru/yandex-xenial');```

external_s. Снимок внешних apt-источников (не Yandex или не secure Yandex).

```SELECT name, release, source, base_uri FROM apt_sources WHERE base_uri NOT IN ('http://common-secure.dist.yandex.ru/common','http://dist.yandex.ru/mdb-bionic-secure','http://dist.yandex.ru/mdb-jammy-secure','http://dist.yandex.ru/yandex-cloud-common-secure','http://dist.yandex.ru/yandex-cloud-secure','http://dist.yandex.ru/yandex-cloud-upstream-bionic-secure','http://yandex-cloud-common-focal-secure.dist.yandex.ru/yandex-cloud-common-focal-secure','http://yandex-cloud-common-secure.dist.yandex.ru/yandex-cloud-common-secure','http://yandex-cloud-focal-secure.dist.yandex.ru/yandex-cloud-focal-secure','http://yandex-cloud-secure.dist.yandex.ru/yandex-cloud-secure','http://yandex-cloud-secure.dist.yandex.ru/yandex-cloud','http://yandex-cloud-upstream-focal-secure.dist.yandex.ru/yandex-cloud-upstream-focal-secure','http://yandex-cloud-upstream-xenial-secure.dist.yandex.ru/yandex-cloud-upstream-xenial-secure','http://yandex-cloud-xenial-esm-secure.dist.yandex.ru/yandex-cloud-xenial-esm-secure','http://yandex-xenial-secure.dist.yandex.ru/yandex-xenial','https://common-secure.dist.yandex.ru/common','https://dist.yandex.ru/mdb-bionic-secure','https://dist.yandex.ru/mdb-jammy-secure','https://dist.yandex.ru/yandex-cloud-common-secure','https://dist.yandex.ru/yandex-cloud-secure','https://dist.yandex.ru/yandex-cloud-upstream-bionic-secure','https://yandex-cloud-common-focal-secure.dist.yandex.ru/yandex-cloud-common-focal-secure','https://yandex-cloud-common-secure.dist.yandex.ru/yandex-cloud-common-secure','https://yandex-cloud-focal-secure.dist.yandex.ru/yandex-cloud-focal-secure','https://yandex-cloud-secure.dist.yandex.ru/yandex-cloud-secure','https://yandex-cloud-secure.dist.yandex.ru/yandex-cloud','https://yandex-cloud-upstream-focal-secure.dist.yandex.ru/yandex-cloud-upstream-focal-secure','https://yandex-cloud-upstream-xenial-secure.dist.yandex.ru/yandex-cloud-upstream-xenial-secure','https://yandex-cloud-xenial-esm-secure.dist.yandex.ru/yandex-cloud-xenial-esm-secure','https://yandex-xenial-secure.dist.yandex.ru/yandex-xenial');```

Результаты можно анализировать с помощью экспорта данных событий из [сервиса Audit Trails](https://yandex.cloud/ru/docs/security-deck/at-ref) в вашу систему SIEM/SOC.

#### Инструкции и решения по выполнению

Правило не требует рекомендаций, потому что является информационным и используется для сбора событий инвентаризации в Audit Trails.

Настройте сбор [событий для Security Deck](https://yandex.cloud/ru/docs/security-deck/at-ref) в Audit Trails с экспортом в системы SIEM/SOC для анализа результатов инвентаризации.
