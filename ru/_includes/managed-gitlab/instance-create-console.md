1. В консоли управления выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно создать [инстанс {{ GL }}](../../managed-gitlab/concepts/index.md#instance).
1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-gitlab }}**.
1. Нажмите кнопку **{{ ui-key.yacloud.gitlab.button_create-instance }}**.
1. В блоке **{{ ui-key.yacloud.compute.group.overview.section_base }}**:

   1. Введите имя инстанса. Оно должно быть уникальным в рамках {{ yandex-cloud }}.

      {% include [name-format](../name-format.md) %}

   1. (Опционально) Введите описание инстанса.

1. В блоке **{{ ui-key.yacloud.gitlab.label_configuration-section }}**:

   1. Выберите тип инстанса.
   1. Укажите [подсеть](../../vpc/concepts/network.md#subnet), в которой будет размещен инстанс. Технические ограничения {{ yandex-cloud }} временно не позволяют выбрать подсеть с диапазоном адресов `192.168.0.0/24`.

      {% note warning %}

      Будет использована [группа безопасности по умолчанию](../../vpc/concepts/security-groups.md#default-security-group) для выбранной [сети](../../vpc/concepts/network.md#network). Выбрать другую при создании инстанса нельзя. Для подключения может потребоваться дополнительная [настройка](../../managed-gitlab/operations/connect.md#configuring-security-groups) группы безопасности по умолчанию.

      {% endnote %}

   1. Выберите размер [диска](../../compute/concepts/disk.md).
   1. Укажите [доменное имя инстанса](../../compute/concepts/network.md#hostname) — для него будут автоматически созданы нужные DNS-записи в домене `.gitlab.yandexcloud.net`.

      Доменное имя должно быть уникальным в рамках {{ yandex-cloud }}.

      * Длина — от 5 до 50 символов.
      * Может содержать строчные буквы латинского алфавита, цифры и дефисы.
      * Первый и последний символ — не дефис.

   1. Задайте срок хранения автоматических резервных копий (в днях).
   1. (Опционально) Измените время начала резервного копирования. Значение по умолчанию — 00:00 UTC (Coordinated Universal Time). Резервное копирование начинается в течение получаса от указанного времени.

1. В блоке **{{ ui-key.yacloud.gitlab.label_admin-section }}** укажите:
   * **{{ ui-key.yacloud.gitlab.field_admin-email }}** — адрес электронной почты администратора инстанса {{ GL }}. На этот адрес придет письмо со ссылкой для создания пароля.
   * **{{ ui-key.yacloud.gitlab.field_admin-login }}** — логин администратора.
1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
1. Дождитесь, когда инстанс будет готов к работе: его статус на панели {{ mgl-name }} сменится на **Running**. Это может занять некоторое время.
