# Изменение настроек инстанса

После создания [инстанса {{ GL }}](../../concepts/index.md#instance) вы самостоятельно можете изменить общие и дополнительные настройки инстанса.

## Изменить общие и дополнительные настройки инстанса {#change-settings}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В консоли управления выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится [инстанс {{ GL }}](../../concepts/index.md#instance).
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-gitlab }}**.
  1. Выберите инстанс и нажмите кнопку ![image](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** в верхней части страницы.
  1. В верхней части страницы:

      * Задайте новые имя и описание инстанса.
      * Добавьте [метки](../../../resource-manager/concepts/labels.md) для разделения инстансов на логические группы.
      * Установите или снимите защиту инстанса от случайного удаления пользователем.

  1. В блоке **{{ ui-key.yacloud.gitlab.label_configuration-section }}**:

      * Измените [тип инстанса](../../concepts/index.md#config). С текущего типа инстанса можно перейти только на более производительный тип, например с `s2.micro` на `s2.small`. Перейти на менее производительный тип инстанса нельзя.
      * Выберите другую [группу безопасности](../../../vpc/concepts/security-groups.md) или создайте новую:

        * Нажмите кнопку **{{ ui-key.yacloud.component.network-subnet-select.button_create-security-group }}**.
        * Введите имя и описание группы безопасности. Правила для группы безопасности вы сможете добавить позже в сервисе {{ vpc-name }}.
        * Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

        {% include [sg-notes](../../../_includes/managed-gitlab/sg-notes.md) %}

      * Задайте размер диска. Размер диска можно увеличить или оставить прежним. Уменьшить размер диска нельзя.
      * Измените срок хранения автоматических резервных копий (в днях).
      * Выберите подходящую [конфигурацию](../../concepts/approval-rules.md#packages) правил ревью кода.

          {% include [note-approval-rules-pricing](../../../_includes/managed-gitlab/note-approval-rules-pricing.md) %}

      * Укажите [токен {{ GL }}](../approval-rules.md#gitlab-token) для активации правил ревью кода.

  1. В блоке **{{ ui-key.yacloud.gitlab.label_additional-section }}** включите или отключите удаление образов без тегов. Настройка влияет на свободное место на диске инстанса.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды [CLI](../../../cli) для изменения настроек инстанса {{ mgl-name }}:

      ```bash
      {{ yc-mdb-gl }} instance update --help
      ```

  1. Измените настройки инстанса {{ GL }} (в примере приведены не все доступные параметры):

      ```bash
      {{ yc-mdb-gl }} instance update <имя_или_идентификатор_инстанса> \
        --new-name <новое_имя_инстанса> \
        --resource-preset-id <класс_хостов> \
        --disk-size <размер_диска_ГБ> \
        --deletion-protection \
        --approval-rules <конфигурация_правил_ревью_кода>
      ```

      Где:

      * `--new-name` — новое имя инстанса, уникальное в рамках {{ yandex-cloud }}. Требования к имени:

          {% include [name-format](../../../_includes/name-format.md) %}

      * `--resource-preset-id` — класс хостов. Он определяет технические характеристики виртуальной машины, на которой будет развернут инстанс {{ GL }}. Возможные значения:

          * `s2.micro` — 2 vCPU, 8 ГБ RAM.
          * `s2.small` — 4 vCPU, 16 ГБ RAM.
          * `s2.medium` — 8 vCPU, 32 ГБ RAM.
          * `s2.large` — 16 vCPU, 64 ГБ RAM.

      * `--disk-size` — размер диска в ГБ.
      * `--deletion-protection` — защита инстанса от случайного удаления пользователем.

          {% note info %}

          С помощью CLI можно включить, но нельзя отключить защиту от случайного удаления.

          {% endnote %}

      * `--approval-rules` — конфигурация [правил ревью кода](../../concepts/approval-rules.md). Возможные значения:

          * `BASIC` — базовая.
          * `STANDARD` — стандартная.
          * `ADVANCED` — продвинутая.

          {% include [note-approval-rules-pricing](../../../_includes/managed-gitlab/note-approval-rules-pricing.md) %}

      Результат:

      ```text
      id: c17c60tpadua********
      folder_id: b1g2slt7p9ug********
      created_at: "2025-07-20T18:34:16.078Z"
      updated_at: "2025-07-20T18:54:49.829961285Z"
      name: test-cli
      resource_preset_id: s2.small
      disk_size: "107374182400"
      status: RUNNING
      admin_login: admin-gl
      admin_email: user@example.com
      domain: test-domain-user.gitlab.yandexcloud.net
      subnet_id: e9b4rrpuu2a********
      backup_retain_period_days: "7"
      deletion_protection: true
      approval_rules_id: BASIC
      gitlab_version: 17.11.6
      ```

      Подробнее о команде читайте в [справочнике CLI](../../cli-ref/instance/update.md).

- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      О том, как создать такой файл, см. в разделе [Создать инстанс {{ GL }}](instance-create.md#create).

  1. Измените в описании инстанса {{ GL }} значения параметров:

      ```hcl
      resource "yandex_gitlab_instance" "my_gitlab_instance" {
        ...
        resource_preset_id        = "<класс_хостов>"
        disk_size                 = <размер_диска_ГБ>
        approval_rules_id         = "<конфигурация_правил_ревью_кода>"
        backup_retain_period_days = <срок_хранения_копий>
        deletion_protection       = <true_или_false>
        ...
      }
      ```

      Где:

      * `resource_preset_id` — класс хостов. Он определяет технические характеристики виртуальной машины, на которой будет развернут инстанс {{ GL }}. Возможные значения:
          * `s2.micro` — 2 vCPU, 8 ГБ RAM.
          * `s2.small` — 4 vCPU, 16 ГБ RAM.
          * `s2.medium` — 8 vCPU, 32 ГБ RAM.
          * `s2.large` — 16 vCPU, 64 ГБ RAM.

      * `disk_size` — размер диска в ГБ.
      * `approval_rules_id` — конфигурация [правил ревью кода](../../concepts/approval-rules.md). Возможные значения:

          * `BASIC` — базовая.
          * `STANDARD` — стандартная.
          * `ADVANCED` — продвинутая.

          {% include [note-approval-rules-pricing](../../../_includes/managed-gitlab/note-approval-rules-pricing.md) %}

      * `backup_retain_period_days` — срок хранения автоматических резервных копий (в днях).
      * `deletion_protection` — защита инстанса от случайного удаления пользователем. Возможные значения: `true` или `false`.

      Более подробную информацию о параметрах ресурса `yandex_gitlab_instance` см. в [документации провайдера]({{ tf-provider-resources-link }}/gitlab_instance).

  1. Проверьте корректность настроек.

      {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

      {{ TF }} обновит все требуемые ресурсы. Проверить изменение ресурсов можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/):

      ```bash
      {{ yc-mdb-gl }} instance list
      ```

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/gitlab_instance).

- API {#api}

  Воспользуйтесь методом REST API [Update](../../api-ref/Instance/update.md) для ресурса [Instance](../../api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/Update](../../api-ref/grpc/Instance/update.md).

{% endlist %}
