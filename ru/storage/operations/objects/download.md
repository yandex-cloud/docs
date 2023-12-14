---
title: "Инструкция по скачиванию объекта из бакета {{ objstorage-full-name }}"
description: "Из статьи вы узнаете, как скачать объект в {{ objstorage-full-name }}."
---

# Скачивание объекта


{% list tabs %}

- Консоль управления
  
  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. Выберите сервис **{{ objstorage-name }}**.
  1. Выберите нужный бакет.
  1. Выберите объект, который хотите скачать.
  1. В правом верхнем углу нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../../_assets/console-icons/arrow-down-to-line.svg) **{{ ui-key.yacloud.storage.file.button_download }}**.

- AWS CLI

  Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../../tools/aws-cli.md).

  Чтобы скачать один объект, выполните команду:

  ```bash
  aws s3 cp \
    --endpoint-url=https://{{ s3-storage-host }} \
    s3://<имя_бакета>/<ключ_объекта> \
    <локальный_путь>
  ```

  Где:
   
  * `--endpoint-url` — эндпоинт {{ objstorage-name }}.
  * `<имя_бакета>` — имя бакета, из которого необходимо скачать объект.
  * `<ключ_объекта>` — [ключ](../../concepts/object.md#key) объекта, который необходимо скачать.
  * `<локальный_путь>` — путь к директории, в которую будет сохранен скачанный объект. Например, `~/downloads/`.
   
  Чтобы скачать все объекты из бакета, выполните команду:
    
  ```bash
  aws s3 cp \
    --endpoint-url=https://{{ s3-storage-host }} \
    --recursive \
    s3://<имя_бакета> \
    <локальный_путь>
  ```
    
  Где:
    
  * `--endpoint-url` — эндпоинт {{ objstorage-name }}.
  * `--recursive` — команда для скачивания всех объектов бакета в локальную директорию.
  * `<имя_бакета>` — имя бакета, из которого необходимо скачать объект.
  * `<локальный_путь>` — путь к директории, в которую будут сохранены скачанные объекты. Например, `~/downloads/`.

  Команда `aws s3 cp` — высокоуровневая, ее функциональность ограничена. Подробнее см. в [справочнике AWS CLI](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/s3/cp.html).

  Объекты из бакета можно скачать выборочно с помощью команды `aws s3api` и шаблона запроса в формате JMESPath. Для скачивания объектов по шаблону выполните команду:

  * **Bash**:

      ```bash
      aws s3api list-objects \
          --endpoint-url https://{{ s3-storage-host }} \
          --bucket <имя_бакета> \
          --query '<запрос>' \
          --output text | xargs -I {} aws s3api get-object --endpoint-url https://{{ s3-storage-host }} --bucket <имя_бакета> --key {} <локальный_путь>{}
      ```

      Где:

      * `--endpoint-url` — эндпоинт {{ objstorage-name }}.
      * `--bucket` — имя бакета, из которого необходимо скачать объекты.
      * `--query` — запрос в формате [JMESPath](https://jmespath.org/).
      * `<локальный_путь>` — путь к директории, в которую будут сохранены скачанные объекты. Например, `~/downloads/`.

      Пример команды для скачивания из бакета `sample-bucket` в локальную директорию `~/downloads/` всех объектов, имена файлов которых начинаются с `date-20231002`:

      ```bash
      aws s3api list-objects \
        --endpoint-url https://{{ s3-storage-host }} \
        --bucket sample-bucket \
        --query 'Contents[?starts_with(Key, `date-20231002`) == `true`].[Key]' \
        --output text | xargs -I {} aws s3api get-object --endpoint-url https://{{ s3-storage-host }} --bucket sample-bucket --key {} ~/downloads/{}
      ```

  * **PowerShell**

      ```powershell
      Foreach($x in (aws s3api list-objects `
        --endpoint-url https://{{ s3-storage-host }} `
        --bucket <имя_бакета> `
        --query '<запрос>' `
        --output text)) `
        {aws s3api get-object --endpoint-url https://{{ s3-storage-host }} --bucket <имя_бакета> --key $x <локальный_путь>$x}
      ```

      Где:

      * `--endpoint-url` — эндпоинт {{ objstorage-name }}.
      * `--bucket` — имя бакета, из которого необходимо скачать объекты.
      * `--query` — запрос в формате [JMESPath](https://jmespath.org/).
      * `<локальный_путь>` — путь к папке, в которую будут сохранены скачанные объекты. Например, `d:\downloads\`.

      Пример команды для скачивания из бакета `sample-bucket` в локальную папку `d:\downloads\` всех объектов, имена файлов которых начинаются с `date-20231002`:

      ```powershell
      Foreach($x in (aws s3api list-objects `
        --endpoint-url https://{{ s3-storage-host }} `
        --bucket sample-bucket `
        --query 'Contents[?starts_with(Key, `date-20231002`) == `true`].[Key]' `
        --output text)) `
        {aws s3api get-object --endpoint-url https://{{ s3-storage-host }} --bucket sample-bucket --key $x d:\downloads\$x}
      ```

- API

  Чтобы скачать объект, воспользуйтесь методом S3 API [get](../../s3/api-ref/object/get.md).

{% endlist %}
