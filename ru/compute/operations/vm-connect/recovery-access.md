# Восстановление доступа к виртуальной машине

Восстановление доступа к [ВМ](../../concepts/vm.md) может понадобиться, если:
* [{#T}](#cloud-init).
* [{#T}](#ssh-recovery).
* [{#T}](#serial-console).
* [{#T}](#os-recovery).

## Утрачены учетные данные пользователя ВМ {#cloud-init}

Если вы утратили закрытый ключ [SSH](../../../glossary/ssh-keygen.md) для Linux или пароль пользователя Windows:
1. [Создайте снимок](../disk-control/create-snapshot.md) [диска](../../concepts/disk.md) ВМ, доступ к которой нужно восстановить.
1. [Создайте ВМ с диском из снимка](../vm-create/create-from-snapshots.md), указав этот диск в качестве загрузочного. При создании ВМ в блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** укажите новые учетные данные для входа.
1. Подключитесь к ВМ по SSH или RDP используя новые учетные данные.

Если для ВМ была изменена конфигурация 'cloud-init' или [сети](../../../vpc/concepts/network.md#network), описанный способ может не сработать. В этом случае смотрите раздел [{#T}](#os-recovery).

## Была изменена публичная часть SSH-ключа {#ssh-recovery}

Проблема с доступом по SSH к ВМ на базе Linux может возникнуть, если публичная часть SSH-ключа на стороне ВМ была изменена или удалена.

Вы можете восстановить доступ по SSH к ВМ на базе Linux с помощью [серийной консоли](#serial-console) при наличии работоспособной пары SSH-ключей.

Если доступ к серийной консоли отсутствует, для восстановления публичной части SSH-ключа выполните следующие действия:
1. [Остановите](../vm-control/vm-stop-and-start.md) ВМ.
1. [Сделайте снимок](../disk-control/create-snapshot.md) с загрузочного диска ВМ.
1. [Создайте](../vm-create/create-from-snapshots.md) вспомогательную ВМ на базе Linux. Для загрузочного диска выберите операционную систему в блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}**. Чтобы подключить диск с данными к вспомогательной ВМ, выберите ранее созданный снимок в блоке **{{ ui-key.yacloud.compute.instances.create.section_storages_ru }}**.
1. [Подключитесь по SSH](../vm-connect/ssh.md) к вспомогательной ВМ, [смонтируйте диск](../vm-control/vm-attach-disk.md#mount-disk-and-fix-uuid), созданный из снимка.
1. Замените SSH-ключ, который хранится на этом диске, на работоспособный:
   1. Перейдите в [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором хранится публичная часть SSH-ключа на смонтированном разделе, например:

      ```bash
      cd /mnt/home/<имя пользователя>/.ssh
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
1. [Создайте](../vm-create/create-from-disks.md) новую ВМ. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** перейдите на вкладку **{{ ui-key.yacloud.compute.instances.create.image_value_custom }}** и выберите диск с исправленным SSH-ключом в качестве загрузочного.

   {% note info %}

   Новая ВМ и диск с исправленным SSH-ключом должны находиться в одной [зоне доступности](../../../overview/concepts/geo-scope.md).

   {% endnote %}

1. [Подключитесь](../vm-connect/ssh.md) к вновь созданной ВМ по SSH.
1. [Удалите снимок диска](../snapshot-control/delete.md), также [удалите](../vm-control/vm-delete.md) вспомогательную и старую ВМ.

## Невозможно подключиться по SSH  {#serial-console}

Проблема может возникнуть из-за ошибки в настройках SSH, [групп безопасности](../../../vpc/concepts/security-groups.md) или сети. Для восстановления доступа подключитесь к ВМ с помощью [серийной консоли](../serial-console/index.md) и сделайте необходимые исправления.

{% include [security-groups-note-vm](../../../_includes/vpc/security-groups-note-vm.md) %}

{% list tabs %}

- Linux

  {% note info %}

  Вы можете воспользоваться серийной консолью, только если был установлен пароль пользователя. Иначе смотрите раздел [{#T}](#os-recovery).

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
1. Если вы обнаружили и устранили проблему загрузки, создайте новую ВМ. При создании в блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** перейдите на вкладку **{{ ui-key.yacloud.compute.instances.create.image_value_custom }}** и выберите исправленный диск в качестве загрузочного.