# Создать профиль ARL

{% include [note-preview-arl](../../_includes/smartwebsecurity/note-preview-arl.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите создать профиль ARL.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. Перейдите на вкладку ![image](../../_assets/smartwebsecurity/arl.svg) **Профили ARL** и нажмите кнопку **Создать профиль ARL**.
  1. Опишите, как вы планируете использовать ARL, и нажмите кнопку **Отправить заявку**.

      После одобрения заявки вы сможете перейти к созданию профиля ARL.
  1. Введите имя профиля.
  1. (опционально) Введите описание.
  1. (опционально) Добавьте профилю [метку](../../resource-manager/concepts/labels.md).
  1. [Добавьте правила ARL](arl-rule-add.md).
  1. Нажмите кнопку **Создать**.

{% endlist %}

### См. также {#see-also}

* [{#T}](arl-rule-add.md)
* [{#T}](profile-update.md)
* [{#T}](arl-profile-delete.md)