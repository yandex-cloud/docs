---
title: '{{ lockbox-full-name }} release notes'
description: This section contains {{ lockbox-name }} release notes.
---

# {{ lockbox-full-name }} release notes

## Q3 2024 {#q3-2024}

* Added the ability to generate secrets automatically. For [generated secrets](concepts/secret.md#secret-type) you can customize the length and specify the character composition.
* Added a new `yandex_lockbox_secret_version_hashed` resource, which allows storing a secret value in the {{ TF }} state in encrypted form. This resource is used when [creating a new version of the secret](operations/secret-version-manage.md#create-version) and is recommended instead of `yandex_lockbox_secret_version`. We also continue supporting `yandex_lockbox_secret_version`.
* It is now possible to schedule [secret version deletion](operations/secret-version-manage.md#set-deleting-time) via {{ TF }} for the `yandex_lockbox_secret_version_hashed` and `yandex_lockbox_secret_version` resources.
* Added the ability to store keys for {{ iam-short-name }} service accounts in the {{ TF }} state in a secure form. To do this, place them in {{ lockbox-name }} using the `output_to_lockbox` parameter. You can specify this parameter for the `yandex_iam_service_account_key`, `yandex_iam_service_account_api_key`, and `yandex_iam_service_account_static_access_key` resources.