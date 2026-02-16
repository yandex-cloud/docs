---
title: Как автоматически просканировать Docker-образ при загрузке с помощью {{ TF }}
description: Следуя данному руководству, вы сможете автоматически просканировать Docker-образ при загрузке в {{ container-registry-full-name }} с помощью {{ TF }}.
---

# Автоматическое сканирование Docker-образа при загрузке с помощью {{ TF }}


{% note info %}

Автоматическое [сканирование](../../concepts/vulnerability-scanner.md) [Docker-образов](../../concepts/docker-image.md) на наличие уязвимостей при загрузке в [{{ container-registry-full-name }}](../../../container-registry/) можно включить в [настройках сканера уязвимостей](../../operations/scanning-docker-image.md#automatically) без создания [функций](../../../functions/concepts/function.md) и [триггеров](../../../functions/concepts/trigger/index.md) [{{ sf-full-name }}](../../../functions/).

{% endnote %}

Чтобы настроить автоматическое [сканирование](../../concepts/vulnerability-scanner.md) [Docker-образов](index.md) на наличие уязвимостей при загрузке в [{{ container-registry-full-name }}](../../../container-registry/) с помощью {{ TF }}:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Подготовьте окружение](#prepare).
1. [Создайте инфраструктуру](#deploy).
1. [Загрузите Docker-образ](#download-image).
1. [Проверьте результат](#check-result).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-begin}

{% include [before-you-begin](../../../_tutorials/_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

{% include [paid-resources](../../../_tutorials/_tutorials_includes/image-auto-scan/paid-resources.md) %}

## Подготовьте окружение {#prepare}

1. [Установите и настройте](../../operations/configure-docker.md) Docker.

## Создайте инфраструктуру {#deploy}

{% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

Чтобы создать инфраструктуру для автоматического сканирования Docker-образа при загрузке с помощью {{ TF }}:
1. [Установите {{ TF }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform) и [получите данные для аутентификации](../../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials).
1. Укажите источник для установки провайдера {{ yandex-cloud }} (раздел [{#T}](../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), шаг 1).
1. Подготовьте файлы с описанием инфраструктуры:

   {% list tabs group=infrastructure_description %}

   - Готовая конфигурация {#ready}

     1. Клонируйте репозиторий с конфигурационными файлами.

        ```bash
        git clone https://github.com/yandex-cloud-examples/yc-cr-image-scanning
        ```

     1. Перейдите в директорию с репозиторием. В ней должны появиться файлы:
        * `image-auto-scan.tf` — конфигурация создаваемой инфраструктуры.
        * `image-auto-scan.auto.tfvars` — файл с пользовательскими данными.
        * `function.zip` — zip-архив с кодом функции.

   - Вручную {#manual}

     1. Создайте папку для конфигурационных файлов.
     1. Создайте в папке конфигурационный файл `image-auto-scan.tf`:

        {% cut "image-auto-scan.tf" %}

        {% include [image-auto-scan-tf-config](../../../_tutorials/_tutorials_includes/image-auto-scan/tf-config.md) %}

        {% endcut %}

     1. Создайте файл с пользовательскими данными `image-auto-scan.auto.tfvars`:

        {% cut "image-auto-scan.auto.tfvars" %}

        {% include [image-auto-scan-tf-variables](../../../_tutorials/_tutorials_includes/image-auto-scan/tf-variables.md) %}

        {% endcut %}

     1. Подготовьте zip-архив с кодом функции.
        1. Создайте файл `handler.sh` и скопируйте в него следующий код:

           {% cut "handler.sh" %}

           {% include [warning-unix-lines](../../../_tutorials/_tutorials_includes/warning-unix-lines.md) %}

           {% include [handler-sh-function](../../../_tutorials/_tutorials_includes/handler-sh-function.md) %}

           {% endcut %}

        1. Создайте zip-архив `function.zip` с файлом `handler.sh`.

   {% endlist %}

   Более подробную информацию о параметрах используемых ресурсов в {{ TF }} см. в документации провайдера:
   * [Сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) — [yandex_iam_service_account]({{ tf-provider-resources-link }}/iam_service_account).
   * [Назначение прав доступа к каталогу](../../../iam/concepts/access-control/index.md#access-bindings) — [yandex_resourcemanager_folder_iam_member]({{ tf-provider-resources-link }}/resourcemanager_folder_iam_member).
   * [Реестр](../../../container-registry/concepts/registry.md) — [yandex_container_registry]({{ tf-provider-resources-link }}/container_registry).
   * [Функция](../../../functions/concepts/function.md) — [yandex_function]({{ tf-provider-resources-link }}/function).
   * [Триггер](../../../functions/concepts/trigger/index.md) — [yandex_function_trigger]({{ tf-provider-resources-link }}/function_trigger).

1. В файле `image-auto-scan.auto.tfvars` задайте пользовательские параметры:
   * `zone` — [зона доступности](../../../overview/concepts/geo-scope.md), в которой будет создана инфраструктура.
   * `folder_id` — [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md), в котором будет создана инфраструктура.

1. Создайте ресурсы:

   {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

## Загрузите Docker-образ {#download-image}

{% include [upload-image](../../../_tutorials/_tutorials_includes/image-auto-scan/upload-image.md) %}

## Проверьте результат {#check-result}

{% include [check-result](../../../_tutorials/_tutorials_includes/image-auto-scan/check-result.md) %}

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. Откройте конфигурационный файл `image-auto-scan.tf` и удалите описание создаваемой инфраструктуры из файла.
1. Примените изменения:

    {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

#### См. также {#see-also}

* [{#T}](console.md)