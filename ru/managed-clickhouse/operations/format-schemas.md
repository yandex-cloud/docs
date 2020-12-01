# Управление схемами формата данных

{% include [mch-format-schemas-intro](../../_includes/mdb/mch-format-schemas-intro.md) %}

Примеры работы с форматами Cap'n Proto и Protobuf при вставке данных в кластер приведены в разделе [{#T}](insert.md).

## Перед подключением схемы формата данных {#prereq}

{{ mch-name }} работает только со схемами формата данных, которые загружены в {{ objstorage-name }}. Перед подключением схемы к кластеру:
1. Подготовьте файл со схемой формата (см. документацию [Cap'n Proto](https://capnproto.org/language.html) и [Protobuf](https://developers.google.com/protocol-buffers/docs/tutorials?hl=ru)).
1. [Загрузите файл](../../storage/operations/objects/upload.md) со схемой формата в {{ objstorage-name }}.
1. [Получите ссылку](../../storage/operations/objects/link-for-download.md) на этот файл.

## Подключить схему формата данных {#add-format-schema}

{% list tabs %}

- CLI 
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  Чтобы подключить схему формата данных к кластеру, выполните команду:
  - для формата **Cap'n Proto**:
     
    ```bash
    yc managed-clickhouse format-schema create "<имя схемы формата>" \
        --cluster-name="<имя кластера>" \
        --type="capnproto" \
        --uri="<ссылка на файл в Object Storage>"
    ```
       
  - для формата **Protobuf**:
       
    ```bash
    yc managed-clickhouse format-schema create "<имя схемы формата>" \
        --cluster-name="<имя кластера>" \
        --type="protobuf" \
        --uri="<ссылка на файл в Object Storage>"
    ```
       
  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).     

{% endtabs %}

## Изменить схему формата данных {#update-format-schema}

{{ mch-name }} не отслеживает изменения в файле со схемой формата данных, который находится в бакете {{ objstorage-name }}. 

Чтобы актуализировать содержимое схемы, которая уже подключена к кластеру:
1. [Загрузите файл](../../storage/operations/objects/upload.md) с актуальной схемой формата данных в {{ objstorage-name }}.
1. [Получите ссылку](../../storage/operations/objects/link-for-download.md) на этот файл.
1. Измените параметры схемы формата данных, подключенной к {{ mch-name }}, передав новую ссылку на файл со схемой формата.

   {% list tabs %}

   - CLI 
  
     {% include [cli-install](../../_includes/cli-install.md) %}
  
     {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
     Чтобы изменить ссылку на файл в объектном хранилище со схемой формата данных, выполнив команду:
  
     ```bash
     yc managed-clickhouse format-schema update "<имя схемы данных>" \
         --cluster-name="<имя кластера>" \
         --uri="<новая ссылка на файл в Object Storage>"
     ```
  
     Имя схемы можно запросить со [списком схем формата данных в кластере](#list-format-schemas); имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).
  
   {% endtabs %}  

## Отключить схему формата данных {#disable-format-schema}

{% note info %}

После отключения схемы формата данных соответствующий объект остается в бакете {{ objstorage-name }}. Если этот объект со схемой формата больше не нужен, его можно [удалить](../../storage/operations/objects/delete.md).

{% endnote %}

{% list tabs %}

- CLI 
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  Чтобы отключить схему формата данных, выполните команду:
  
  ```bash
  yc managed-clickhouse format-schema delete "<имя схемы формата>" \
      --cluster-name="<имя кластера>"
  ```
  
  Имя схемы можно запросить со [списком схем формата данных в кластере](#list-format-schemas); имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).
  
{% endtabs %} 

## Получить список схем формата данных в кластере {#list-format-schemas}

{% list tabs %}

- CLI 
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  Чтобы получить список схем формата данных в кластере, выполните команду:
  
  ```bash
  yc managed-clickhouse format-schema list --cluster-name="<имя кластера>"
  ```
  
  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).   
  
{% endtabs %}  

## Получить детальную информацию о схеме формата данных {get-format-schema} 

{% list tabs %}

- CLI 
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  Чтобы получить детальную информацию о схеме формата данных, выполните команду:
  
  ```bash
  yc managed-clickhouse format-schema get "<имя схемы формата>" \
      --cluster-name="<имя кластера>" 
  ```
  
  Имя схемы можно запросить со [списком схем формата данных в кластере](#list-format-schemas); имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).
  
{% endtabs %} 
