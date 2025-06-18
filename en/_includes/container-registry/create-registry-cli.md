{% include [cli-install](../cli-install.md) %}

{% include [default-catalogue](../default-catalogue.md) %}

1. Make sure that a registry has not been created in the folder yet:

    ```bash
    yc container registry list
    ```

    Result:

    ```text
    +----+------+-----------+
    | ID | NAME | FOLDER ID |
    +----+------+-----------+
    +----+------+-----------+
    ```

    If the folder already contains a registry, see [{#T}](../../container-registry/operations/registry/registry-update.md) for info on how you can update it.

1. Create a registry:

    * With automated vulnerability scanning:


        ```bash
        yc container registry create --name my-reg --secure
        ```

      {% include [safe-registry](safe-registry.md) %}

    * Without automated vulnerability scanning:

        ```bash
        yc container registry create --name my-reg
        ```

    Result:

    ```text
    done
    id: crpd50616s9a********
    folder_id: b1g88tflru0e********
    name: my-reg
    status: ACTIVE
    created_at: "2019-01-09T14:34:06.601Z"
    ```

    Follow these registry naming requirements:

    {% include [name-format](../name-format.md) %}

    The `--name` parameter is optional. You can create a registry without a name and use its ID to access it. The `name` field is user-defined. It is used when listing in the {{ yandex-cloud }} CLI and not used in the Docker CLI.
1. Make sure the registry was created:

    ```bash
    yc container registry list
    ```

    Result:

    ```text
    +----------------------+--------+----------------------+
    |          ID          |  NAME  |      FOLDER ID       |
    +----------------------+--------+----------------------+
    | crpd50616s9a******** | my-reg | b1g88tflru0e******** |
    +----------------------+--------+----------------------+
    ```