### Инвентаризация информации об установленных пакетах ОС {#apps}

#|
|| **kind** | **severity** | **ID** ||
|| inventory | low | inventory.apps ||
|#

#### Описание

Это правило инвентаризации собирает информацию об установленных пакетах на рабочих узлах с помощью агента инвентаризации.

Запросы:

installed. Показывает изменения в установленных пакетах.

```SELECT os_version.name AS os_name, os_version.version AS os_version, os_version.major AS os_major, os_version.minor AS os_minor, os_version.platform AS os_platform, os_version.codename AS os_codename, deb_packages.name AS pkg_name, deb_packages.source AS pkg_source, deb_packages.version AS pkg_version, deb_packages.arch AS pkg_arch, deb_packages.status AS pkg_status FROM os_version JOIN deb_packages;```

installed_s. Показывает все установленные пакеты.

```SELECT os_version.name AS os_name, os_version.version AS os_version, os_version.major AS os_major, os_version.minor AS os_minor, os_version.platform AS os_platform, os_version.codename AS os_codename, deb_packages.name AS pkg_name, deb_packages.source AS pkg_source, deb_packages.version AS pkg_version, deb_packages.arch AS pkg_arch, deb_packages.status AS pkg_status FROM os_version JOIN deb_packages;```

Результаты можно анализировать с помощью экспорта данных событий из [сервиса Audit Trails](https://yandex.cloud/ru/docs/security-deck/at-ref) в вашу систему SIEM/SOC.

#### Инструкции и решения по выполнению

Правило не требует рекомендаций, потому что является информационным и используется для сбора событий инвентаризации в Audit Trails.

Настройте сбор [событий для Security Deck](https://yandex.cloud/ru/docs/security-deck/at-ref) в Audit Trails с экспортом в системы SIEM/SOC для анализа результатов инвентаризации.
