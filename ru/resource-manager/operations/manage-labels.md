---
title: Управление метками в {{ resmgr-full-name }}
description: Добавление, изменение и удаление меток ресурсов с помощью консоли управления, CLI, Terraform и API в {{ resmgr-name }}.
---

# Управление метками

Вы можете добавить, удалить или изменить [метку](../concepts/labels.md#services) ресурса с помощью консоли управления, командной строки {{ yandex-cloud }}, {{ TF }} и API.

Метки поддерживаются в определенных [сервисах](../concepts/labels.md#services). Управление метками в некоторых сервисах может отличаться, например в [{{ objstorage-name }}](../../storage/operations/buckets/tagging.md).

## Добавить метку {#add-label}

{% list tabs group=instructions %}

- Консоль управления {#console}

  В примере ниже показано добавление метки к виртуальной машине {{ compute-name }}. Аналогично вы можете добавить метку другому ресурсу.

  1. В [консоли управления]({{ link-console-main }}) на панели сверху нажмите ![image](../../_assets/console-icons/layout-side-content-left.svg) или ![image](../../_assets/console-icons/chevron-down.svg) и выберите каталог, в котором находится ВМ.
  1. [Перейдите]({{ link-console-main }}/link/resource-manager) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}**.
  1. В списке ВМ выберите нужную.
  1. Нажмите ![horizontal-ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.edit }}**.
  1. В поле **{{ ui-key.yacloud.component.label-set.label_labels }}** нажмите **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
  1. Введите ключ и значение и нажмите **Enter**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы добавить или обновить существующую метку ресурса сервиса, воспользуйтесь командой:

  ```
  yc <имя_сервиса> <тип_ресурса> add-labels <имя_или_идентификатор_ресурса> \
    --labels <имя_метки>=<значение_метки>
  ```

  **Пример**

  Добавить метку виртуальной машине:

  > ```
  > yc compute instance add-labels cl123g4dridnn5cn****-**** --labels project=test
  > ```
  >
  > Результат:
  > 
  > ```
  > done (5s)
  > id: fhm1pr2bu3p4********
  > folder_id: b1g23ga45mev********
  > created_at: "2020-08-07T11:29:18Z"
  > name: cl123g4dridnn5cn****-****
  > labels:
  >   project: test
  > zone_id: {{ region-id }}-a
  > ...
  > ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Добавьте к ресурсу в конфигурационном файле следующий фрагмент:

      ```
        labels = {
          <ключ_метки> = "<значение_метки>"
        }
      ```

  1. Примените изменения:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  После этого к ресурсу будет добавлена метка. Проверить появление метки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

  ```
  yc <имя_сервиса> <тип_ресурса> get <имя_или_идентификатор_ресурса>
  ``` 

  **Пример**

  Описание метки для секрета {{ lockbox-name }}:

  > ```
  > resource "yandex_lockbox_secret" "my_secret" {
  >   name   = lockbox-test-secret
  >   labels = {
  >     label-test-key = "label-test-value"
  >   }
  > }
  > ```

- API {#api}

    Чтобы добавить метку облака или каталога, воспользуйтесь одним из методов:

    * Для облака — методом REST API [update](../api-ref/Cloud/update.md) для ресурса [Cloud](../api-ref/Cloud/index.md) или вызовом gRPC API [CloudService/Update](../api-ref/grpc/Cloud/update.md).
    * Для каталога — методом REST API [update](../api-ref/Folder/update.md) для ресурса [Folder](../api-ref/Folder/index.md) или вызовом gRPC API [FolderService/Update](../api-ref/grpc/Folder/update.md).

    Получите текущие метки методом [Cloud.get](../api-ref/Cloud/get.md) или [Folder.get](../api-ref/Folder/get.md). Добавьте новую пару ключ–значение к текущему набору меток.

    В запросе на изменение укажите `updateMask: "labels"` и полный итоговый набор меток в `labels`, включая метки, которые требуется сохранить. Переданный набор заменяет существующие метки ресурса.

{% endlist %}

Вы можете завести одну метку с несколькими значениями. Например, создать метку `my-cloud` с несколькими значениями:

* `my-vm` — для виртуальной машины;
* `my-disk` — для диска.

## Изменить метку {#update-label}

Изменить метки ресурса можно с помощью командной строки {{ yandex-cloud }}, {{ TF }} и API.

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  {% include [labels-rewrite-warning](../../_includes/labels-rewrite-warning.md) %}

  Чтобы изменить метку ресурса сервиса воспользуйтесь командой:

  ```
  yc <имя_сервиса> <тип_ресурса> update <имя_или_идентификатор_ресурса> \
    --labels <имя_метки>=<значение_метки>
  ```

  **Пример**
  
  Изменение метки для кластера {{ k8s }}:

  > ```
  > yc managed-kubernetes cluster update k8s-gpu --labels new_lable=test_label
  > ```
  >
  > Результат:
  >
  > ```
  > done (1m36s)
  > id: cat1hknor234********
  > folder_id: b1g23ga45mev********
  > created_at: "2020-08-07T11:15:59Z"
  > name: cluster
  > labels:
  >   new_lable: test_label
  > status: RUNNING
  > ...
  > ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Найдите в конфигурационном файле следующий фрагмент:

      ```
        labels = {
          <ключ_метки> = <значение_метки>
        }
      ```

  1. Измените ключ и значение метки на новые.
  1. Примените изменения:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  После этого у ресурса будет изменена метка. Проверить изменение метки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

  ```
  yc <имя_сервиса> <тип_ресурса> get <имя_или_идентификатор_ресурса>
  ``` 

- API {#api}

    Чтобы изменить метку облака или каталога, воспользуйтесь одним из методов:

    * Для облака — методом REST API [update](../api-ref/Cloud/update.md) для ресурса [Cloud](../api-ref/Cloud/index.md) или вызовом gRPC API [CloudService/Update](../api-ref/grpc/Cloud/update.md).
    * Для каталога — методом REST API [update](../api-ref/Folder/update.md) для ресурса [Folder](../api-ref/Folder/index.md) или вызовом gRPC API [FolderService/Update](../api-ref/grpc/Folder/update.md).

    Получите текущие метки методом [Cloud.get](../api-ref/Cloud/get.md) или [Folder.get](../api-ref/Folder/get.md). Измените нужную пару ключ–значение в текущем наборе меток.

    В запросе на изменение укажите `updateMask: "labels"` и полный итоговый набор меток в `labels`, включая метки, которые требуется сохранить. Переданный набор заменяет существующие метки ресурса.

{% endlist %}

## Удалить метку {#remove-label}

{% list tabs group=instructions %}

- Консоль управления {#console}

  В примере ниже показано удаление метки виртуальной машины {{ compute-name }}. Аналогично вы можете удалить метку другого ресурса.

  1. В [консоли управления]({{ link-console-main }}) на панели сверху нажмите ![image](../../_assets/console-icons/layout-side-content-left.svg) или ![image](../../_assets/console-icons/chevron-down.svg) и выберите каталог, в котором находится ВМ.
  1. [Перейдите]({{ link-console-main }}/link/resource-manager) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}**.
  1. В списке ВМ выберите нужную.
  1. Нажмите ![horizontal-ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.edit }}**.
  1. В поле **{{ ui-key.yacloud.component.label-set.label_labels }}** выберите нужную метку и нажмите ![cross](../../_assets/console-icons/xmark.svg) справа от ее имени.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Удалите метку ресурса сервиса:

  ```
  yc <имя_сервиса> <тип_ресурса> remove-labels <имя_или_идентификатор_ресурса> \
    --labels <имя_метки>
  ```
  
  **Пример**
  
  Удаление метки для кластера {{ mmy-short-name }}:

  > ```
  > yc managed-mysql cluster remove-labels mysql123 --labels my_lable
  > ```
  >
  > Результат:
  >
  > ```
  > id: c1qmjaatlurm********
  > folder_id: b1g23ga45mev********
  > created_at: "2020-08-20T11:53:20.015543Z"
  > name: mysql123
  > environment: PRODUCTION
  > ...
  > ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Найдите в конфигурационном файле следующий фрагмент:

      ```
        labels = {
          <ключ_метки> = "<значение_метки>"
        }
      ```

  1. Удалите фрагмент.
  1. Примените изменения:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  После этого у ресурса будет удалена метка. Проверить удаление метки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

  ```
  yc <имя_сервиса> <тип_ресурса> get <имя_или_идентификатор_ресурса>
  ``` 

- API {#api}

    Чтобы удалить метку облака или каталога, воспользуйтесь одним из методов:

    * Для облака — методом REST API [update](../api-ref/Cloud/update.md) для ресурса [Cloud](../api-ref/Cloud/index.md) или вызовом gRPC API [CloudService/Update](../api-ref/grpc/Cloud/update.md).
    * Для каталога — методом REST API [update](../api-ref/Folder/update.md) для ресурса [Folder](../api-ref/Folder/index.md) или вызовом gRPC API [FolderService/Update](../api-ref/grpc/Folder/update.md).

    Получите текущие метки методом [Cloud.get](../api-ref/Cloud/get.md) или [Folder.get](../api-ref/Folder/get.md). Исключите удаляемую метку из текущего набора. Чтобы удалить все метки, передайте пустой объект `labels`.

    В запросе на изменение укажите `updateMask: "labels"` и полный итоговый набор меток в `labels`, включая метки, которые требуется сохранить. Переданный набор заменяет существующие метки ресурса.

{% endlist %}
