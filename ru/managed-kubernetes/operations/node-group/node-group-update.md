---
title: "Как изменить группу узлов {{ managed-k8s-name }}"
description: "Следуя данной инструкции, вы сможете изменить группу узлов {{ managed-k8s-name }}."
---

# Изменение группы узлов {{ managed-k8s-name }}


{% include [node-vm-explained](../../../_includes/managed-kubernetes/node-vm-explained.md) %}

{% include [node-vm-manipulation-warning](../../../_includes/managed-kubernetes/node-vm-manipulation-warning.md) %}

{% include [yc-node-group-list](../../../_includes/managed-kubernetes/node-group-list.md) %}

Перед началом работы убедитесь, что в [облаке](../../../resource-manager/concepts/resources-hierarchy.md#cloud) достаточно [свободных ресурсов](../../concepts/limits.md).

## Изменить параметры группы узлов {#update-settings}

Вы можете изменить следующие параметры [группы узлов {{ managed-k8s-name }}](../../concepts/index.md#node-group):
* Имя.
* Описание.
* Масштабирование: для фиксированного типа — количество узлов {{ managed-k8s-name }}, для [автоматического](../../concepts/node-group/cluster-autoscaler.md) — минимальное, максимальное и начальное количество узлов {{ managed-k8s-name }}. Тип масштабирования нельзя изменить.
* [Версию {{ k8s }}](../../concepts/release-channels-and-updates.md).
* Способ назначения [IP-адреса](../../../vpc/concepts/address.md): только внутреннего или также внешнего.
* Список [групп безопасности](../connect/security-groups.md).

  {% note alert %}

  Не удаляйте [группы безопасности](../../../vpc/concepts/security-groups.md), привязанные к работающей группе узлов {{ managed-k8s-name }}: это может привести к нарушению ее работы и потере данных.

  {% endnote %}

* [Вычислительные ресурсы](../../../compute/concepts/vm-platforms.md) и размер [диска](../../../compute/concepts/disk.md) узлов {{ managed-k8s-name }}.
* Шаблон имени узлов {{ managed-k8s-name }}.
* Политику [обновлений](../../concepts/release-channels-and-updates.md#updates).

Инструкция по изменению [зоны доступности](../../../overview/concepts/geo-scope.md) группы узлов приведена в разделе [{#T}](../../tutorials/migration-to-an-availability-zone.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы изменить группу узлов {{ managed-k8s-name }}:
  1. Откройте раздел **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}** в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder), где требуется изменить кластер {{ managed-k8s-name }}.
  1. Нажмите на имя нужного кластера {{ managed-k8s-name }}.
  1. Перейдите во вкладку **{{ ui-key.yacloud.k8s.nodes.label_node-groups }}**.
  1. Выберите нужную группу узлов.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.edit }}** в правом верхнем углу.
  1. В открывшемся окне измените необходимые параметры.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  Получите подробную информацию о команде для изменения группы узлов {{ managed-k8s-name }}:

  ```bash
  yc managed-kubernetes node-group update --help
  ```

  Для изменения группы узлов {{ managed-k8s-name }} воспользуйтесь флагами:

  * `--new-name` — изменить имя.
  * `--description` — изменить описание.
  * `--service-account-id`, `--service-account-name` — изменить [сервисный аккаунт](../../../iam/concepts/index.md#sa) для ресурсов.
  * `--node-service-account-id`, `--node-service-account-name` — изменить сервисный аккаунт для узлов {{ managed-k8s-name }}.
  * `--version` — изменить версию {{ k8s }}.
  * `--network-interface` — настройки [сети](../../../vpc/concepts/network.md#network):

    {% include [network-interface](../../../_includes/managed-kubernetes/cli-network-interface.md) %}

  * `--network-acceleration-type` — выбор типа [ускорения сети](../../../compute/concepts/software-accelerated-network.md):
    * `standard` — без ускорения.
    * `software-accelerated` — программно-ускоренная сеть.

      {% include [note-software-accelerated-network](../../../_includes/managed-kubernetes/note-software-accelerated-network.md) %}

  * `--node-name` — изменить шаблон имени узлов {{ managed-k8s-name }}. Для уникальности имени шаблон должен содержать хотя бы одну переменную:

    {% include [node-name](../../../_includes/managed-kubernetes/node-name.md) %}

  * `--template-labels` — изменить [облачные метки группы узлов](../../../resource-manager/concepts/labels.md) в формате `<имя_метки>=<значение_метки>`. Можно указать несколько меток через запятую.
  * `--latest-revision` — получить все доступные обновления для текущей версии [мастера {{ managed-k8s-name }}](../../concepts/index.md#master).
  * Настройки масштабирования:

    * `--fixed-size` — изменить фиксированное количество узлов в группе узлов {{ managed-k8s-name }}.
    * `--auto-scale` — изменить настройки [автоматического масштабирования кластера {{ managed-k8s-name }}](../../concepts/node-group/cluster-autoscaler.md):

      * `min` — минимальное количество узлов в группе.
      * `max` — максимальное количество узлов в группе.
      * `initial` — начальное количество узлов в группе.

    Тип масштабирования нельзя изменить.

  * `--auto-upgrade` — управлять автоматическими обновлениями.
  * Управление окном обновлений:
    * `--anytime-maintenance-window` — обновлять в любое время.
    * `--daily-maintenance-window` — обновлять ежедневно в выбранное время.
    * `--weekly-maintenance-window` — обновлять в выбранные дни.

  {% note warning %}

  * Не поддерживается использование ключа метаданных `user-data` для донастройки ВМ и передачи пользовательских данных.
  * Для управления [SSH-ключами](../../../glossary/ssh-keygen.md) можно [воспользоваться ключом `ssh-keys`](../../../compute/concepts/vm-metadata.md).
  * Для донастройки узлов используйте привилегированные наборы DaemonSet. Например, [sysctl-tuner](https://github.com/elemir/yc-recipes/tree/master/sysctl-tuner).

  {% endnote %}

- {{ TF }} {#tf}

  Чтобы изменить группу узлов {{ managed-k8s-name }}:
  1. Откройте актуальный конфигурационный файл {{ TF }} с описанием группы узлов {{ managed-k8s-name }}.

     О том, как создать такой файл, см. в разделе [{#T}](node-group-create.md).
  1. Измените параметры в описании группы узлов {{ managed-k8s-name }}.

     * Чтобы изменить настройки масштабирования, измените в блоке `scale_policy`:

       * Для фиксированного масштабирования — значение параметра `fixed_scale.size`.
       * Для [автоматического масштабирования](../../concepts/node-group/cluster-autoscaler.md) — параметры в блоке `auto_scale`:

          * `min` — минимальное количество узлов в группе.
          * `max` — максимальное количество узлов в группе.
          * `initial` — начальное количество узлов в группе.

       Тип масштабирования нельзя изменить.

     * Чтобы изменить [облачные метки группы узлов](../../../resource-manager/concepts/labels.md), добавьте блок `instance_template.labels`:

       ```hcl
       resource "yandex_kubernetes_node_group" "<имя_группы_узлов>" {
         ...
         instance_template {
           ...
           labels {
             "<имя_метки>"="<значение_метки>"
           }
         }
       }
       ```

     * Чтобы изменить шаблон имени узлов {{ managed-k8s-name }}, измените параметр `instance_template.name`. Для уникальности имени шаблон должен содержать хотя бы одну переменную:

       {% include [node-name](../../../_includes/managed-kubernetes/node-name.md) %}

     * Чтобы изменить [DNS-записи](../../../dns/concepts/resource-record.md):

       {% include [node-name](../../../_includes/managed-kubernetes/tf-node-name.md) %}

  1. Проверьте корректность конфигурационных файлов.

     {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

     {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

     Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-k8s-nodegroup }}).

- API {#api}

  Чтобы изменить параметры [группы узлов {{ managed-k8s-name }}](../../concepts/index.md#node-group), воспользуйтесь методом [update](../../api-ref/NodeGroup/update.md) для ресурса [NodeGroup](../../api-ref/NodeGroup).

  Чтобы изменить [облачные метки группы узлов](../../../resource-manager/concepts/labels.md), передайте значения меток в параметре `nodeTemplate.labels`.

  Чтобы изменить шаблон имени узлов {{ managed-k8s-name }}, передайте его в параметре `nodeTemplate.name`. Для уникальности имени шаблон должен содержать хотя бы одну переменную:

  {% include [node-name](../../../_includes/managed-kubernetes/node-name.md) %}

  Чтобы изменить [DNS-записи](../../../dns/concepts/resource-record.md), передайте их настройки в параметре `nodeTemplate.v4AddressSpec.dnsRecordSpecs`. В [FQDN](../../../glossary/fqdn.md) записи DNS можно использовать шаблон с переменными для имени узлов `nodeTemplate.name`.

{% endlist %}

## Включить доступ к узлам из интернета {#node-internet-access}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. Нажмите на имя нужной ВМ.
  1. В блоке **{{ ui-key.yacloud.compute.instance.overview.section_network }}** нажмите значок ![options](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.compute.instance.overview.button_add-public-ip }}**.
  1. Укажите нужные настройки и нажмите кнопку **{{ ui-key.yacloud.component.compute.one-to-one-nat-form.button_submit }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Для включения доступа к [узлам {{ managed-k8s-name }}](../../concepts/index.md#node-group) из интернета:
  1. Получите подробную информацию о команде для изменения группы узлов {{ managed-k8s-name }}:

     ```bash
     {{ yc-k8s }} node-group update --help
     ```

  1. Выполните команду изменения группы узлов, передав ей флаг `--network-interface`:

     ```bash
     {{ yc-k8s }} node-group update <идентификатор_или_имя_группы_узлов> \
     ...
       --network-interface subnets=<имя_подсети_группы_узлов>, ipv4-address=nat
     ```

     Имена и идентификаторы групп узлов {{ managed-k8s-name }} можно получить со [списком групп узлов в каталоге](node-group-list.md#list).

- API {#api}

  Воспользуйтесь методом [update](../../api-ref/NodeGroup/update.md) для ресурса [NodeGroup](../../api-ref/NodeGroup).

{% endlist %}

Альтернативный способ выдать доступ в интернет узлам кластера {{ managed-k8s-name }} — создать и настроить [NAT-шлюз](../../../vpc/operations/create-nat-gateway.md) или [NAT-инстанс](../../../vpc/tutorials/nat-instance/index.md). В результате с помощью [статической маршрутизации](../../../vpc/concepts/routing.md) трафик будет направлен через шлюз или отдельную ВМ с функциями NAT.

{% note info %}

Если вы назначили публичные IP-адреса узлам кластера и затем настроили NAT-шлюз или NAT-инстанс, доступ в интернет через публичные адреса пропадет. Подробнее см. в [документации сервиса {{ vpc-full-name }}](../../../vpc/concepts/routing.md#internet-routes).

{% endnote %}

## Назначить taint-политику на группу узлов {#assign-taint}

Добавление [taint-политик](../../concepts/index.md#taints-tolerations) пересоздает группу узлов {{ managed-k8s-name }}. Сначала удаляются все узлы в группе, затем в нее добавляются узлы с taint-политиками.

{% list tabs group=instructions %}

- {{ TF }} {#tf}

  Чтобы назначить taint-политику на группу узлов:

  1. Откройте актуальный конфигурационный файл {{ TF }} с описанием группы узлов {{ managed-k8s-name }}.

     О том, как создать такой файл, см. в разделе [{#T}](node-group-create.md).

  1. В описание группы узлов добавьте блок `node_taints`:

     ```hcl
     resource "yandex_kubernetes_node_group" "<имя_группы_узлов>" {
       ...
       node_taints = [
         "<ключ>=<значение>:<taint-эффект>",
         ...
       ]
       ...
     }
     ```

     Укажите произвольные ключ и значение. В качестве taint-эффекта выберите один из доступных:

     * `NoSchedule` — запретить запуск новых подов на узлах группы (уже запущенные поды продолжат работу).
     * `PreferNoSchedule` — избегать запуска подов на узлах группы, если для запуска этих подов есть свободные ресурсы в других группах.
     * `NoExecute` — завершить работу подов на узлах этой группы, расселить их в другие группы, а запуск новых подов запретить.

     Можно назначить несколько taint-политик, в этом случае укажите их через запятую.

  1. Проверьте корректность конфигурационных файлов.

     {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

     {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

     Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-k8s-nodegroup }}).

- API {#api}

  Чтобы назначить taint-политику на группу узлов, воспользуйтесь методом [update](../../api-ref/NodeGroup/update.md) для ресурса [NodeGroup](../../api-ref/NodeGroup/index.md) и передайте в запросе:

  * Taint-политики в параметре `nodeTaints`.
  * Обновляемый параметр `nodeTaints` в параметре `updateMask`.

  {% include [Note API updateMask](../../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Снять taint-политику с группы узлов {#remove-taint}

Удаление [taint-политик](../../concepts/index.md#taints-tolerations) пересоздает группу узлов {{ managed-k8s-name }}. Сначала удаляются все узлы в группе, затем в нее добавляются узлы с новой конфигурацией.

{% list tabs group=instructions %}

- {{ TF }} {#tf}

  Чтобы снять taint-политику с группы узлов:

  1. Откройте актуальный конфигурационный файл {{ TF }} с описанием группы узлов {{ managed-k8s-name }}.

     О том, как создать такой файл, см. в разделе [{#T}](node-group-create.md).

  1. Удалите из описания группы узлов ненужные taint-политики в блоке `node_taints`.

  1. Проверьте корректность конфигурационных файлов.

     {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

     {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

     Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-k8s-nodegroup }}).

- API {#api}

  Чтобы снять taint-политику с группы узлов, воспользуйтесь методом [update](../../api-ref/NodeGroup/update.md) для ресурса [NodeGroup](../../api-ref/NodeGroup/index.md) и передайте в запросе:

  * Новый набор taint-политик в параметре `nodeTaints`. Если вы хотите снять все политики, передайте в запросе `"nodeTaints": []`.
  * Обновляемый параметр `nodeTaints` в параметре `updateMask`.

  {% include [Note API updateMask](../../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Управлять облачными метками группы узлов {#manage-label}

Вы можете выполнять следующие действия с [облачными метками](../../../resource-manager/concepts/labels.md) группы узлов {{ managed-k8s-name }}:
* [Добавить](#add-label).
* [Изменить](#update-label).
* [Удалить](#remove-label).

### Добавить облачную метку {#add-label}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  Добавьте облачную метку [группе узлов {{ managed-k8s-name }}](../../concepts/index.md#node-group):

  ```bash
  yc managed-kubernetes node-group add-labels my-node-group --labels new_label=test_label
  ```

  Результат:

  ```text
  done (28s)
  id: catpl8c44kii********
  cluster_id: catcsqidoos7********
  ...
  ```

- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл {{ TF }} с описанием группы узлов {{ managed-k8s-name }}.

     О том, как создать такой файл, см. в разделе [{#T}](node-group-create.md).
  1. Добавьте в описание группы узлов {{ managed-k8s-name }} параметр `labels`:

     ```hcl
     resource "yandex_kubernetes_node_group" "<имя_группы_узлов>" {
       cluster_id = yandex_kubernetes_cluster.<имя_кластера>.id
       ...
       labels = {
         "<облачная_метка>" = "<значение>"
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

### Изменить облачную метку {#update-label}

{% list tabs group=instructions %}

- CLI {#cli}

  Измените облачную метку группы узлов {{ managed-k8s-name }}:

  {% note warning %}

  Существующий набор `labels` полностью перезаписывается набором, переданным в запросе.

  {% endnote %}

  ```bash
  yc managed-kubernetes node-group update my-node-group --labels test_label=my_ng_label
  ```

  Результат:

  ```text
  done (3s)
  id: catpl8c44kii********
  cluster_id: catcsqidoos7********
  ...
  ```

- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл {{ TF }} с описанием группы узлов {{ managed-k8s-name }}.

     О том, как создать такой файл, см. в разделе [{#T}](node-group-create.md).
  1. Измените в описании группы узлов {{ managed-k8s-name }} значения параметра `labels`:

     ```hcl
     resource "yandex_kubernetes_node_group" "<имя_группы_узлов>" {
       cluster_id = yandex_kubernetes_cluster.<имя_кластера>.id
       ...
       labels = {
         "<облачная_метка>" = "<значение>"
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

### Удалить облачную метку {#remove-label}

{% list tabs group=instructions %}

- CLI {#cli}

  Удалите облачную метку группы узлов {{ managed-k8s-name }}:

  ```bash
  yc managed-kubernetes node-group remove-labels my-node-group --labels test_label
  ```

  Результат:

  ```text
  done (2s)
  id: catpl8c44kii********
  cluster_id: catcsqidoos7********
  ...
  ```

- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл {{ TF }} с описанием группы узлов {{ managed-k8s-name }}.

     О том, как создать такой файл, см. в разделе [{#T}](node-group-create.md).
  1. Удалите из описания группы узлов {{ managed-k8s-name }} ненужные облачные метки в блоке `labels`.
  1. Проверьте корректность конфигурационных файлов.

     {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

     {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-k8s-nodegroup }}).

{% endlist %}

## Изменить способ подключения к узлам в группе узлов {#switch-node-connect-mode}

{% include [node-connect-mode-reconciling-warning](../../../_includes/managed-kubernetes/node-connect-mode-reconciling-warning.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Откройте раздел **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}** в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder), где требуется изменить кластер {{ managed-k8s-name }}.
    1. Нажмите на имя нужного кластера {{ managed-k8s-name }}.
    1. Перейдите во вкладку **{{ ui-key.yacloud.k8s.nodes.label_node-groups }}**.
    1. Выберите нужную группу узлов.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.edit }}** в правом верхнем углу.
    1. Измените настройки для способов подключения:

        1. Чтобы включить или выключить доступ к узлам через {{ oslogin }}, используйте опцию **{{ ui-key.yacloud.compute.instances.create.field_os-login-access-method }}**.

            {% include [note-oslogin-ssh-warning](../../../_includes/managed-kubernetes/note-oslogin-ssh-warning.md) %}

            {% include [configure-connect-oslogin](../../../_includes/managed-kubernetes/configure-connect-oslogin.md) %}

        1. {% include [enable-ssh-access](../../../_includes/managed-kubernetes/enable-ssh-access.md) %}

            {% include [configure-connect-ssh](../../../_includes/managed-kubernetes/configure-connect-ssh.md) %}

        1. {% include [disable-ssh-access](../../../_includes/managed-kubernetes/disable-ssh-access.md) %}

    1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

    1. {% include [configure-oslogin-access](../../../_includes/managed-kubernetes/configure-oslogin-access.md) %}

    1. {% include [enable-ssh-access](../../../_includes/managed-kubernetes/enable-ssh-access.md) %}

        {% include [configure-connect-ssh](../../../_includes/managed-kubernetes/configure-connect-ssh.md) %}

    1. {% include [disable-ssh-access](../../../_includes/managed-kubernetes/disable-ssh-access.md) %}

- {{ TF }} {#tf}

    1. {% include [configure-oslogin-access](../../../_includes/managed-kubernetes/configure-oslogin-access.md) %}

    1. {% include [enable-ssh-access](../../../_includes/managed-kubernetes/enable-ssh-access.md) %}

        {% include [configure-connect-ssh](../../../_includes/managed-kubernetes/configure-connect-ssh.md) %}

    1. {% include [disable-ssh-access](../../../_includes/managed-kubernetes/disable-ssh-access.md) %}

- API {#api}

    1. {% include [configure-oslogin-access](../../../_includes/managed-kubernetes/configure-oslogin-access.md) %}

    1. {% include [enable-ssh-access](../../../_includes/managed-kubernetes/enable-ssh-access.md) %}

        {% include [configure-connect-ssh](../../../_includes/managed-kubernetes/configure-connect-ssh.md) %}

    1. {% include [disable-ssh-access](../../../_includes/managed-kubernetes/disable-ssh-access.md) %}

{% endlist %}

## Изменить метаданные {#update-metadata}

{% note warning %}

{% include [node-group-metadata-warning](../../../_includes/managed-kubernetes/node-group-metadata-warning.md) %}

После изменения метаданных группа узлов временно перейдет в статус `Reconciling`: все узлы в группе будут пересозданы для применения изменений.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Откройте раздел **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}** в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder), где требуется изменить кластер {{ managed-k8s-name }}.
    1. Нажмите на имя нужного кластера {{ managed-k8s-name }}.
    1. Перейдите во вкладку **{{ ui-key.yacloud.k8s.nodes.label_node-groups }}**.
    1. Выберите нужную группу узлов.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.edit }}** в правом верхнем углу.
    1. Раскройте блок **{{ ui-key.yacloud.common.metadata }}** и измените, добавьте или удалите метаданные для узлов.

        Чтобы добавить метаданные, используйте кнопку **{{ ui-key.yacloud.common.metadata-add-field }}**. Укажите ключ и значение каждого элемента метаданных в отдельном наборе полей.

    1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    1. Чтобы добавить или изменить метаданные с определенным ключом:

        1. Посмотрите описание команды CLI для добавления и обновления метаданных группы узлов {{ managed-k8s-name }}:

            ```bash
            {{ yc-k8s }} node-group add-metadata --help
            ```

        1. Чтобы добавить новые метаданные или изменить их, если они существуют, выполните команду:

            ```bash
            {{ yc-k8s }} node-group add-metadata \
              --name <имя_группы_узлов> \
              --metadata <ключ>=<значение>
            ```

            Имя группы узлов можно запросить со [списком групп узлов в каталоге](./node-group-list.md#list).

            Перечень существующих метаданных можно запросить вместе с [подробной информацией о группе узлов](./node-group-list.md#get).

            {% note tip %}

            Используйте параметр `--metadata-from-file` вместо `--metadata`, если нужно получить значение из файла:

            ```bash
            --metadata-from-file <ключ>=<путь_к_файлу_со_значением>
            ```

            {% include [metadata-key-from-file](../../../_includes/managed-kubernetes/metadata-key-from-file.md) %}

            {% endnote %}

    1. Чтобы удалить метаданные с определенным ключом:

        1. Посмотрите описание команды CLI для удаления метаданных группы узлов {{ managed-k8s-name }}:

            ```bash
            {{ yc-k8s }} node-group remove-metadata --help
            ```

        1. Удалите существующие метаданные:

            ```bash
            {{ yc-k8s }} node-group remove-metadata \
              --name <имя_группы_узлов> \
              --keys <ключ>
            ```

            Имя группы узлов можно запросить со [списком групп узлов в каталоге](./node-group-list.md#list).

            Перечень существующих метаданных можно запросить вместе с [подробной информацией о группе узлов](./node-group-list.md#get).

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с описанием группы узлов {{ managed-k8s-name }}.

        О том, как создать такой файл, см. в разделе [{#T}](./node-group-create.md).

    1. Чтобы добавить, изменить или удалить метаданные с определенным ключом, измените перечень ключей и значений в параметре `instance_template.metadata`. Если такого параметра нет — добавьте его.

        ```hcl
        resource "yandex_kubernetes_node_group" "<имя_группы_узлов>" {
          cluster_id = yandex_kubernetes_cluster.<имя_кластера>.id
          ...
          instance_template {
            metadata = {
              "<ключ>" = "<значение>"
              ...
            }
            ...
          }
          ...
        }
        ```

        {% note tip %}

        Используйте функцию `file()`, если нужно получить значение из файла:

        ```hcl
        "<ключ>" = file("<путь_к_файлу_со_значением>")
        ```

        {% include [metadata-key-from-file](../../../_includes/managed-kubernetes/metadata-key-from-file.md) %}

        {% endnote %}

    1. Проверьте корректность конфигурационных файлов.

        {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-k8s-nodegroup }}).

- API {#api}

    1. {% include [get-metadata-via-api](../../../_includes/managed-kubernetes/get-metadata-via-api.md) %}

    1. Воспользуйтесь методом REST API [update](../../api-ref/NodeGroup/update.md) для ресурса [NodeGroup](../../api-ref/NodeGroup/index.md) и передайте в запросе:

        * Идентификатор группы узлов в параметре `nodeGroupId`.

        * Параметр `updateMask` со значением `nodeTemplate.metadata`.

            {% include [Note API updateMask](../../../_includes/note-api-updatemask.md) %}

        * Параметр `nodeTemplate.metadata`, в котором перечислены метаданные группы узлов.

            Внесите нужные изменения в перечень метаданных, который был получен на предыдущем шаге: добавьте, измените или удалите пары `ключ=значение`. Затем передайте обновленный перечень в параметре `nodeTemplate.metadata`.

            {% note alert %}

            Метаданные, не перечисленные в параметре `nodeTemplate.metadata`, будут удалены.

            {% endnote %}

{% endlist %}
