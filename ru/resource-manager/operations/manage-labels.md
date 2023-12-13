# Управление метками

Вы можете добавить, удалить или изменить [метку](../concepts/labels.md#services) ресурса с помощью консоли управления, командной строки {{ yandex-cloud }} и {{ TF }}.

Метки поддерживаются в определенных [сервисах](../concepts/labels.md#services). Управление метками в некоторых сервисах может отличаться, например в [{{ objstorage-name }}](../../storage/operations/buckets/tagging.md).

## Добавить метку {#add-label}

{% list tabs %}

- Консоль управления

  В примере ниже показано добавление метки к виртуальной машине {{ compute-name }}. Аналогично вы можете добавить метку другому ресурсу.

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится ВМ.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.switch_instances }}**.
  1. В списке ВМ выберите нужную.
  1. Нажмите ![horizontal-ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.edit }}**.
  1. В поле **{{ ui-key.yacloud.component.label-set.label_labels }}** нажмите **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
  1. Введите ключ и значение и нажмите **Enter**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы добавить метку ресурсу сервиса, воспользуйтесь командой:

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

- {{ TF }}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Добавьте к ресурсу в конфигурационном файле следующий фрагмент:

      ```
        labels = {
          <ключ_метки> = "<значение_метки>"
        }
      ```

  1. Примените изменения:

      {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}

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

{% endlist %}

Вы можете завести одну метку с несколькими значениями. Например, создать метку `my-cloud` с несколькими значениями:

* `my-vm` — для виртуальной машины;
* `my-disk` — для диска.

## Изменить метку {#update-label}

Изменить метку можно только с помощью командной строки {{ yandex-cloud }} и {{ TF }}.

{% list tabs %}

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  {% note warning %}

  Существующий набор `labels` полностью перезаписывается набором, переданным в запросе.

  {% endnote %}

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

- {{ TF }}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Найдите в конфигурационном файле следующий фрагмент:

      ```
        labels = {
          <ключ_метки> = <значение_метки>
        }
      ```

  1. Измените ключ и значение метки на новые.
  1. Примените изменения:

      {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}

  После этого у ресурса будет изменена метка. Проверить изменение метки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

  ```
  yc <имя_сервиса> <тип_ресурса> get <имя_или_идентификатор_ресурса>
  ``` 

{% endlist %}

## Удалить метку {#remove-label}

{% list tabs %}

- Консоль управления

  В примере ниже показано удаление метки виртуальной машины {{ compute-name }}. Аналогично вы можете удалить метку другого ресурса.

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится ВМ.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.switch_instances }}**.
  1. В списке ВМ выберите нужную.
  1. Нажмите ![horizontal-ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.edit }}**.
  1. В поле **{{ ui-key.yacloud.component.label-set.label_labels }}** выберите нужную метку и нажмите ![cross](../../_assets/console-icons/xmark.svg) справа от ее имени.

- CLI

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

- {{ TF }}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Найдите в конфигурационном файле следующий фрагмент:

      ```
        labels = {
          <ключ_метки> = "<значение_метки>"
        }
      ```

  1. Удалите фрагмент.
  1. Примените изменения:

      {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}

  После этого у ресурса будет удалена метка. Проверить удаление метки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

  ```
  yc <имя_сервиса> <тип_ресурса> get <имя_или_идентификатор_ресурса>
  ``` 

{% endlist %}
