{% include [cli-install](../cli-install.md) %}

{% include [default-catalogue](../default-catalogue.md) %}

1. Посмотрите описание команды [CLI](../../cli) для создания инстанса {{ mgl-name }}:

     ```bash
     yc managed-gitlab instance create --help
     ```

1. Выберите [подсеть](../../vpc/concepts/network.md#subnet):

    ```bash
    yc vpc subnet list
    ```

    Результат:

     ```text
     +----------------------+---------------------------+----------------------+----------------+-------------------+-----------------+
     |          ID          |           NAME            |      NETWORK ID      | ROUTE TABLE ID |       ZONE        |      RANGE      |
     +----------------------+---------------------------+----------------------+----------------+-------------------+-----------------+
     | e9bnlm18l70a******** |   default-{{ region-id }}-a   | enpe3m3fa00u******** |                |   {{ region-id }}-a   | [10.128.0.0/24] |
     +----------------------+---------------------------+----------------------+----------------+-------------------+-----------------+
     ```

1. Создайте инстанс {{ GL }} (в примере приведены не все доступные параметры):

    ```bash
    yc managed-gitlab instance create \
      --name first-instance \
      --resource-preset-id <класс_хостов> \
      --disk-size <размер_диска_ГБ> \
      --admin-login <логин администратора> \
      --admin-email <электронная_почта_администратора> \
      --domain-prefix <доменное_имя_инстанса> \
      --deletion-protection \
      --approval-rules <конфигурация_правил_ревью_кода> \
      --subnet-id <идентификатор_подсети>
    ```

    Где:
    * `--name` — имя инстанса, уникальное в рамках {{ yandex-cloud }}. Требования к имени:

      {% include [name-format](../name-format.md) %}

    * `--resource-preset-id` — класс хостов. Он определяет технические характеристики виртуальной машины, на которой будет развернут инстанс {{ GL }}. Возможные значения:
      * `s2.micro` — 2 vCPU, 8 ГБ RAM.
      * `s2.small` — 4 vCPU, 16 ГБ RAM.
      * `s2.medium` — 8 vCPU, 32 ГБ RAM.
      * `s2.large` — 16 vCPU, 64 ГБ RAM.
    * `--disk-size` — размер диска в ГБ.
    * `--admin-login` — логин администратора инстанса {{ GL }}.
    * `--admin-email` — адрес электронной почты администратора. На этот адрес придет письмо со ссылкой для создания пароля.
    * `--domain-prefix` — [доменное имя инстанса](../../compute/concepts/network.md#hostname). Для него будут автоматически созданы нужные DNS-записи в домене `.gitlab.yandexcloud.net`.

      {% include [domain-name-format](domain-name-format.md) %}

    * `--deletion-protection` — защита инстанса от случайного удаления пользователем.
    * `--approval-rules` — конфигурация [правил ревью кода](../../managed-gitlab/concepts/approval-rules.md). Возможные значения:
      * `BASIC` — базовая.
      * `STANDARD` — стандартная.
      * `ADVANCED` — продвинутая.

      {% include [note-approval-rules-pricing](note-approval-rules-pricing.md) %}

    * `--subnet-id` — идентификатор выбранной подсети.

    Результат:

    ```text
    id: c17c60tpadua********
    folder_id: b1g2slt7p9ug********
    created_at: "2025-07-20T18:34:16.078Z"
    updated_at: "2025-07-20T18:34:16.078Z"
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

    Подробнее о команде читайте в [справочнике CLI](../../managed-gitlab/cli-ref/instance/create.md).
