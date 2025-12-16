---
title: Как арендовать сервер в {{ baremetal-full-name }} в пользовательской конфигурации
description: Следуя данной инструкции, вы сможете арендовать сервер в {{ baremetal-full-name }} в конфигурации, собранной индивидуально под ваши потребности.
---

# Арендовать сервер в своей конфигурации

Вы можете сами [сконфигурировать](../../concepts/server-configurations.md#custom) ваш сервер. Для этого:

## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../../../_tutorials/_tutorials_includes/before-you-begin.md) %}

## Арендуйте сервер {#server-lease}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. {% include [server-lease-step1](../../../_includes/baremetal/instruction-steps/server-lease-step1.md) %}
  1. {% include [server-lease-step2](../../../_includes/baremetal/instruction-steps/server-lease-step2.md) %}
  1. Нажмите кнопку **{{ ui-key.yacloud.baremetal.label_create-server }}** и в открывшемся окне выберите вариант `{{ ui-key.yacloud.baremetal.servers.ServerConfigPage.custom-configs_b5Ab9 }}`. В открывшемся окне настройте конфигурацию сервера:

      1. В блоке **{{ ui-key.yacloud.baremetal.customConfig.CustomConfigForm.cpu_s3pPr }}** выберите устраивающий вас CPU.

          При необходимости воспользуйтесь фильтром по производителю, количеству ядер и тактовой частоте доступных процессоров.
      1. В блоке **{{ ui-key.yacloud.baremetal.customConfig.CustomConfigForm.ram_1vn53 }}** укажите тип и объем доступной на сервере памяти RAM.
      1. В блоке **{{ ui-key.yacloud.baremetal.customConfig.CustomConfigForm.disks_sZbyA }}** добавьте на сервер группу дисковых устройств определенного типоразмера:

          1. В поле **{{ ui-key.yacloud.baremetal.customConfig.DiskField.type_g1iH9 }}** выберите тип дискового устройства.
          1. В появившемся поле **{{ ui-key.yacloud.baremetal.customConfig.DiskField.size_59KKi }}** выберите размер дисков в создаваемой группе.
          1. В появившемся поле **{{ ui-key.yacloud.baremetal.customConfig.DiskField.amount_kBdTj }}** выберите количество дисков в группе.

          На сервере должна быть как минимум одна группа, состоящая не менее чем из двух дисков.

          Вы можете добавить на сервер дополнительные группы дисков других типоразмеров. Для этого нажмите кнопку ![plus](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.baremetal.customConfig.DisksField.addDiskButton_77P9P }}**.
      1. В блоке **{{ ui-key.yacloud.baremetal.customConfig.CustomConfigForm.network_b7gsC }}** выберите скорость соединения сетевых карт сервера в [публичной](../../concepts/network.md#public-network) и [приватной](../../concepts/network.md#private-network) сетях, а также наличие на сервере [групп агрегирования](../../concepts/mc-lag.md) MC-LAG.
      1. В блоке **{{ ui-key.yacloud.baremetal.field_hardware-pool-id }}** выберите [пул серверов](../../concepts/servers.md#server-pools), в котором будет расположен сервер.
      1. В блоке **{{ ui-key.yacloud.baremetal.customConfig.PsuField.withReserve_3DjVq }}** выберите, будет ли на сервере [резервирование питания](../../concepts/servers.md#server-power-supply).
      1. Нажмите кнопку **{{ ui-key.yacloud.common.continue }}**.
  1. В открывшемся окне настройте параметры сервера:

      1. В блоках **{{ ui-key.yacloud.baremetal.title_section-server-config }}** и **{{ ui-key.yacloud.baremetal.title_section-lease-conditions }}** убедитесь, что параметры выбранной конфигурации сервера соответствуют вашим потребностям.

          Если выбранные параметры вам не подходят, нажмите значок ![arrow-left](../../../_assets/console-icons/arrow-left.svg) в блоке **{{ ui-key.yacloud.baremetal.title_section-server-config }}**, чтобы вернуться к настройке конфигурации.
      1. В поле **{{ ui-key.yacloud.baremetal.field_server-lease-duration }}** выберите [период](../../../baremetal/concepts/servers.md#server-lease), на который вы хотите арендовать сервер: `1 месяц` или `1 год`.
      
          {% include [server-lease-step6-period](../../../_includes/baremetal/instruction-steps/server-lease-step6-period.md) %}
      1. {% include [server-lease-step7-bm](../../../_includes/baremetal/instruction-steps/server-lease-step7-bm.md) %}
      1. В блоке **{{ ui-key.yacloud.baremetal.title_section-disk }}** настройте разметку дисков:

          1. Нажмите кнопку **{{ ui-key.yacloud.baremetal.action_disk-layout-settings }}**.
          1. Укажите параметры разделов. Чтобы создать новый раздел, нажмите кнопку ![plus](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.baremetal.actions_add-partition }}**.

              Чтобы самостоятельно собрать RAID-массивы и настроить разделы дисков, нажмите кнопку ![square-plus](../../../_assets/console-icons/square-plus.svg) **{{ ui-key.yacloud.baremetal.action_add-to-raid }}**.
          1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.
      1. {% include [server-lease-step9-bm](../../../_includes/baremetal/instruction-steps/server-lease-step9-bm.md) %}
      1. {% include [server-lease-step10-bm](../../../_includes/baremetal/instruction-steps/server-lease-step10-bm.md) %}
      1. Если вы устанавливаете на сервер операционную систему из публичного образа в {{ marketplace-short-name }}, в блоке **{{ ui-key.yacloud.baremetal.title_server-access }}** задайте параметры доступа к серверу:

          {% include [server-lease-access](../../../_includes/baremetal/server-lease-access.md) %}
      
      1. (Опционально) Включите резервное копирование сервера в [{{ backup-full-name }}](../../../backup/index.yaml):

          {% include [server-lease-step11](../../../_includes/baremetal/instruction-steps/server-lease-step11.md) %}

          Подробнее см. в инструкции [{#T}](../../../backup/operations/backup-baremetal/lease-server-with-backup.md).
      1. {% include [server-lease-step12](../../../_includes/baremetal/instruction-steps/server-lease-step12.md) %}
      1. {% include [server-lease-step13](../../../_includes/baremetal/instruction-steps/server-lease-step13.md) %}

{% endlist %}

В результате сервер перейдет в [статус](../../concepts/servers.md#server-status) `PROVISIONING`. Сервису {{ baremetal-full-name }} потребуется до пяти календарных дней, чтобы собрать запрошенную вами конфигурацию и запустить сервер, после чего он перейдет в статус `RUNNING`.
