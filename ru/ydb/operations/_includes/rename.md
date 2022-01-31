---
sourcePath: ru/ydb/overlay/operations/_includes/rename.md
---
# Переименование таблицы

{{ ydb-short-name }} позволяет переименовать существующую таблицу, переместить ее в другую директорию этой же базы данных, а так же заменить одну таблицу другой, при этом данные заменяемой таблицы будут удалены. При выполнении операций изменяются только метаданные таблицы, например ее путь и имя. Данные таблицы не переносятся и не перезаписываются.

Операции выполняются изолированно, внешний процесс видит только два состояния таблицы: до и после выполнения операции. Это важно, например, при замене таблицы — данные заменяемой таблицы удаляются в той же транзакции, в которой заменяющая таблица переименовывается. Во время выполнения операции замены возможны ошибки запросов к заменяемой таблице с [retryable-статусами](../../reference/ydb-sdk/error_handling.md#termination-statuses).

Чтобы выполнить переименование нескольких таблиц, используйте соответствующие методы SDK или команду [rename](../../reference/ydb-cli/commands/tools/rename.md) {{ ydb-short-name }} CLI. Все действия, которые описаны в одной операции переименования, будут выполнены в одной транзакции.

Скорость выполнения переименования определяется типом дата-транзакций, которые выполняются в данный момент на таблице, и не зависит от количества данных в таблице.

## Примеры использования {#use-cases}

Примеры выполняются на базе данных со следующей схемой:

```text
db ─┐ 
    ├─ cinema ───────────┐
    ├─ logs ─────────────┐
    |                    ├─ blank_logs
    |                    └─ current_logs
    ├─ new-project ──────┐
    |                    ├─ main_table
    |                    ├─ second_table
    |                    └─ third_table
    ├─ pre-prod-project ─┐
    |                    ├─ main_table
    |                    └─ other_table
    └─ prod-project ─────┐
                         ├─ main_table
                         └─ other_table
```

### Переименовать таблицы {#change-the-name}

{% list tabs %}

- CLI

  Чтобы переименовать таблицы `main_table`, `second_table`, `third_table` в `episodes`, `seasons` и `series` соответственно, выполните команды:

  ```bash
  {{ ydb-cli }} tools rename \
    --item source=new-project/main_table,destination=new-project/episodes

  {{ ydb-cli }} tools rename \
    --item source=new-project/second_table,destination=new-project/seasons

  {{ ydb-cli }} tools rename \
    --item source=new-project/third_table,destination=new-project/series
  ```

  Таблицы будут переименованы последовательно в разных транзакциях. Чтобы сделать переименование в одной транзакции, выполните команду:

  ```bash
  {{ ydb-cli }} tools rename \
    --item source=new-project/main_table,destination=new-project/episodes \
    --item source=new-project/second_table,destination=new-project/seasons \
    --item source=new-project/third_table,destination=new-project/series
  ```

  Все таблицы будут переименованы в одной транзакции. Внешний процесс увидит только два состояния: до и после переименования.

- YQL

  Чтобы переименовать таблицы `main_table`, `second_table`, `third_table` в `episodes`, `seasons` и `series` соответственно, выполните запрос:

  ```sql
  ALTER TABLE `new-project/main_table` RENAME TO `new-project/episodes`;
  ALTER TABLE `new-project/second_table` RENAME TO `new-project/seasons`;
  ALTER TABLE `new-project/third_table` RENAME TO `new-project/series`;
  ```

  Запрос будет выполнен в режиме автокоммита каждого утверждения — каждая таблица будет переименована в отдельной транзакции. С точки зрения внешнего процесса, таблицы будут переименованы последовательно одна за другой.

  Чтобы переименовать несколько таблиц в одной транзакции, используйте способы вызова метода, которые обеспечивают транзакционное выполнение, например команду [rename](../../reference/ydb-cli/commands/tools/rename.md) {{ ydb-short-name }} CLI.

{% endlist %}

### Переместить таблицу {#move}

{% list tabs %}

- CLI

  Чтобы переименовать таблицы и переместить их в директорию `cinema`, выполните команды:

  ```bash
  {{ ydb-cli }} tools rename \
    --item source=new-project/main_table,destination=cinema/episodes
                  
  {{ ydb-cli }} tools rename \
    --item source=new-project/second_table,destination=cinema/seasons
                  
  {{ ydb-cli }} tools rename \
    --item source=new-project/third_table,destination=cinema/series
  ```

  Таблицы будут переименованы и перемещены последовательно в разных транзакциях. Чтобы выполнить переименование и перемещение нескольких таблиц в одной транзакции, выполните команду:

  ```bash
  {{ ydb-cli }} tools rename \
    --item source=new-project/main_table,destination=cinema/episodes \
    --item source=new-project/second_table,destination=cinema/seasons \
    --item source=new-project/third_table,destination=cinema/series
  ```

  Все таблицы будут переименованы и перемещены в одной транзакции. Внешний процесс увидит только два состояния: до и после переименования и перемещения всех таблиц.

- YQL

  Чтобы переименовать таблицы и переместить их в директорию `cinema`, выполните запрос:

  ```sql
  ALTER TABLE `new-project/main_table` RENAME TO `cinema/episodes`;
  ALTER TABLE `new-project/second_table` RENAME TO `cinema/seasons`;
  ALTER TABLE `new-project/third_table` RENAME TO `cinema/series`;
  ```

  Запрос будет выполнен в режиме автокоммита каждого утверждения — каждая таблица будет переименована и перемещена в отдельной транзакции. С точки зрения внешнего процесса, таблицы будут переименованы и перемещены последовательно одна за другой.

  Чтобы переименовать и перенести несколько таблиц в одной транзакции, используйте способы вызова метода, которые обеспечивают транзакционное выполнение, например команду [rename](../../reference/ydb-cli/commands/tools/rename.md) {{ ydb-short-name }} CLI.

{% endlist %}

### Заменить таблицу {#replace}

Замена может быть полезна, если проще подготовить новую таблицу с нужными данными, чем удалить лишнее из существующей.

{% note warning %}

При замене {{ ydb-short-name }} не проверяет идентичность схем у заменяемой и заменяющей таблиц.

Ваши запросы к заменяемой таблице будут перекомпилированы после завершения замены. Запросы не смогу быть выполнены, если схема заменяемой таблицы не совместима с заменяющей.

{% endnote %}

{% list tabs %}

- CLI

  Чтобы заменить таблицу, выполните команду:

  ```bash
  {{ ydb-cli }} tools rename \
    --item replace=True,Source=pre-prod-project/main_table,destination=prod-project/main_table
  ```

  Для замены таблицы необходимо указать параметр `replace=True`.

  Если нужно оставить заменяемую таблицу как резервную копию данных, выполните команду:

  ```bash
  {{ ydb-cli }} tools rename \
    --item source=prod-project/main_table,destination=prod-project/main_table.backup \
    --item source=pre-prod-project/main_table,destination=prod-project/main_table 
  ```

  Параметр `replace=True` не используется, потому что ни одна таблица не должна быть удалена. Операции выполняются в порядке указания аргументов `--item` в команде: сначала `prod-project/main_table` будет перемещена в `prod-project/main_table.backup`, затем `pre-prod-project/main_table` будет переименована в `prod-project/main_table`. Все операции будут выполнены в одной транзакции.

  Чтобы заменить несколько таблиц, выполните команду:

  ```bash
  {{ ydb-cli }} tools rename \
    --item source=prod-project/main_table,destination=prod-project/main_table.backup \
    --item source=pre-prod-project/main_table,destination=prod-project/main_table \
    --item source=prod-project/other_table,destination=prod-project/other_table.backup \
    --item source=pre-prod-project/other_table,destination=prod-project/other_table 
  ```

- YQL

  Чтобы заменить таблицу, выполните запрос:

  ```sql
  DROP TABLE `prod-project/main_table`;
  ALTER TABLE `pre-prod-project/main_table` RENAME TO `prod-project/main_table`;
  ```

  Запрос будет выполнен в режиме автокоммита каждого утверждения — сначала удалятся заменяемая таблица, затем перемещается и переименовывается замещающая. С точки зрения внешнего процесса, таблица будет удалена, а затем появится вновь.

  Чтобы заменить таблицу в одной транзакции, используйте способы вызова метода, которые обеспечивают транзакционное выполнение, например команду [rename](../../reference/ydb-cli/commands/tools/rename.md) {{ ydb-short-name }} CLI.

{% endlist %}

### Ротировать таблицы вне пользовательского приложения {#rotation}

Пользовательское приложение сохраняет данные в таблицу `logs/current_logs`. Необходимо выполнить ротацию данных в этой таблице. Ротация должна быть реализована внешними по отношению к приложению средствами.

Перед выполнением ротации необходимо подготовить пустую таблицу `logs/blank_logs` со схемой, идентичной схеме таблицы `logs/current_logs`.

{% list tabs %}

- CLI

  Чтобы ротировать данные, выполните команду:

  ```bash
  {{ ydb-cli }} tools rename \
    --item source=logs/current_logs,destination=logs/old_logs \
    --item source=logs/blank_logs,destination=logs/current_logs 
  ```

{% endlist %}

Данные, которые до операции были доступны в таблице `logs/current_logs`, теперь теперь находятся в `logs/old_logs`. Таблица `logs/current_logs` пуста потому, что по этому пути была перемещена таблица `logs/blank`. Чтобы повторить ротацию, необходимо создать заново таблицу`logs/blank`.
