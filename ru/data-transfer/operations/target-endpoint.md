# Управление эндпоинтом-приемником

[Эндпоинт](../concepts/index.md#endpoint)-приемник описывает настройки базы данных, в которую будет производиться перенос информации с помощью {{ data-transfer-name }}. Вы можете [создать](#create-endpoint), [изменить](#update-endpoint) или [удалить](#delete-endpoint) такой эндпоинт.

## Создать эндпоинт {#create-endpoint}

{% list tabs %}

- Консоль управления

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ data-transfer-name}}**.
    1. На вкладке **Эндпоинты** нажмите кнопку **Создать эндпоинт**.
    1. В поле **Направление** выберите **Приемник**.
    1. Укажите имя эндпоинта. Используйте строчные латинские буквы и цифры.
    1. (Опционально) укажите описание эндпоинта.
    1. В поле **База данных** выберите тип СУБД, в которую вы хотите передавать данные.
    1. Задайте параметры эндпоинта:

        - [{#T}](#settings-mysql).
        - [{#T}](#settings-postgresql).

    1. Нажмите кнопку **Создать**.

{% endlist %}

## Изменить эндпоинт {#update-endpoint}

{% list tabs %}

- Консоль управления

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ data-transfer-name }}**.
    1. На вкладке **Эндпоинты** выберите эндпоинт и нажмите кнопку ![pencil](../../_assets/pencil.svg) **Редактировать** на панели сверху.
    1. Отредактируйте параметры эндпоинта:

        - [{#T}](#settings-mysql).
        - [{#T}](#settings-postgresql).

    1. Нажмите кнопку **Применить**.

{% endlist %}

## Удалить эндпоинт {#delete-endpoint}

{% include [delete-endpoint](../../_includes/delete-endpoint.md) %}

## Параметры эндпоинтов {#endpoint-settings}

### {{ MY }} {#settings-mysql}

* **Настройки подключения** — выбор типа подключения к БД:

   {% include  [mysql-connection-necessary-settings.md](../../_includes/data-transfer/mysql-connection-necessary-settings.md) %}
   
* Дополнительные настройки:

   * [Режим sql_mode](https://dev.mysql.com/doc/refman/8.0/en/sql-mode.html).
   
   * Отключение проверки внешних ключей на приемнике. Используются настройки `FOREIGN_KEY_CHECKS=0` и `UNIQUE_CHECKS=0`.
     
     {% note warning %}
     
     Отключение проверки внешних ключей (`FOREIGN_KEY_CHECKS=0`) ускорит репликацию, но может привести к нарушению целостности данных при использовании каскадных операций.
     
     {% endnote %}   
   
   * **Часовой пояс базы**, указывается как идентификатор [IANA Time Zone Database](https://www.iana.org/time-zones). По умолчанию используется UTC+0.

### {{ PG }} {#settings-postgresql}

**Настройки подключения** — выбор типа подключения к БД:

   {% include  [pg-connection-necessary-settings.md](../../_includes/data-transfer/pg-connection-necessary-settings.md) %}
