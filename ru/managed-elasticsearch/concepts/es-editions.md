# Редакции Elasticsearch

Возможности, предоставляемые в {{ mes-name }}, зависят от редакции {{ ES }}:

| Название                                  | `BASIC`                              | `GOLD`                               | `PLATINUM`                           |
|-------------------------------------------| :----------------------------------: | :----------------------------------: | :----------------------------------: |
| Поиск и визуализация                      | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| Безопасность и шифрование                 | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| Аудит                                     | ![no](../../_assets/common/no.svg)   | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| Дополнительные инструменты визуализации   | ![no](../../_assets/common/no.svg)   | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| Расширенный мониторинг                    | ![no](../../_assets/common/no.svg)   | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| Расширенная поддержка работы с геоданными | ![no](../../_assets/common/no.svg)   | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| Аналитика по графам                       | ![no](../../_assets/common/no.svg)   | ![no](../../_assets/common/no.svg)   | ![yes](../../_assets/common/yes.svg) |
| Машинное обучение                         | ![no](../../_assets/common/no.svg)   | ![no](../../_assets/common/no.svg)   | ![yes](../../_assets/common/yes.svg) |
| Расширенное управление доступом           | ![no](../../_assets/common/no.svg)   | ![no](../../_assets/common/no.svg)   | ![yes](../../_assets/common/yes.svg) |

{% if audience == "draft" %}

Сервис {{ mes-name }} поддерживает следующие редакции {{ ES }}:

- `BASIC`

    В этой редакции:

    - предоставляются минимальные настройки для обеспечения безопасности (аутентификация, авторизация и учет);
    - обеспечиваются базовые возможности мониторинга.

- `GOLD`

    В этой редакции, помимо всех возможностей `BASIC`:

    - предоставляются расширенные настройки для обеспечения безопасности (вход с помощью Single Sign-On, контроль доступа на уровне атрибутов и другие возможности);
    - поддерживается Elasticsearch Token Service;
    - есть возможность экспорта отчетов в PDF и PNG.

- `PLATINUM`

    В этой редакции, помимо всех возможностей `GOLD`:

    - доступны все возможности для обеспечения безопасности {{ ES }};
    - поддерживаются клиенты JDBC, ODBC, Tableau Connector;
    - поддерживается интеграция с IBM Resillent и ServiceNow ITSM;
    - доступна кросс-кластерная репликация;
    - доступна интеграция с технологиями машинного обучения;
    - возможно подключение приватных источников контента.

{% endif %}
