1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором будет храниться телеметрия.
1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
1. Введите имя сервисного аккаунта, например `monium-sa`.
1. Нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** и добавьте [роль](../../monium/security/index.md#monium-telemetry-writer) `monium.telemetry.writer`.

    Если вы планируете передавать только некоторые типы данных, вместо `monium.telemetry.writer` выберите одну или несколько ролей с более узкими наборами разрешений: `monium.metrics.writer`, `monium.logs.writer`, `monium.traces.writer`.
1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.
1. В открывшемся списке выберите созданный сервисный аккаунт.
1. На панели сверху нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}** и выберите пункт **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_api_key }}**.
1. Выберите **{{ ui-key.yacloud.iam.folder.service-account.overview.field_key-scope }}** — `yc.monium.telemetry.write`.

    Если вы планируете передавать только некоторые типы данных, вместо `yc.monium.telemetry.write` выберите одну или несколько более узких [областей действия](../../iam/concepts/authorization/api-key.md#scoped-api-keys): `yc.monium.metrics.write`, `yc.monium.logs.write`, `yc.monium.traces.write`.
1. (Опционально) Укажите **{{ ui-key.yacloud.iam.folder.service-account.overview.field_key-expires-at }}** создаваемого API-ключа.
1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**.
1. Сохраните полученный секретный ключ — он понадобится на следующем шаге.

    После закрытия окна повторно посмотреть секретный ключ будет нельзя.
