{% note info %}

Задания в статусах `ERROR`, `DONE` или `CANCELLED` отменить нельзя. Чтобы узнать статус задания, получите [список заданий](#list) в кластере.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mdb.cluster.switch_jobs }}**.
  1. Нажмите на имя нужного задания.
  1. В правом верхнем углу страницы нажмите кнопку **{{ ui-key.yacloud.common.cancel }}**.
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