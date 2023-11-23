---
title: "Как изменить секрет в {{ lockbox-full-name }}"
description: "Следуя данной инструкции, вы сможете изменить секрет." 
---

# Изменить секрет

Чтобы изменить секрет:

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит секрет.
    1. В списке сервисов выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_lockbox }}**.
    1. В меню слева выберите **{{ ui-key.yacloud.lockbox.label_section-secrets }}**.
    1. Напротив нужного секрета нажмите значок ![image](../../_assets/horizontal-ellipsis.svg).
    1. В открывшемся меню выберите пункт **{{ ui-key.yacloud.common.edit }}**.
    1. Скорректируйте имя и описание секрета, отметьте опцию **{{ ui-key.yacloud.lockbox.forms.field_deletion-protection }}** при необходимости.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI
  
  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для добавления ресурсов в секрет:
     ```bash
     yc lockbox secret update --help
     ```

  1. Выполните команду, указав имя или идентификатор секрета:
     ```bash
     yc lockbox secret update \
       --id <идентификатор_секрета> \
       --new-name <новое_имя_секрета> \
       --description <новое_описание_секрета>
     ```

     Результат:
     ```
     id: e6q2ig0u9b97********
     folder_id: b1gyggt2th59********
     created_at: "2021-11-08T19:23:00.383Z"
     name: <новое_имя_секрета>
     description: <новое_описание_секрета>
     status: ACTIVE
     current_version:
       id: e6q8ma3b6pd1********
       secret_id: e6q2ug0o9b24********
       created_at: "2021-11-08T19:23:00.383Z"
       status: ACTIVE
       payload_entry_keys:
       - <ключ>
     ```

- {{ TF }}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Откройте файл конфигурации Terraform и измените фрагмент с описанием секрета:

     {% cut "Пример описания секрета в конфигурации {{ TF }}" %}

     ```
     ...
     resource "yandex_lockbox_secret" "my_secret" {
       name                = "My secret"
       description         = "test secret from tf"
       folder_id           = "b1gmitvfx321d3********"
       kms_key_id          = "abjp8q2fjfg0s********"
       deletion_protection = true
       labels              = {
         tf-label    = "tf-label-value",
         empty-label = ""
       }
     }
     ...
     ```

     {% endcut %}

  1. Примените изменения:

      {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}

  Проверить изменение секрета и его настроек можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

    ```bash
    yc lockbox secret get <имя_секрета>
    ```

- API

  Чтобы изменить секрет, воспользуйтесь методом REST API [update](../api-ref/Secret/update.md) для ресурса [Secret](../api-ref/Secret/index.md) или вызовом gRPC API [SecretService/Update](../api-ref/grpc/secret_service.md#Update).

{% endlist %}

## См. также {#see-also}

* [{#T}](../concepts/secret.md)
