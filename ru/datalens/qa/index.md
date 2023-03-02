---
title: "{{ datalens-full-name }}. Ответы на вопросы"
description: "Как получить логи моей работы в сервисе {{ datalens-full-name }}? Ответы на этот и другие вопросы в данной статье."
---

# Ответы на вопросы в {{ datalens-name }}

В данном разделе собраны ответы на вопросы пользователей, возникающие при работе с {{ datalens-short-name }}.

Разделы:

* [Права доступа](#permissions)
* [Подключения](#connections)
* [Датасеты](#datasets)
* [Чарты](#charts)
* [Вычисляемые поля](#calculation-fields)
* [Дашборды](#dashboards)
* [Другое](#other)

## Права доступа {#permissions}

### Как добавить пользователя и отправить ему ссылку на дашборд? {#how-add-user-send-ref}

Чтобы другой пользователь с учетной записью Яндекса мог открыть ваш дашборд, настройте доступ к {{ datalens-full-name }}:

1. Добавьте пользователя:

   {% list tabs %}

   - В организацию

     {% include [datalens-add-user-organization](../../_includes/datalens/operations/datalens-add-user-organization.md) %}

     После этого у пользователя появляется доступ к вашему экземпляру {{ datalens-full-name }}.

   - В облако

     1. Откройте страницу [Управление доступом]({{ link-console-access-management }}).
     1. В правом верхнем углу нажмите кнопку **Добавить пользователя**.
     1. Введите электронную почту пользователя в Яндексе и нажмите **Добавить**. Новый пользователь появится в списке пользователей.
     1. Нажмите значок ![image](../../_assets/datalens/horizontal-ellipsis.svg) напротив нового пользователя и выберите **Настроить роли**.
     1. В блоке **Роли в каталогах** выберите каталог. В столбце **Роли** нажмите значок ![image](../../_assets/plus-sign.svg). Назначьте роль `datalens.instances.user`.

     После этого у пользователя появляется доступ к вашему экземпляру {{ datalens-full-name }}.

   {% endlist %}

1. Убедитесь, что у пользователя есть права доступа на дашборд:

   1. Откройте дашборд.
   1. В поле **Добавить участника** введите Все или имя пользователя, которому нужны расширенные доступы.
   1. Перейдите к блоку **Текущий объект** и установите права доступа для дашборда:

      * просмотр — доступен только просмотр;
      * редактирование — доступны просмотр и редактирование;
      * администрирование — доступны просмотр, редактирование и управление.

   1. Включите опцию **Связанные объекты**, чтобы предоставить права на другие связанные с дашбордом объекты (подключение, датасеты и чарты).

Пользователь получит доступ к вашему {{ datalens-short-name }} и объектам с правами доступа **Все**. Вы сможете назначить этому пользователю отдельные права на объекты.

Ссылку на дашборд при этом можно будет отправлять из браузера. Подробнее про права доступа на объекты {{ datalens-short-name }} см. в [документации]{% if lang == "ru" %}(https://cloud.yandex.ru/docs/datalens/security/#permissions){% endif %}{% if lang == "en" %}(https://cloud.yandex.com/en-ru/docs/datalens/security/#permissions){% endif %}.

Также вы можете сделать свой дашборд публичным с помощью [{#T}](../concepts/datalens-public.md).

{% include [permission-error](../../_qa/datalens/permission-error.md) %}

{% include [copy-into-folder](../../_qa/datalens/copy-into-folder.md) %}

{% include [revoke-token.md](../../_qa/datalens/revoke-token.md) %}

## Подключения {#connections}

{% include [postgre-type.md](../../_qa/datalens/postgre-type.md) %}

{% include [metrica-clickhouse-connection](../../_qa/datalens/metrica-clickhouse-connection.md) %}

{% include [uploading-data-logs-api.md](../../_qa/datalens/uploading-data-logs-api.md) %}

{% include [csv-rows-display](../../_qa/datalens/csv-rows-display.md) %}

{% include [csv-long-loading](../../_qa/datalens/csv-long-loading.md) %}

{% include [csv-network-error](../../_qa/datalens/csv-network-error.md) %}

### Что делать, если таблица из Google Sheets работает некорректно? {#google-sheets-error}

{% include [google-sheets-error](../../_qa/datalens/google-sheets-error.md) %}

## Датасеты {#datasets}

{% include [incorrectly-identified-date-field](../../_qa/datalens/incorrectly-identified-date-field.md) %}

{% include [how-to-link-two-tables](../../_qa/datalens/linking-two-tables.md) %}

{% include [add-line-numeration](../../_qa/datalens/add-line-numeration.md) %}

{% include [unix-time](../../_qa/datalens/unix-time.md) %}

{% include [add-sql](../../_qa/datalens/add-sql.md) %}

{% include [make-geocode](../../_qa/datalens/make-geocode.md) %}

{% include [get-geo](../../_qa/datalens/get-geo.md) %}

{% include [qa-materialization-error](../../_qa/datalens/where-is-materialization.md) %}

## Чарты {#charts}

{% include [show-top-100-values](../../_qa/datalens/show-top-100-values.md) %}

{% include [create-labels-in-pie-chart](../../_qa/datalens/create-labels-in-pie-chart.md) %}

{% include [hide-legend-in-chart](../../_qa/datalens/hide-legend-in-chart.md) %}

{% include [add-two-indicators](../../_qa/datalens/add-two-indicators.md) %}

{% include [add-columns-signatures](../../_qa/datalens/add-columns-signatures.md) %}

{% include [create-grouped-column-chart](../../_qa/datalens/create-grouped-column-chart.md) %}

{% include [add-column-grouped](../../_qa/datalens/add-column-grouped.md) %}

{% include [number-of-indicators-in-color-section](../../_qa/datalens/number-of-indicators-in-color-section.md) %}

{% include [creating-line-chart-with-columns](../../_qa/datalens/creating-line-chart-with-columns.md) %}

{% include [pie-chart-note](../../_qa/datalens/pie-chart-note.md) %}

{% include [making-logarithmic-scale](../../_qa/datalens/making-logarithmic-scale.md) %}

{% include [sign-last-point](../../_qa/datalens/sign-last-point.md) %}

{% include [sign-multiple-lines](../../_qa/datalens/sign-multiple-lines.md) %}

{% include [resize-column](../../_qa/datalens/resize-column.md) %}

{% include [rename-column](../../_qa/datalens/rename-column.md) %}

{% include [null-setting-in-charts](../../_qa/datalens/null-setting-in-charts.md) %}

## Вычисляемые поля {#calculation-fields}

{% include [calculate-cumulative-sum](../../_qa/datalens/calculating-cumulative-sum.md) %}

{% include [calculate-ifnull-zn-nan](../../_qa/datalens/calculating-ifnull-zn-nan.md) %}

## Дашборды {#dashboards}

{% include [configure-link-between-selectors](../../_qa/datalens/configure-link-between-selectors.md) %}

{% include [unavailable-selector-values](../../_qa/datalens/unavailable-selector-values.md) %}

{% include [apply-filter-to-two-datasets](../../_qa/datalens/apply-filter-to-two-datasets.md) %}

{% include [configure-selectors](../../_qa/datalens/configure-selectors.md) %}

{% include [making-available-chart](../../_qa/datalens/making-available-chart.md) %}

### Как сделать публичным дашборд, содержащий данные Метрики или AppMetrica? {#how-metrica-appmetrica-share}

Опубликовать такой дашборд нельзя.

Чтобы поделиться дашбордом, содержащим данные Метрики или AppMetrica, воспользуйтесь одним из способов:

{% include [datalens-metrica-appmetrica-share](../../_includes/datalens/datalens-metrica-appmetrica-share.md) %}

## Другое {#other}

### Я могу получить логи моей работы в сервисах? {#logs}

Да, вы можете запросить записи о том, что происходило с вашими ресурсами, из логов сервисов {{ yandex-cloud }}. Подробнее читайте в разделе [{#T}](../../support/request.md).

{% include [copy-folder](../../_qa/datalens/copy-folder.md) %}

### Можно ли установить {{ datalens-short-name }} внутри компании? {#datalens-local}

{{ datalens-short-name }} представлен только в виде облачного сервиса. Также хотим отметить:

* {{ datalens-short-name }} — это сервис {{ yandex-cloud }}, который соответствует ФЗ-152 и индустриальным стандартам безопасности. Подробнее в разделе [Безопасность {{ yandex-cloud }}](/security).

* Для {{ datalens-short-name }} можно [настроить федерацию учетных записей](../../organization/quick-start.md).

### Почему заблокировано облако с экземпляром {{ datalens-short-name }}? {#datalens-suspended}

Ваше облако может быть заблокировано в следующих случаях:

* Наличие задолженности за использование платных сервисов {{ yandex-cloud }}, которые находятся в том же облаке, что и {{ datalens-short-name }}.
* Пробный период за использование платных сервисов {{ yandex-cloud }} завершен.
* При нарушении [условий использования]{% if lang == "ru" %}(https://yandex.ru/legal/cloud_termsofuse/?lang=ru){% endif %}{% if lang == "en" %}(https://yandex.ru/legal/cloud_termsofuse/?lang=en){% endif %} {{ yandex-cloud }}.

После блокировки облака ваш экземпляр {{ datalens-short-name }} будет недоступен. Работа с {{ datalens-short-name }} будет невозможна до восстановления облака.

Подробнее о блокировке можно прочитать в разделе [Автоматическая блокировка облака](../../overview/concepts/data-deletion.md#block).

{% include [object-id](../../_qa/datalens/object-id.md) %}

{% include [network-error](../../_qa/datalens/network-error.md) %}

## Как сообщить о проблеме {#how-to-resolve-problem}

Сообщить о проблеме можно двумя способами:

* Через интерфейс {{ datalens-full-name }}. В интерфейсе {{ datalens-full-name }} рядом с кодом ошибки нажмите кнопку **Сообщить о проблеме**, добавьте в описание всю необходимую информацию о проблеме. Автоматически будет создан запрос в техническую поддержку {{ yandex-cloud }}.
* Через прямое обращение в [техническую поддержку]({{ link-console-support }}) {{ yandex-cloud }}.

При обращении желательно предоставить:

* Максимально точное описание проблемы и порядок ваших действий.
* Изображения, GIF или видео.

{% if lang == "ru" %}Предложения и пожелания по работе сервиса можно оставлять в [сообществе пользователей {{ yandex-cloud }}](/features?serviceId=23).{% endif %}

Чтобы следить за новостями и обсуждать лучшие практики использования сервиса, присоединяйтесь к сообществу [DataLens](https://t.me/YandexDataLens) в Telegram.
