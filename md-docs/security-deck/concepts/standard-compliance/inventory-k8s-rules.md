[Документация Yandex Cloud](../../../index.md) > [Yandex Security Deck](../../index.md) > [Концепции](../index.md) > [Интерфейс соответствия требованиям](index.md) > Аудит процессов и приложений

# Аудит процессов и приложений на рабочих узлах Kubernetes

Набор содержит правила, позволяющие выполнять инвентаризацию и аудит множества параметров и компонентов с уровня операционной системы рабочих узлов Kubernetes. 

Набор правил не соответствует требованиям стандартов безопасности, поскольку предназначен только для сбора информации. Для ее анализа можно использовать сервис [Yandex Audit Trails](../../../audit-trails/index.md) с последующим экспортом в системы SIEM/SOC.

Правило | Идентификатор проверки
--- | ---
Инвентаризация параметров sysctl ОС | [kspm.inventory.sysctl](../../rules-reference/kspm.md#sysctl)
Инвентаризация информации о логинах пользователей ОС | [kspm.inventory.logins](../../rules-reference/kspm.md#logins)
Инвентаризация информации о сетевых параметрах ОС | [kspm.inventory.network](../../rules-reference/kspm.md#network)
Инвентаризация разделяемой памяти ОС | [kspm.inventory.shared-memory](../../rules-reference/kspm.md#shared-memory)
Инвентаризация о базовых параметрах ОС | [kspm.inventory.general](../../rules-reference/kspm.md#general)
Инвентаризация процессов ОС | [kspm.inventory.processes](../../rules-reference/kspm.md#processes)
Инвентаризация информации об установленных пакетах ОС | [kspm.inventory.apps](../../rules-reference/kspm.md#apps)
Инвентаризация пользователей ОС | [kspm.inventory.users](../../rules-reference/kspm.md#users)
Инвентаризация APT-репозиториев ОС | [kspm.inventory.apt-sources](../../rules-reference/kspm.md#apt-sources)
Инвентаризация AppArmor ОС | [kspm.inventory.apparmor](../../rules-reference/kspm.md#apparmor)
Инвентаризация самомониторинга агента osquery | [kspm.inventory.selfmon](../../rules-reference/kspm.md#selfmon)
Инвентаризация событий seccomp ОС | [kspm.inventory.seccomp](../../rules-reference/kspm.md#seccomp)
Инвентаризация ядра ОС | [kspm.inventory.kernel](../../rules-reference/kspm.md#kernel)