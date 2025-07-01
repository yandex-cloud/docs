# Остановка и запуск инстанса {{ GL }}

При необходимости вы можете остановить [инстанс {{ GL }}](../../concepts/index.md#instance) и запустить его заново. При остановке инстанса все данные в нем сохранятся.

Время простоя остановленного инстанса не тарифицируется: вы продолжаете платить только за объем хранимых данных инстанса и объем резервных копий, которые хранятся в {{ objstorage-full-name }}, в соответствии с [тарифом](../../pricing.md#prices-storage).

## Остановить инстанс {#stop-instance}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-gitlab }}**.
  1. Найдите нужный инстанс в списке, нажмите на значок ![options](../../../_assets/console-icons/ellipsis.svg) и выберите пункт **{{ ui-key.yacloud.common.stop }}**.
  1. В открывшемся диалоге подтвердите остановку инстанса и нажмите кнопку **{{ ui-key.yacloud.common.stop }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Чтобы остановить инстанс {{ GL }}, выполните команду:

  ```bash
  {{ yc-mdb-gl }} instance stop <имя_или_идентификатор_инстанса>
  ```

  Идентификатор или имя инстанса можно [запросить](instance-list.md#list) со списком инстансов в каталоге.

  Результат:

  ```text
  done (20s)
  id: c17ab1ehdfag********
  folder_id: b1gmm82dtdb3********
  created_at: "2024-01-29T16:11:45.859Z"
  updated_at: "2025-06-25T20:38:41.325Z"
  name: inst-gitlab
  resource_preset_id: s2.micro
  disk_size: "32212254720"
  status: STOPPED
  admin_login: <логин_администратора>
  admin_email: <электронная_почта>
  domain: example.gitlab.yandexcloud.net
  subnet_id: e9bp8qmchqh2********
  backup_retain_period_days: "7"
  approval_rules_id: NONE
  gitlab_version: 17.11.4
  ```

  Подробнее о команде читайте в [справочнике CLI](../../cli-ref/instance/stop.md).

{% endlist %}

## Запустить инстанс {#start-instance}

Инстанс в статусе **Stopped** можно запустить заново.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-gitlab }}**.
  1. Найдите нужный остановленный инстанс в списке, нажмите на значок ![options](../../../_assets/console-icons/ellipsis.svg) и выберите пункт **{{ ui-key.yacloud.common.start }}**.
  1. В открывшемся диалоге подтвердите запуск инстанса нажатием на кнопку **{{ ui-key.yacloud.common.start }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Чтобы запустить инстанс {{ GL }}, выполните команду:

  ```bash
  {{ yc-mdb-gl }} instance start <имя_или_идентификатор_инстанса>
  ```

  Идентификатор или имя инстанса можно [запросить](instance-list.md#list) со списком инстансов в каталоге.

  Результат:

  ```text
  done (1m44s)
  id: c17ab1ehdfag********
  folder_id: b1gmm82dtdb3********
  created_at: "2024-01-29T16:11:45.859Z"
  updated_at: "2025-06-25T20:38:41.325Z"
  name: inst-gitlab
  resource_preset_id: s2.micro
  disk_size: "32212254720"
  status: RUNNING
  admin_login: <логин_администратора>
  admin_email: <электронная_почта>
  domain: example.gitlab.yandexcloud.net
  subnet_id: e9bp8qmchqh2********
  backup_retain_period_days: "7"
  approval_rules_id: NONE
  gitlab_version: 17.11.4
  ```

  Подробнее о команде читайте в [справочнике CLI](../../cli-ref/instance/start.md).

{% endlist %}