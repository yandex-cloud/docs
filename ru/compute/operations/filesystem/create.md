# Создать файловое хранилище

Чтобы создать [файловое хранилище](../../concepts/filesystem.md):

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать файловое хранилище.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../../_assets/compute/storage.svg) **{{ ui-key.yacloud.compute.switch_file-storages }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.nfs.button_create-filesystem }}**.
  1. Введите имя хранилища.
    
     {% include [name-format-2](../../../_includes/name-format-2.md) %}
    
  1. (опционально) Добавьте описание хранилища.
  1. Выберите [зону доступности](../../../overview/concepts/geo-scope.md): `{{ region-id }}-a` или `{{ region-id }}-b`. Хранилище можно подключить только к виртуальным машинам из той же зоны доступности.
  1. Выберите [тип хранилища](../../concepts/filesystem.md#types).
  
     {% note warning %}
     
     Зону доступности и тип файлового хранилища нельзя изменить после его создания.
     
     {% endnote %}
     
  1. Укажите размер блока и размер диска хранилища.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
  
- API

  Воспользуйтесь методом REST API [create](../../api-ref/Filesystem/create.md) для ресурса [Filesystem](../../api-ref/Filesystem/index.md) или вызовом gRPC API [FilesystemService/Create](../../api-ref/grpc/filesystem_service.md#Create).

{% endlist %}