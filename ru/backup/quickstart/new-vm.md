---
title: Как начать работать с {{ backup-full-name }} на новой ВМ
description: Следуя данной инструкции, вы сможете подключиться к {{ backup-name }} и начать работать с сервисом на новых виртуальных машинах.
---

# Как начать работать с {{ backup-full-name }} на новой ВМ


{% include [quickstart-billing-paragraph](../../_includes/backup/quickstart-billing-paragraph.md) %}

В этой инструкции вы создадите и подключите к {{ backup-name }} виртуальную машину под управлением ОС [Linux](https://ru.wikipedia.org/wiki/Linux). Если вам не нужно создавать новую виртуальную машину и вы хотите подключить к {{ backup-name }} существующую ВМ, воспользуйтесь инструкцией [{#T}](./existing-vm.md).

{% include [quickstart-paid-resources](../../_includes/backup/quickstart-paid-resources.md) %}

Чтобы начать работать с {{ backup-name }}:

1. [Подготовьте инфраструктуру](#deploy-infrastructure).
1. [Активируйте {{ backup-name }}](#activate-provider).
1. [Создайте ВМ](#vm-create).
1. [Привяжите ВМ к политике резервного копирования](#add-policy).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте инфраструктуру {#deploy-infrastructure}

1. Если у вас еще нет облачной сети, [создайте](../../vpc/operations/network-create.md) ее.
1. Если в вашей [облачной сети](../../vpc/concepts/network.md#network) нет подсети, [создайте](../../vpc/operations/subnet-create.md) ее.
1. В вашей облачной сети [создайте](../../vpc/operations/security-group-create.md) группу безопасности со следующими [правилами](../../vpc/concepts/security-groups.md#security-groups-rules) для исходящего трафика:

    {% include [outgoing-rules](../../_includes/backup/outgoing-rules.md) %}

1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт и [назначьте](../../iam/operations/sa/assign-role-for-sa.md) ему [роль](../security/index.md#backup-editor) `backup.editor`.

## Активируйте {{ backup-name }} {#activate-provider}

{% include [quickstart-activate-provider](../../_includes/backup/quickstart-activate-provider.md) %}

## Создайте ВМ {#vm-create}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы хотите создать ВМ с подключением к {{ backup-name }}.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.button_create }}**.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** выберите один из [образов](../../compute/concepts/image.md) с [поддерживаемой операционной системой](../concepts/vm-connection.md#os), например [Ubuntu 20.04](/marketplace/products/yc/ubuntu-20-04-lts).
  1. В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}** выберите [зону доступности](../../overview/concepts/geo-scope.md), в которой будет находиться ВМ.
  1. В блоках **{{ ui-key.yacloud.compute.instances.create.section_storages }}** и **{{ ui-key.yacloud.compute.instances.create.section_platform }}** задайте желаемые параметры ВМ.

      {% include [vm-requirements](../../_includes/backup/vm-requirements.md) %}

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

      1. В поле **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** выберите подсеть, [подготовленную ранее](#deploy-infrastructure).
      1. В поле **{{ ui-key.yacloud.component.compute.network-select.field_external }}** выберите `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`.

          Вместо назначения ВМ публичного IP-адреса вы можете привязать к [подсети](../../vpc/concepts/network.md#subnet) с ВМ [таблицу маршрутизации](../../vpc/concepts/routing.md#rt-vm), разрешающую доступ в интернет через [NAT-шлюз](../../vpc/concepts/gateways.md) или пользовательский маршрутизатор.

      1. В поле **{{ ui-key.yacloud.component.compute.network-select.field_security-groups }}** выберите группу безопасности, [настроенную ранее](#deploy-infrastructure).

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** выберите вариант **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** и укажите данные для доступа к ВМ:
  
      * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите имя пользователя.
      * В поле **{{ ui-key.yacloud.compute.instances.create.field_key }}** выберите SSH-ключ, сохраненный в вашем профиле [пользователя организации](../../organization/concepts/membership.md).

      Если в вашем профиле нет сохраненных SSH-ключей, нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_add-ssh-key }}**, чтобы добавить новый ключ.

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}** задайте имя ВМ:

      {% include [name-format](../../_includes/name-format.md) %}

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_additional }}**:

      1. Выберите сервисный аккаунт, [созданный ранее](#deploy-infrastructure).
      1. Включите опцию **{{ ui-key.yacloud.compute.instances.create.section_backup }}**.

  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

{% endlist %}

Подробнее о создании ВМ см. в разделе [{#T}](../../compute/operations/index.md#vm-create).

## Привяжите ВМ к политике резервного копирования {#add-policy}

{% include [agent-installation-timespan](../../_includes/backup/agent-installation-timespan.md) %}

{% include [quickstart-attach-to-policy-after-agent-setup](../../_includes/backup/quickstart-attach-to-policy-after-agent-setup.md) %}

1. {% include [quickstart-check-vm-agent-status](../../_includes/backup/quickstart-check-vm-agent-status.md) %}
1. {% include [quickstart-attach-vm-to-policy](../../_includes/backup/quickstart-attach-vm-to-policy.md) %}

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:
1. Если для ВМ были созданы резервные копии, [удалите](../operations/backup-vm/delete.md) их.
1. [Удалите](../operations/delete-vm.md) ВМ из {{ backup-name }}.
1. [Удалите](../../compute/operations/vm-control/vm-delete.md) ВМ из {{ compute-name }}.

## Что дальше {#what-is-next}

* [Узнайте об особенностях сервиса](../concepts/index.md)
* [Посмотрите другие инструкции по работе с сервисом](../operations/index.md)

#### См. также {#see-also}

{% include [see-also-snapshot](../../_includes/backup/see-also-snapshot.md) %}

* [{#T}](./existing-vm.md)