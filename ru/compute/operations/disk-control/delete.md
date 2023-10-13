---
title: "Как удалить диск"
description: "Удалить можно только не подключенный к виртуальной машине диск. Удаление диска — неотменяемая и необратимая операция, восстановить удаленный диск невозможно. Удаление диска не приводит к удалению снимков этого диска. Снимки нужно удалять отдельно. Чтобы удалить диск в консоли управления выберите каталог, которому принадлежит диск, выберите сервис {{ compute-name }}, на странице Виртуальные машины перейдите на вкладку Диски. В строке с нужным диском нажмите значок выбора и нажмите Удалить."
---

# Удалить диск

{% note warning %}

Удалить можно только не подключенный к виртуальной машине диск. Как отключить диск читайте в разделе [{#T}](../vm-control/vm-detach-disk.md). Удаление диска — неотменяемая и необратимая операция, восстановить удаленный диск невозможно.

{% endnote %}

Удаление диска не приводит к удалению снимков этого диска. Снимки нужно [удалять](../snapshot-control/delete.md) отдельно.

Чтобы удалить диск:

{% list tabs %}

- Консоль управления

  1. В консоли управления выберите каталог, которому принадлежит диск.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../../_assets/compute/disks-pic.svg) **{{ ui-key.yacloud.compute.switch_disks }}**.
  1. В строке с нужным диском нажмите значок ![image](../../../_assets/horizontal-ellipsis.svg) и выберите **{{ ui-key.yacloud.compute.disks.button_action-delete }}**.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.compute.disks.button_action-delete }}**.

- CLI

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команд CLI для удаления дисков:

     ```bash
     yc compute disk delete --help
     ```

  1. Получите список дисков в каталоге по умолчанию:

     {% include [compute-disk-list](../../../_includes/compute/disk-list.md) %}

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужного диска.
  1. Удалите диск:

     ```bash
     yc compute disk delete \
       --name first-disk
     ```

- API

  Чтобы удалить диск, воспользуйтесь методом REST API [delete](../../api-ref/Disk/delete.md) для ресурса [Disk](../../api-ref/Disk/index.md) или вызовом gRPC API [DiskService/Delete](../../api-ref/grpc/disk_service.md#Delete).

  Список доступных дисков запрашивайте методом REST API [list](../../api-ref/Disk/list.md) или вызовом gRPC API [DiskService/List](../../api-ref/grpc/disk_service.md#List).

- {{ TF }}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Если вы создавали диск с помощью {{ TF }}, вы можете удалить его:
  1. В командной строке перейдите в папку, где расположен конфигурационный файл {{ TF }}.
  1. Удалите ресурсы с помощью команды:

     ```bash
     terraform destroy
     ```

     {% note alert %}

     {{ TF }} удалит все ресурсы, созданные в текущей конфигурации: кластеры, сети, подсети, ВМ и т. д.

     {% endnote %}

  1. Введите слово `yes` и нажмите **Enter**.

{% endlist %}