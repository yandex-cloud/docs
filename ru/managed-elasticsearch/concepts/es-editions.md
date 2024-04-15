---
title: "Редакции Elasticsearch"
description: "Возможности, предоставляемые {{ mes-name }}, зависят от редакции {{ ES }}."
---

# Редакции {{ ES }}

{% include [Elasticsearch-end-of-service](../../_includes/mdb/mes/note-end-of-service.md) %}

{% note info %}

С 13 июня 2022 года прекращена поддержка редакции `Gold` в кластерах {{ mes-name }}. Создать новый кластер с этой редакцией или перейти на нее с `Basic` или `Platinum` невозможно. 6 июля 2022 года редакция всех кластеров `Gold` была автоматически повышена до `Platinum`.

{% endnote %}

Возможности, предоставляемые {{ mes-name }}, зависят от редакции {{ ES }}:

| Название | Описание | `Basic` | `Gold` | `Platinum` |
|----------|----------| :-----: | :----: | :--------: |
| Поиск и визуализация | Базовые инструменты Elasticsearch и Kibana по поиску и визуализации | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| Управление данными и поставкой | Управление поставкой из Kibana и [жизненным циклом индексов](https://www.elastic.co/guide/en/elasticsearch/reference/current/index-lifecycle-management.html) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| Безопасность и шифрование | Поддержка encryption-in-transit, внутрикластерного шифрования, ролевой модели доступа (RBAC) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| Аудит | Возможность рестроспективно проследить действия, произведенные с кластером и данными на нем | ![no](../../_assets/common/no.svg)   | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| Дополнительные инструменты визуализации | Возможности, упрощающие просмотр и работу с информацией. Например, динамическая генерация ссылок в зависимости от данных, экспорт в PDF | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| Расширенный мониторинг и оповещения | Возможность настройки оповещений в Jira, Slack, email для мониторинга | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| Расширенная поддержка работы с геоданными | Агрегация по геопризнакам | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| Графовая аналитика | Возможность анализировать взаимосвязи элементов в индексах | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) |
| Машинное обучение | Функции машинного обучения: обнаружение аномалий, регрессия, классификация | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) |
| Расширенное управление доступом | Интеграция со сторонними провайдерами аутентификации и авторизации (SAML). Возможность гранулярной настройки уровней доступа к данным | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) |


Вы можете [изменить редакцию {{ ES }}](../operations/cluster-version-update.md#start-edition-update) после создания кластера. Прежде чем понижать используемую редакцию, убедитесь, что сокращение функциональных возможностей не нарушит работу ваших приложений.
