# Поставка данных из {{ forms-full-name }} в {{ datalens-full-name }} с использованием {{ sf-full-name }} и {{ yq-full-name }} при помощи {{ TF }}

# Поставка данных из {{ forms-full-name }} в {{ datalens-full-name }} с использованием {{ sf-full-name }} и {{ yq-full-name }} при помощи {{ TF }}


Чтобы настроить интеграцию {{ forms-name }} и {{ datalens-name }} при помощи Terraform:

1. [Подготовьте инфраструктуру](#prepare-infrastructure).
1. [Создайте и настройте функцию {{ sf-full-name }}](#create-function).
1. [Создайте и настройте форму в {{ forms-name }}](#create-form).
1. [Настройте подключение и привязку к данным в сервисе {{ yq-full-name }}](#yq-integration).
1. [Настройте получение данных в {{ datalens-name }}](#set-up-datalens).
1. [Протестируйте интеграцию созданных ресурсов](#test-forms-integration).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#prepare-cloud}

Зарегистрируйтесь в {{ yandex-cloud }} и создайте [платежный аккаунт](../../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь.
1. На странице **[{{ ui-key.yacloud_billing.billing.label_service }}]({{ link-console-billing }})** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../billing/quickstart/index.md) и [привяжите](../../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака]({{ link-console-cloud }}).

[Подробнее об облаках и каталогах](../../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входят:

* плата за использование бакета {{ objstorage-full-name }} (см. [тарифы {{ objstorage-name }}](../../../storage/pricing.md));
* плата за хранение и запросы секретов {{ lockbox-full-name }} (см. [тарифы {{ lockbox-name }}](../../../lockbox/pricing.md));
* плата за вызовы функций и вычислительные ресурсы, выделенные для выполнения функций (см. [тарифы {{ sf-name }}](../../../functions/pricing.md));
* плата за объем считанных из источников данных при исполнении запросов {{ yq-name }} (см. [тарифы {{ yq-name }}](../../../query/pricing.md));
* плата за использование {{ datalens-name }} в соответствии с тарифным планом (см. [тарифы {{ datalens-name }}](../../../datalens/pricing.md)).

## Подготовьте инфраструктуру {#prepare-infrastructure}

[{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

{{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).

Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).

Чтобы подготовить инфраструктуру при помощи {{ TF }}:

1. Если у вас еще нет {{ TF }}, [установите его](../../infrastructure-management/terraform-quickstart.md#install-terraform).
1. [Получите данные для аутентификации](../../infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
1. [Настройте и инициализируйте провайдер](../../infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../../infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

1. Скачайте в ту же рабочую директорию файл конфигурации [forms-and-datalens-integration.tf](https://github.com/yandex-cloud-examples/yc-serverless-forms-datalens-integration/blob/main/forms-and-datalens-integration.tf).

    В этом файле описаны:

    * Сеть и подсеть, в которых будет создаваться инфраструктура для функции {{ sf-name }}.
    * Сервисный аккаунт со следующими ролями:
        * `lockbox.payloadViewer` — для чтения секретов {{ lockbox-full-name }};
        * `functions.functionInvoker` — для вызова функции {{ sf-name }};
        * `storage.admin` — для чтения и записи данных в бакет {{ objstorage-name }}, а также управления ACL бакета;
        * `yq.viewer` и `yq.invoker` — для интеграции {{ datalens-name }} и {{ yq-name }}.      
    * Статический ключ сервисного аккаунта, который используется для создания бакета {{ objstorage-name }}.
    * Статический ключ сервисного аккаунта, который используется для создания функции {{ sf-name }}.
    * Секрет {{ lockbox-name }} для хранения данных о статическом ключе сервисного аккаунта для функции {{ sf-name }}.
    * Информационный ресурс `data` для секрета {{ lockbox-name }}, из которого функция {{ sf-name }} получает идентификатор версии секрета.
    * Бакет {{ objstorage-name }} для результатов работы функции.
    * Функция {{ sf-name }} с публичным доступом.

1. В блоке с локальными переменными файла `forms-and-datalens-integration.tf` укажите:
    * идентификатор вашего каталога в переменной `sa_folder_id`;
    * имя бакета {{ objstorage-name }} в переменной `bucket-name`.

1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

    ```bash
    terraform validate
    ```

    Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

1. Создайте необходимую инфраструктуру:

    1. Выполните команду для просмотра планируемых изменений:
    
       ```bash
       terraform plan
       ```
    
       Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
    
    1. Если вас устраивают планируемые изменения, внесите их:
       1. Выполните команду:
    
          ```bash
          terraform apply
          ```
    
       1. Подтвердите изменение ресурсов.
       1. Дождитесь завершения операции.

    В указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).


## Создайте и настройте функцию {{ sf-name }} {#create-function}

1. Скачайте в директорию с файлом `forms-and-datalens-integration.tf` [архив с кодом функции](https://github.com/yandex-cloud-examples/yc-serverless-forms-datalens-integration/blob/main/function-zip).    

1. В блоке локальных переменных файла `forms-and-datalens-integration.tf` укажите значения:

    * `content_path` = `function.zip`.
    * `create-function` = `1`.

1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

    ```bash
    terraform validate
    ```

    Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

1. Создайте необходимую инфраструктуру:

    1. Выполните команду для просмотра планируемых изменений:
    
       ```bash
       terraform plan
       ```
    
       Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
    
    1. Если вас устраивают планируемые изменения, внесите их:
       1. Выполните команду:
    
          ```bash
          terraform apply
          ```
    
       1. Подтвердите изменение ресурсов.
       1. Дождитесь завершения операции.

    В указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

## Создайте и настройте форму {{ forms-name }} {#set-up-form}

### Создайте API-ключ {#create-api-key}

[API-ключ](../../../iam/concepts/authorization/api-key.md) нужен для настройки интеграции с {{ forms-name }}.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите нужный каталог.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Выберите сервисный аккаунт `forms-integration`.
  1. Перейдите в раздел **{{ ui-key.yacloud.common.overview }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}** и выберите **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_api_key }}**.  
  1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**.
  1. В открывшемся окне **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_label_title }}** отобразятся **{{ ui-key.yacloud.iam.folder.service-account.overview.label_id-title }}** и **{{ ui-key.yacloud.iam.folder.service-account.overview.label_secret-key-title }}**. Сохраните их — они понадобятся в дальнейшем.

{% endlist %}

### Создайте форму {#create-form}

{% list tabs group=instructions %}

- Интерфейс {{ forms-name }} {#forms}

  1. Перейдите в сервис [{{ forms-name }}]({{ link-forms-b2b }}).

  1. Нажмите кнопку **Создать форму**.

  1. Добавьте в форму хотя бы два любых поля и настройте произвольные вопросы в них.

  1. Нажмите кнопку **Опубликовать**.

  1. Сохраните ссылку на опубликованную форму — она понадобится позднее.

{% endlist %}

### Настройте интеграцию с функцией {{ sf-name }} {#set-up-integration}

{% list tabs group=instructions %}

- Интерфейс {{ forms-name }} {#forms}

  1. Перейдите в сервис [{{ forms-name }}]({{ link-forms-b2b }}).

  1. Откройте созданную ранее форму.

  1. Перейдите на вкладку **Настройки**.

  1. Откройте раздел **Дополнительно**.

  1. В блоке **Ключ для запуска облачных функций** введите данные [созданного ранее API-ключа](#create-api-key) и нажмите кнопку **Сохранить**.

  1. Откройте вкладку **Интеграции**.

  1. Нажмите кнопку **Cloud Functions**, чтобы добавить условие для интеграции.

  1. В поле **Код функции** введите идентификатор функции {{ sf-name }}. Вы можете скопировать идентификатор в разделе **{{ ui-key.yacloud.common.overview }}** функции {{ sf-name }} в [консоли управления]({{ link-console-main }}).

  1. В поле **Показывать сообщение о результате действия** выберите **Показывать**.

  1. Нажмите кнопку **Сохранить**.

{% endlist %}

### Проверьте работу созданной интеграции {#test-integration}

1. Перейдите по публичной ссылке созданной ранее формы.

1. Заполните форму и нажмите кнопку **Отправить**.

1. Перейдите в сервис [{{ forms-name }}]({{ link-forms-b2b }}).

1. Откройте созданную ранее форму.

1. Откройте вкладку **Интеграции**.

1. Перейдите на страницу **Выполненные интеграции**.

1. Откройте запись о выполненном действии и убедитесь, что в разделе **Ответ** получен HTTP-ответ `200 — ОК`.

1. Перейдите в [консоль управления]({{ link-console-main }}) и откройте [созданный ранее бакет](#create-s3-bucket). Убедитесь, что в нем появился JSON-файл с данными из заполненной формы.

   Название папки, в которой будет расположен файл, соответствует внутреннему идентификатору формы. Сохраните этот идентификатор — он понадобится для следующих шагов.

   Все последующие результаты заполнения формы будут сохраняться в этой папке.

1. Заполните форму еще несколько раз, причем одно из полей заполните одинаково хотя бы в двух формах. В дальнейшем это увеличит наглядность при тестировании интеграции.

## Настройте подключение и привязку к данным в сервисе {{ yq-name }} {#yq-integration}

{% list tabs group=instruction %}

- Интерфейс {{ yq-name }} {#yquery}

  1. Откройте [консоль управления]({{ link-console-main }}).
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
  1. На вкладке **{{ ui-key.yql.yq-ide-aside.connections.tab-text }}** нажмите кнопку ![info](../../../_assets/console-icons/plus.svg) **{{ ui-key.yql.yq-connection-form.action_create-new }}**.
  1. Создайте соединение со следующими параметрами:
      * **{{ ui-key.yql.yq-connection-form.connection-name.input-label }}** — `forms-connection`.
      * **{{ ui-key.yql.yq-connection-form.connection-type.input-label }}** — `{{ objstorage-name }}`.
      * **{{ ui-key.yql.yq-binding-form.connection-bucket.title }}** — имя [созданного ранее](#create-s3-bucket) бакета.
      * **{{ ui-key.yql.yq-connection-form.service-account.input-label }}** — `forms-integration-sa`.
  1. В открывшемся окне задайте параметры привязки к данным:
      * **{{ ui-key.yql.yq-binding-form.connection-type.title }}** — `{{ objstorage-name }}`.
      * **{{ ui-key.yql.yq-binding-form.connection.title }}** — `forms-connection`.
      * **{{ ui-key.yql.yq-binding-form.binding-path-pattern.title }}** — `/<идентификатор_формы>/`.
        Вы можете скопировать идентификатор:
          * В разделе **{{ ui-key.yacloud.storage.bucket.switch_files }}** бакета {{ objstorage-name }}. Название папки, в которой расположен файл с результатами заполнения формы, соответствует ее идентификатору.
          * В адресной строке [интерфейса {{ forms-name }}]({{ link-forms-b2b }}) на странице просмотра или редактирования формы.        
      * **{{ ui-key.yql.yq-binding-form.binding-format.title }}** — `json_each-row`.
      * **{{ ui-key.yql.yq-binding-form.binding-fields.title }}** — создайте колонки для полей, которые вы задали в форме.
        Чтобы {{ yq-name }} определил колонки самостоятельно, нажмите кнопку **{{ ui-key.yql.yq-binding-form.title_infer-columns }}**.

{% endlist %}

## Настройте получение данных в {{ datalens-name }} {#set-up-datalens}

{% list tabs group=instructions %}

- Интерфейс {{ datalens-name }} {#datalens}

  1. Перейдите в [сервис {{ datalens-name }}]({{ link-datalens-main-promo }}).
  1. Нажмите **Начать в облаке**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/thunderbolt.svg) **Подключения** и нажмите кнопку **Создать подключение**.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}** и задайте в открывшемся окне следующие параметры:
      * **Облако и каталог** — выберите облако и каталог, в котором вы создали остальные ресурсы.
      * **Сервисный аккаунт** — `forms-integration-sa`.
  1. Нажмите кнопку **Сохранить изменения** и в открывшемся окне задайте имя подключения — `forms-datalens-connection`, затем нажмите кнопку **Создать**.
  1. Вернитесь на главную страницу [сервиса {{ datalens-name }}]({{ link-datalens-main-skip-promo }}) и нажмите кнопку **Создать датасет**.
  1. На панели подключений нажмите ![icon](../../../_assets/console-icons/plus.svg) **Добавить** и выберите подключение `forms-datalens-connection`.
  1. В блоке **Таблицы** выберите нужную таблицу и перетащите ее в рабочую область {{ datalens-name }}.
      После загрузки данные из таблицы появятся на панели **Предпросмотр**.
  1. Нажмите кнопку **Сохранить** и введите имя датасета — `forms-integration-dataset`, затем нажмите кнопку **Создать**.

{% endlist %}

## Протестируйте интеграцию созданных ресурсов {#test-forms-integration}

Чтобы проверить совместную работу созданных ресурсов, откройте датасет `forms-integration-dataset` и нажмите кнопку **Создать чарт**. В открывшемся окне создайте произвольный чарт с данными, полученными из формы. Для большей наглядности постройте чарт по тому полю, в котором есть повторяющиеся значения.

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать.

1. В терминале перейдите в директорию с планом инфраструктуры.

    {% note warning %}

    Убедитесь, что в директории нет {{ TF }}-манифестов с ресурсами, которые вы хотите сохранить. {{ TF }} удаляет все ресурсы, которые были созданы с помощью манифестов в текущей директории.

    {% endnote %}

1. Удалите ресурсы:

    1. Выполните команду:

        ```bash
        terraform destroy
        ```

    1. Подтвердите удаление ресурсов и дождитесь завершения операции.

    Все ресурсы, которые были описаны в {{ TF }}-манифестах, будут удалены.