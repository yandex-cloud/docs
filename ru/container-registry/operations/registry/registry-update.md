---
title: "Как изменить реестр в {{ container-registry-full-name }}"
description: "Следуя данной инструкции, вы сможете изменить реестр." 
---

# Изменить реестр

Узнайте, как изменить:
* [Имя реестра](#update-name).
* [Метку реестра](#update-label).
* [Доступ для IP-адресов](#access-ip).

Для обращения к [реестру](../../concepts/registry.md) используйте его идентификатор или имя. Как узнать идентификатор или имя реестра, читайте в разделе [{#T}](registry-list.md).

## Изменить имя реестра {#update-name}

{% list tabs %}

- Консоль управления

  Чтобы изменить имя [реестра](../../concepts/registry.md):
  1. Откройте раздел **{{ ui-key.yacloud.iam.folder.dashboard.label_container-registry }}** в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder), где требуется изменить реестр.
  1. Нажмите значок ![image](../../../_assets/console-icons/ellipsis-vertical.svg) в строке реестра, который требуется изменить.
  1. В открывшемся меню нажмите кнопку **{{ ui-key.yacloud.common.edit }}**.
  1. В открывшемся окне укажите нужное имя реестра.
  1. (опционально) Измените метки.
  1. Нажмите кнопку **{{ ui-key.yacloud.cr.overview.popup-update_button_update }}**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  Измените имя реестра:

  ```bash
  yc container registry update my-reg --new-name new-reg
  ```

  Результат:

  ```bash
  id: crp3qleutgksvd1prhvb
  folder_id: b1g88tflru0ek1omtsu0
  name: new-reg
  status: ACTIVE
  created_at: "2019-01-15T14:39:48.154Z"
  ```

- API

  Чтобы изменить имя реестра, воспользуйтесь методом [update](../../api-ref/Registry/update.md) для ресурса [Registry](../../api-ref/Registry/).

{% endlist %}

## Изменить метку реестра {#update-label}

{% list tabs %}

- CLI

  Измените метку реестра (не путайте с тегами [Docker-образа](../../concepts/docker-image.md)):

  ```bash
  yc container registry update new-reg --labels new_label=test_label
  ```

  Результат:

  ```bash
  id: crp3qleutgksvd1prhvb
  folder_id: b1g88tflru0ek1omtsu0
  name: new-reg
  status: ACTIVE
  created_at: "2019-01-15T14:39:48.154Z"
  labels:
    new_label: test_label
  ```

- API

  Чтобы изменить метку реестра, воспользуйтесь методом [update](../../api-ref/Registry/update.md) для ресурса [Registry](../../api-ref/Registry/).

{% endlist %}

## Настроить доступ для IP-адресов {#access-ip}

{% list tabs %}

- Консоль управления

  Чтобы добавить или удалить [IP-адрес](../../../vpc/concepts/address.md) и настроить доступ к реестру:
  1. Откройте раздел **{{ ui-key.yacloud.iam.folder.dashboard.label_container-registry }}** в каталоге, где требуется изменить реестр.
  1. Нажмите на имя нужного реестра, затем выберите вкладку ![ip-address.svg](../../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud.cr.registry.label_ip-permissions }}** и нажмите кнопку **{{ ui-key.yacloud.cr.registry.button_update-ip-permissions }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.add }}** и укажите IP-адрес и право на действие с реестром — `PULL` (позволяет скачивать Docker-образы из реестра) или `PUSH` (позволяет загружать Docker-образы в реестр).
  1. Нажмите значок ![image](../../../_assets/console-icons/xmark.svg) в строке IP-адреса, права доступа с которого требуется удалить.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  Добавьте IP-адрес для разрешения доступа:

  ```bash
  yc container registry add-ip-permissions \
    --name my-reg \
    --pull <IP-адрес с доступом к PULL> \
    --push <IP-адрес с доступом к PUSH>
  ```

  Удалите доступ для IP-адреса:

  ```bash
  yc container registry remove-ip-permissions \
    --name my-reg \
    --pull <IP-адрес с доступом к PULL> \
    --push <IP-адрес с доступом к PUSH>
  ```

- API

  Чтобы добавить, изменить или удалить IP-адрес и настроить права доступа к [реестру](../../concepts/registry.md), воспользуйтесь методом [updateIpPermission](../../api-ref/Registry/updateIpPermission.md) для ресурса [Registry](../../api-ref/Registry/).

{% endlist %}