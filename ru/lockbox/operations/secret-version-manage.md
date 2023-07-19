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
    1. В списке сервисов выберите сервис **{{ lockbox-short-name }}**.
    1. Нажмите на имя нужного секрета.
    1. В разделе **Версии** нажмите **Добавить версию**.
    1. Добавьте следующие параметры:
        * (опционально) **Описание** — описание версии.
        * **Ключ** — несекретное название для значения, по которому вы будете его идентифицировать.
        * **Значение** — секретные данные в явном виде.
        Вы можете создать несколько пар ключей и значений в одной версии.
    1. Нажмите кнопку **Добавить версию**.

- {{ TF }}

  Если у вас ещё нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

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
         key        = "<ключ_секрета1>"
         text_value = "<значение_секрета1>"
       }
       entries {
         key        = "<ключ_секрета2>"
         text_value = "<значение_секрета2>"
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
    1. В списке сервисов выберите сервис **{{ lockbox-short-name }}**.
    1. Нажмите на имя нужного секрета.
    1. В разделе **Версии** будет показан список всех версий секрета и информация о них.
    1. Нажмите на нужную версию, чтобы получить информацию о ее парах ключ — значение.

- API

  Чтобы получить информацию о версии, воспользуйтесь методом REST API [listVersions](../api-ref/Secret/listVersions.md) для ресурса [Secret](../api-ref/Secret/index.md) или вызовом gRPC API [SecretService/ListVersions](../api-ref/grpc/secret_service.md#ListVersions).

{% endlist %}

## Создать версию на основе существующей {#create-version-based-on-other}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит секрет.
    1. В списке сервисов выберите сервис **{{ lockbox-short-name }}**.
    1. Нажмите на имя нужного секрета.
    1. В разделе **Версии**, напротив нужной версии нажмите ![image](../../_assets/horizontal-ellipsis.svg).
    1. Выберите пункт **Создать новую версию на основе этой**.
    1. Измените или добавьте следующие параметры:
        * (опционально) **Описание** — описание версии.
        * **Ключ** — несекретное название для значения, по которому вы будете его идентифицировать.
        * **Значение** — секретные данные в явном виде.
        Вы можете создать несколько пар ключей и значений в одной версии.
    1. Нажмите кнопку **Добавить версию**.

- API

  Чтобы создать версию на основе существующей, воспользуйтесь методом REST API [addVersion](../api-ref/Secret/addVersion.md) для ресурса [Secret](../api-ref/Secret/index.md) или вызовом gRPC API [SecretService/AddVersion](../api-ref/grpc/secret_service.md#AddVersion).

{% endlist %}

## Откатиться к определенной версии {#backup}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит секрет.
    1. В списке сервисов выберите сервис **{{ lockbox-short-name }}**.
    1. Нажмите на имя нужного секрета.
    1. В разделе **Версии**, напротив нужной версии нажмите ![image](../../_assets/horizontal-ellipsis.svg).
    1. Выберите пункт **Откатить до этой версии**.
    1. Нажмите кнопку **Откатить**.

- API

  Чтобы откатиться к существующей версии, воспользуйтесь методом REST API [addVersion](../api-ref/Secret/addVersion.md) для ресурса [Secret](../api-ref/Secret/index.md) или вызовом gRPC API [SecretService/AddVersion](../api-ref/grpc/secret_service.md#AddVersion) с указанием целевой версии.

{% endlist %}

## Запланировать удаление версии {#set-deleting-time}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит секрет.
    1. В списке сервисов выберите сервис **{{ lockbox-short-name }}**.
    1. Нажмите на имя нужного секрета.
    1. В разделе **Версии**, напротив нужной версии нажмите ![image](../../_assets/horizontal-ellipsis.svg).
    1. Выберите пункт **Запланировать удаление**.
    1. Введите время до удаления.
    1. Нажмите кнопку **Запланировать**.

- API

  Чтобы запланировать удаление версии, воспользуйтесь методом REST API [scheduleVersionDestruction](../api-ref/Secret/addVersion.md) для ресурса [Secret](../api-ref/Secret/index.md) или вызовом gRPC API [SecretService/ScheduleVersionDestruction](../api-ref/grpc/secret_service.md#ScheduleVersionDestruction).

{% endlist %}

## См. также {#see-also}

* [{#T}](../concepts/secret.md)
