# Updating a function

You can change the [name](function-update.md#update-name) and [description](function-update.md#update-description) of a function as well as [manage function labels](function-update.md#manage-label). To change the code or operation parameters of a function, [create a new version of the function](version-manage.md#version-create).

{% include [function-list-note](../../../_includes/functions/function-list-note.md) %}

## Changing the name of a function {#update-name}

{% list tabs %}

- Management console

    1. In the [management console]({{ link-console-main }}), go to the folder where you want to change the name of a [function](../../concepts/function.md).
    1. Select **{{ sf-name }}**.
    1. Select a function.
    1. In the upper-right corner, click **Edit**.
    1. In the window that opens, enter the desired function name.
    1. Click **Save**.

- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    To change the function name, run the command:

    ```
    yc serverless function update <function name> --new-name <new function name>
    ```

    Result:

    ```
    id: b097d9ous3gep99khe83
    folder_id: aoek49ghmknnpj1ll45e
    created_at: "2019-06-06T11:36:48.688Z"
    name: my-beta-function
    labels:
     test: test
    log_group_id: eolv6578frac08uh5h6s
    http_invoke_url: https://functions.yandexcloud.net/b097d9ous3gep99khe83
    status: ACTIVE
    ```

- API

    You can change the function name using the API method [update](../../functions/api-ref/Function/update.md).

- Yandex Cloud Toolkit

    You can rename the function using the [Yandex Cloud Toolkit plugin]{% if lang == "ru" %}(https://github.com/yandex-cloud/ide-plugin-jetbrains){% endif %}{% if lang == "en" %}(https://github.com/yandex-cloud/ide-plugin-jetbrains/blob/master/README.en.md){% endif %} for the family of IDEs on the [IntelliJ platform]{% if lang == "ru" %}(https://www.jetbrains.com/ru-ru/opensource/idea/){% endif %}{% if lang == "en" %}(https://www.jetbrains.com/opensource/idea/){% endif %} from [JetBrains](https://www.jetbrains.com/).

{% endlist %}

## Updating the description of a function {#update-description}

{% list tabs %}

- Management console

    1. In the [management console]({{ link-console-main }}), go to the folder where you want to change the description of a [function](../../concepts/function.md).
    1. Select **{{ sf-name }}**.
    1. Select a function.
    1. In the upper-right corner, click **Edit**.
    1. In the window that opens, enter the description of the function.
    1. Click **Save**.

- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    To update the description of a function, run the command:

    ```
    yc serverless function update <function name> --description "<function description>"
    ```

    Result:

    ```
    id: b097d9ous3gep99khe83
    folder_id: aoek49ghmknnpj1ll45e
    created_at: "2019-06-06T11:36:48.688Z"
    name: my-beta-function
    description: My beta function.
    labels:
      test: test
    log_group_id: eolv6578frac08uh5h6s
    http_invoke_url: https://functions.yandexcloud.net/b097d9ous3gep99khe83
    status: ACTIVE
    ```

- API

    You can update the description of a function using the API method [update](../../functions/api-ref/Function/update.md).

- Yandex Cloud Toolkit

    You can update the description of a function using the [Yandex Cloud Toolkit plugin]{% if lang == "ru" %}(https://github.com/yandex-cloud/ide-plugin-jetbrains){% endif %}{% if lang == "en" %}(https://github.com/yandex-cloud/ide-plugin-jetbrains/blob/master/README.en.md){% endif %} for the family of IDEs on the [IntelliJ platform]{% if lang == "ru" %}(https://www.jetbrains.com/ru-ru/opensource/idea/){% endif %}{% if lang == "en" %}(https://www.jetbrains.com/opensource/idea/){% endif %} from [JetBrains](https://www.jetbrains.com/).

{% endlist %}

## Managing function labels {#manage-label}

You can perform the following actions with function labels:

- [Add a label](#add-label)
- [Update a label](#update-label)
- [Delete a label](#remove-label)

### Adding a label {#add-label}

{% list tabs %}

- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    To add a label to a function, run the command:

    ```
    yc serverless function add-labels <function name> --labels <key>=<value>
    ```

    Result:

    ```
    id: b097d9ous3gep99khe83
    folder_id: aoek49ghmknnpj1ll45e
    created_at: "2019-06-06T11:36:48.688Z"
    name: my-beta-function
    description: My beta function.
    labels:
      test: test
      version: beta
    log_group_id: eolv6578frac08uh5h6s
    http_invoke_url: https://functions.yandexcloud.net/b097d9ous3gep99khe83
    status: ACTIVE
    ```

- API

    You can add a label to a function using the API method [update](../../functions/api-ref/Function/update.md).

{% endlist %}

### Updating a label {#update-label}

{% list tabs %}

- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    To update the function label, run the command:

    {% note warning %}

    The existing set of `labels` is completely replaced by the set transmitted.

    {% endnote %}

    ```
    yc serverless function update <function name> --labels <key>=<value>
    ```

    Result:

    ```
    id: b097d9ous3gep99khe83
    folder_id: aoek49ghmknnpj1ll45e
    created_at: "2019-06-06T11:36:48.688Z"
    name: my-beta-function
    description: My beta function.
    labels:
      new_labels: my-beta-function
    log_group_id: eolv6578frac08uh5h6s
    http_invoke_url: https://functions.yandexcloud.net/b097d9ous3gep99khe83
    ```

- API

    You can edit labels of a function using the API method [update](../../functions/api-ref/Function/update.md).

{% endlist %}

### Deleting a label {#remove-label}

{% list tabs %}

- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    To delete a function label, run the command:

    ```
    yc serverless function remove-labels <function name> --labels <key>
    ```

    Result:

    ```
    id: b097d9ous3gep99khe83
    folder_id: aoek49ghmknnpj1ll45e
    created_at: "2019-06-06T11:36:48.688Z"
    name: my-beta-function
    description: My beta function.
    labels:
      version: beta
    log_group_id: eolv6578frac08uh5h6s
    http_invoke_url: https://functions.yandexcloud.net/b097d9ous3gep99khe83
    status: ACTIVE
    ```

- API

    You can delete a function label using the API method [update](../../functions/api-ref/Function/update.md).

{% endlist %}

