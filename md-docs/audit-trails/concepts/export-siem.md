[Документация Yandex Cloud](../../index.md) > [Yandex Audit Trails](../index.md) > [Концепции](index.md) > Экспорт в SIEM

# Экспорт аудитных логов в SIEM


Файлы аудитного лога доступны для экспорта в SIEM.

Команда Yandex Cloud подготовила комплект решений для экспорта аудитных логов для нескольких SIEM. Файлы решений приведены в соответствующих разделах [репозитория Yandex Cloud Security Solution Library](https://github.com/yandex-cloud-examples/yc-security-solutions-library).

[Yandex Cloud Security Solution Library](https://yandex.cloud/ru/solutions/security-solution-library) — это набор примеров и рекомендаций по построению безопасной инфраструктуры в Yandex Cloud, собранных в публичном репозитории на GitHub.

![image](../../_assets/audit-trails/export-siem.svg)

<small>Схема принятия решения по выбору архитектуры</small>

В настоящее время подготовлены решения для следующих SIEM:
* [ArcSight](../tutorials/export-logs-to-arcsight.md).
* [Splunk](../tutorials/export-logs-to-splunk.md).
* [MaxPatrol SIEM](../tutorials/maxpatrol/index.md).

Все решения обеспечивают непрерывную доставку файлов аудитных логов из бакетов в SIEM, а также содержат правила корреляции, дашборды и запросы для поиска важных событий безопасности. Команда Yandex Cloud поддерживает и регулярно обновляет все решения.