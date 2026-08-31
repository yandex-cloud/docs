{% include [note-job-cancel](../../_includes/managed-spark/note-job-cancel.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. [Перейдите]({{ link-console-main }}/link/data-proc) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}**.
  1. Выберите нужный кластер и перейдите в раздел **{{ ui-key.yacloud.mdb.cluster.switch_jobs }}**.
  1. Нажмите на имя нужного задания.
  1. В правом верхнем углу страницы нажмите **{{ ui-key.yacloud.common.cancel }}**.
  1. В открывшемся окне выберите **{{ ui-key.yacloud.mdb.dialogs.popup_button_cancel }}**.

- CLI {#cli}

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  Чтобы отменить задание, выполните команду:

  ```bash
  {{ yc-dp }} job cancel <имя_или_идентификатор_задания> \
    --cluster-name=<имя_кластера>
  ```

  Идентификатор и имя задания можно получить со [списком заданий в кластере](#list), имя кластера — со [списком кластеров в каталоге](../../data-proc/operations/cluster-list.md#list).

- API {#api}

  Воспользуйтесь методом API [cancel](../../data-proc/api-ref/Job/cancel) и передайте в запросе:
  * Идентификатор кластера в параметре `clusterId`.
  * Идентификатор задания в параметре `jobId`.

  Идентификатор кластера можно получить со [списком кластеров в каталоге](../../data-proc/operations/cluster-list.md#list), идентификатор задания — со [списком заданий в кластере](#list).

{% endlist %}