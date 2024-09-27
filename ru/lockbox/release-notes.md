---
title: "История изменений в {{ lockbox-full-name }}"
description: "В разделе представлена история изменений сервиса {{ lockbox-name }}."
---

# История изменений в {{ lockbox-full-name }}

## III квартал 2024 {#q3-2024}

* Добавлена возможность генерировать секреты автоматически. Для [генерируемых секретов](concepts/secret.md#secret-type) можно настроить длину и указать состав символов.
* Добавлен новый ресурс `yandex_lockbox_secret_version_hashed`, который позволяет хранить в состоянии {{ TF }} секретное значение в зашифрованном виде. Этот ресурс используется при [создании новой версии секрета](operations/secret-version-manage.md#create-version) и рекомендуется вместо `yandex_lockbox_secret_version`. Поддержка `yandex_lockbox_secret_version` также остается.
* Появилась возможность запланировать [удаление версии секрета](operations/secret-version-manage.md#set-deleting-time) через {{ TF }} для ресурсов `yandex_lockbox_secret_version_hashed` и `yandex_lockbox_secret_version`.
* Добавлена возможность хранить ключи для сервисных аккаунтов {{ iam-short-name }} в состоянии {{ TF }} в защищенном виде. Для этого они размещаются в {{ lockbox-name }} с помощью параметра `output_to_lockbox`. Параметр можно указать для ресурсов: `yandex_iam_service_account_key`, `yandex_iam_service_account_api_key` и `yandex_iam_service_account_static_access_key`.