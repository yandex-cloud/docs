# Updating a function

You can change the [name](function-update.md#update-name) and [description](function-update.md#update-description) of a function as well as [manage function labels](function-update.md#manage-label). To change the code or operation parameters of a function, [create a new version of the function](version-manage.md#version-create).

{% include [function-list-note](../../../_includes/functions/function-list-note.md) %}

## Changing the name of a function {#update-name}

{% list tabs %}

- Management console

    To change the name of a [function](../../concepts/function.md):
    1. Open the **{{ sf-name }}** section in the folder where you want to update the function.
    1. Select the desired function from the list.
    1. In the window that opens, click **Edit**.
    1. In the window that opens, enter the desired function name.
    1. Click **Save**.

- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}

    Change the function name:

    ```
    $ yc serverless function update <function name> --new-name <new function name>
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

{% endlist %}

## Updating the description of a function {#update-description}

{% list tabs %}

- Management console

    To change the name of a [function](../../concepts/function.md):
    1. Open the **{{ sf-name }}** section in the folder where you want to update the function.
    1. Select the desired function from the list.
    1. In the window that opens, click **Edit**.
    1. In the window that opens, enter the description of the function.
    1. Click **Save**.

- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}

    Update the function description:

    ```
    $ yc serverless function update <function name> --description "<function description>"
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

{% endlist %}

## Managing function labels {#manage-label}

You can perform the following actions with function labels:

- [Add a label](#add-label).
- [Update a label](#update-label).
- [Delete a label](#remove-label).

### Adding a label {#add-label}

{% list tabs %}

- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}

    Add a label to a function:

    ```
    $ yc serverless function add-labels <function name> --labels <key>=<value>
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

{% endlist %}

### Updating a label {#update-label}

{% list tabs %}

- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}

    Update a function label:

    {% note warning %}

    The existing set of `labels` is completely replaced by the set transmitted.

    {% endnote %}

    ```
    $ yc serverless function update <function name> --labels <key>=<value>
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

{% endlist %}

### Deleting a label {#remove-label}

{% list tabs %}

- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}

    Delete a function label:

    ```
    $ yc serverless function remove-labels <function name> --labels <key>
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

{% endlist %}
