# Параметры эндпоинта-приемника {{ MY }}

При [создании](../index.md#create) или [изменении](../index.md#update) эндпоинта вы можете задать:

* Настройки подключения к [кластеру {{ mmy-full-name }}](#managed-service) или [пользовательской инсталляции](#on-premise), в т. ч. на базе виртуальных машин {{ compute-full-name }}. Эти параметры обязательные.
* [Дополнительные параметры](#additional-settings).

## Кластер {{ mmy-name }} {#managed-service}

Подключение к БД с указанием идентификатора кластера в {{ yandex-cloud }}. Доступно только для кластеров, развернутых в сервисе [{{ mmy-full-name }}](../../../../managed-mysql/).

{% list tabs %}

- Консоль управления

    {% include [Managed MySQL UI](../../../../_includes/data-transfer/necessary-settings/ui/managed-mysql-target.md) %}

- CLI

    * Тип эндпоинта — `mysql-target`.

    {% include [Managed MySQL CLI](../../../../_includes/data-transfer/necessary-settings/cli/managed-mysql-target.md) %}

- Terraform

    * Тип эндпоинта — `mysql_target`.

    {% include [Managed MySQL Terraform](../../../../_includes/data-transfer/necessary-settings/terraform/managed-mysql-target.md) %}

    Пример структуры конфигурационного файла:

    ```hcl
    resource "yandex_datatransfer_endpoint" "<имя эндпоинта в {{ TF }}>" {
      name = "<имя эндпоинта>"
      settings {
        mysql_target {
          connection {
            mdb_cluster_id = "<идентификатор кластера {{ mmy-name }}>"
          }
          database = "<имя переносимой базы данных>"
          user     = "<имя пользователя для подключения>"
          password {
            raw = "<пароль пользователя>"
          }
          <дополнительные настройки эндпоинта>
        }
      }
    }
    ```

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-dt-endpoint }}).

- API

    {% include [Managed MySQL API](../../../../_includes/data-transfer/necessary-settings/api/managed-mysql-target.md) %}

{% endlist %}

## Пользовательская инсталляция {#on-premise}

Для случая OnPremise все поля заполняются вручную.

{% list tabs %}

- Консоль управления

    {% include [On premise MySQL UI](../../../../_includes/data-transfer/necessary-settings/ui/on-premise-mysql-target.md) %}

- CLI

    * Тип эндпоинта — `mysql-target`.

    {% include [On premise MySQL CLI](../../../../_includes/data-transfer/necessary-settings/cli/on-premise-mysql-target.md) %}

- Terraform

    * Тип эндпоинта — `mysql_target`.

    {% include [On premise MySQL CLI](../../../../_includes/data-transfer/necessary-settings/terraform/on-premise-mysql-target.md) %}

    Пример структуры конфигурационного файла:

    ```hcl
    resource "yandex_datatransfer_endpoint" "<имя эндпоинта в {{ TF }}>" {
      name = "<имя эндпоинта>"
      settings {
        mysql_target {
          connection {
            on_premise {
              hosts = ["<список хостов>"]
              port  = <порт для подключения>
            }
          }
          database = "<имя переносимой базы данных>"
          user     = "<имя пользователя для подключения>"
          password {
            raw = "<пароль пользователя>"
          }
          <дополнительные настройки эндпоинта>
        }
      }
    }
    ```

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-dt-endpoint }}).

- API

    {% include [On premise MySQL API](../../../../_includes/data-transfer/necessary-settings/api/on-premise-mysql-target.md) %}

{% endlist %}

## Дополнительные настройки {#additional-settings}

{% note warning %}

Настройки **Политика очистки** и **Схема БД для служебных таблиц** можно задать только через Консоль управления.

{% endnote %}

{% list tabs %}

- Консоль управления

    * **Режим sql_mode** — укажите настройки, переопределяющие [стандартное поведение {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/sql-mode.html).

    * **Отключение проверки констрейтов** — используется для ускорения репликации: настройки `FOREIGN_KEY_CHECKS` и `UNIQUE_CHECKS` устанавливаются в значение `0` (проверки не производятся).

        {% include [Note turn-off-mysql-constraints](../../../../_includes/data-transfer/notes/mysql-turn-off-constraints.md) %}

    * **Часовой пояс базы** — укажите идентификатор [IANA Time Zone Database](https://www.iana.org/time-zones). По умолчанию используется UTC+0.

    * {% include [Field Cleanup Policy Disabled/Drop/Truncate](../../../../_includes/data-transfer/fields/common/ui/cleanup-policy-disabled-drop-truncate.md) %}

    * **Схема БД для служебных таблиц** — укажите имя схемы, в которой будут созданы служебные таблицы, необходимые для обеспечения работы трансфера.

- CLI

    * `--sql-mode` — укажите настройки, переопределяющие [стандартное поведение {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/sql-mode.html)

    * `--skip-constraint-checks` — используется для ускорения репликации: настройки `FOREIGN_KEY_CHECKS` и `UNIQUE_CHECKS` устанавливаются в значение `0` (проверки не производятся).

        {% include [Note turn-off-mysql-constraints](../../../../_includes/data-transfer/notes/mysql-turn-off-constraints.md) %}

    * `--timezone` — укажите идентификатор [IANA Time Zone Database](https://www.iana.org/time-zones). По умолчанию используется UTC+0.

- Terraform

    * `sql_mode` — укажите настройки, переопределяющие [стандартное поведение {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/sql-mode.html). По умолчанию используется список `NO_AUTO_VALUE_ON_ZERO,NO_DIR_IN_CREATE,NO_ENGINE_SUBSTITUTION`.

    * `skip_constraint_checks` — используется для ускорения репликации: настройки `FOREIGN_KEY_CHECKS` и `UNIQUE_CHECKS` устанавливаются в значение `0` (проверки не производятся).

        {% include [Note turn-off-mysql-constraints](../../../../_includes/data-transfer/notes/mysql-turn-off-constraints.md) %}

    * `timezone` — укажите идентификатор [IANA Time Zone Database](https://www.iana.org/time-zones). По умолчанию используется UTC+0.

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-dt-endpoint }}).

- API

    * `sqlMode` — укажите настройки, переопределяющие [стандрартное поведение {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/sql-mode.html)

    * `skipConstraintChecks` — используется для ускорения репликации: настройки `FOREIGN_KEY_CHECKS` и `UNIQUE_CHECKS` устанавливаются в значение `0` (проверки не производятся).

        {% include [Note turn-off-mysql-constraints](../../../../_includes/data-transfer/notes/mysql-turn-off-constraints.md) %}

    * `timezone` — укажите идентификатор [IANA Time Zone Database](https://www.iana.org/time-zones). По умолчанию используется UTC+0.

{% endlist %}
