---
title: Как переустановить ОС на сервере {{ baremetal-name }} из образа {{ marketplace-short-name }}
description: Следуя данной инструкции, вы сможете переустановить операционную систему сервера {{ baremetal-full-name }} из образа {{ marketplace-short-name }}.
---

# Переустановить операционную систему из образа {{ marketplace-short-name }}

{{ marketplace-short-name }} — это каталог предварительно настроенных образов операционных систем доступных для установки на серверы {{ baremetal-name }}.

{{ baremetal-full-name }} позволяет переустановить операционную систему сервера из публичного образа {{ marketplace-short-name }}. При переустановке вы можете выбрать любую доступную в {{ marketplace-short-name }} для серверов {{ baremetal-name }} операционную систему, а также перераспределить дисковое пространство, пересобрать RAID-массивы и перенастроить параметры доступа root-пользователя.

{% note warning %}

После переустановки операционной системы данные с дисков будут удалены. Конфигурация сервера не изменится.

{% endnote %}

Чтобы переустановить операционную систему сервера {{ baremetal-name }}:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится нужный сервер.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. В строке с нужным сервером нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![ArrowsRotateLeft](../../../_assets/console-icons/arrows-rotate-left.svg) **{{ ui-key.yacloud.baremetal.action_reinstall-server-os-menu }}**.
  1. В открывшемся окне:

      1. В блоке **{{ ui-key.yacloud.baremetal.title_section-server-product }}** выберите один из доступных образов ОС.
      1. {% include [server-lease-step6](../../../_includes/baremetal/instruction-steps/server-lease-step6.md) %}

          Если не вносить изменений в разметку дисков, на сервере сохранятся заданные ранее настройки RAID-массивов и распределения дискового пространства.
      1. В блоке **{{ ui-key.yacloud.baremetal.title_server-access }}**:

          {% include [server-lease-access](../../../_includes/baremetal/server-lease-access.md) %}

      1. Нажмите кнопку **{{ ui-key.yacloud.baremetal.action_reinstall-server-os }}** и дождитесь переустановки операционной системы сервера.

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. Посмотрите описание команды для переустановки ОС:

      ```bash
      yc baremetal server reinstall --help
      ```

   1. Переустановите ОС:

      ```bash
      yc baremetal server reinstall \
        --name <имя_сервера> \
        --os-settings "image-id=<идентификатор_образа>,image-name=<имя_образа>,ssh-key-public=<содержимое_открытого_SSH-ключа>,ssh-key-user-id=<идентификатор_пользователя_SSH-ключа>,password-plain-text=<пароль_пользователя>,password-lockbox-secret={secret-id=<идентификатор_секрета>,version-id=<версия_секрета>,key=<ключ_секрета>}" \
        --storage "partition={type=<файловая_система>,size-gib=<размер_раздела>,mount-point=<точка_монтирования>},raid-type=<уровень RAID-массива>,disk={id=<номер_диска>,size-gib=<размер_диска>,type=<тип_диска>}"
      ```

      Где:
      * `--name` — имя сервера.
      * {% include [server-lease-cli-os](../../../_includes/baremetal/instruction-steps/server-lease-cli-os.md) %}
      * {% include [server-lease-cli-storage](../../../_includes/baremetal/instruction-steps/server-lease-cli-storage.md) %}

{% endlist %}

## Пример {#example}

Переустановите операционную систему:

 {% list tabs group=instructions %}

 - CLI {#cli}

   ```bash
   yc baremetal server reinstall \
     --name demo-baremetal-server \
     --os-settings "image-id=ly5vtno2mjr3k4iuecur,password-plain-text=FDrxicR********,ssh-key-public=ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGcM4tRfRHJGrlLMT+YJFr+aOdSQ********"
   ```

   Результат:

   ```text
   done (22m47s)
   id: ly5u2442ulmz********
   cloud_id: b1gia87mbaom********
   folder_id: b1g0ijbfaqsn********
   name: demo-baremetal-server
   description: My first BareMetal server
   zone_id: ru-central1-m
   hardware_pool_id: ru-central1-m4
   status: RUNNING
   os_settings:
     image_id: ly5vtno2mjr3k4iuecur
     ssh_public_key: ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGcM4tRfRHJGrlLMT+YJFr+aOdSQYnYYjAoj********
     storages:
       - partitions:
           - type: EXT3
             size_gib: "9"
             mount_point: /boot
           - type: SWAP
             size_gib: "4"
           - type: EXT4
             mount_point: /
         raid:
           type: RAID10
           disks:
             - id: ly54aes2ecmb********
               type: HDD
               size_gib: "1862"
             - id: ly5nrgud6zrt********
               type: HDD
               size_gib: "1862"
             - id: ly5yf2ylmchh********
               type: HDD
               size_gib: "1862"
             - id: ly5loug77ciu********
               type: HDD
               size_gib: "1862"
   configuration_id: ly5lymxdltk3xitpkrmi
   created_at: "2025-07-09T07:23:39.323794Z"
   labels:
     env: test
   ```

{% endlist %}