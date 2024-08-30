# Публичный доступ

Вы можете предоставить публичный доступ к созданным чартам и дашбордам: любой пользователь сможет пройти по ссылке и посмотреть опубликованный объект без авторизации. При этом пользователь не может посмотреть настройки чарта, подключения, датасет или выполнить произвольный SQL-запрос.

{% include [share-note](../../_includes/datalens/datalens-share-note.md) %}

## Правила публикации {#rules}

Перед публикацией данных убедитесь, что:

* У вас есть право доступа `{{ permission-admin }}` на публикуемые чарты, дашборды и связанные с ними объекты.
* Ваши чарты и дашборды не содержат персональных данных или коммерческой тайны. Доступ к опубликованным данным неограничен.
* Подключение, поверх которого построены объекты, поддерживает публикацию данных. Нельзя публиковать данные из следующих подключений:

  * [Google BigQuery](../operations/connection/create-big-query.md)
  * [Snowflake](../operations/connection/create-snowflake.md)
  * [Metrica](../operations/connection/create-metrica-api.md)
  * [AppMetrica](../operations/connection/create-appmetrica.md)

    {% note info %}

    Дашбордом или чартом на основе данных Метрики или AppMetrica можно [поделиться](#metrica-share).

    {% endnote %}

Чтобы обезопасить опубликованные данные, рекомендуем:

* При создании подключения к БД предоставлять пользователю право просмотра только на таблицы, которые используются для построения датасета.
* Оставлять в датасете минимум данных и добавлять только необходимые фильтры на дашборд. Данные на публичном дашборде можно скачать в машиночитаемом формате.

## Опубликовать объект {#how-to-publish}

{% list tabs group=datalens_public %}

- Публикация дашборда {#dashboard}

  {% include [datalens-public-dashboard](../../_includes/datalens/operations/datalens-public-dashboard.md) %}

- Публикация чарта {#chart}

  {% include [datalens-public-chart](../../_includes/datalens/operations/datalens-public-chart.md) %}

{% endlist %}

## Посмотреть опубликованные объекты {#public-objects-list}

[Администратор](../security/roles.md#datalens-admin) экземпляра {{ datalens-short-name }} может посмотреть список всех опубликованных в нем объектов:

1. Перейдите на [главную страницу]({{ link-datalens-main }}) {{ datalens-short-name }}.
1. На панели слева выберите ![sliders](../../_assets/console-icons/sliders.svg) **Настройки сервиса**.
1. В разделе **Возможность публикации** нажмите кнопку **Посмотреть опубликованное**.

## Поделиться чартом на основе данных Метрики или AppMetrica {#metrica-share}

Чтобы поделиться чартом или дашбордом, содержащим данные Метрики или AppMetrica, воспользуйтесь одним из способов:

{% include [datalens-metrica-appmetrica-share](../../_includes/datalens/datalens-metrica-appmetrica-share.md) %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}

## Отключить возможность публикации {#publication-disable}

{% include [business-note](../../_includes/datalens/datalens-functionality-available-business-note.md) %}

По умолчанию пользователи могут публиковать чарты и дашборды, на которые у них есть права администратора. Эту возможность можно отключить на уровне экземпляра {{ datalens-short-name }}. После запрета публикации:

* все ранее опубликованные объекты пропадут из публичного доступа;
* пользователи не смогут предоставлять публичный доступ к объектам.

Отключить возможность публикации может только [администратор](../security/roles.md#datalens-admin) экземпляра {{ datalens-short-name }} (роль `{{ roles-datalens-admin }}`).

Чтобы запретить публикацию объектов:

1. Перейдите на [главную страницу]({{ link-datalens-main }}) {{ datalens-short-name }}.
1. На панели слева выберите ![sliders](../../_assets/console-icons/sliders.svg) **Настройки сервиса**.
1. В разделе **Возможность публикации**:

   1. Посмотрите список опубликованных объектов, которые пропадут из публичного доступа. Для этого нажмите кнопку **Посмотреть опубликованное**.
   1. Отключите опцию **Возможность публикации**.

#### См. также: {#see-also}

* [{#T}](../security/embedded-objects.md).
