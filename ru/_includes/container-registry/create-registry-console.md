1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором будет создан реестр.
1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_container-registry }}**.
1. Нажмите кнопку **{{ ui-key.yacloud.cr.overview.button_create }}**.
1. Задайте имя реестра. Требования к имени:

    {% include [name-format](../name-format.md) %}

1. (Опционально) В блоке **{{ ui-key.yacloud.cr.overview.popup-create_field_auto_scan }}**:


    * Отключите опцию **{{ ui-key.yacloud.cr.overview.popup-create_scan_push_text }}**, чтобы не сканировать Docker-образы при загрузке в репозиторий.
    * Отключите опцию **{{ ui-key.yacloud.cr.overview.popup-create_scan_period_enabled }}** или настройте периодичность сканирования.

      {% include [safe-registry](../container-registry/safe-registry.md) %}

1. (Опционально) Добавьте метки.
1. Нажмите кнопку **{{ ui-key.yacloud.cr.overview.popup-create_button_create }}**.