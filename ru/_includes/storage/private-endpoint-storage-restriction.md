Вы можете ограничить доступ в бакет на уровне сервиса, тогда доступ к бакету будет возможен только из сервисных подключений {{ vpc-short-name }}.

{% note warning %}

После включения данной опции доступ в бакет из публичной сети будет невозможен. Доступ в бакет с помощью [консоли управления]({{ link-console-main }}) можно включить отдельной опцией. См. также [Особенности копирования объектов на стороне сервера (Server Side Copy)](#server-side-copy).

{% endnote %}

### Разрешить доступ в бакет только из сервисных подключений {{ vpc-short-name }} на уровне сервиса {#enable-service-restriction}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы настроили сервисное подключение {{ vpc-short-name }}.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ objstorage-name }}**.
  1. Выберите бакет в списке.
  1. На панели слева выберите ![image](../../_assets/console-icons/wrench.svg) **{{ ui-key.yacloud.storage.bucket.switch_settings }}**.
  1. В блоке **{{ ui-key.yacloud.storage.form.BucketSettingsFormSection.field_label-strict-mode_2ttnd }}** активируйте опцию **{{ ui-key.yacloud.storage.form.BucketSettingsFormSection.field_description-strict-mode_9cpMe }}**.
  1. В поле **{{ ui-key.yacloud.storage.form.Service_onnectionsField.field_lable-service-connections_iGyHa }}** укажите идентификатор созданного сервисного подключения.
  1. (Опционально) Активируйте опцию **{{ ui-key.yacloud.storage.form.BucketSettingsFormSection.field_force-cloud-console-access_5bS8y }}**. Опция позволяет при включенном доступе только через сервисные подключения {{ vpc-short-name }} работать с бакетом с помощью консоли управления. При отключенной опции доступ к бакету остается только через API и CLI.
  1. Нажмите **{{ ui-key.yacloud.common.save }}**.

- {{ yandex-cloud }} CLI {#cli}

  {% include [include](../cli-install.md) %}
  
  {% include [default-catalogue](../default-catalogue.md) %}

  1. Создайте дополнительные [ресурсные записи](../../dns/concepts/resource-record.md) в DNS для переопределения публичного FQDN сервиса, к которому создается подключение. Для этого включите специальный параметр сервисного подключения {{ vpc-short-name }}:
  
      ```bash
      yc vpc private-endpoint update \
        --id <идентификатор_сервисного_подключения> \
        --private-dns-records-enabled
      ```

  1. Измените настройки бакета, указав параметры для включения доступа только из сервисных подключений {{ vpc-short-name }}:
  
      ```bash
      yc storage bucket update \
        --name <имя_бакета> \
        --enable-private-endpoints true \
        --private-endpoints <идентификатор_сервисного_подключения> \
        --private-endpoints-force-cloudconsole-access true
      ```

      Где:
      * `--name` — имя бакета.
      * `--enable-private-endpoints` — параметр для включения доступа к бакету только из сервисных подключений {{ vpc-short-name }}. Если параметр не указан, доступ к бакету будет возможен как из публичной сети, так и из сервисных подключений {{ vpc-short-name }}.
      * `--private-endpoints` — список идентификаторов сервисных подключений {{ vpc-short-name }}, доступ из которых будет разрешен.

        {% note warning %}

        Если идентификаторы сервисных подключений {{ vpc-short-name }} не указаны, доступ к бакету будет невозможен отовсюду. Однако останется возможность [выключить](#disable) ограничения на доступ только из сервисных подключений {{ vpc-short-name }}.

        {% endnote %}

      * `--private-endpoints-force-cloudconsole-access` — (опционально) параметр для включения доступа к бакету с помощью консоли управления при включенном доступе только через сервисные подключения {{ vpc-short-name }}. При отключенной опции доступ в бакет остается только через API и CLI.

- API {#api}

  Чтобы разрешить доступ в бакет только из сервисных подключений {{ vpc-short-name }} на уровне сервиса, воспользуйтесь методом REST API [update](../../storage/api-ref/Bucket/update.md) для ресурса [Bucket](../../storage/api-ref/grpc/Bucket/index.md) или вызовом gRPC API [Bucket/Update](../../storage/api-ref/grpc/Bucket/update.md).

{% endlist %}

### Восстановить доступ к бакету из публичной сети {#disable}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы настроили сервисное подключение {{ vpc-short-name }}.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ objstorage-name }}**.
  1. Выберите бакет в списке.
  1. На панели слева выберите ![image](../../_assets/console-icons/wrench.svg) **{{ ui-key.yacloud.storage.bucket.switch_settings }}**.
  1. В блоке **{{ ui-key.yacloud.storage.form.BucketSettingsFormSection.field_label-strict-mode_2ttnd }}** деактивируйте опцию **{{ ui-key.yacloud.storage.form.BucketSettingsFormSection.field_description-strict-mode_9cpMe }}**.
  1. Нажмите **{{ ui-key.yacloud.common.save }}**.

- {{ yandex-cloud }} CLI {#cli}

  Измените настройки бакета:
  
  ```bash
  yc storage bucket update \
    --name <имя_бакета> \
    --enable-private-endpoints false    
  ```

  Где:
  * `--name` — имя бакета.
  * `--enable-private-endpoints` — параметр для включения доступа к бакету только из сервисных подключений {{ vpc-short-name }}.

    {% note tip %}

    После того как ограничение на доступ только из сервисных подключений {{ vpc-short-name }} снято, список сервисных подключений, переданный ранее в параметре `--private-endpoints`, сохраняется в настройках бакета. При повторном ограничении доступа нет необходимости передавать список еще раз.

    {% endnote %}

- API {#api}

  Чтобы разрешить доступ в бакет только из сервисных подключений {{ vpc-short-name }} на уровне сервиса, воспользуйтесь методом REST API [update](../../storage/api-ref/Bucket/update.md) для ресурса [Bucket](../../storage/api-ref/grpc/Bucket/index.md) или вызовом gRPC API [Bucket/Update](../../storage/api-ref/grpc/Bucket/update.md).

{% endlist %}