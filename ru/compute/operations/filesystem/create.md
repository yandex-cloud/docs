---
title: "Как создать файловое хранилище в {{ compute-full-name }}"
description: "Следуя данной инструкции, вы сможете создать файловое хранилище." 
---

# Создать файловое хранилище

Чтобы создать [файловое хранилище](../../concepts/filesystem.md):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать файловое хранилище.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.compute.switch_file-storages }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.nfs.button_create-filesystem }}**.
  1. Введите имя хранилища.
    
     {% include [name-format-2](../../../_includes/name-format-2.md) %}
    
  1. (Опционально) Добавьте описание хранилища.
  1. Выберите [зону доступности](../../../overview/concepts/geo-scope.md): `{{ region-id }}-a` или `{{ region-id }}-b`. Хранилище можно подключить только к виртуальным машинам из той же зоны доступности.
  1. Выберите [тип хранилища](../../concepts/filesystem.md#types).
  
     {% note warning %}
     
     Зону доступности и тип файлового хранилища нельзя изменить после его создания.
     
     {% endnote %}
     
  1. Укажите размер блока и размер диска хранилища.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

           
      ```
      provider "yandex" {
        zone = "{{ region-id }}-a"
      }

      resource "yandex_compute_filesystem" "default" {
        name   = "<имя_хранилища>"
        type   = "<тип_хранилища>"
        zone   = "<зона_доступности>"
        size   = <размер_хранилища>
        labels = {
          <ключ_метки_1> = "<значение_метки_1>"
          <ключ_метки_2> = "<значение_метки_2>"
       }
      }
      ```



      Где:

      * `name` — имя хранилища. Обязательный параметр.
      * `type` — [тип хранилища](../../concepts/filesystem.md#types). Возможные значения: `network-hdd` или `network-ssd`. По умолчанию выбирается тип хранилища `network-hdd`. Необязательный параметр.
      * `zone` — [зона доступности](../../../overview/concepts/geo-scope.md). Возможные значения: `{{ region-id }}-a` или `{{ region-id }}-b`. Необязательный параметр.
      * `size` — размер хранилища в ГБ. Необязательный параметр. Значение по умолчанию 150 ГБ.
      * `labels` — [метка](../../../resource-manager/concepts/labels.md) ресурса в формате `<ключ> = "<значение>"`. Необязательный параметр.

      Более подробную информацию о параметрах ресурса `yandex_compute_filesystem` в Terraform, см. в [документации провайдера]({{ tf-provider-link }}/compute_filesystem).

  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../../_tutorials/terraform-validate-plan-apply.md) %}

  После этого в указанном каталоге будет создано хранилище. Проверить появление хранилища и его настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

    ```bash
    yc compute filesystem get <имя_хранилища>
    ```

- API {#api}

  Воспользуйтесь методом REST API [create](../../api-ref/Filesystem/create.md) для ресурса [Filesystem](../../api-ref/Filesystem/index.md) или вызовом gRPC API [FilesystemService/Create](../../api-ref/grpc/filesystem_service.md#Create).

{% endlist %}