# Изменение реестра

Вы можете изменить [имя](registry-update.md#update-name) или [описание](registry-update.md#update-description) реестра, а также [управлять метками реестра](registry-update.md#manage-label).

Для обращения к реестру используйте его уникальный идентификатор или имя. Как узнать уникальный идентификатор или имя реестра, читайте в разделе [{#T}](registry-list.md).

## Изменить имя реестра {#update-name}

{% list tabs %}

- Консоль управления

   Чтобы изменить имя реестра:

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите изменить имя реестра.
   1. Выберите сервис **{{ iot-short-name }}**.
   1. Справа от имени нужного реестра нажмите значок ![image](../../../_assets/horizontal-ellipsis.svg), в выпадающем списке выберите **Редактировать**.
   1. Измените поле **Имя**.
   1. Нажмите кнопку **Сохранить**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  Измените имя реестра:

  ```
  yc iot registry update my-registry --new-name test-registry
  ```
  
  Результат:
  ```
  id: b91ki3851hab9m0l68je
  folder_id: aoek49ghmknnpj1ll45e
  created_at: "2019-05-28T11:29:42.420Z"
  name: test-registry
  ```

- {{ TF }}

  {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}
  
  Подробнее о {{ TF }} [читайте в документации](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы изменить имя реестра, созданного с помощью {{ TF }}:

  1. Откройте файл конфигурации {{ TF }} и измените значение параметра `name` во фрагменте с описанием реестра.

      Пример описания реестра в конфигурации {{ TF }}:

      ```hcl
      resource "yandex_iot_core_registry" "my_registry" {
        name        = "test-registry"
        description = "test registry for terraform provider documentation"
        }
      ...
      }
      ```

      Более подробную информацию о параметрах ресурса `yandex_iot_core_registry` в {{ TF }}, см. в [документации провайдера]({{ tf-provider-link }}/iot_core_registry).
  1. В командной строке перейдите в папку, где вы отредактировали конфигурационный файл.
  1. Проверьте корректность конфигурационного файла с помощью команды:

      ```bash
      terraform validate
      ```
     
      Если конфигурация является корректной, появится сообщение:
     
      ```bash
      Success! The configuration is valid.
      ```

  1. Выполните команду:

      ```bash
      terraform plan
      ```
  
      В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
  1. Примените изменения конфигурации:

      ```bash
      terraform apply
      ```
     
  1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

      Проверить измененное имя реестра можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

      ```bash
      yc iot registry list
      ```

- API

  Чтобы изменить имя реестра, воспользуйтесь методом REST API [update](../../api-ref/Registry/update.md) для ресурса [Registry](../../api-ref/Registry/index.md) или вызовом gRPC API [RegistryService/Update](../../api-ref/grpc/registry_service.md#Update).

{% endlist %}

## Изменить описание реестра {#update-description}

{% list tabs %}

- Консоль управления

   Чтобы изменить описание реестра:

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите изменить описание реестра.
   1. Выберите сервис **{{ iot-short-name }}**.
   1. Справа от имени нужного реестра нажмите значок ![image](../../../_assets/horizontal-ellipsis.svg), в выпадающем списке выберите **Редактировать**.
   1. Измените поле **Описание**.
   1. Нажмите кнопку **Сохранить**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  Измените описание реестра:

  ```
  yc iot registry update my-registry --description "My test registry."
  ```
  
  Результат:
  ```
  id: b91ki3851hab9m0l68je
  folder_id: aoek49ghmknnpj1ll45e
  created_at: "2019-05-28T11:29:42.420Z"
  name: my-registry
  description: My test registry.
  labels:
    test_label: my_registry_label
  ```

- {{ TF }}

  {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}
  
  Подробнее о {{ TF }} [читайте в документации](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы изменить описание реестра, созданного с помощью {{ TF }}:

  1. Откройте файл конфигурации {{ TF }} и измените значение параметра `description` во фрагменте с описанием реестра.

      Пример описания реестра в конфигурации {{ TF }}:

      ```hcl
      resource "yandex_iot_core_registry" "my_registry" {
        name        = "test-registry"
        description = "test registry for terraform provider documentation"
        }
      ...
      }
      ```

      Более подробную информацию о параметрах ресурса `yandex_iot_core_registry` в {{ TF }}, см. в [документации провайдера]({{ tf-provider-link }}/iot_core_registry).
  1. В командной строке перейдите в папку, где вы отредактировали конфигурационный файл.
  1. Проверьте корректность конфигурационного файла с помощью команды:

      ```bash
      terraform validate
      ```
     
      Если конфигурация является корректной, появится сообщение:
     
      ```bash
      Success! The configuration is valid.
      ```

  1. Выполните команду:

      ```bash
      terraform plan
      ```
  
      В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
  1. Примените изменения конфигурации:

      ```bash
      terraform apply
      ```
     
  1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

      Проверить измененное описание реестра можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

      ```bash
      yc iot registry get <имя_реестра>
      ```

- API

  Чтобы изменить описание реестра, воспользуйтесь методом REST API [update](../../api-ref/Registry/update.md) для ресурса [Registry](../../api-ref/Registry/index.md) или вызовом gRPC API [RegistryService/Update](../../api-ref/grpc/registry_service.md#Update).

{% endlist %}

## Управлять метками реестра {#manage-label}

Вы можете выполнять следующие действия с метками реестра:

* [Добавить](registry-update.md#add-label).
* [Изменить](registry-update.md#update-label).
* [Удалить](registry-update.md#remove-label).

### Добавить метку {#add-label}

{% list tabs %}

- Консоль управления

   Чтобы добавить метку реестра:

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите добавить метку реестра.
   1. Выберите сервис **{{ iot-short-name }}**.
   1. Справа от имени нужного реестра нажмите значок ![image](../../../_assets/horizontal-ellipsis.svg), в выпадающем списке выберите **Редактировать**.
   1. Заполните поля **Ключ**, **Значение** и нажмите кнопку **Добавить метку**.
   1. Нажмите кнопку **Сохранить**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  Добавьте метку реестру:

  ```
  yc iot registry add-labels my-registry --labels new_label=test_label
  ```
  
  Результат:
  ```
  id: b91ki3851hab9m0l68je
  folder_id: aoek49ghmknnpj1ll45e
  created_at: "2019-05-28T11:29:42.420Z"
  name: my-registry
  labels:
    new_label: test_label
  ```

- {{ TF }}

  {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}
  
  Подробнее о {{ TF }} [читайте в документации](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы добавить метку реестра, созданного с помощью {{ TF }}:

  1. Опишите в конфигурационном файле параметры ресурса, который необходимо создать:

     * `yandex_iot_core_registry` — параметры реестра:
       * `name` — имя реестра.
       * `description` — описание реестра.
       * `labels` — метки реестра в формате `ключ:значение`.

      Пример структуры ресурса в конфигурационном файле:

      ```hcl
      resource "yandex_iot_core_registry" "my_registry" {
        name        = "test-registry"
        description = "test registry for terraform provider documentation"
        labels = {
          new-label = "test-label"
        }
      ...
      }
      ```

      Более подробную информацию о параметрах ресурса `yandex_iot_core_registry` в {{ TF }}, см. в [документации провайдера]({{ tf-provider-link }}/iot_core_registry).
  1. В командной строке перейдите в папку, где вы отредактировали конфигурационный файл.
  1. Проверьте корректность конфигурационного файла с помощью команды:

      ```bash
      terraform validate
      ```
     
      Если конфигурация является корректной, появится сообщение:
     
      ```bash
      Success! The configuration is valid.
      ```

  1. Выполните команду:

      ```bash
      terraform plan
      ```
  
      В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
  1. Примените изменения конфигурации:

      ```bash
      terraform apply
      ```
     
  1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

      Проверить метки реестра можно с помощью команды [CLI](../../../cli/quickstart.md):

      ```bash
      yc iot registry get <имя_реестра>
      ```

- API

  Чтобы добавить метку реестру, воспользуйтесь методом REST API [update](../../api-ref/Registry/update.md) для ресурса [Registry](../../api-ref/Registry/index.md) или вызовом gRPC API [RegistryService/Update](../../api-ref/grpc/registry_service.md#Update).

{% endlist %}

### Изменить метку {#update-label}

{% list tabs %}

- Консоль управления

   Чтобы изменить метку реестра:

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите изменить метку реестра.
   1. Выберите сервис **{{ iot-short-name }}**.
   1. Справа от имени нужного реестра нажмите значок ![image](../../../_assets/horizontal-ellipsis.svg), в выпадающем списке выберите **Редактировать**.
   1. Измените поля **Ключ**, **Значение**.
   1. Нажмите кнопку **Сохранить**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  Измените метку реестра:

  {% note warning %}

  Существующий набор `labels` полностью перезаписывается набором, переданным в запросе.

  {% endnote %}

  ```
  yc iot registry update my-registry --labels test_label=my_registry_label
  ```
  
  Результат:
  ```
  id: b91ki3851hab9m0l68je
  folder_id: aoek49ghmknnpj1ll45e
  created_at: "2019-05-28T11:29:42.420Z"
  name: my-registry
  labels:
    test_label: my_registry_label
  ```

- {{ TF }}

  {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}
  
  Подробнее о {{ TF }} [читайте в документации](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы изменить метку реестра, созданного с помощью {{ TF }}:

  1. Откройте файл конфигурации {{ TF }} и измените значение метки в блоке `labels`, во фрагменте с описанием реестра.

      Пример описания реестра в конфигурации {{ TF }}:

      ```hcl
      resource "yandex_iot_core_registry" "my_registry" {
        name        = "test-registry"
        description = "test registry for terraform provider documentation"
        labels = {
          test-label = "my-registry-label"
        }
      ...
      }
      ```

      Более подробную информацию о параметрах ресурса `yandex_iot_core_registry` в {{ TF }}, см. в [документации провайдера]({{ tf-provider-link }}/iot_core_registry).
  1. В командной строке перейдите в папку, где вы отредактировали конфигурационный файл.
  1. Проверьте корректность конфигурационного файла с помощью команды:

      ```bash
      terraform validate
      ```
     
      Если конфигурация является корректной, появится сообщение:
     
      ```bash
      Success! The configuration is valid.
      ```

  1. Выполните команду:

      ```bash
      terraform plan
      ```
  
      В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
  1. Примените изменения конфигурации:

      ```bash
      terraform apply
      ```
     
  1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

      Проверить метки реестра можно с помощью команды [CLI](../../../cli/quickstart.md):

      ```bash
      yc iot registry get <имя_реестра>
      ```

- API

  Чтобы изменить метку реестра, воспользуйтесь методом REST API [update](../../api-ref/Registry/update.md) для ресурса [Registry](../../api-ref/Registry/index.md) или вызовом gRPC API [RegistryService/Update](../../api-ref/grpc/registry_service.md#Update).

{% endlist %}

### Удалить метку {#remove-label}

{% list tabs %}

- Консоль управления

   Чтобы удалить метку реестра:

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите удалить метку реестра.
   1. Выберите сервис **{{ iot-short-name }}**.
   1. Справа от имени нужного реестра нажмите значок ![image](../../../_assets/horizontal-ellipsis.svg), в выпадающем списке выберите **Редактировать**.
   1. Справа от удаляемой метки нажмите значок ![image](../../../_assets/cross.svg).
   1. Нажмите кнопку **Сохранить**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  Удалите метку реестра:

  ```
  yc iot registry remove-labels my-registry --labels new_label
  ```
  
  Результат:
  ```
  id: b91ki3851hab9m0l68je
  folder_id: aoek49ghmknnpj1ll45e
  created_at: "2019-05-28T11:29:42.420Z"
  name: my-registry
  ```

- {{ TF }}

  {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}
  
  Подробнее о {{ TF }} [читайте в документации](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы удалить метку реестра, созданного с помощью {{ TF }}:

  1. Откройте файл конфигурации {{ TF }} и удалите значение нужной метки в блоке `labels`, во фрагменте с описанием реестра. Чтобы удалить все метки, удалите блок `labels` целиком.

      Пример описания реестра в конфигурации {{ TF }}:

      ```hcl
      resource "yandex_iot_core_registry" "my_registry" {
        name        = "test-registry"
        description = "test registry for terraform provider documentation"
        labels = {
          test-label = "my-registry-label"
        }
      ...
      }
      ```

      Более подробную информацию о параметрах ресурса `yandex_iot_core_registry` в {{ TF }}, см. в [документации провайдера]({{ tf-provider-link }}/iot_core_registry).
  1. В командной строке перейдите в папку, где вы отредактировали конфигурационный файл.
  1. Проверьте корректность конфигурационного файла с помощью команды:

      ```bash
      terraform validate
      ```
     
      Если конфигурация является корректной, появится сообщение:
     
      ```bash
      Success! The configuration is valid.
      ```

  1. Выполните команду:

      ```bash
      terraform plan
      ```
  
      В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
  1. Примените изменения конфигурации:

      ```bash
      terraform apply
      ```
     
  1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

      Проверить метки реестра можно с помощью команды [CLI](../../../cli/quickstart.md):

      ```bash
      yc iot registry get <имя_реестра>
      ```

- API

  Чтобы удалить метку реестра, воспользуйтесь методом REST API [update](../../api-ref/Registry/update.md) для ресурса [Registry](../../api-ref/Registry/index.md) или вызовом gRPC API [RegistryService/Update](../../api-ref/grpc/registry_service.md#Update).

{% endlist %}