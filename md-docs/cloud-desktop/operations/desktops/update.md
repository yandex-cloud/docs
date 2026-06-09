# Обновить рабочий стол

Изменение [образа](../../concepts/images.md), размера [рабочего диска](../../concepts/disks.md#working-disk), vCPU, доли vCPU и RAM в параметрах [группы](../../concepts/desktops-and-groups.md) приводит к пересозданию [рабочих столов](../../concepts/desktops-and-groups.md).

[Загрузочный диск](../../concepts/disks.md#boot-disk) создается заново из образа, который был ранее выбран для группы рабочих столов. Установленные на загрузочный диск ПО и обновления будут потеряны. Рабочий диск остается прежним. Изменения не затрагивают директорию пользователя.

Чтобы применить изменения к конкретному рабочему столу, [обновите](update.md) его.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором расположен рабочий стол.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-desktop }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/display.svg) **{{ ui-key.yacloud.vdi.label_desktops }}**.
  1. Напротив рабочего стола, который нужно обновить, нажмите ![options](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.button_update }}**.
  1. Подтвердите обновление.

- {{ yandex-cloud }} CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды [CLI](../../../cli/index.md) для обновления [рабочего стола](../../concepts/desktops-and-groups.md):

      ```bash
      yc desktops desktop update --help
      ```

  1. Получите список рабочих столов в каталоге по умолчанию:

      ```bash
      yc desktops desktop list
      ```

      Результат:

      ```bash
      +----------------------+------------------+--------+----------------------+---------------------+
      |          ID          |       NAME       | STATUS |   DESKTOP GROUP ID   |   CREATED (UTC-0)   |
      +----------------------+------------------+--------+----------------------+---------------------+
      | e3vmvhgbgac4******** | my-cloud-desktop | ACTIVE | e3v1rbln45tl******** | 2024-10-09 22:42:28 |
      | e3vio1bc5ppz******** | reserved-desktop | ACTIVE | e3v9om0ur4rl******** | 2024-10-09 21:35:17 |
      +----------------------+------------------+--------+----------------------+---------------------+
      ```

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужного рабочего стола, например `my-cloud-desktop`.
  1. Обновите рабочий стол:

      ```bash
      yc desktops desktop update --name <имя_рабочего_стола>
      ```

      Результат:

      ```text
      id: e3vmvhgbgac4********
      folder_id: b1g681qpemb4********
      desktop_group_id: e3v1rbln45tl********
      created_at: "2024-10-09T22:42:28.020Z"
      status: UPDATING
      name: my-cloud-desktop
      resources:
        memory: "4294967296"
        cores: "2"
        core_fraction: "100"
      network_interfaces:
        - network_id: enp0asmd9pr9********
          subnet_id: e2lb1da2dd9v********
      users:
        - subject_id: ajej2i98kcjd********
      ```

{% endlist %}

После обновления рабочего стола [сбросьте пароль пользователя](password-reset.md).