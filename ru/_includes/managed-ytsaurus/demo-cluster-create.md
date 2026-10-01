1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать кластер {{ myt-name }}.
1. [Перейдите]({{ link-console-main }}/link/managed-ytsaurus) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-ytsaurus }}**.
1. Нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
1. Выберите **{{ ui-key.yacloud.managed-ytsaurus.clusters.YTSaurusClusterCreatePage.cluster-kind-card_demo_title_4B7zu }}** для создания кластера с минимальной рабочей конфигурацией.
1. В блоке **{{ ui-key.yacloud.managed-ytsaurus.clusters.YTSaurusClusterCreatePage.base-params-section_title_nfKo2 }}**:

    1. Задайте имя кластера. Имя должно быть уникальным в рамках каталога.
    1. (Опционально) Введите описание кластера.
    1. (Опционально) Создайте [метки](../../resource-manager/concepts/labels.md):

        1. Нажмите кнопку **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
        1. Введите метку в формате `ключ: значение`.
        1. Нажмите **Enter**.

1. В блоке **{{ ui-key.yacloud.managed-ytsaurus.clusters.YTSaurusClusterCreatePage.net-settings-section_title_wo42X }}** выберите:

    * [Зону доступности](../../overview/concepts/geo-scope.md) для размещения кластера.
    * [Подсеть](../../vpc/operations/subnet-create.md).
    * (Опционально) [Группу безопасности](../../vpc/concepts/security-groups.md) для сетевого трафика кластера.

        {% note warning %}

        Зону доступности, подсеть и группы безопасности нельзя изменить после создания кластера.

        {% endnote %}

    * (Опционально) В поле **{{ ui-key.yacloud.managed-ytsaurus.clusters.NetworkSettingsForm.field_cidr-blocks-whitelist_label_hL9Hc }}** укажите разрешенные диапазоны IPv4-адресов в формате CIDR для доступа к кластеру из интернета, например `203.0.113.0/24`.

        {% include [cidr-blocks-whitelist](cidr-blocks-whitelist.md) %}

1. В блоке **{{ ui-key.yacloud.managed-ytsaurus.clusters.YTSaurusClusterCreatePage.cluster-config-section_title_fPkN8 }}** ознакомьтесь с параметрами конфигурации кластера.
1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
1. Дождитесь, когда кластер будет готов к работе: его статус на панели {{ myt-name }} сменится на **Running**. Это может занять продолжительное время.
