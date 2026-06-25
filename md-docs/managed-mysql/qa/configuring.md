# Настройки параметров MySQL®

* [Как задать часовой пояс (time zone)?](#time-zone)

* [Как установить режим SQL (sql_mode)?](#sql-mode)

* [Какое значение установить для innodb_buffer_pool_size?](#innodb-buffer-pool-size)

* [Как отключить строгий режим Innodb?](#innodb-strict-mode)

* [Как изменить набор символов и правила их сравнения (CHARACTER SET, COLLATE)?](#character-collate)

* [Как настроить другие параметры?](#params)

#### Как задать часовой пояс (time zone)? {#time-zone}

Часовой пояс задается в виде смещения от UTC. Например, для Москвы: `'+03:00'`. Названия часовых поясов не поддерживаются.

Подробнее в [документации MySQL®](https://dev.mysql.com/doc/refman/5.7/en/time-zone-support.html#time-zone-variables).

#### Как установить режим SQL (sql_mode)? {#sql-mode}

Воспользуйтесь инструкцией в разделе [Управление базами данных](../operations/databases.md#sql-mode).

#### Какое значение установить для innodb_buffer_pool_size? {#innodb-buffer-pool-size}

Рекомендуемые границы для параметра:
* Минимум — 25% от объема RAM на хосте.
* Максимум — 75% от объема RAM на хосте при условии, что остается не менее 1–1,6 ГБ свободной памяти для выполнения запросов, мониторинга и системных процессов.

#### Как отключить строгий режим Innodb? {#innodb-strict-mode}

По умолчанию [строгий режим Innodb](../concepts/settings-list.md#setting-strict-mode) включен. Если отключать режим средствами MySQL®, возникнет ошибка:

```text
Mysql query error: (1227) Access denied; you need (at least one of) the SYSTEM_VARIABLES_ADMIN or SESSION_VARIABLES_ADMIN privilege(s) for this operation (400)
```

Чтобы отключить строгий режим, измените значение параметра `innodb_strict_mode` с помощью [интерфейсов Yandex Cloud](../operations/update.md#change-mysql-config). Также убедитесь, что в вашей конфигурации не осталось команды, отключающей строгий режим, например `$connection–>queryExecute("SET innodb_strict_mode=0");`.

#### Как изменить набор символов и правила их сравнения (CHARACTER SET, COLLATE)? {#character-collate}

Воспользуйтесь инструкцией в разделе [Управление базами данных](../operations/databases.md#charset-collate).

#### Как настроить другие параметры? {#params}

Настройки MySQL®, доступные для изменения, перечислены в [документации](../concepts/settings-list.md). Изменить их значения можно в одном из доступных интерфейсов: консоль управления, CLI, API или Terraform. Для этого воспользуйтесь инструкцией в разделе [Изменение кластера](../operations/update.md#change-mysql-config).