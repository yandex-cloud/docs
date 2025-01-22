---
title: Как восстановить доступ к виртуальной машине в {{ compute-full-name }}
description: Следуя данной инструкции, вы сможете восстановить доступ к виртуальной машине.
---

# Восстановление доступа к виртуальной машине

Восстановление доступа к [ВМ](../../concepts/vm.md) может понадобиться, если:
* [Утрачены учетные данные пользователя ВМ](#cloud-init).
* [Была изменена публичная часть SSH-ключа](#ssh-recovery).
* [Невозможно подключиться по SSH](#serial-console).
* [Не загружается ВМ](#os-recovery).

## Утрачены учетные данные пользователя ВМ {#cloud-init}

Если вы утратили закрытый ключ [SSH](../../../glossary/ssh-keygen.md) для Linux или пароль пользователя Windows:
1. [Создайте снимок](../disk-control/create-snapshot.md) [диска](../../concepts/disk.md) ВМ, доступ к которой нужно восстановить.
1. Если для вас важно сохранить [публичный IP-адрес](../../../vpc/concepts/address.md#public-addresses), используемый текущей виртуальной машиной, [сделайте](../../../vpc/operations/set-static-ip.md) этот IP-адрес статическим.
1. [Остановите](../vm-control/vm-stop-and-start.md#stop) ВМ и [отвяжите](../vm-control/vm-detach-public-ip.md) от нее публичный IP-адрес.
1. [Создайте новую ВМ с диском из снимка](../vm-create/create-from-snapshots.md), указав этот диск в качестве загрузочного. При создании ВМ в блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** укажите новые учетные данные для входа.

    Если ранее вы делали публичный IP-адрес ВМ статическим, используйте этот IP-адрес в качестве публичного IP-адреса новой ВМ:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      В поле **{{ ui-key.yacloud.component.compute.network-select.field_external }}** выберите способ назначения адреса `{{ ui-key.yacloud.component.compute.network-select.switch_list }}` и в появившемся списке выберите зарезервированный ранее IP-адрес.

    - CLI {#cli}

      В команде `yc compute instance create` передайте зарезервированный ранее IP-адрес в поле `nat-address` параметра `--network-interface`. Например:
      
      ```bash
      yc compute instance create \
        ...
        --network-interface subnet-name=subnet-b,nat-ip-version=ipv4,nat-address=111.112.13.14 \
        ...
      ```

      Подробнее о команде `yc compute instance create` читайте в [справочнике CLI](../../../cli/cli-ref/compute/cli-ref/instance/create.md).

    - {{ TF }} {#tf}

      В секции `network_interface` ресурса `yandex_compute_disk` укажите зарезервированный ранее IP-адрес в параметре `nat_ip_address`. Например:

      ```hcl
      network_interface {
        subnet_id      = "e2lqsms4cdl3********"
        nat            = true
        nat_ip_address = "111.112.13.14"
      }
      ```

      Подробнее о ресурсе `yandex_compute_disk` см. в [документации провайдера]({{ tf-provider-resources-link }}/compute_instance).

    {% endlist %}

1. Подключитесь к ВМ [по SSH](./ssh.md) или [RDP](./rdp.md), используя новые учетные данные.
1. Убедившись, что новая ВМ доступна и работоспособна, [удалите](../vm-control/vm-delete.md) старую ВМ и [снимок](../snapshot-control/delete.md) диска.

    Если их не удалить, они продолжат тарифицироваться, а {{ yandex-cloud }} продолжит брать за них плату.

Если для ВМ была изменена конфигурация 'cloud-init' или [сети](../../../vpc/concepts/network.md#network), описанный способ может не сработать. В этом случае смотрите раздел [Не загружается ВМ](#os-recovery).

## Была изменена публичная часть SSH-ключа {#ssh-recovery}

Проблема с доступом по SSH к ВМ на базе Linux может возникнуть, если публичная часть SSH-ключа на стороне ВМ была изменена или удалена.

Вы можете восстановить доступ по SSH к ВМ на базе Linux с помощью [серийной консоли](#serial-console) при наличии работоспособной пары SSH-ключей.

Если доступ к серийной консоли отсутствует, для восстановления публичной части SSH-ключа выполните следующие действия:
1. [Остановите](../vm-control/vm-stop-and-start.md) ВМ.
1. [Сделайте снимок](../disk-control/create-snapshot.md) с загрузочного диска ВМ.
1. [Создайте](../vm-create/create-from-snapshots.md) вспомогательную ВМ на базе Linux. Для загрузочного диска выберите операционную систему в блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}**. Чтобы подключить диск с данными к вспомогательной ВМ, выберите ранее созданный снимок в блоке **{{ ui-key.yacloud.compute.instances.create.section_storages }}**.
1. [Подключитесь по SSH](../vm-connect/ssh.md) к вспомогательной ВМ, [смонтируйте диск](../vm-control/vm-attach-disk.md#mount-disk-and-fix-uuid), созданный из снимка.
1. Замените SSH-ключ, который хранится на этом диске, на работоспособный:
   1. Перейдите в [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором хранится публичная часть SSH-ключа на смонтированном разделе, например:

      ```bash
      cd /mnt/home/<имя_пользователя>/.ssh
      ```

      По умолчанию пользовательские SSH-ключи хранятся в каталоге `~/.ssh` конкретного пользователя.
   1. Откройте файл `authorized_keys`, например, с помощью текстового редактора `nano`:

      ```bash
      nano authorized_keys
      ```

      Если файл отсутствует, после выполнения команды он будет создан.
   1. Замените содержимое файла на публичную часть работоспособной пары SSH-ключей.
1. Отмонтируйте от ВМ диск с исправленным SSH-ключом:

   ```bash
   sudo umount /mnt
   ```

1. [Остановите](../vm-control/vm-stop-and-start.md) вспомогательную ВМ, [отключите](../vm-control/vm-detach-disk.md) от нее диск с исправленным SSH-ключом.
1. [Создайте](../vm-create/create-from-disks.md) новую ВМ. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** перейдите на вкладку **{{ ui-key.yacloud.compute.instances.create.image_value_custom_new }}** и выберите диск с исправленным SSH-ключом в качестве загрузочного.

   {% note info %}

   Новая ВМ и диск с исправленным SSH-ключом должны находиться в одной [зоне доступности](../../../overview/concepts/geo-scope.md).

   {% endnote %}

1. [Подключитесь](../vm-connect/ssh.md) к вновь созданной ВМ по SSH.
1. [Удалите снимок диска](../snapshot-control/delete.md), также [удалите](../vm-control/vm-delete.md) вспомогательную и старую ВМ.

    Если их не удалить, они продолжат тарифицироваться, а {{ yandex-cloud }} продолжит брать за них плату.

## Невозможно подключиться по SSH {#serial-console}

Проблема может возникнуть из-за ошибки в настройках SSH, [групп безопасности](../../../vpc/concepts/security-groups.md) или сети. Для восстановления доступа подключитесь к ВМ с помощью [серийной консоли](../serial-console/index.md) и сделайте необходимые исправления.

{% list tabs group=operating_system %}

- Linux {#linux}

  {% note info %}

  Вы можете воспользоваться серийной консолью, только если был установлен пароль пользователя. Иначе смотрите раздел [Не загружается ВМ](#os-recovery).

  {% endnote %}

  1. [Включите доступ](../serial-console/index.md#turn-on-for-current-instance) к серийной консоли ВМ.
  1. [Подключитесь](../serial-console/connect-cli.md#connect-to-serial-console) к серийной консоли ВМ.
  1. Измените настройки SSH или сети. Если настроены группы безопасности, проверьте, чтобы в правилах был разрешен входящий трафик по протоколу TCP на порт 22.
  1. Подключитесь к ВМ через SSH.

{% endlist %}

## Утерян SSH-ключ {#lost-ssh}

{% include [new-connect-ssh](../../../_qa/compute/new-connect-ssh.md) %}

## Не загружается ВМ {#os-recovery}

Если ВМ не загружается, получите доступ к данным диска следующим образом:
1. [Создайте снимок](../disk-control/create-snapshot.md) диска ВМ, доступ к которой нужно восстановить.
1. [Создайте диск](../disk-create/empty.md) из снимка. При создании диска в поле **{{ ui-key.yacloud.compute.instances.create-disk.field_source }}** выберите `{{ ui-key.yacloud.compute.instances.create-disk.value_source-snapshot }}` и укажите созданный снимок.
1. [Подключите диск](../vm-control/vm-attach-disk.md) в качестве дополнительного к вспомогательной ВМ.
1. Измените конфигурационные файлы, влияющие на загрузку ВМ или скопируйте важные данные.
1. [Отключите диск](../vm-control/vm-detach-disk.md) от вспомогательной ВМ.
1. Если вы обнаружили и устранили проблему загрузки, создайте новую ВМ. При создании в блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** перейдите на вкладку **{{ ui-key.yacloud.compute.instances.create.image_value_custom_new }}** и выберите исправленный диск в качестве загрузочного.
1. После восстановления доступа к ВМ не забудьте удалить неиспользуемые ресурсы: [виртуальные машины](../vm-control/vm-delete.md), [диски](../disk-control/delete.md) и [снимки дисков](../snapshot-control/delete.md). Если их не удалить, они продолжат тарифицироваться, а {{ yandex-cloud }} продолжит брать за них плату.