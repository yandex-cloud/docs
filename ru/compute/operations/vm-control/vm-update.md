# Изменить виртуальную машину

После создания ВМ вы можете изменить ее имя, описание, метки, платформу или метаданные.

Как изменить конфигурацию ВМ, читайте в разделе [{#T}](vm-update-resources.md).

{% list tabs %}

- Консоль управления

  Чтобы изменить ВМ:
  1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит ВМ.
  1. Выберите сервис **{{ compute-name }}**.
  1. Нажмите на имя нужной ВМ.
  1. Нажмите **Изменить ВМ**.
  1. Измените параметры ВМ, например, переименуйте машину, отредактировав поле **Имя**.
  1. Внизу страницы нажмите кнопку **Сохранить изменения**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для обновления параметров ВМ:

     ```bash
     yc compute instance update --help
     ```

  1. Получите список ВМ в каталоге по умолчанию:

     {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужной машины, например `first-instance`.
  1. Измените параметры ВМ, например, переименуйте машину:

     ```bash
     yc compute instance update first-instance \
       --new-name windows-vm
     ```

- API

  Чтобы изменить ВМ, воспользуйтесь методом REST API [update](../../api-ref/Instance/update.md) для ресурса [Instance](../../api-ref/Instance/) или вызовом gRPC API [InstanceService/Update](../../api-ref/grpc/instance_service.md#Update).

{% endlist %}

{% note info %}

При изменении имени ВМ, имя хоста и, соответственно, FQDN не изменяются. Подробнее про генерацию имени FQDN читайте в разделе [{#T}](../../concepts/network.md#hostname).

{% endnote %}

## Примеры {#examples}

### Просмотреть список изменяемых параметров {#viewing-a-list-of-configurable-parameters}

Чтобы просмотреть список изменяемых параметров, выполните команду:

{% list tabs %}

- CLI

  ```bash
  yc compute instance update --help
  ```

{% endlist %}

### Изменить имя и описание {#changing-the-name-and-description}

Чтобы изменить имя и описание ВМ, выполните следующие шаги:

{% list tabs %}

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Получите список ВМ в каталоге по умолчанию:

     {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужной машины, например `first-instance`.
  1. Измените имя и описание ВМ:

     ```bash
     yc compute instance update first-instance \
       --new-name first-vm \
       --description "changed description vm via CLI"
     ```

- API

  Воспользуйтесь методом REST API [update](../../api-ref/Instance/update.md) для ресурса [Instance](../../api-ref/Instance/) или вызовом gRPC API [InstanceService/Update](../../api-ref/grpc/instance_service.md#Update).

{% endlist %}

{% note alert %}

Не изменяйте имя ВМ, если она принадлежит [группе узлов](../../../managed-kubernetes/concepts/index.md#node-group) кластера {{ managed-k8s-name }}. Имя для такой ВМ генерируется автоматически, и его изменение нарушит работу кластера.

{% endnote %}

### Изменить метаданные {#changing-metadata}

Метаданные на базе разных операционных систем могут отличаться. При изменении имеющийся набор метаданных полностью перезаписывается набором, переданным в команде.

Чтобы изменить метаданные ВМ, выполните следующие шаги:

{% list tabs %}

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Получите список ВМ в каталоге по умолчанию:

     {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужной машины, например `first-instance`.
  1. Получите информацию о ВМ вместе с метаданными. Все пользовательские метаданные определены в ключе `user-data`.

     ```bash
     yc compute instance get --full first-instance
     ```

  1. Измените метаданные ВМ. Изменить метаданные можно с помощью флагов:
     * `--metadata` — для изменения значения из одной строки.
     * `--metadata-from-file` — для изменения значения из нескольких строк.

     Пример изменения пароля администратора на ВМ, на базе ОС Windows:
     1. Создайте YAML-файл (например, `metadata.yaml`) и укажите следующие данные:

        ```yaml
        #ps1
        net user administrator '<пароль>'
        ```

     1. Выполните команду:

        ```bash
        yc compute instance update first-instance \
          --metadata-from-file user-data=metadata.yaml
        ```

        Имеющийся набор метаданных будет полностью перезаписан.

{% endlist %}