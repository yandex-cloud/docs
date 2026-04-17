1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором будет храниться телеметрия.
1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
1. Введите имя сервисного аккаунта, например `monium-ca`.
1. Нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** и добавьте `monium.telemetry.writer`.
   Если вы планируете передавать только некоторые типы данных, вместо `monium.telemetry.writer` выберите одну или несколько ролей: `monium.metrics.writer`, `monium.logs.writer`, `monium.traces.writer`.

1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.
1. Выберите созданный аккаунт в списке.
1. На панели сверху нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}** и выберите пункт **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_api_key }}**.
1. Выберите **{{ ui-key.yacloud.iam.folder.service-account.overview.field_key-scope }}** — `yc.monium.telemetry.write`.
   Если вы планируете передавать только некоторые типы данных, вместо `yc.monium.telemetry.write` выберите одну или несколько ролей: `yc.monium.metrics.write`, `yc.monium.logs.write`, `yc.monium.traces.write`.
1. (Опционально) Укажите **{{ ui-key.yacloud.iam.folder.service-account.overview.field_key-expires-at }}**.
1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**.
1. Сохраните секретный ключ, он понадобится на следующем шаге.