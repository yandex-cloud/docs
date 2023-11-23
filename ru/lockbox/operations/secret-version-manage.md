---
title: "Как управлять версиями секрета в {{ lockbox-full-name }}"
description: "Следуя данной инструкции, вы сможете управлять версиями секрета." 
---

# Управление версиями секрета

Управление версиями секрета позволяет:

* [Создать новую версию](#create-version).
* [Получить информацию о версии](#get-version).
* [Создать версию на основе существующей](#create-version-based-on-other).
* [Откатиться к определенной версии](#backup).
* [Запланировать удаление версии](#set-deleting-time).

## Создать новую версию {#create-version}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит секрет.
    1. В списке сервисов выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_lockbox }}**.
    1. Нажмите на имя нужного секрета.
    1. В разделе **{{ ui-key.yacloud.lockbox.label_secret-versions-section }}** нажмите **{{ ui-key.yacloud.lockbox.button_add-version }}**.
    1. Добавьте следующие параметры:
        * (Опционально) **{{ ui-key.yacloud.common.description }}** — описание версии.
        * **{{ ui-key.yacloud.lockbox.forms.label_key }}** — несекретное название для значения, по которому вы будете его идентифицировать.
        * **{{ ui-key.yacloud.lockbox.forms.label_value }}** — секретные данные в явном виде.
        Вы можете создать несколько пар ключей и значений в одной версии.
    1. Нажмите кнопку **{{ ui-key.yacloud.lockbox.button_add-version }}**.

- {{ TF }}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

     
     ```
     terraform {
       required_providers {
         yandex = {
           source = "yandex-cloud/yandex"
         }
       }
       required_version = ">= 0.13"
     }
     provider "yandex" {
       zone = "{{ region-id }}-a"
     }

     resource "yandex_lockbox_secret_version" "my_version" {
       secret_id = "<идентификатор_секрета>"
       entries {
         key        = "<ключ_секрета_1>"
         text_value = "<значение_секрета_1>"
       }
       entries {
         key        = "<ключ_секрета_2>"
         text_value = "<значение_секрета_2>"
       }
     }
     ```



     Где:

     * `secret_id` — идентификатор секрета, для которого создается версия. Обязательный параметр.
     * `entries` — блок с параметрами секрета. Для каждого секрета необходимо создать отдельный блок `entries`. Может содержать следующие параметры:
        * `key` — ключ секрета — несекретное название для значения, по которому вы будете его идентифицировать. Обязательный параметр.
        * `text_value` — секретные данные в явном виде. Обязательный параметр.

      Более подробную информацию о параметрах ресурса `yandex_lockbox_secret_version` в Terraform, см. в [документации провайдера]({{ tf-provider-resources-link }}/lockbox_secret_version).

  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}

  После этого для указанного секрета будет создана версия. Проверить появление версии и ее настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

    ```bash
    yc lockbox secret list-versions <идентификатор_секрета>
    ```

- API

  Чтобы создать новую версию секрета, воспользуйтесь методом REST API [addVersion](../api-ref/Secret/addVersion.md) для ресурса [Secret](../api-ref/Secret/index.md) или вызовом gRPC API [SecretService/AddVersion](../api-ref/grpc/secret_service.md#AddVersion).

{% endlist %}

## Получить информацию о версии {#get-version}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит секрет.
    1. В списке сервисов выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_lockbox }}**.
    1. Нажмите на имя нужного секрета.
    1. В разделе **{{ ui-key.yacloud.lockbox.label_secret-versions-section }}** будет показан список всех версий секрета и информация о них.
    1. Нажмите на нужную версию, чтобы получить информацию о ее парах ключ — значение.

- API

  Чтобы получить информацию о версии, воспользуйтесь методом REST API [listVersions](../api-ref/Secret/listVersions.md) для ресурса [Secret](../api-ref/Secret/index.md) или вызовом gRPC API [SecretService/ListVersions](../api-ref/grpc/secret_service.md#ListVersions).

{% endlist %}

## Создать версию на основе существующей {#create-version-based-on-other}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит секрет.
    1. В списке сервисов выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_lockbox }}**.
    1. Нажмите на имя нужного секрета.
    1. В разделе **{{ ui-key.yacloud.lockbox.label_secret-versions-section }}**, напротив нужной версии нажмите ![image](../../_assets/horizontal-ellipsis.svg).
    1. Выберите пункт **{{ ui-key.yacloud.lockbox.button_action-open-version-add-dialog }}**.
    1. Измените или добавьте следующие параметры:
        * (Опционально) **{{ ui-key.yacloud.common.description }}** — описание версии.
        * **{{ ui-key.yacloud.lockbox.forms.label_key }}** — несекретное название для значения, по которому вы будете его идентифицировать.
        * **{{ ui-key.yacloud.lockbox.forms.label_value }}** — секретные данные в явном виде.
        Вы можете создать несколько пар ключей и значений в одной версии.
    1. Нажмите кнопку **{{ ui-key.yacloud.lockbox.button_add-version }}**.

- API

  Чтобы создать версию на основе существующей, воспользуйтесь методом REST API [addVersion](../api-ref/Secret/addVersion.md) для ресурса [Secret](../api-ref/Secret/index.md) или вызовом gRPC API [SecretService/AddVersion](../api-ref/grpc/secret_service.md#AddVersion).

{% endlist %}

## Изменить текущую версию {#backup}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит секрет.
    1. В списке сервисов выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_lockbox }}**.
    1. Нажмите на имя нужного секрета.
    1. В разделе **{{ ui-key.yacloud.lockbox.label_secret-versions-section }}**, напротив нужной версии нажмите ![image](../../_assets/horizontal-ellipsis.svg).
    1. Выберите пункт **{{ ui-key.yacloud.lockbox.field_make-version-current }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.lockbox.button_action-make-version-current }}**.

- API

  Чтобы изменить текущую версию, воспользуйтесь методом REST API [addVersion](../api-ref/Secret/addVersion.md) для ресурса [Secret](../api-ref/Secret/index.md) или вызовом gRPC API [SecretService/AddVersion](../api-ref/grpc/secret_service.md#AddVersion) с указанием целевой версии.

{% endlist %}

## Запланировать удаление версии {#set-deleting-time}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит секрет.
    1. В списке сервисов выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_lockbox }}**.
    1. Нажмите на имя нужного секрета.
    1. В разделе **{{ ui-key.yacloud.lockbox.label_secret-versions-section }}**, напротив нужной версии нажмите ![image](../../_assets/horizontal-ellipsis.svg).
    1. Выберите пункт **{{ ui-key.yacloud.lockbox.button_action-schedule-for-destruction }}**.
    1. Введите время до удаления.
    1. Нажмите кнопку **{{ ui-key.yacloud.lockbox.forms.button_schedule-destruction }}**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для планирования удаления версии:

      ```bash
      yc lockbox secret schedule-version-destruction --help
      ```
  1. Запланируйте удаление версии, указав имя секрета, идентификатор версии и время до удаления. Например 1 неделя — `168h`:
      
      ```bash
      yc lockbox secret schedule-version-destruction <имя_секрета> \
        --version-id <идентификатор_версии> \
        --pending-period 168h
      ```
      Результат:

      ```bash      
      id: e6qor8pe3ju7********
      secret_id: e6qkkp3k29jf********
      created_at: "2023-11-08T13:14:34.676Z"
      destroy_at: "2023-11-15T17:06:28.795Z"
      status: SCHEDULED_FOR_DESTRUCTION
      payload_entry_keys:
        - secret-key
      ```

- API

  Чтобы запланировать удаление версии, воспользуйтесь методом REST API [scheduleVersionDestruction](../api-ref/Secret/addVersion.md) для ресурса [Secret](../api-ref/Secret/index.md) или вызовом gRPC API [SecretService/ScheduleVersionDestruction](../api-ref/grpc/secret_service.md#ScheduleVersionDestruction).

{% endlist %}

## См. также {#see-also}

* [{#T}](../concepts/secret.md)
