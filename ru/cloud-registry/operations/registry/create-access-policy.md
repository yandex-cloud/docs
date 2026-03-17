---
title: Как настроить политику доступа к реестру {{ cloud-registry-full-name }}
description: Следуя данной инструкции, вы сможете настроить политику доступа к реестру.
---

# Настроить политику доступа к реестру

Для [реестра](../../concepts/registry.md) можно настроить политики доступа с конкретных [IP-адресов](../../../vpc/concepts/address.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится реестр.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-registry }}**.
  1. Выберите реестр.
  1. Перейдите на вкладку **{{ ui-key.yacloud.cloud-registry.title_ip-permissions }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.cloud-registry.registries.button_update-ip-permissions-full }}**.
  1. Введите IP-адрес и укажите действие:
     * `PULL` — разрешение на скачивание [артефактов](../../concepts/artifacts/index.md) из реестра;
     * `PUSH` — разрешение на загрузку артефактов в реестр.
  1. Если нужно настроить доступ для нескольких IP-адресов, нажмите **{{ ui-key.yacloud.common.add }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Задайте политику доступа к реестру:

     ```bash
     yc cloud-registry registry add-ip-permissions <имя_или_идентификатор_реестра> \
       --pull <IP-адрес> \
       --push <IP-адрес>
     ```

     Где:
     * `--pull` — флаг, разрешающий скачивание [артефактов](../../concepts/artifacts/index.md) из реестра.
     * `--push` — флаг, разрешающий загрузку артефактов в реестр.

     Результат:

     ```text
     done (1s)
     ```

     Чтобы удалить все настроенные политики доступа к реестру и сразу задать новые, используйте команду `yc cloud-registry registry set-ip-permissions`.

  1. Проверьте назначенные ограничения:

     ```bash
     yc cloud-registry registry list-ip-permissions <имя_или_идентификатор_реестра>
     ```

     Результат:

     ```text
     +--------+-----------+
     | ACTION |    IP     |
     +--------+-----------+
     | PULL   | 10.1.2.11 |
     | PUSH   | 10.1.2.11 |
     +--------+-----------+
     ```
- API {#api}

  Чтобы настроить политику доступа к реестру, воспользуйтесь методом REST API [updateIpPermissions](../../api-ref/Registry/updateIpPermissions.md) для ресурса [Registry](../../api-ref/Registry/index.md) или вызовом gRPC API [RegistryService/UpdateIpPermissions](../../api-ref/grpc/Registry/updateIpPermissions.md).

{% endlist %}
