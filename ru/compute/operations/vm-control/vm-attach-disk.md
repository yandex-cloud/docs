# Подключить диск к виртуальной машине

Подключить диск можно как к работающей, так и к остановленной виртуальной машине.

Чтобы диск был успешно подключен к работающей ВМ, операционная система машины должна быть готова принимать команды на подключение диска. Перед подключением диска убедитесь, что ОС загружена, или остановите виртуальную машину — иначе операция подключения диска завершится с ошибкой. При возникновении ошибки остановите ВМ и повторите операцию.

{% include [disk-auto-delete](../../_includes_service/disk-auto-delete.md) %}

## Подключить диск {#attach}

Чтобы подключить диск к виртуальной машине:

{% list tabs %}

- Консоль управления

   1. Выберите каталог, которому принадлежит виртуальная машина.
   1. Выберите сервис **{{ compute-full-name }}**.
   1. Перейдите в раздел **Диски**.
   1. В блоке **Диски** выберите неподключенный диск или [создайте](../disk-create/empty.md) новый.
   1. Напротив нужного диска нажмите ![image](../../../_assets/horizontal-ellipsis.svg) и выберите **Присоединить**.
   1. В открывшемся окне:
      - В поле **ВМ** выберите виртуальную машину, к которой нужно подключить диск.
      - Введите **Название устройства**.
      - Выберите значение параметра **Автоматическое удаление**.
   1. Нажмите кнопку **Подключить**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для подключения дисков:

      ```
      $ yc compute instance attach-disk --help
      ```

  1. Получите список виртуальных машин в каталоге по умолчанию:

      {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужной машины, например `first-instance`.

  1. Получите список дисков в каталоге по умолчанию:

      {% include [compute-disk-list](../../../_includes/compute/disk-list.md) %}

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужного диска, например `first-disk`. Посмотреть список подключенных к виртуальной машине дисков можно с помощью команды:

      ```
      $ yc compute instance get --full first-instance
      ```

  1. Подключите диск к виртуальной машине:

      ```
      $ yc compute instance attach-disk first-instance \
          --disk-name first-disk \
          --mode rw
      ```

      Чтобы диск был автоматически удален при удалении виртуальной машины, укажите флаг `--auto-delete`.

      {% include [attach_empty_disk](../../_includes_service/attach-empty-disk.md) %}

      Если возникла ошибка, остановите виртуальную машину:

      ```
      $ yc compute instance stop first-instance
      ```

      Затем подключите диск повторно.

  1. Если виртуальная машина была остановлена, запустите ее заново:

      ```
      $ yc compute instance start first-instance
      ```

- API

  Воспользуйтесь методом [attachDisk](../../api-ref/Instance/attachDisk.md) для ресурса [Instance](../../api-ref/Instance/).

{% endlist %}

## Смонтировать диск, созданный из снимка или образа {#mount-disk-and-fix-uuid}

Для использования подключенного диска:

{% list tabs %}

- Linux

  Смонтируйте диск:

  1. Подключитесь к виртуальной машине [по SSH](../vm-connect/ssh.md).
  1. Выполните команду `blkid` и проверьте, что нет разделов с одинаковыми UUID:

      ```bash
      $ sudo blkid
      /dev/vda2: UUID="0d6dfef0-542d-47ba-b55b-18ab5f5f9210" TYPE="ext4" PARTUUID="752aa845-94ee-4850-9188-71c2f919ee7b"
      /dev/vdb2: UUID="0d6dfef0-542d-47ba-b55b-18ab5f5f9210" TYPE="ext4" PARTUUID="752aa845-94ee-4850-9188-71c2f919ee7b"
      ...
      ```
  1. Если вы обнаружили, что какие-то UUID дублируются, сгенерируйте новый UUID для тех дубликатов, которые идут последними в выводе команды `blkid`. Для примера из предыдущего шага надо сгенерировать UUID для раздела `/dev/vdb2`:

      ```bash
      $ sudo e2fsck -f /dev/vdb2
      $ sudo tune2fs -U $(uuidgen) /dev/vdb2
      ```

      Этот способ подойдет для разделов с файловыми системами `ext2`, `ext3` и `ext4`. Последняя используется в образах Linux, предоставляемых {{ yandex-cloud }}. Тип файловой системы возвращается командой `blkid` в параметре `TYPE`.

      Чтобы проверить, что UUID изменился, снова выполните команду `blkid`:

      ```bash
      $ sudo blkid
      /dev/vda2: UUID="0d6dfef0-542d-47ba-b55b-18ab5f5f9210" TYPE="ext4" PARTUUID="752aa845-94ee-4850-9188-71c2f919ee7b"
      /dev/vdb2: UUID="ea004485-07fb-4128-b20d-e408db1e8ae8" TYPE="ext4" PARTUUID="752aa845-94ee-4850-9188-71c2f919ee7b"
      ```

      {% include [include](../../../_includes/compute/duplicated-uuid-note.md) %}
  1. {% include [include](../../../_includes/compute/mount-disk.md) %}
  1. Выполните команду `df`, чтобы проверить состояние файловой системы.

- Windows

  1. Подключитесь к виртуальной машине [по RDP](../vm-connect/rdp.md).
  1. Назначьте букву подключенному диску. Как это сделать читайте в [документации Microsoft](https://docs.microsoft.com/ru-ru/windows-server/storage/disk-management/change-a-drive-letter).

{% endlist %}

## Разметить и смонтировать пустой диск в Linux {#mount}

Чтобы самостоятельно разметить и смонтировать пустой диск:

1. Выполните команду `lsblk`, чтобы проверить, подключен ли диск как устройство и узнать его путь в системе.  Обычно, пустой диск имеет метку вида `/dev/vdb`.

1. Разметьте диск. Для этого, создайте на нем [разделы](https://help.ubuntu.ru/wiki/%D1%80%D0%B0%D0%B7%D0%B4%D0%B5%D0%BB%D1%8B_%D0%B8_%D1%84%D0%B0%D0%B9%D0%BB%D0%BE%D0%B2%D1%8B%D0%B5_%D1%81%D0%B8%D1%81%D1%82%D0%B5%D0%BC%D1%8B_linux) с помощью утилит [cfdisk](https://www.alv.me/utility-razmetki-cfdisk/), `fdisk`, или `parted`. Отформатируйте диск в нужную файловую систему, например, с помощью утилиты [mkfs](https://www.opennet.ru/man.shtml?topic=mkfs&category=8&russian=0).

1. {% include [include](../../../_includes/compute/mount-disk.md) %}
1. Выполните команду `df`, чтобы проверить состояние файловой системы.
