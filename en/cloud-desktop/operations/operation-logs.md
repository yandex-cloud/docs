# Viewing operations with the service's resources

All actions with {{ cloud-desktop-name }} resources are logged as a list of operations. Each operation is assigned a unique ID.

## Getting a list of operations {#get-operations}

{% list tabs group=instructions %}

- Management console {#console}

  You can get a list of operations for a specific resource. The steps below describe how you can do this for a [desktop](../concepts/desktops-and-groups.md). The same steps apply to other service resources.

  1. In the [management console]({{ link-console-main }}), open the folder the desktop is in.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-desktop }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/display.svg) **{{ ui-key.yacloud.vdi.label_desktops }}**.
  1. Select the desktop you need.
  1. Go to the ![image](../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.common.operations-key-value }}** panel for the selected desktop.

     You will see a list of operations with the selected desktop.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of operations for a {{ cloud-desktop-name }} resource, run this command:

  ```bash
  yc desktops <resource_type> list-operations <resource_name_or_ID>
  ```

  **Example**

  Getting a list of operations for a desktop:

  ```bash
  yc desktops desktop list-operations e3v7nfkhn0q4********
  ```

  Result:

  ```text
  +----------------------+---------------------+----------------------+---------------------+---------+-----------------+
  |          ID          |     CREATED AT      |      CREATED BY      |     MODIFIED AT     | STATUS  |   DESCRIPTION   |
  +----------------------+---------------------+----------------------+---------------------+---------+-----------------+
  | e3vlaf6r4241******** | 2024-05-14 17:55:00 | aje9k8luj4qf******** | 2024-05-14 17:55:00 | RUNNING | Restart desktop |
  | e3vns4mmfsal******** | 2024-05-14 17:41:14 | aje9k8luj4qf******** | 2024-05-14 17:45:17 | DONE    | Create desktop  |
  +----------------------+---------------------+----------------------+---------------------+---------+-----------------+
  ```

  By default, information about operations is provided as text. To get more detailed information, specify the `yaml` or `json` output data format using the `--format` flag:

  ```bash
  yc desktops desktop list-operations e3v7nfkhn0q4******** --format yaml
  ```

  Result:

  ```text
  - id: e3vlaf6r4241********
    description: Restart desktop
    created_at: "2024-05-14T17:55:00.742136402Z"
    created_by: aje9k8luj4qf********
    modified_at: "2024-05-14T17:55:00.742136402Z"
    metadata:
      '@type': type.googleapis.com/yandex.cloud.clouddesktop.v1.api.RestartDesktopMetadata
      desktop_id: e3v7nfkhn0q4********
  - id: e3vns4mmfsal********
    description: Create desktop
    created_at: "2024-05-14T17:41:14.076Z"
    created_by: aje9k8luj4qf********
    modified_at: "2024-05-14T17:45:17.355765714Z"
    done: true
    metadata:
      '@type': type.googleapis.com/yandex.cloud.clouddesktop.v1.api.CreateDesktopMetadata
      desktop_id: e3v7nfkhn0q4********
  ```

{% endlist %}

## Getting detailed information about an operation {#get-operations-info}

1. [Get a list of operations](#get-operations) for the resource.
1. Copy the ID of the operation.
1. Get detailed information about the operation:

    {% list tabs group=instructions %}

    - CLI {#cli}

      {% include [cli-install](../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../_includes/default-catalogue.md) %}

      Run this command:

      ```bash
      yc operation get <operation_ID>
      ```

      Result:

      ```text
      id: e3vlaf6r4241********
      description: Restart desktop
      created_at: "2024-05-14T17:55:00.742Z"
      created_by: aje9k8luj4qf********
      modified_at: "2024-05-14T17:57:47.065Z"
      done: true
      metadata:
        '@type': type.googleapis.com/yandex.cloud.clouddesktop.v1.api.RestartDesktopMetadata
        desktop_id: e3v7nfkhn0q4********
      response:
        '@type': type.googleapis.com/yandex.cloud.clouddesktop.v1.api.Desktop
        id: e3v7nfkhn0q4********
        folder_id: b1g681qpemb4********
        desktop_group_id: e3vud47oonha********
        created_at: "2024-05-14T17:41:14.076Z"
        name: my-desktop-group-1fb68746********
        resources:
          memory: "2147483648"
          cores: "2"
          core_fraction: "100"
        network_interfaces:
          - network_id: enpphqi8uvcm********
            subnet_id: e9bmuh93af4v********
        users:
          - subject_id: aje9k8luj4qf********
      ```

    {% endlist %}

#### See also {#see-also}

* [{#T}](../../api-design-guide/concepts/about-async.md)