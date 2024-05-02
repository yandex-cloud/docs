---
title: "Как создать файловое хранилище в {{ compute-full-name }}"
description: "Следуя данной инструкции, вы сможете создать файловое хранилище."
---

# Создать файловое хранилище


Чтобы создать [файловое хранилище](../../concepts/filesystem.md):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно создать файловое хранилище.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.compute.switch_file-storages }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.nfs.button_create-filesystem }}**.
  1. Введите имя файлового хранилища.

     {% include [name-format-2](../../../_includes/name-format-2.md) %}

  1. (Опционально) Добавьте описание файлового хранилища.
  1. Выберите [зону доступности](../../../overview/concepts/geo-scope.md). Файловое хранилище можно подключить только к [виртуальным машинам](../../concepts/vm.md) из той же зоны доступности.
  1. Выберите [тип файлового хранилища](../../concepts/filesystem.md#types).

     {% note warning %}

     Зону доступности и тип файлового хранилища нельзя изменить после его создания.

     {% endnote %}

  1. Укажите размер блока и размер диска файлового хранилища.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды [CLI](../../../cli/) для создания файлового хранилища:

      ```bash
      yc compute filesystem create --help
      ```

  1. Создайте файловое хранилище в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder) по умолчанию:

      ```bash
      yc compute filesystem create \
        --name <имя_файлового_хранилища> \
        --type <тип_файлового_хранилища> \
        --zone <зона_доступности> \
        --size <размер_файлового_хранилища> \
        --labels <ключ>=<значение>
      ```

      Где:
      * `--name` — имя файлового хранилища. Требования к имени:

        {% include [name-format](../../../_includes/name-format.md) %}

      * `--type` — [тип файлового хранилища](../../concepts/filesystem.md#types). Возможные значения: `network-hdd` или `network-ssd`.
      * `--zone` — [зона доступности](../../../overview/concepts/geo-scope.md).
      * `--size` — размер файлового хранилища. Необязательный параметр. Значение по умолчанию 150 ГБ.

        По умолчанию значение задается в байтах. Чтобы указать размер в мегабайтах или гигабайтах, используйте суффиксы `M` и `G`. Например: `2048M` или `2G`.

      * `--labels` — [метки](../../../resource-manager/concepts/labels.md) файлового хранилища в формате `<ключ>=<значение>`. Необязательный параметр.

        Чтобы указать несколько меток, перечислите их через запятую: `<ключ_1>=<значение_1>,<ключ_2>=<значение_2>,...,<ключ_n>=<значение_n>`.

      Результат:

      ```yml
      done (11s)
      id: epdcago8e5lr********
      folder_id: b1gt6g8ht345********
      created_at: "2024-05-02T05:56:39Z"
      name: my-sample-fs
      labels:
        key1: value1
        key2: value2
        key3: value3
      type_id: network-hdd
      zone_id: {{ region-id }}-a
      size: "1073741824"
      status: READY
      ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

     ```hcl
     provider "yandex" {
       zone = "{{ region-id }}-a"
     }

     resource "yandex_compute_filesystem" "default" {
       name   = "<имя_файлового_хранилища>"
       type   = "<тип_файлового_хранилища>"
       zone   = "<зона_доступности>"
       size   = <размер_файлового_хранилища>
       labels = {
         <ключ_метки_1> = "<значение_метки_1>"
         <ключ_метки_2> = "<значение_метки_2>"
       }
     }
     ```

     Где:
     * `name` — имя файлового хранилища. Обязательный параметр.
     * `type` — [тип файлового хранилища](../../concepts/filesystem.md#types). Возможные значения: `network-hdd` или `network-ssd`. По умолчанию выбирается тип файлового хранилища `network-hdd`. Необязательный параметр.
     * `zone` — [зона доступности](../../../overview/concepts/geo-scope.md). Необязательный параметр.
     * `size` — размер файлового хранилища в ГБ. Необязательный параметр. Значение по умолчанию 150 ГБ.
     * `labels` — [метка](../../../resource-manager/concepts/labels.md) ресурса в формате `<ключ> = "<значение>"`. Необязательный параметр.

      Более подробную информацию о параметрах ресурса `yandex_compute_filesystem` в {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/compute_filesystem).
  1. Создайте ресурсы:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  После этого в указанном [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder) будет создано файловое хранилище. Проверить появление файлового хранилища и его настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/):

  ```bash
  yc compute filesystem get <имя_файлового_хранилища>
  ```

- API {#api}

  Воспользуйтесь методом REST API [create](../../api-ref/Filesystem/create.md) для ресурса [Filesystem](../../api-ref/Filesystem/index.md) или вызовом gRPC API [FilesystemService/Create](../../api-ref/grpc/filesystem_service.md#Create).

{% endlist %}