# Изменение группы узлов

{% include [yc-node-group-list](../../../_includes/managed-kubernetes/node-group-list.md) %}

## Изменить параметры группы узлов {#update-settings}

Вы можете изменить следующие параметры [группы узлов](../../concepts/index.md#node-group):
* Имя.
* Описание.
* Количество узлов.
* Версию {{ k8s }}.
* [Среду запуска контейнеров](../../concepts/index.md#config).
* Список [групп безопасности](../connect/security-groups.md).

  {% note alert %}

  Не удаляйте группы безопасности, привязанные к работающей группе узлов: это может привести к нарушению ее работы и потере данных.

  {% endnote %}

* Вычислительные ресурсы и размер диска узлов.
* Шаблон имени узлов.
* Политику [обновлений](../../concepts/release-channels-and-updates.md#updates).

{% note alert %}

Не изменяйте параметры виртуальных машин, принадлежащих кластеру {{ managed-k8s-name }}, с помощью [интерфейсов {{ compute-full-name }}](../../../compute/operations/vm-control/vm-update.md). Это приведет к нарушению работы группы узлов и всего кластера.

{% endnote %}

{% list tabs %}

- Консоль управления

  Чтобы изменить [группу узлов](../../concepts/index.md#node-group):
  1. Откройте раздел **{{ managed-k8s-name }}** в каталоге, где требуется изменить [кластер {{ k8s }}](../../concepts/index.md#kubernetes-cluster).
  1. Нажмите на имя нужного кластера.
  1. Перейдите во вкладку **Группы узлов**.
  1. Нажмите кнопку **Редактировать** в правом верхнем углу.
  1. В открывшемся окне измените необходимые параметры.
  1. Нажмите кнопку **Сохранить изменения**.

- CLI

  Получите подробную информацию о команде для изменения группы узлов:

  ```bash
  yc managed-kubernetes node-group update --help
  ```

  Для изменения группы узлов воспользуйтесь следующими параметрами:
  * `--new-name` — изменить имя.
  * `--description` — изменить описание.
  * `--service-account-id`, `--service-account-name` — изменить [сервисный аккаунт](../../../iam/concepts/index.md#sa) для ресурсов.
  * `--node-service-account-id`, `--node-service-account-name` — изменить сервисный аккаунт для узлов.
  * `--version` — изменить версию {{ k8s }}.
  * `--network-interface` — настройки [сети](../../../vpc/concepts/network.md#network):

    {% include [network-interface](../../../_includes/managed-kubernetes/cli-network-interface.md) %}

  * `--network-acceleration-type` — выбор типа [ускорения сети](../../../vpc/concepts/software-accelerated-network.md):
    * `standard` — без ускорения.
    * `software-accelerated` — программно-ускоренная сеть.

      {% note warning %}

      Перед включением программно-ускоренной сети убедитесь, что у вас достаточно [свободных ресурсов в облаке](../../concepts/limits.md) для создания одного дополнительного узла.

      {% endnote %}

  * `--container-runtime` — изменить [среду запуска контейнеров](../../concepts/index.md#config), `docker` или `containerd`.
  * `--node-name` — изменить шаблон имени узлов. Для уникальности имени шаблон должен содержать хотя бы одну переменную:

    {% include [node-name](../../../_includes/managed-kubernetes/node-name.md) %}

  * `--template-labels` — изменить [ресурсные метки {{ yandex-cloud }}](../../../resource-manager/concepts/labels.md) в формате `<имя метки>=<значение метки>` для ВМ, представляющих узлы группы. Можно указать несколько меток через запятую.
  * `--latest-revision` — получить все доступные обновления для текущей версии [мастера](../../concepts/index.md#master).
  * `--auto-upgrade` — управлять автоматическими обновлениями.
  * Управление окном обновлений:
    * `--anytime-maintenance-window` — обновлять в любое время.
    * `--daily-maintenance-window` — обновлять ежедневно в выбранное время.
    * `--weekly-maintenance-window` — обновлять в выбранные дни.

  {% note warning %}

  * Не поддерживается использование ключа метаданных `user-data` для донастройки ВМ и передачи пользовательских данных.
  * Для управления ssh-ключами можно [воспользоваться ключом `ssh-keys`](../../../compute/concepts/vm-metadata.md).
  * Для донастройки узлов используйте привилегированные наборы DaemonSet. Например, [sysctl-tuner](https://github.com/elemir/yc-recipes/tree/master/sysctl-tuner).

  {% endnote %}

- {{ TF }}

  Чтобы изменить [группу узлов](../../concepts/index.md#node-group):
  1. Откройте актуальный конфигурационный файл {{ TF }} с описанием группы узлов.

     О том, как создать такой файл, см. в разделе [{#T}](node-group-create.md).
  1. Измените параметры в описании группы узлов.
     * Чтобы изменить [среду запуска контейнеров](../../concepts/index.md#config), добавьте блок `instance_template.container_runtime`:

       ```hcl
       resource "yandex_kubernetes_node_group" "<имя группы>" {
         ...
         instance_template {
           ...
           container_runtime {
             type = "<docker | containerd>"
           }
         }
       }
       ```

     * Чтобы изменить [ресурсные метки {{ yandex-cloud }}](../../../resource-manager/concepts/labels.md) для ВМ, представляющих узлы группы, добавьте блок `instance_template.labels`:

       ```hcl
       resource "yandex_kubernetes_node_group" "<имя группы>" {
         ...
         instance_template {
           ...
           labels {
             "<имя метки>"="<значение метки>"
           }
         }
       }
       ```

     * Чтобы изменить шаблон имени узлов, измените параметр `instance_template.name`. Для уникальности имени шаблон должен содержать хотя бы одну переменную:

       {% include [node-name](../../../_includes/managed-kubernetes/node-name.md) %}

     * Чтобы изменить [DNS-записи](../../../dns/concepts/resource-record.md):

       {% include [node-name](../../../_includes/managed-kubernetes/tf-node-name.md) %}

  1. Проверьте корректность конфигурационных файлов.

     {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

     {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

     Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-k8s-nodegroup }}).

- API

  Чтобы изменить параметры [группы узлов](../../concepts/index.md#node-group), воспользуйтесь методом [update](../../api-ref/NodeGroup/update.md) для ресурса [NodeGroup](../../api-ref/NodeGroup).

  Чтобы изменить [среду запуска контейнеров](../../concepts/index.md#config), передайте значение `docker` или `containerd` в параметре `nodeTemplate.containerRuntimeSettings.type`.

  Чтобы изменить [ресурсные метки {{ yandex-cloud }}](../../../resource-manager/concepts/labels.md) для ВМ, представляющих узлы группы, передайте их значения в параметре `nodeTemplate.labels`.

  Чтобы изменить шаблон имени узлов, передайте его в параметре `nodeTemplate.name`. Для уникальности имени шаблон должен содержать хотя бы одну переменную:

  {% include [node-name](../../../_includes/managed-kubernetes/node-name.md) %}

  Чтобы изменить [DNS-записи](../../../dns/concepts/resource-record.md), передайте их настройки в параметре `nodeTemplate.v4AddressSpec.dnsRecordSpecs`. В FQDN записи DNS можно использовать шаблон с переменными для имени узлов `nodeTemplate.name`.

{% endlist %}

## Включить доступ к узлам из интернета {#node-internet-access}

{% list tabs %}

- Консоль управления

  1. Перейдите на страницу каталога и выберите сервис **{{ compute-name }}**.
  1. Нажмите на имя нужной ВМ.
  1. В блоке **Сеть** нажмите значок ![options](../../../_assets/horizontal-ellipsis.svg) и выберите **Добавление публичного IP-адреса**.
  1. Укажите нужные настройки и нажмите кнопку **Добавить**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Для включения доступа к [узлам](../../concepts/index.md#node-group) из интернета:
  1. Получите подробную информацию о команде для изменения группы узлов:

     ```bash
     {{ yc-k8s }} node-group update --help
     ```

  1. Выполните команду изменения группы узлов, передав ей параметр `--network-interface`:

     ```bash
     {{ yc-k8s }} node-group update <идентификатор или имя группы узлов> \
     ...
       --network-interface subnets=<имя подсети группы узлов>, ipv4-address=nat
     ```

     Имена и идентификаторы групп узлов можно получить со [списком групп узлов в каталоге](node-group-list.md#list).

- API

  Воспользуйтесь методом [update](../../api-ref/NodeGroup/update.md) для ресурса [NodeGroup](../../api-ref/NodeGroup).

{% endlist %}

## Управлять метками группы узлов {#manage-label}

Вы можете выполнять следующие действия с [метками](../../../resource-manager/concepts/labels.md) группы узлов:
* [Добавить](#add-label).
* [Изменить](#update-label).
* [Удалить](#remove-label).

### Добавить метку {#add-label}

{% list tabs %}

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  Добавьте метку [группе узлов](../../concepts/index.md#node-group):

  ```bash
  yc managed-kubernetes node-group add-labels my-node-group --labels new_label=test_label
  ```

  Результат:

  ```bash
  done (28s)
  id: catpl8c44kiibp20u4f3
  cluster_id: catcsqidoos7tq0513us
  ...
  ```

- {{ TF }}

  1. Откройте актуальный конфигурационный файл {{ TF }} с описанием группы узлов.

     О том, как создать такой файл, см. в разделе [{#T}](node-group-create.md).
  1. Добавьте в описание группы узлов параметр `labels`:

     ```hcl
     resource "yandex_kubernetes_node_group" "<имя группы узлов>" {
       cluster_id = yandex_kubernetes_cluster.<имя кластера>.id
       ...
       labels = {
         "<метка>" = "<значение>"
       }
       ...
     }
     ```

  1. Проверьте корректность конфигурационных файлов.

     {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

     {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-k8s-nodegroup }}).

{% endlist %}

### Изменить метку {#update-label}

{% list tabs %}

- CLI

  Измените метку группы узлов:

  {% note warning %}

  Существующий набор `labels` полностью перезаписывается набором, переданным в запросе.

  {% endnote %}

  ```bash
  yc managed-kubernetes node-group update my-node-group --labels test_label=my_ng_label
  ```

  Результат:

  ```bash
  done (3s)
  id: catpl8c44kiibp20u4f3
  cluster_id: catcsqidoos7tq0513us
  ...
  ```

- {{ TF }}

  1. Откройте актуальный конфигурационный файл {{ TF }} с описанием группы узлов.

     О том, как создать такой файл, см. в разделе [{#T}](node-group-create.md).
  1. Измените в описании группы узлов значения параметра `labels`:

     ```hcl
     resource "yandex_kubernetes_node_group" "<имя группы узлов>" {
       cluster_id = yandex_kubernetes_cluster.<имя кластера>.id
       ...
       labels = {
         "<метка>" = "<значение>"
         ...
       }
       ...
     }
     ```

  1. Проверьте корректность конфигурационных файлов.

     {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

     {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-k8s-nodegroup }}).

{% endlist %}

### Удалить метку {#remove-label}

{% list tabs %}

- CLI

  Удалите метку группы узлов:

  ```bash
  yc managed-kubernetes node-group remove-labels my-node-group --labels test_label
  ```

  Результат:

  ```bash
  done (2s)
  id: catpl8c44kiibp20u4f3
  cluster_id: catcsqidoos7tq0513us
  ...
  ```

- {{ TF }}

  1. Откройте актуальный конфигурационный файл {{ TF }} с описанием группы узлов.

     О том, как создать такой файл, см. в разделе [{#T}](node-group-create.md).
  1. Удалите из описания группы узлов ненужные метки в блоке `labels`.
  1. Проверьте корректность конфигурационных файлов.

     {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

     {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-k8s-nodegroup }}).

{% endlist %}