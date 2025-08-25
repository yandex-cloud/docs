[Загрузите](../../baremetal/operations/image-upload.md#upload-file) ISO-образ в [{{ objstorage-full-name }}](../../storage/index.yaml) и получите ссылку на загруженный объект:

1. Создайте бакет {{ objstorage-name }}:

    {% note info %}

    Чтобы создать [бакет](../../storage/concepts/bucket.md), у вас должна быть _минимальная_ [роль](../../storage/security/index.md#storage-editor) `storage.editor` на [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder).

    {% endnote %}

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать бакет.
      1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
      1. Справа сверху нажмите **{{ ui-key.yacloud.storage.buckets.button_create }}**.
      1. На странице создания бакета:

          1. Введите имя бакета в соответствии с [правилами именования](../../storage/concepts/bucket.md#naming).
          1. При необходимости задайте ограничение на максимальный размер бакета или включите опцию **{{ ui-key.yacloud.storage.bucket.settings.label_size-limit-disabled }}**.
          1. Значения остальных параметров оставьте без изменения и нажмите **{{ ui-key.yacloud.storage.buckets.create.button_create }}**.

    - {{ yandex-cloud }} CLI {#cli}

      {% include [cli-install](../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../_includes/default-catalogue.md) %}

      1. Создайте бакет в каталоге по умолчанию:

          ```bash
          yc storage bucket create --name <имя_бакета>
          ```

          Где `--name` — имя бакета. Обязательный параметр. Подробнее см. [Правила именования бакетов](../../storage/concepts/bucket.md#naming).

          Результат:

          ```text
          name: <имя_бакета>
          folder_id: b1gt6g8ht345********
          anonymous_access_flags: {}
          default_storage_class: STANDARD
          versioning: VERSIONING_DISABLED
          created_at: "2025-08-06T07:29:40.418079Z"
          resource_id: e3e9neva43dl********
          ```

          Подробнее о команде `yc storage bucket create` см. в [Справочнике {{ yandex-cloud }} CLI](../../cli/cli-ref/storage/cli-ref/bucket/create.md).

    {% endlist %}

1. Загрузите скачанный файл с образом в созданный бакет:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      {% note info %}

      Через консоль управления нельзя загрузить объекты размером более 5 ГБ (см. [{#T}](../../storage/concepts/limits.md)). Для загрузки больших объектов используйте другие [инструменты](../../storage/tools/index.md).

      {% endnote %}

      1. В [консоли управления]({{ link-console-main }}) в списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}** и перейдите в бакет, в который нужно загрузить образ.
      1. На панели слева выберите ![image](../../_assets/console-icons/folder-tree.svg) **{{ ui-key.yacloud.storage.bucket.switch_files }}** и в правом верхнем углу экрана нажмите кнопку ![arrow-up-from-line](../../_assets/console-icons/arrow-up-from-line.svg) **{{ ui-key.yacloud.storage.bucket.button_upload }}**.
      1. В открывшемся окне выберите файл с образом и нажмите **Открыть**.
      1. В окне загрузки объектов нажмите **{{ ui-key.yacloud.storage.button_upload }}** и дождитесь завершения загрузки.
      1. Обновите страницу.

    - {{ yandex-cloud }} CLI {#cli}

      1. Выполните команду:

          ```bash
          yc storage s3api put-object \
            --body <путь_к_локальному_файлу> \
            --bucket <имя_бакета> \
            --key <путь_к_объекту>
          ```

          Где:

          * `--body` — путь к файлу, который нужно загрузить в бакет. Например: `./ubuntu.iso`.
          * `--bucket` — имя вашего бакета.
          * `--key` — [ключ](../../storage/concepts/object.md#key), по которому объект будет храниться в бакете. Например: `Ubuntu-2404.iso`.

          Результат:

          ```text
          etag: '"87740887a5159e2685500c02********"'
          request_id: 300dceee********
          ```
      Подробнее о команде `yc storage s3api put-object` см. в [Справочнике {{ yandex-cloud }} CLI](../../cli/cli-ref/storage/cli-ref/s3api/put-object.md).

    {% endlist %}

1. Получите ссылку на загруженный в бакет образ:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления]({{ link-console-main }}) выберите каталог.
      1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}** и выберите нужный бакет.
      1. Нажмите на имя объекта с загруженным ISO-образом.
      1. В правом верхнем углу экрана нажмите кнопку ![link](../../_assets/storage/link.svg) **{{ ui-key.yacloud.storage.file.button_generate }}**.
      1. Нажмите **{{ ui-key.yacloud.storage.file.button_generate }}**.
      1. Скопируйте полученную ссылку.

    {% endlist %}