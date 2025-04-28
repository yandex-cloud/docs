---
title: Как арендовать сервер {{ baremetal-full-name }} с подключением к {{ backup-full-name }}
description: Следуя данной инструкции, вы сможете арендовать сервер {{ baremetal-name }} с подключением к {{ backup-name }}.
---

# Арендовать сервер {{ baremetal-full-name }} с подключением к {{ backup-name }}

{% note info %}

{% include [baremetal-note](../../../_includes/backup/baremetal-note.md) %}

{% endnote %}

Вы можете создавать резервные копии [серверов](../../../baremetal/concepts/servers.md) {{ baremetal-name }} с поддерживаемыми операционными системами на базе Linux: {#os-support}

{% include [baremetal-os-list](../../../_includes/backup/baremetal-os-list.md) %}


## Перед началом работы {#before-you-begin}

1. [Создайте](../../../iam/operations/sa/create.md) сервисный аккаунт с ролями [baremetal.editor](../../../baremetal/security/index.md#baremetal-editor) и [backup.editor](../../security/index.md#backup-editor).
1. [Создайте](../../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) пару SSH-ключей.


## Аренда сервера {#server-rent}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите арендовать сервер.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. Нажмите **{{ ui-key.yacloud.baremetal.label_create-server }}**.
  1. Выберите [зону доступности](../../../overview/concepts/geo-scope.md).
  1. Выберите [пул](../../../baremetal/concepts/servers.md#server-pools).
  1. В блоке **{{ ui-key.yacloud.baremetal.title_section-server-config }}**:

      1. Выберите конфигурацию сервера.
      1. Настройте разметку диска:

          1. Нажмите **{{ ui-key.yacloud.baremetal.action_disk-layout-settings }}**.
          1. Оставьте разметку по умолчанию и нажмите **{{ ui-key.yacloud.common.save }}**.

          {% note info %}

          Параметры разметки диска важны для дальнейшего восстановления сервера из резервной копии. Подробнее см. в инструкции [{#T}](../backup-vm/recover.md).

          {% endnote %}

  1. В блоке **{{ ui-key.yacloud.baremetal.title_section-server-product }}** выберите [операционную систему, поддерживаемую в {{ backup-name }}](#os-support).
  1. В блоке **{{ ui-key.yacloud.baremetal.title_section-lease-conditions }}** укажите число серверов и период аренды.
  1. В блоке **{{ ui-key.yacloud.baremetal.title_section-server-network-settings }}**:

      1. В поле **{{ ui-key.yacloud.baremetal.field_subnet-id }}** нажмите **{{ ui-key.yacloud.common.create }}**.
      1. (опционально) Если вам требуется включить DHCP для автоматического назначения IP-адресов, сделайте это в блоке **{{ ui-key.yacloud.baremetal.title_routing-settings }}**.
      1. Введите имя подсети и нажмите **{{ ui-key.yacloud.baremetal.label_create-subnetwork }}**.
      1. В поле **{{ ui-key.yacloud.baremetal.field_needed-public-ip }}** выберите `{{ ui-key.yacloud.baremetal.label_public-ip-auto }}`.

          Чтобы [агент {{ backup-name }}](../../concepts/agent.md) мог обмениваться данными с серверами [провайдера резервного копирования](../../concepts/index.md#providers), на сервере должен быть обеспечен сетевой доступ к IP-адресам ресурсов сервиса {{ backup-name }} согласно таблице: {#ip-access}

          {% include [outgoing traffic](../../../_includes/backup/outgoing-rules.md) %} 

  1. В блоке **{{ ui-key.yacloud.baremetal.title_server-access }}**:

      1. Сгенерируйте пароль для root-пользователя. Для этого напротив поля **{{ ui-key.yacloud.baremetal.field_password }}** нажмите **{{ ui-key.yacloud.component.password-input.label_button-generate }}**.

      {% note warning %}

      После заказа сервера пароль больше нигде нельзя посмотреть. Сразу сохраните пароль в надежном месте.

      {% endnote %}

      1. В поле **{{ ui-key.yacloud.baremetal.field_ssh-public-key }}** вставьте содержимое файла открытого ключа, созданного при [подготовке к работе](#before-you-begin).

  1. Включите резервное копирование сервера в {{ backup-name }}:

      1. Раскройте блок **{{ ui-key.yacloud.baremetal.title_section-backup }}**.
      1. Выберите [политику резервного копирования](../../concepts/policy.md) или [создайте](../../operations/policy-vm/create.md) новую.
      1. Выберите [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) с ролями `baremetal.editor` и `backup.editor`, созданный при [подготовке к работе](#before-you-begin).

  1. В блоке **{{ ui-key.yacloud.baremetal.title_section-server-info }}** введите имя сервера.
  1. Нажмите **{{ ui-key.yacloud.baremetal.label_create-server }}**.

{% endlist %}

Подробнее об аренде сервера см. в [документации {{ baremetal-name }}](../../../baremetal/operations/servers/server-lease.md).