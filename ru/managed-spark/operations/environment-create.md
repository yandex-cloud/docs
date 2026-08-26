---
title: Создание окружения для кластера {{ SPRK }}
description: Из статьи вы узнаете, как создать окружение для кластера {{ SPRK }}.
keywords:
  - создание окружение для кластера {{ SPRK }}
  - окружение для кластера {{ SPRK }}
---

# Создание окружения

Вы можете [создать окружение с нуля](#create-env) либо [создать новое окружение на основе существующего](#create-copy-env) и отредактировать необходимые параметры.

## Создать окружение {#create-env}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. [Перейдите]({{ link-console-main }}/link/managed-spark) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spark }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/cube.svg) **{{ ui-key.yacloud.spark.label_title-environments }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.spark.Spark.EnvironmentsList.button_create_sqDYH }}**.
  1. В блоке **{{ ui-key.yacloud.spark.EnvironmentForm.EnvironmentFormContent.section_general_fDK9S }}**:
     
     1. Задайте имя окружения.
     1. (Опционально) Введите описание окружения.
     1. (Опционально) Создайте [метки](../../resource-manager/concepts/labels.md):

        1. Нажмите кнопку **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
        1. Введите метку в формате `ключ: значение`.
        1. Нажмите **Enter**.

  1. В блоке **{{ ui-key.yacloud.spark.EnvironmentForm.EnvironmentFormContent.section_base-environment_tkR1g }}** выберите необходимое базовое окружение из списка.
  1. В блоке **{{ ui-key.yacloud.spark.EnvironmentForm.EnvironmentFormContent.section_packages_oct8m }}**:

     * **{{ ui-key.yacloud.spark.EnvironmentForm.EnvironmentFormContent.field_pip-packages_rnW6Y }}** — названия pip-пакетов через пробел, чтобы установить дополнительные библиотеки и приложения в окружение.
     * **{{ ui-key.yacloud.spark.EnvironmentForm.EnvironmentFormContent.field_deb-packages_htNFj }}** — названия deb-пакетов через пробел, чтобы установить дополнительные библиотеки и приложения в окружение.

     При необходимости задайте ограничения на версии устанавливаемых пакетов, например:

     ```text
     py4j>=0.10.9.7 pandas>=1.05 grpcio>=1.48,<1.57 grpcio-status>=1.48,<1.57 googleapis-common-protos==1.56.4
     ```

     Формат названия пакета и выбор версии определены командой установки: `pip install` — для pip-пакетов, `apt install` — для deb-пакетов.

     {% note warning %}
   
     Список пакетов нельзя изменить после создания окружения. Если вы хотите изменить список пакетов, [создайте новое окружение на основе существующего](#create-copy-env) и внесите необходимые изменения.
   
     {% endnote %}

  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

       {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Получите список базовых окружений с помощью вызова [EnvironmentService/ListBase](../environment/api-ref/grpc/Environment/listBase.md):

       ```bash
       grpcurl \
         -format json \
         -import-path ~/cloudapi/ \
         -import-path ~/cloudapi/third_party/googleapis/ \
         -proto ~/cloudapi/yandex/cloud/spark/v1/environment/environment_service.proto \
         -rpc-header "Authorization: Bearer $IAM_TOKEN" \
         -d '{
                "folder_id": "<идентификатор_каталога>"
            }' \
         {{ api-host-spark }}:{{ port-https }} \
         yandex.cloud.spark.v1.environment.EnvironmentService.ListBase
       ```

       Идентификатор каталога можно получить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).

    1. Воспользуйтесь вызовом [EnvironmentService/Create](../environment/api-ref/grpc/Environment/create.md), чтобы создать окружение:

       ```bash
       grpcurl \
         -format json \
         -import-path ~/cloudapi/ \
         -import-path ~/cloudapi/third_party/googleapis/ \
         -proto ~/cloudapi/yandex/cloud/spark/v1/environment/environment_service.proto \
         -rpc-header "Authorization: Bearer $IAM_TOKEN" \
         -d '{
                "base_id": "<идентификатор_базового_окружения>",
                "folder_id": "<идентификатор_каталога>",
                "name": "<имя_окружения>",
                "description": "<описание_окружения>",
                "labels": {
                  "<ключ_метки>": "<значение_метки>"
                },
                "config": {
                  "pip_packages": [
                    "<pip_пакет_1>",
                    "<pip_пакет_2>"
                  ],
                  "deb_packages": [
                    "<deb_пакет_1>",
                    "<deb_пакет_2>"
                  ]
                }
            }' \
         {{ api-host-spark }}:{{ port-https }} \
         yandex.cloud.spark.v1.environment.EnvironmentService.Create
       ```

       Где:

       * `base_id` — идентификатор базового окружения, полученный на предыдущем шаге;
       * `folder_id` — идентификатор каталога;
       * `name` — имя окружения;
       * `description` — описание окружения;
       * `labels` — метки окружения;
       * `config` — параметры пакетов, которые нужно установить в окружение:

          * `pip_packages` — список pip-пакетов;
          * `deb_packages` — список deb-пакетов.

          При необходимости задайте ограничения на версии устанавливаемых пакетов, например:

          ```json
          "pip_packages": [
            "pandas==2.1.1",
            "scikit-learn>=1.0.0",
            "clickhouse-driver~=0.2.0"
          ]
          ```

          Формат названия пакета и выбор версии определяются командами установки: `pip install` — для pip-пакетов, `apt install` — для deb-пакетов.

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../environment/api-ref/grpc/Environment/create.md#yandex.cloud.operation.Operation).

{% endlist %}

## Создать новое окружение на основе существующего {#create-copy-env}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. [Перейдите]({{ link-console-main }}/link/managed-spark) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spark }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/cubes-3.svg) **{{ ui-key.yacloud.spark.label_title-environments }}**.
  1. Выберите в списке необходимое окружение, перейдите в него и нажмите кнопку ![image](../../_assets/console-icons/copy-plus.svg) **{{ ui-key.yacloud.spark.EnvironmentActions.button_action-copy_dFws4 }}** на панели сверху.
  1. Добавьте или измените необходимые параметры окружения.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}
