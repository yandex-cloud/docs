# Управление метками

Вы можете добавить, удалить или изменить [метку](../concepts/labels.md#services) ресурса с помощью консоли управления, командной строки {{ yandex-cloud }} и {{ TF }}.

## Добавить метку {#add-label}

{% list tabs %}

- Консоль управления

  В примере ниже показано добавление метки к виртуальной машине {{ compute-name }}. Вы также можете добавить метку к ресурсу из [списка](../concepts/labels.md#services) сервисов, в которых поддержаны метки.

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится ВМ.
  1. В списке сервисов выберите **{{ compute-name }}**.
  1. В списке ВМ выберите нужную.
  1. Нажмите ![horizontal-ellipsis](../../_assets/horizontal-ellipsis.svg) и выберите **Редактировать**.
  1. В поле **Метки** нажмите **Добавить метку**.
  1. Введите ключ и значение и нажмите **Enter**.

- YC CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы добавить метку ресурсу сервиса воспользуйтесь командой:

  ```
  yc <имя_сервиса> <тип_ресурса> add-labels <имя_или_идентификатор_ресурса> \
    --labels <имя_метки>=<значение_метки>
  ```

  **Пример**

  Добавить метку виртуальной машине:

  > ```
  > yc compute instance add-labels cl123g4dridnn5cna6df-yduv --labels project=test
  > ```
  >
  > Результат:
  > 
  > ```
  > done (5s)
  > id: fhm1pr2bu3p45s6ildh7
  > folder_id: b1g23ga45mev6cljderg
  > created_at: "2020-08-07T11:29:18Z"
  > name: cl123g4dridnn5cna6df-yduv
  > labels:
  >   project: test
  > zone_id: {{ region-id }}-a
  > ...
  > ```

- {{ TF }}

  Если у вас ещё нет {{ TF }}, {% if audience != "internal" %}[установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform){% else %}установите его и настройте провайдер {{ yandex-cloud }}{% endif %}.

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

## Изменить метку {#update-label}

Изменить метку можно только с помощью командной строки {{ yandex-cloud }} и {{ TF }}.

{% list tabs %}

- YC CLI

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
  > id: cat1hknor2345e6d7rr8
  > folder_id: b1g23ga45mev6cljderg
  > created_at: "2020-08-07T11:15:59Z"
  > name: cluster
  > labels:
  >   new_lable: test_label
  > status: RUNNING
  > ...
  > ```

- {{ TF }}

  Если у вас ещё нет {{ TF }}, {% if audience != "internal" %}[установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform){% else %}установите его и настройте провайдер {{ yandex-cloud }}{% endif %}.

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

  В примере ниже показано удаление метки виртуальной машины {{ compute-name }}. Вы также можете удалить метку другого ресурса.

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится ВМ.
  1. В списке сервисов выберите **{{ compute-name }}**.
  1. В списке ВМ выберите нужную.
  1. Нажмите ![horizontal-ellipsis](../../_assets/horizontal-ellipsis.svg) и выберите **Редактировать**.
  1. В поле **Метки** нажмите выберите нужную метку и нажмите ![cross](../../_assets/cross.svg) справа от ее имени.

- YC CLI

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
  > id: c1qmjaatlurm2bcoi34i
  > folder_id: b1g23ga45mev6cljderg
  > created_at: "2020-08-20T11:53:20.015543Z"
  > name: mysql123
  > environment: PRODUCTION
  > ...
  > ```

- {{ TF }}

  Если у вас ещё нет {{ TF }}, {% if audience != "internal" %}[установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform){% else %}установите его и настройте провайдер {{ yandex-cloud }}{% endif %}.

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
