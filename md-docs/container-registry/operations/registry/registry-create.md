# Создать реестр

Использовать созданный [реестр](../../concepts/registry.md) могут все пользователи и [сервисные аккаунты](../../../iam/concepts/users/service-accounts.md), у которых есть права на [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder). 

Вы можете создать безопасный реестр с автоматическим сканированием с помощью [сканера уязвимостей](../../concepts/vulnerability-scanner.md).

{% note info %}

Сканирование Docker-образов на наличие уязвимостей [тарифицируется](../../pricing.md#scanner).

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором будет создан реестр.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_container-registry }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.cr.overview.button_create }}**.
  1. Задайте имя реестра. Требования к имени:
  
      * длина — от 3 до 63 символов;
      * может содержать строчные буквы латинского алфавита, цифры и дефисы;
      * первый символ — буква, последний — не дефис.
  
  1. (Опционально) В блоке **{{ ui-key.yacloud.cr.overview.popup-create_field_auto_scan }}**:
  
  
      * Отключите опцию **{{ ui-key.yacloud.cr.overview.popup-create_scan_push_text }}**, чтобы не сканировать Docker-образы при загрузке в репозиторий.
      * Отключите опцию **{{ ui-key.yacloud.cr.overview.popup-create_scan_period_enabled }}** или настройте периодичность сканирования.
  
        {% note warning %}
        
        Автоматическое сканирование Docker-образов повышает безопасность реестра. Настройки сканирования уязвимостей по умолчанию соответствуют [Стандарту по защите облачной инфраструктуры {{ yandex-cloud }}](../../../security/standard/app-security.md#pipeline-recommendations).
        
        {% endnote %}
  
  1. (Опционально) Добавьте метки.
  1. Нажмите кнопку **{{ ui-key.yacloud.cr.overview.popup-create_button_create }}**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).
  
  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.
  
  1. Убедитесь, что в каталоге еще не создан реестр:
  
      ```bash
      yc container registry list
      ```
  
      Результат:
  
      ```text
      +----+------+-----------+
      | ID | NAME | FOLDER ID |
      +----+------+-----------+
      +----+------+-----------+
      ```
  
      Если в каталоге уже есть реестр, посмотрите, как можно его изменить, в разделе [{#T}](registry-update.md).
  
  1. Создайте реестр:
  
      * с автоматическим сканированием уязвимостей:
  
  
          ```bash
          yc container registry create --name my-reg --secure
          ```
  
        {% note warning %}
        
        Автоматическое сканирование Docker-образов повышает безопасность реестра. Настройки сканирования уязвимостей по умолчанию соответствуют [Стандарту по защите облачной инфраструктуры {{ yandex-cloud }}](../../../security/standard/app-security.md#pipeline-recommendations).
        
        {% endnote %}
  
      * без автоматического сканирования уязвимостей:
  
          ```bash
          yc container registry create --name my-reg
          ```
  
      Результат:
  
      ```text
      done
      id: crpd50616s9a********
      folder_id: b1g88tflru0e********
      name: my-reg
      status: ACTIVE
      created_at: "2019-01-09T14:34:06.601Z"
      ```
  
      Требования к имени реестра:
  
      * длина — от 3 до 63 символов;
      * может содержать строчные буквы латинского алфавита, цифры и дефисы;
      * первый символ — буква, последний — не дефис.
  
      Параметр `--name` необязательный, можно создать реестр без имени и обращаться к нему по идентификатору. Поле `name` пользовательское, оно используется при листинге в {{ yandex-cloud }} CLI и не используется в Docker CLI.
  1. Проверьте, что реестр создался:
  
      ```bash
      yc container registry list
      ```
  
      Результат:
  
      ```text
      +----------------------+--------+----------------------+
      |          ID          |  NAME  |      FOLDER ID       |
      +----------------------+--------+----------------------+
      | crpd50616s9a******** | my-reg | b1g88tflru0e******** |
      +----------------------+--------+----------------------+
      ```

- {{ TF }} {#tf}

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.
  1. Добавьте в конфигурационный файл параметры реестра, который необходимо создать. Например, файл с названием `example.tf` в директории `~/cloud-terraform`:

     ```hcl
     resource "yandex_container_registry" "my-reg" {
       name = "my-registry"
       folder_id = "<идентификатор_каталога>"
       labels = {
         my-label = "my-label-value"
       }
     }
     ```

     Где:
     * `name` — имя реестра.
     * `folder_id` — идентификатор каталога.
     * `labels` — набор [меток](../../../resource-manager/concepts/labels.md).

     Более подробную информацию о ресурсах, которые можно создать с помощью {{ TF }}, смотрите в [документации провайдера]({{ tf-provider-link }}).
  1. Проверьте корректность конфигурационного файла.
     1. В командной строке перейдите в директорию, где вы сохранили конфигурационный файл:

        ```bash
        cd /Users/<имя_пользователя>/cloud-terraform
        ```

     1. Выполните проверку с помощью команды:

        ```bash
        terraform plan
        ```

        Результат:

        ```text
        Refreshing Terraform state in-memory prior to plan...
        The refreshed state will be used to calculate this plan, but will not be
        persisted to local or remote state storage.
        ...
        Note: You didn't specify an "-out" parameter to save this plan, so Terraform
        can't guarantee that exactly these actions will be performed if
        "terraform apply" is subsequently run.
        ```

  1. Создайте реестр.
     1. Выполните команду:

        ```bash
        terraform apply
        ```

        Результат:

        ```text
        An execution plan has been generated and is shown below.
        Resource actions are indicated with the following symbols:
          + create
        ...
          Terraform will perform the actions described above.
          Only 'yes' will be accepted to approve.

          Enter a value:
        ```

     1. Подтвердите создание реестра. Для этого введите значение `yes` и нажмите **Enter**:

        ```bash
        Enter a value: yes
        ```

        Результат:

        ```text
        yandex_container_registry.default: Creating...
        yandex_container_registry.default: Creation complete after 4s [id=crpuljdfqoj3********]

        Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
        ```

        В каталоге будет создан реестр с именем `my-registry`.
     1. Проверьте ресурсы и их настройки в [консоли управления]({{ link-console-main }}).

- API {#api}

  Чтобы создать реестр, воспользуйтесь методом [create](../../api-ref/Registry/create.md) для ресурса [Registry](../../api-ref/Registry/index.md).

{% endlist %}