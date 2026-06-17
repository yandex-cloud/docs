# Изменение брокера

{% note warning %}

Сервис Yandex IoT Core больше не доступен для новых пользователей. 

Текущие пользователи могут создавать ресурсы до 1 ноября 2026 года. После сервис перейдет в режим read-only, а 1 декабря 2026 года — прекратит работу. Подробнее о сроках и порядке закрытия читайте на странице [Закрытие сервиса](../../sunset.md).

{% endnote %}

{% note info %}

Брокер находится на стадии [Preview](../../../overview/concepts/launch-stages.md).

{% endnote %}

Вы можете изменить [имя](broker-update.md#update-name) или [описание](broker-update.md#update-description) брокера, а также [управлять метками брокера](broker-update.md#manage-label).

Для обращения к брокеру используйте его уникальный идентификатор или имя. Как узнать уникальный идентификатор или имя брокера, читайте в разделе [Получение информации о брокере](broker-list.md).

## Изменить имя брокера {#update-name}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы хотите изменить имя брокера.
   1. Перейдите в сервис **IoT Core**.
   1. На панели слева выберите **Брокеры**.
   1. Справа от имени нужного брокера нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и в выпадающем списке выберите **Редактировать**.
   1. Измените поле **Имя**.
   1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).
    
  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Измените имя брокера:

  ```bash
  yc iot broker update my-broker --new-name test-broker
  ```

  Результат:
  ```text
  id: b91ki3851h**********
  folder_id: aoek49ghmk**********
  created_at: "2019-05-28T11:29:42.420Z"
  name: test-broker
  ```

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).
  
  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  Чтобы изменить имя брокера, созданного с помощью Terraform:

  1. Откройте файл конфигурации Terraform и измените значение параметра `name` во фрагменте с описанием брокера.

      Пример описания брокера в конфигурации Terraform:

      ```hcl
      resource "yandex_iot_core_broker" "my_broker" {
        name        = "test-broker"
        description = "test broker for terraform provider documentation"
        }
      ...
      }
      ```

      Подробнее о параметрах ресурса `yandex_iot_core_broker` в [документации провайдера](../../../terraform/resources/iot_core_broker.md).
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

      В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
  1. Примените изменения конфигурации:

      ```bash
      terraform apply
      ```

  1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

      Проверить измененное имя брокера можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../../cli/quickstart.md):

      ```bash
      yc iot broker list
      ```

- API {#api}

  Чтобы изменить имя брокера, воспользуйтесь методом REST API [update](../../broker/api-ref/Broker/update.md) для ресурса [Broker](../../broker/api-ref/Broker/index.md) или вызовом gRPC API [BrokerService/Update](../../broker/api-ref/grpc/Broker/update.md).

{% endlist %}

## Изменить описание брокера {#update-description}

{% list tabs group=instructions %}

- Консоль управления {#console}

   Чтобы изменить описание брокера:

   1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы хотите изменить описание брокера.
   1. Перейдите в сервис **IoT Core**.
   1. На панели слева выберите **Брокеры**.
   1. Справа от имени нужного брокера нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg), в выпадающем списке выберите **Редактировать**.
   1. Измените поле **Описание**.
   1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  Измените описание брокера:

  ```bash
  yc iot broker update my-broker --description "My test broker."
  ```

  Результат:
  ```text
  id: b91ki3851h**********
  folder_id: aoek49ghmk**********
  created_at: "2019-05-28T11:29:42.420Z"
  name: my-broker
  description: My test broker.
  labels:
    test_label: my_broker_label
  ```

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).
  
  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  Чтобы изменить описание брокера, созданного с помощью Terraform:

  1. Откройте файл конфигурации Terraform и измените значение параметра `description` во фрагменте с описанием брокера.

      Пример описания брокера в конфигурации Terraform:

      ```hcl
      resource "yandex_iot_core_broker" "my_broker" {
        name        = "test-broker"
        description = "test broker for terraform provider documentation"
        }
      ...
      }
      ```

      Подробнее о параметрах ресурса `yandex_iot_core_broker` в [документации провайдера](../../../terraform/resources/iot_core_broker.md).
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

      В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
  1. Примените изменения конфигурации:

      ```bash
      terraform apply
      ```

  1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

      Проверить измененное описание брокера можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../../cli/quickstart.md):

      ```bash
      yc iot broker get <имя_брокера>
      ```

- API {#api}

  Чтобы изменить описание брокера, воспользуйтесь методом REST API [update](../../broker/api-ref/Broker/update.md) для ресурса [Broker](../../broker/api-ref/Broker/index.md) или вызовом gRPC API [BrokerService/Update](../../broker/api-ref/grpc/Broker/update.md).

{% endlist %}

## Управлять метками брокера {#manage-label}

Вы можете выполнять следующие действия с метками брокера:

* [Добавить](broker-update.md#add-label).
* [Изменить](broker-update.md#update-label).
* [Удалить](broker-update.md#remove-label).

### Добавить метку {#add-label}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы хотите добавить метку брокера.
   1. Перейдите в сервис **IoT Core**.
   1. На панели слева выберите **Брокеры**.
   1. Справа от имени нужного брокера нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и в выпадающем списке выберите **Редактировать**.
   1. Заполните поля **Ключ**, **Значение** и нажмите кнопку **Добавить метку**.
   1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).
    
  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Добавьте метку брокеру:

  ```bash
  yc iot broker add-labels my-broker --labels new_label=test_label
  ```

  Результат:
  ```text
  id: b91ki3851h**********
  folder_id: aoek49ghmk**********
  created_at: "2019-05-28T11:29:42.420Z"
  name: my-broker
  labels:
    new_label: test_label
  ```

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).
  
  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  Чтобы добавить метку брокеру, созданному с помощью Terraform:

  1. Опишите в конфигурационном файле параметры ресурса, который необходимо создать:

     * `yandex_iot_core_broker` — параметры брокера:
       * `name` — имя брокера.
       * `description` — описание брокера.
       * `labels` — метки брокера в формате `ключ:значение`.

      Пример структуры ресурса в конфигурационном файле:

      ```hcl
      resource "yandex_iot_core_broker" "my_broker" {
        name        = "test-broker"
        description = "test broker for terraform provider documentation"
        labels = {
          new-label = "test-label"
        }
      ...
      }
      ```

      Подробнее о параметрах ресурса `yandex_iot_core_broker` в [документации провайдера](../../../terraform/resources/iot_core_broker.md).
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

      В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
  1. Примените изменения конфигурации:

      ```bash
      terraform apply
      ```

  1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

      Проверить метки брокера можно с помощью команды [CLI](../../../cli/quickstart.md):

      ```bash
      yc iot broker get <имя_брокера>
      ```

- API {#api}

  Чтобы добавить метку брокеру, воспользуйтесь методом REST API [update](../../broker/api-ref/Broker/update.md) для ресурса [Broker](../../broker/api-ref/Broker/index.md) или вызовом gRPC API [BrokerService/Update](../../broker/api-ref/grpc/Broker/update.md).

{% endlist %}

### Изменить метку {#update-label}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы хотите изменить метку брокера.
   1. Перейдите в сервис **IoT Core**.
   1. На панели слева выберите **Брокеры**.
   1. Справа от имени нужного брокера нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и в выпадающем списке выберите **Редактировать**.
   1. Измените поля **Ключ** и **Значение**.
   1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).
    
  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Измените метку брокера:

  {% note warning %}
  
  Существующий набор меток (`labels`) полностью перезаписывается набором, переданным в запросе.
  
  {% endnote %}

  ```bash
  yc iot broker update my-broker --labels test_label=my_broker_label
  ```

  Результат:
  ```text
  id: b91ki3851h**********
  folder_id: aoek49ghmk**********
  created_at: "2019-05-28T11:29:42.420Z"
  name: my-broker
  labels:
    test_label: my_broker_label
  ```

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).
  
  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  Чтобы изменить метку брокера, созданного с помощью Terraform:

  1. Откройте файл конфигурации Terraform и измените значение метки в блоке `labels`, во фрагменте с описанием брокера.

      Пример описания брокера в конфигурации Terraform:

      ```hcl
      resource "yandex_iot_core_broker" "my_broker" {
        name        = "test-broker"
        description = "test broker for terraform provider documentation"
        labels = {
          test-label = "my-broker-label"
        }
      ...
      }
      ```

      Подробнее о параметрах ресурса `yandex_iot_core_broker` в [документации провайдера](../../../terraform/resources/iot_core_broker.md).
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

      В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
  1. Примените изменения конфигурации:

      ```bash
      terraform apply
      ```

  1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

      Проверить метки брокера можно с помощью команды [CLI](../../../cli/quickstart.md):

      ```bash
      yc iot broker get <имя_брокера>
      ```

- API {#api}

  Чтобы изменить метку брокера, воспользуйтесь методом REST API [update](../../broker/api-ref/Broker/update.md) для ресурса [Broker](../../broker/api-ref/Broker/index.md) или вызовом gRPC API [BrokerService/Update](../../broker/api-ref/grpc/Broker/update.md).

{% endlist %}

### Удалить метку {#remove-label}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы хотите удалить метку брокера.
   1. Перейдите в сервис **IoT Core**.
   1. На панели слева выберите **Брокеры**.
   1. Справа от имени нужного брокера нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и в выпадающем списке выберите **Редактировать**.
   1. Справа от удаляемой метки нажмите значок ![image](../../../_assets/console-icons/xmark.svg).
   1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).
    
  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Удалите метку брокера:

  ```bash
  yc iot broker remove-labels my-broker --labels new_label
  ```

  Результат:
  ```text
  id: b91ki3851h**********
  folder_id: aoek49ghmk**********
  created_at: "2019-05-28T11:29:42.420Z"
  name: my-broker
  ```

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).
  
  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  Чтобы удалить метку брокера, созданного с помощью Terraform:

  1. Откройте файл конфигурации Terraform и удалите значение нужной метки в блоке `labels`, во фрагменте с описанием брокера. Чтобы удалить все метки, удалите блок `labels` целиком.

      Пример описания брокера в конфигурации Terraform:

      ```hcl
      resource "yandex_iot_core_broker" "my_broker" {
        name        = "test-broker"
        description = "test broker for terraform provider documentation"
        labels = {
          test-label = "my-broker-label"
        }
      ...
      }
      ```

      Подробнее о параметрах ресурса `yandex_iot_core_broker` в [документации провайдера](../../../terraform/resources/iot_core_broker.md).
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

      В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
  1. Примените изменения конфигурации:

      ```bash
      terraform apply
      ```

  1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

      Проверить метки брокера можно с помощью команды [CLI](../../../cli/quickstart.md):

      ```bash
      yc iot broker get <имя_брокера>
      ```

- API {#api}

  Чтобы удалить метку брокера, воспользуйтесь методом REST API [update](../../broker/api-ref/Broker/update.md) для ресурса [Broker](../../broker/api-ref/Broker/index.md) или вызовом gRPC API [BrokerService/Update](../../broker/api-ref/grpc/Broker/update.md).

{% endlist %}