---
title: "Как подключиться к узлу кластера {{ k8s }} через {{ oslogin }} в {{ managed-k8s-full-name }}"
description: "Следуя данной инструкции, вы сможете подключиться к узлу через {{ oslogin }}."
---

# Подключение к узлу через {{ oslogin }}

[{{ oslogin }}](../../organization/concepts/os-login.md) используется вместо SSH-ключей для доступа к виртуальным машинам {{ yandex-cloud }} через SSH. С помощью {{ oslogin }} вы можете подключиться к узлам {{ managed-k8s-name }}.

{% include [node-vm-explained](../../_includes/managed-kubernetes/node-vm-explained.md) %}

{% include [node-vm-manipulation-warning](../../_includes/managed-kubernetes/node-vm-manipulation-warning.md) %}

[Настройте узел кластера](#configure-node), после чего подключитесь к нему одним из двух способов:

* [с помощью CLI](#connect-via-cli);
* [с помощью SSH](#connect-via-ssh).

## Перед началом работы

1. {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

1. [Включите доступ через {{ oslogin }}](../../organization/operations/os-login-access.md) на уровне организации.

1. [Включите доступ к узлам из интернета](./node-group/node-group-update.md#node-internet-access) для группы узлов, содержащей узел, к которому нужно подключиться.

1. Убедитесь, что аккаунту, с которого вы подключаетесь к узлу, [назначена одна из ролей](../../iam/operations/roles/grant.md):

    * `compute.osLogin` — для доступа к узлу без прав sudo;
    * `compute.osAdminLogin` — для доступа с правами sudo.

## Настройте узел {#configure-node}

Подготовьте узел кластера к подключению:

1. Убедитесь, что для узла включен [внешний доступ](./node-group/node-group-update.md#node-internet-access).

1. Активируйте доступ к узлу через {{ oslogin }}, изменив способ подключения к узлам.

    {% include [node-connect-mode-reconciling-warning](../../_includes/managed-kubernetes/node-connect-mode-reconciling-warning.md) %}

    {% list tabs group=instructions %}

    - Консоль управления {#console}

        1. Откройте раздел **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}** в [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder), где находится кластер {{ managed-k8s-name }}, к узлу которого нужен доступ.
        1. Нажмите на имя нужного кластера {{ managed-k8s-name }}.
        1. Перейдите во вкладку **{{ ui-key.yacloud.k8s.nodes.label_node-groups }}**.
        1. Выберите нужную группу узлов.
        1. Нажмите кнопку **{{ ui-key.yacloud.common.edit }}** в правом верхнем углу.
        1. Выберите опцию **{{ ui-key.yacloud.compute.instances.create.field_os-login-access-method }}**.

            {% include [note-oslogin-ssh-warning](../../_includes/managed-kubernetes/note-oslogin-ssh-warning.md) %}

        1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

    - CLI {#cli}

      {% include [cli-install](../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../_includes/default-catalogue.md) %}

      Чтобы включить {{ oslogin }} для всех узлов в группе узлов:

      1. Посмотрите описание команды CLI для добавления и обновления метаданных группы узлов {{ managed-k8s-name }}:

          ```bash
          {{ yc-k8s }} node-group add-metadata --help
          ```

      1. Выполните команду:

          ```bash
          {{ yc-k8s }} node-group add-metadata \
            --name <имя_группы_узлов> \
            --metadata enable-oslogin=true
          ```

          Имя группы узлов можно запросить со [списком групп узлов в каталоге](./node-group/node-group-list.md#list).

          {% include [note-oslogin-ssh-warning](../../_includes/managed-kubernetes/note-oslogin-ssh-warning.md) %}

    - {{ TF }} {#tf}

      1. Откройте актуальный конфигурационный файл {{ TF }} с описанием группы узлов {{ managed-k8s-name }}.

          О том, как создать такой файл, см. в разделе [{#T}](./node-group/node-group-create.md).

      1. Добавьте в описание группы узлов параметр `instance_template.metadata`, или измените его, если он уже есть.

          Укажите в этом параметре ключ метаданных `enable-oslogin` со значением `true`:

          ```hcl
          resource "yandex_kubernetes_node_group" "<имя_группы_узлов>" {
            cluster_id = yandex_kubernetes_cluster.<имя_кластера>.id
            ...
            instance_template {
              metadata = {
                "enable-oslogin" = "true"
                ...
              }
              ...
            }
            ...
          }
          ```

          {% include [note-oslogin-ssh-warning](../../_includes/managed-kubernetes/note-oslogin-ssh-warning.md) %}

      1. Проверьте корректность конфигурационных файлов.

          {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

      1. Подтвердите изменение ресурсов.

          {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-k8s-nodegroup }}).

    - API {#api}

      1. {% include [get-metadata-via-api](../../_includes/managed-kubernetes/get-metadata-via-api.md) %}

      1. Воспользуйтесь методом API [update](../api-ref/NodeGroup/update.md) и передайте в запросе:

          * Идентификатор группы узлов в параметре `nodeGroupId`.

          * Параметр `updateMask` со значением `nodeTemplate.metadata`.

            {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

          * Параметр `nodeTemplate.metadata`, в котором перечислены без изменений все существующие метаданные группы узлов в виде пар `ключ=значение`.

            Для ключа `enable-oslogin` замените текущее значение на `true`. Если такого ключа нет, добавьте его.

            {% include [note-oslogin-ssh-warning](../../_includes/managed-kubernetes/note-oslogin-ssh-warning.md) %}

            {% cut "Пример перечисления метаданных в параметре" %}

            > * Существующие ключи метаданных в группе узлов:
            >
            >   ```json
            >   "nodeTemplate": {
            >       "metadata": {
            >           "enable-oslogin": "undefined",
            >           "<существующий_ключ_1>": "<существующее_значение_1>",
            >           "<существующий_ключ_2>": "<существующее_значение_2>"
            >       },
            >       ...
            >   }
            >   ```
            >
            > * Ключи метаданных для передачи в запросе к API:
            >
            >   ```json
            >   "nodeTemplate": {
            >       "metadata": {
            >           "enable-oslogin": "true",
            >           "<существующий_ключ_1>": "<существующее_значение_1>",
            >           "<существующий_ключ_2>": "<существующее_значение_2>"
            >       }
            >   }
            >   ```

            {% endcut %}

            {% include [Alert API Updating Metadata](../../_includes/managed-kubernetes/metadata-updating-alert.md) %}

    {% endlist %}

## Подключитесь к узлу с помощью CLI {#connect-via-cli}

1. Посмотрите описание команды CLI для подключения к узлу:

    ```bash
    yc compute ssh --help
    ```

1. Чтобы узнать имя нужного узла, получите список узлов в кластере:

    ```bash
    {{ yc-k8s }} node-group list-nodes --name <имя_группы_узлов>
    ```

    Пример результата:

    ```bash
    +----------------------+-----------------+---------------------------+-------------+--------+
    | CLOUD INSTANCE       | KUBERNETES NODE | RESOURCES                 | DISK        | STATUS |
    +----------------------+-----------------+---------------------------+-------------+--------+
    | fhmmh23ugigb******** | <имя_узла>      | 4 100% core(s), 8.0 GB of | 64.0 GB ssd | READY  |
    | RUNNING_ACTUAL       |                 | memory                    |             |        |
    +----------------------+-----------------+---------------------------+-------------+--------+
    ```

1. Подключитесь к узлу:

    ```bash
    yc compute ssh --name <имя_узла>
    ```

## Подключитесь к узлу с помощью SSH {#connect-via-ssh}

1. [Экспортируйте сертификат](../../compute/operations/vm-connect/os-login-export-certificate.md) {{ oslogin }}.

   {% note info %}

   Сертификат действителен один час. По истечении этого времени для подключения к узлу экспортируйте новый сертификат.

   {% endnote %}

1. Узнайте публичный адрес узла:

   1. Получите идентификатор группы узлов:

      ```bash
      {{ yc-k8s }} node-group list
      ```

      Результат:

      ```bash
      +------------------------------+----------------------+-----------+----------------------+---------------------+---------+------+
      |          ID                  |      CLUSTER ID      |   NAME    |  INSTANCE GROUP ID   |     CREATED AT      | STATUS  | SIZE |
      +------------------------------+----------------------+-----------+----------------------+---------------------+---------+------+
      | <идентификатор_группы_узлов> | cato4gqs0ave******** | ng-name   | cl17a1c3mbau******** | 2024-02-08 04:25:06 | RUNNING |    1 |
      +------------------------------+----------------------+-----------+----------------------+---------------------+---------+------+
      ```

      Нужный параметр находится в столбце `ID`.

   1. Посмотрите список узлов {{ managed-k8s-name }}, которые принадлежат этой группе:

      ```bash
      yc compute instance-group list-instances <идентификатор_группы_узлов>
      ```

      Результат:

      ```bash
      +----------------------+---------------------------+----------------+-------------+----------------------+----------------+
      |     INSTANCE ID      |           NAME            |  EXTERNAL IP   | INTERNAL IP |        STATUS        | STATUS MESSAGE |
      +----------------------+---------------------------+----------------+-------------+----------------------+----------------+
      | fhm8nq5p7t0r******** | cl12kvrgj493rhrkimmb-**** | 84.201.156.211 | 10.128.0.36 | RUNNING_ACTUAL [25m] |                |
      +----------------------+---------------------------+----------------+-------------+----------------------+----------------+
      ```

      Публичный IP-адрес узла {{ managed-k8s-name }} указан в столбце `EXTERNAL IP`.

1. Подключитесь к ВМ:

    ```bash
    ssh -i <путь_к_файлу_сертификата> <имя_пользователя>@<публичный_IP-адрес_узла>
    ```

    Где:

    * `<путь_к_файлу_сертификата>` — путь к сохраненному ранее файлу `Identity` сертификата. Например: `/home/user1/.ssh/yc-cloud-id-b1gia87mbaom********-orgusername`.
    * `<имя_пользователя>` — имя пользователя в организации. Оно указано в конце имени экспортированного сертификата {{ oslogin }}. В примере выше это `orgusername`.
    * `<публичный_IP-адрес_узла>` — полученный ранее публичный адрес узла.

    При первом подключении к узлу появится предупреждение о неизвестном хосте:

    ```text
    The authenticity of host '158.160.**.** (158.160.**.**)' can't be established.
    ECDSA key fingerprint is SHA256:PoaSwqxRc8g6iOXtiH7ayGHpSN0MXwUfWHk********.
    Are you sure you want to continue connecting (yes/no)?
    ```

    Введите в терминале слово `yes` и нажмите **Enter**.
