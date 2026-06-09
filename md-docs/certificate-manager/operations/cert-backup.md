# Резервное копирование сертификатов

## Сохранить сертификат {#backup}

Чтобы сохранить сертификат:
1. Получите идентификатор сертификата.

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится сертификат.
     1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_certificate-manager }}**.
     1. Скопируйте содержимое поля **{{ ui-key.yacloud.common.id }}** для сохраняемого сертификата.

   - CLI {#cli}

     Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

     По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

     1. Посмотрите описание команды CLI для получения списка сертификатов:

        ```bash
        yc cm certificate list --help
        ```

     1. Выполните команду:

        ```bash
        yc cm certificate list
        ```

   - API {#api}

     Чтобы получить идентификатор сертификата, воспользуйтесь методом REST API [list](../api-ref/Certificate/list.md) для ресурса [Certificate](../api-ref/Certificate/index.md) или вызовом gRPC API [CertificateService/List](../api-ref/grpc/Certificate/list.md).


   {% endlist %}

1. Получите содержимое сертификата.

   {% list tabs group=instructions %}

   - CLI {#cli}

     Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

     По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

     1. Посмотрите описание команды CLI для получения содержимого сертификатов:

        ```bash
        yc cm certificate content --help
        ```

     1. Выполните команду:

        ```bash
        yc cm certificate content \
          --id <идентификатор_сертификата> \
          --chain <путь_к_файлу_цепочки_сертификатов> \
          --key <путь_к_файлу_закрытого_ключа>
        ...
        ```

   - API {#api}

     Чтобы получить содержимое сертификата, воспользуйтесь методом REST API [get](../api-ref/CertificateContent/get.md) для ресурса [CertificateContent](../api-ref/CertificateContent/index.md) или вызовом gRPC API [CertificateContentService/Get](../api-ref/grpc/CertificateContent/get.md).

   {% endlist %}

   Поместите полученные файлы в надежное долговременное хранилище.
1. Повторите процедуру для каждого сертификата, резервную копию которого необходимо создать.

## Восстановить сертификат {#restore}

{% note info %}

Нельзя восстановить сертификат с истекшим сроком действия.

{% endnote %}

Чтобы восстановить пользовательский сертификат из файлов с цепочкой сертификатов и ключом:
1. Подготовьте файлы с содержимым сертификата.
1. Импортируйте сертификат.

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором будет восстановлен сертификат.
     1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_certificate-manager }}**.
     1. Нажмите кнопку **{{ ui-key.yacloud.certificate-manager.button_empty-action }}**.
     1. В открывшемся меню выберите **{{ ui-key.yacloud.certificate-manager.action_import }}**.
     1. В открывшемся окне в поле **{{ ui-key.yacloud.certificate-manager.metadata.field_name }}** введите имя сертификата.
     1. (Опционально) В поле **Описание** введите описание сертификата.
     1. В поле **{{ ui-key.yacloud.certificate-manager.import.field_chain }}** нажмите кнопку **{{ ui-key.yacloud.certificate-manager.import.button_add-chain }}**.
        1. Выберите способ добавления: `{{ ui-key.yacloud.component.file-content-dialog.value_upload }}`.
        1. Нажмите кнопку **Прикрепить файл** и укажите файл цепочки сертификатов.
        1. Нажмите кнопку **{{ ui-key.yacloud.component.file-content-dialog.button_submit }}**.
     1. В поле **{{ ui-key.yacloud.certificate-manager.import.field_privateKey }}** нажмите кнопку **{{ ui-key.yacloud.certificate-manager.import.button_add-privateKey }}**.
        1. Выберите способ добавления: `{{ ui-key.yacloud.component.file-content-dialog.value_upload }}` или `{{ ui-key.yacloud.component.file-content-dialog.value_manual }}`.
        1. Нажмите кнопку **Прикрепить файл** и укажите файл приватного ключа.
        1. Нажмите кнопку **{{ ui-key.yacloud.component.file-content-dialog.button_submit }}**.
     1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

   - CLI {#cli}

     Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

     По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

     1. Посмотрите описание команды:

        ```bash
        yc cm certificate create --help
        ```

     1. Выполните команду:

        ```bash
        yc cm certificate create \
          --name <имя_сертификата> \
          --chain <путь_к_файлу_цепочки_сертификатов> \
          --key <путь_к_файлу_закрытого_ключа>
        ...
        ```

   - API {#api}

     Чтобы импортировать сертификат, воспользуйтесь методом REST API [create](../api-ref/Certificate/create.md) для ресурса [Certificate](../api-ref/Certificate/index.md) или вызовом gRPC API [CertificateService/Create](../api-ref/grpc/Certificate/create.md).

   {% endlist %}

   Идентификатор восстановленного сертификата будет отличаться от идентификатора, который был у сертификата в момент сохранения.
1. Повторите процедуру для каждого сертификата, содержимое которого надо восстановить.

Сохраненный [сертификат от Let's Encrypt](../concepts/managed-certificate.md) после восстановления станет [пользовательским](../concepts/imported-certificate.md). Для [обновления](import/cert-update.md) такого сертификата необходимо загружать новую версию самостоятельно.

#### См. также {#see-also}

* [{#T}](import/cert-create.md).