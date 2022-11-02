# Изменение брокера

{% include [note-pp](../../../_includes/iot-core/note-pp.md) %}

Вы можете изменить [имя](broker-update.md#update-name) или [описание](broker-update.md#update-description) брокера, а также [управлять метками брокера](broker-update.md#manage-label).

Для обращения к брокеру используйте его уникальный идентификатор или имя. Как узнать уникальный идентификатор или имя брокера, читайте в разделе [{#T}](broker-list.md).

## Изменить имя брокера {#update-name}

{% list tabs %}

- Консоль управления

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите изменить имя брокера.
   1. Выберите сервис **{{ iot-short-name }}**.
   1. Справа от имени нужного брокера нажмите значок ![image](../../../_assets/horizontal-ellipsis.svg) и в выпадающем списке выберите **Редактировать**.
   1. Измените поле **Имя**.
   1. Нажмите кнопку **Сохранить**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}
    
  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Измените имя брокера:

  ```
  yc iot broker update my-broker --new-name test-broker
  ```
  
  Результат:
  ```
  id: b91ki3851h**********
  folder_id: aoek49ghmk**********
  created_at: "2019-05-28T11:29:42.420Z"
  name: test-broker
  ```

- {{ TF }}

  {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}
  
  Подробнее о {{ TF }} [читайте в документации](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы изменить имя брокера, созданного с помощью {{ TF }}:

  1. Откройте файл конфигурации {{ TF }} и измените значение параметра `name` во фрагменте с описанием брокера.

      Пример описания брокера в конфигурации {{ TF }}:

      ```hcl
      resource "yandex_iot_core_broker" "my_broker" {
        name        = "test-broker"
        description = "test broker for terraform provider documentation"
        }
      ...
      }
      ```

      Более подробную информацию о параметрах ресурса `yandex_iot_core_broker` в {{ TF }}, см. в [документации провайдера]({{ tf-provider-link }}/iot_core_broker).
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

      Проверить измененное имя брокера можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

      ```bash
      yc iot broker list
      ```

- API

  Изменить имя брокера можно с помощью метода API [update](../../broker/api-ref/Broker/update.md).

{% endlist %}

## Изменить описание брокера {#update-description}

{% list tabs %}

- Консоль управления

   Чтобы изменить описание брокера:

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите изменить описание брокера.
   1. Выберите сервис **{{ iot-short-name }}**.
   1. Справа от имени нужного брокера нажмите значок ![image](../../../_assets/horizontal-ellipsis.svg), в выпадающем списке выберите **Редактировать**.
   1. Измените поле **Описание**.
   1. Нажмите кнопку **Сохранить**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  Измените описание брокера:

  ```
  yc iot broker update my-broker --description "My test broker."
  ```
  
  Результат:
  ```
  id: b91ki3851h**********
  folder_id: aoek49ghmk**********
  created_at: "2019-05-28T11:29:42.420Z"
  name: my-broker
  description: My test broker.
  labels:
    test_label: my_broker_label
  ```

- {{ TF }}

  {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}
  
  Подробнее о {{ TF }} [читайте в документации](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы изменить описание брокера, созданного с помощью {{ TF }}:

  1. Откройте файл конфигурации {{ TF }} и измените значение параметра `description` во фрагменте с описанием брокера.

      Пример описания брокера в конфигурации {{ TF }}:

      ```hcl
      resource "yandex_iot_core_broker" "my_broker" {
        name        = "test-broker"
        description = "test broker for terraform provider documentation"
        }
      ...
      }
      ```

      Более подробную информацию о параметрах ресурса `yandex_iot_core_broker` в {{ TF }}, см. в [документации провайдера]({{ tf-provider-link }}/iot_core_broker).
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

      Проверить измененное описание брокера можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

      ```bash
      yc iot broker get <имя_брокера>
      ```

- API

  Изменить описание брокера можно с помощью метода API [update](../../broker/api-ref/Broker/update.md).

{% endlist %}

## Управлять метками брокера {#manage-label}

Вы можете выполнять следующие действия с метками брокера:

* [Добавить](broker-update.md#add-label).
* [Изменить](broker-update.md#update-label).
* [Удалить](broker-update.md#remove-label).

### Добавить метку {#add-label}

{% list tabs %}

- Консоль управления

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите добавить метку брокера.
   1. Выберите сервис **{{ iot-short-name }}**.
   1. Справа от имени нужного брокера нажмите значок ![image](../../../_assets/horizontal-ellipsis.svg) и в выпадающем списке выберите **Редактировать**.
   1. Заполните поля **Ключ**, **Значение** и нажмите кнопку **Добавить метку**.
   1. Нажмите кнопку **Сохранить**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}
    
  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Добавьте метку брокеру:

  ```
  yc iot broker add-labels my-broker --labels new_label=test_label
  ```
  
  Результат:
  ```
  id: b91ki3851h**********
  folder_id: aoek49ghmk**********
  created_at: "2019-05-28T11:29:42.420Z"
  name: my-broker
  labels:
    new_label: test_label
  ```

- {{ TF }}

  {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}
  
  Подробнее о {{ TF }} [читайте в документации](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы добавить метку брокеру, созданному с помощью {{ TF }}:

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

      Более подробную информацию о параметрах ресурса `yandex_iot_core_broker` в {{ TF }}, см. в [документации провайдера]({{ tf-provider-link }}/iot_core_broker).
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

      Проверить метки брокера можно с помощью команды [CLI](../../../cli/quickstart.md):

      ```bash
      yc iot broker get <имя_брокера>
      ```

- API

  Добавить метку брокеру можно с помощью метода API [update](../../broker/api-ref/Broker/update.md).

{% endlist %}

### Изменить метку {#update-label}

{% list tabs %}

- Консоль управления

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите изменить метку брокера.
   1. Выберите сервис **{{ iot-short-name }}**.
   1. Справа от имени нужного брокера нажмите значок ![image](../../../_assets/horizontal-ellipsis.svg) и в выпадающем списке выберите **Редактировать**.
   1. Измените поля **Ключ** и **Значение**.
   1. Нажмите кнопку **Сохранить**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}
    
  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Измените метку брокера:

  {% note warning %}

  Существующий набор `labels` полностью перезаписывается набором, переданным в запросе.

  {% endnote %}

  ```
  yc iot broker update my-broker --labels test_label=my_broker_label
  ```
  
  Результат:
  ```
  id: b91ki3851h**********
  folder_id: aoek49ghmk**********
  created_at: "2019-05-28T11:29:42.420Z"
  name: my-broker
  labels:
    test_label: my_broker_label
  ```

- {{ TF }}

  {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}
  
  Подробнее о {{ TF }} [читайте в документации](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы изменить метку брокера, созданного с помощью {{ TF }}:

  1. Откройте файл конфигурации {{ TF }} и измените значение метки в блоке `labels`, во фрагменте с описанием брокера.

      Пример описания брокера в конфигурации {{ TF }}:

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

      Более подробную информацию о параметрах ресурса `yandex_iot_core_broker` в {{ TF }}, см. в [документации провайдера]({{ tf-provider-link }}/iot_core_broker).
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

      Проверить метки брокера можно с помощью команды [CLI](../../../cli/quickstart.md):

      ```bash
      yc iot broker get <имя_брокера>
      ```

- API

  Изменить метку брокера можно с помощью метода API [update](../../broker/api-ref/Broker/update.md).

{% endlist %}

### Удалить метку {#remove-label}

{% list tabs %}

- Консоль управления

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите удалить метку брокера.
   1. Выберите сервис **{{ iot-short-name }}**.
   1. Справа от имени нужного брокера нажмите значок ![image](../../../_assets/horizontal-ellipsis.svg) и в выпадающем списке выберите **Редактировать**.
   1. Справа от удаляемой метки нажмите значок ![image](../../../_assets/cross.svg).
   1. Нажмите кнопку **Сохранить**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}
    
  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Удалите метку брокера:

  ```
  yc iot broker remove-labels my-broker --labels new_label
  ```
  
  Результат:
  ```
  id: b91ki3851h**********
  folder_id: aoek49ghmk**********
  created_at: "2019-05-28T11:29:42.420Z"
  name: my-broker
  ```

- {{ TF }}

  {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}
  
  Подробнее о {{ TF }} [читайте в документации](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы удалить метку брокера, созданного с помощью {{ TF }}:

  1. Откройте файл конфигурации {{ TF }} и удалите значение нужной метки в блоке `labels`, во фрагменте с описанием брокера. Чтобы удалить все метки, удалите блок `labels` целиком.

      Пример описания брокера в конфигурации {{ TF }}:

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

      Более подробную информацию о параметрах ресурса `yandex_iot_core_broker` в {{ TF }}, см. в [документации провайдера]({{ tf-provider-link }}/iot_core_broker).
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

      Проверить метки брокера можно с помощью команды [CLI](../../../cli/quickstart.md):

      ```bash
      yc iot broker get <имя_брокера>
      ```

- API

  Удалить метку брокера можно с помощью метода API [update](../../broker/api-ref/Broker/update.md).

{% endlist %}