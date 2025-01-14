---
title: Как создать профиль безопасности ARL {{ sws-full-name }}
description: Следуя данной инструкции, вы сможете создать профиль безопасности ARL {{ sws-full-name }}.
---

# Создать профиль ARL

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы хотите создать [профиль ARL](../concepts/arl.md).
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. На панели слева выберите ![image](../../_assets/smartwebsecurity/arl.svg) **{{ ui-key.yacloud.smart-web-security.arl.label_profiles }}** и нажмите кнопку **{{ ui-key.yacloud.smart-web-security.arl.label_create-profile }}**.
  1. Введите имя профиля.
  1. (опционально) Введите описание.
  1. (опционально) Добавьте профилю [метки](../../resource-manager/concepts/labels.md).
  1. [Добавьте](arl-rule-add.md) правила ARL.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

### См. также {#see-also}

* [{#T}](arl-rule-add.md)
* [{#T}](profile-update.md)
* [{#T}](arl-profile-delete.md)
