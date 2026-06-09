# Изменение реестра

{% note warning %}

Сервис {{ iot-full-name }} больше не доступен для новых пользователей. 

Текущие пользователи могут создавать ресурсы до 1 ноября 2026 года. После сервис перейдет в режим read-only, а 1 декабря 2026 года — прекратит работу. Подробнее о сроках и порядке закрытия читайте на странице [Закрытие сервиса](../../sunset.md).

{% endnote %}

Вы можете изменить [имя](registry-update.md#update-name) или [описание](registry-update.md#update-description) реестра, а также [управлять метками реестра](registry-update.md#manage-label).

Для обращения к реестру используйте его идентификатор или имя. Как узнать идентификатор или имя реестра, читайте в разделе [{#T}](registry-list.md).

## Изменить имя реестра {#update-name}

{% list tabs group=instructions %}

- Консоль управления {#console}

   Чтобы изменить имя реестра:

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите изменить имя реестра.
   1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
   1. Справа от имени нужного реестра нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg), в выпадающем списке выберите **{{ ui-key.yacloud.common.edit }}**.
   1. Измените поле **{{ ui-key.yacloud.common.name }}**.
   1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  Измените имя реестра:

  ```bash
  yc iot registry update my-registry --new-name test-registry
  ```

  Результат:
  ```text
  id: b91ki3851hab********
  folder_id: aoek49ghmknn********
  created_at: "2019-05-28T11:29:42.420Z"
  name: test-registry
  ```

- {{ TF }} {#tf}

  [{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  {{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).
  
  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

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

      Более подробную информацию о параметрах ресурса `yandex_iot_core_registry` в {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/iot_core_registry).
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

- API {#api}

  Чтобы изменить имя реестра, воспользуйтесь методом REST API [update](../../api-ref/Registry/update.md) для ресурса [Registry](../../api-ref/Registry/index.md) или вызовом gRPC API [RegistryService/Update](../../api-ref/grpc/Registry/update.md).

{% endlist %}

## Изменить описание реестра {#update-description}

{% list tabs group=instructions %}

- Консоль управления {#console}

   Чтобы изменить описание реестра:

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите изменить описание реестра.
   1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
   1. Справа от имени нужного реестра нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg), в выпадающем списке выберите **{{ ui-key.yacloud.common.edit }}**.
   1. Измените поле **{{ ui-key.yacloud.common.description }}**.
   1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  Измените описание реестра:

  ```bash
  yc iot registry update my-registry --description "My test registry."
  ```

  Результат:
  ```text
  id: b91ki3851hab********
  folder_id: aoek49ghmknn********
  created_at: "2019-05-28T11:29:42.420Z"
  name: my-registry
  description: My test registry.
  labels:
    test_label: my_registry_label
  ```

- {{ TF }} {#tf}

  [{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  {{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).
  
  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

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

      Более подробную информацию о параметрах ресурса `yandex_iot_core_registry` в {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/iot_core_registry).
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

- API {#api}

  Чтобы изменить описание реестра, воспользуйтесь методом REST API [update](../../api-ref/Registry/update.md) для ресурса [Registry](../../api-ref/Registry/index.md) или вызовом gRPC API [RegistryService/Update](../../api-ref/grpc/Registry/update.md).

{% endlist %}

## Управлять метками реестра {#manage-label}

Вы можете выполнять следующие действия с метками реестра:

* [Добавить](registry-update.md#add-label).
* [Изменить](registry-update.md#update-label).
* [Удалить](registry-update.md#remove-label).

### Добавить метку {#add-label}

{% list tabs group=instructions %}

- Консоль управления {#console}

   Чтобы добавить метку реестра:

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите добавить метку реестра.
   1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
   1. Справа от имени нужного реестра нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg), в выпадающем списке выберите **{{ ui-key.yacloud.common.edit }}**.
   1. Заполните поля **{{ ui-key.yacloud.component.key-values-input.label_key }}**, **{{ ui-key.yacloud.component.key-values-input.label_value }}** и нажмите кнопку **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
   1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  Добавьте метку реестру:

  ```bash
  yc iot registry add-labels my-registry --labels new_label=test_label
  ```

  Результат:
  ```text
  id: b91ki3851hab********
  folder_id: aoek49ghmknn********
  created_at: "2019-05-28T11:29:42.420Z"
  name: my-registry
  labels:
    new_label: test_label
  ```

- {{ TF }} {#tf}

  [{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  {{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).
  
  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

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

      Более подробную информацию о параметрах ресурса `yandex_iot_core_registry` в {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/iot_core_registry).
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

- API {#api}

  Чтобы добавить метку реестру, воспользуйтесь методом REST API [update](../../api-ref/Registry/update.md) для ресурса [Registry](../../api-ref/Registry/index.md) или вызовом gRPC API [RegistryService/Update](../../api-ref/grpc/Registry/update.md).

{% endlist %}

### Изменить метку {#update-label}

{% list tabs group=instructions %}

- Консоль управления {#console}

   Чтобы изменить метку реестра:

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите изменить метку реестра.
   1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
   1. Справа от имени нужного реестра нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg), в выпадающем списке выберите **{{ ui-key.yacloud.common.edit }}**.
   1. Измените поля **{{ ui-key.yacloud.component.key-values-input.label_key }}**, **{{ ui-key.yacloud.component.key-values-input.label_value }}**.
   1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  Измените метку реестра:

  {% note warning %}
  
  Существующий набор меток (`labels`) полностью перезаписывается набором, переданным в запросе.
  
  {% endnote %}

  ```bash
  yc iot registry update my-registry --labels test_label=my_registry_label
  ```

  Результат:
  ```text
  id: b91ki3851hab********
  folder_id: aoek49ghmknn********
  created_at: "2019-05-28T11:29:42.420Z"
  name: my-registry
  labels:
    test_label: my_registry_label
  ```

- {{ TF }} {#tf}

  [{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  {{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).
  
  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

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

      Более подробную информацию о параметрах ресурса `yandex_iot_core_registry` в {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/iot_core_registry).
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

- API {#api}

  Чтобы изменить метку реестра, воспользуйтесь методом REST API [update](../../api-ref/Registry/update.md) для ресурса [Registry](../../api-ref/Registry/index.md) или вызовом gRPC API [RegistryService/Update](../../api-ref/grpc/Registry/update.md).

{% endlist %}

### Удалить метку {#remove-label}

{% list tabs group=instructions %}

- Консоль управления {#console}

   Чтобы удалить метку реестра:

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите удалить метку реестра.
   1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
   1. Справа от имени нужного реестра нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg), в выпадающем списке выберите **{{ ui-key.yacloud.common.edit }}**.
   1. Справа от удаляемой метки нажмите значок ![image](../../../_assets/console-icons/xmark.svg).
   1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  Удалите метку реестра:

  ```bash
  yc iot registry remove-labels my-registry --labels new_label
  ```

  Результат:
  ```text
  id: b91ki3851hab********
  folder_id: aoek49ghmknn********
  created_at: "2019-05-28T11:29:42.420Z"
  name: my-registry
  ```

- {{ TF }} {#tf}

  [{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  {{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).
  
  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

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

      Более подробную информацию о параметрах ресурса `yandex_iot_core_registry` в {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/iot_core_registry).
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

- API {#api}

  Чтобы удалить метку реестра, воспользуйтесь методом REST API [update](../../api-ref/Registry/update.md) для ресурса [Registry](../../api-ref/Registry/index.md) или вызовом gRPC API [RegistryService/Update](../../api-ref/grpc/Registry/update.md).

{% endlist %}