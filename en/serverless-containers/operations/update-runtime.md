# Changing the container operation mode

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder with your container.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.
  1. Select the container you want to change the [operation mode](../concepts/container.md#runtime) for.
  1. Go to the **{{ ui-key.yacloud.serverless-containers.label_editor }}** tab.
  1. In the window that opens, under **{{ ui-key.yacloud.serverless-containers.section_general }}**, select `{{ ui-key.yacloud.serverless-containers.label_runtime-http-server }}` or `{{ ui-key.yacloud.serverless-containers.label_runtime-task-execution }}`.
  1. Click **{{ ui-key.yacloud.serverless-containers.button_deploy-revision }}**. This will create a new container revision with the selected operation mode.

- CLI {#cli}

  To change the [container operation mode](../concepts/container.md#runtime), run this command:

  ```bash
  yc serverless container revision deploy \
    --container-id <container_ID> \
    --image <Docker_image_URL> \
    --service-account-id <service_account_ID>
    --runtime <operation_mode>
  ```

  Where:
  * `--container-id`: Container ID. To find out the ID, [get](list.md) a list of containers.
  * `--image`: {{ container-registry-full-name }} Docker image URL.
  * `--service-account-id`: [ID of the service account](../../iam/operations/sa/get-id.md) with permissions to download a Docker image.
  * `--runtime`: Container operation mode. It can be either `http` or `task`. The default value is `http`.


  Result:

  ```text
  done (3s)
  id: bba8faed420g********
  container_id: bbab5i36nvda********
  created_at: "2024-12-13T12:12:09.057Z"
  image:
    image_url: cr.yandex/crpp35hht729********/ubuntu:hello
    image_digest: sha256:f6f34c6cf5f56e594e9828274592f1cc4d9383b1689057ccaf188d41********
  resources:
    memory: "134217728"
    cores: "1"
    core_fraction: "100"
  execution_timeout: 3s
  concurrency: "1"
  service_account_id: aje07l4q4vmo********
  status: ACTIVE
  log_options:
    folder_id: b1gc1t4cb638********
  runtime:
    task: {}
  ```

- API {#api}

  To change the [container operation mode](../concepts/container.md#runtime), use the [deployRevision](../containers/api-ref/Container/deployRevision.md) REST API method for the [Container](../containers/api-ref/Container/index.md) resource or the [ContainerService/DeployRevision](../containers/api-ref/grpc/Container/deployRevision.md) gRPC API call.

{% endlist %}
