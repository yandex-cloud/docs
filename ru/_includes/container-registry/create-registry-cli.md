{% include [cli-install](../cli-install.md) %}

{% include [default-catalogue](../default-catalogue.md) %}

1. Убедитесь, что в каталоге еще не создан реестр:

    ```bash
    yc container registry list
    ```

    Результат:

    ```text
    +----+------+-----------+
    | ID | NAME | FOLDER ID |
    +----+------+-----------+
    +----+------+-----------+
    ```

    Если в каталоге уже есть реестр, посмотрите, как можно его изменить, в разделе [{#T}](../../container-registry/operations/registry/registry-update.md).

1. Создайте реестр:

    * с автоматическим сканированием уязвимостей:


        ```bash
        yc container registry create --name my-reg --secure
        ```

      {% include [safe-registry](safe-registry.md) %}

    * без автоматического сканирования уязвимостей:

        ```bash
        yc container registry create --name my-reg
        ```

    Результат:

    ```text
    done
    id: crpd50616s9a********
    folder_id: b1g88tflru0e********
    name: my-reg
    status: ACTIVE
    created_at: "2019-01-09T14:34:06.601Z"
    ```

    Требования к имени реестра:

    {% include [name-format](../name-format.md) %}

    Параметр `--name` необязательный, можно создать реестр без имени и обращаться к нему по идентификатору. Поле `name` пользовательское, оно используется при листинге в {{ yandex-cloud }} CLI и не используется в Docker CLI.
1. Проверьте, что реестр создался:

    ```bash
    yc container registry list
    ```

    Результат:

    ```text
    +----------------------+--------+----------------------+
    |          ID          |  NAME  |      FOLDER ID       |
    +----------------------+--------+----------------------+
    | crpd50616s9a******** | my-reg | b1g88tflru0e******** |
    +----------------------+--------+----------------------+
    ```