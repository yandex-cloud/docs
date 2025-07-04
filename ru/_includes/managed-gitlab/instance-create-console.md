1. В консоли управления выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно создать [инстанс {{ GL }}](../../managed-gitlab/concepts/index.md#instance).
1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-gitlab }}**.
1. Нажмите кнопку **{{ ui-key.yacloud.gitlab.button_create-instance }}**.
1. В верхней части страницы:

   1. Введите имя инстанса. Оно должно быть уникальным в рамках {{ yandex-cloud }}.

      {% include [name-format](../name-format.md) %}

   1. (Опционально) Введите описание инстанса.
   1. (Опционально) Добавьте [метки](../../resource-manager/concepts/labels.md) для разделения инстансов на логические группы.
   1. (Опционально) Установите защиту инстанса от случайного удаления пользователем.

1. В блоке **{{ ui-key.yacloud.gitlab.label_configuration-section }}**:

   1. Выберите [тип инстанса](../../managed-gitlab/concepts/index.md#config). После создания инстанса можно [изменить его тип](../../managed-gitlab/operations/instance/instance-update.md) на более производительный.
   1. Укажите [зону доступности](../../overview/concepts/geo-scope.md). После создания инстанса изменить его зону доступности невозможно.
   1. Укажите [подсеть](../../vpc/concepts/network.md#subnet), в которой будет размещен инстанс. Технические ограничения {{ yandex-cloud }} временно не позволяют выбрать подсеть с диапазоном адресов `192.168.0.0/24`.
   1. Выберите [группу безопасности](../../vpc/concepts/security-groups.md) или создайте новую:

      1. Нажмите кнопку **{{ ui-key.yacloud.component.network-subnet-select.button_create-security-group }}**.
      1. Введите имя и описание группы безопасности. Правила для группы безопасности вы сможете добавить позже в сервисе **{{ vpc-name }}**.
      1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

      {% include [sg-notes](sg-notes.md) %}

   1. Выберите размер [диска](../../compute/concepts/disk.md). После создания инстанса размер его диска [можно увеличить](../../managed-gitlab/operations/instance/instance-update.md).
   1. Укажите [доменное имя инстанса](../../compute/concepts/network.md#hostname) — для него будут автоматически созданы нужные DNS-записи в домене `.gitlab.yandexcloud.net`.

      {% include [domain-name-format](domain-name-format.md) %}

   1. Задайте срок хранения автоматических резервных копий (в днях).
   1. (Опционально) Включите [правила ревью кода](../../managed-gitlab/concepts/approval-rules.md). Для этого выберите подходящую конфигурацию правил ревью.

      {% include [note-approval-rules-pricing](note-approval-rules-pricing.md) %}

1. В блоке **{{ ui-key.yacloud.gitlab.label_admin-section }}** укажите:
   * **{{ ui-key.yacloud.gitlab.field_admin-email }}** — адрес электронной почты администратора инстанса {{ GL }}. На этот адрес придет письмо со ссылкой для создания пароля.
   * **{{ ui-key.yacloud.gitlab.field_admin-login }}** — логин администратора.
1. (Опционально) В блоке **{{ ui-key.yacloud.gitlab.label_additional-section }}** включите удаление образов без тегов. Настройка влияет на свободное место на диске инстанса.
1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
1. Дождитесь, когда инстанс будет готов к работе: его статус на панели {{ mgl-name }} сменится на **Running**. Это может занять некоторое время.
