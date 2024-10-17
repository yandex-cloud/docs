{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder with your container.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.
    1. Select the container to get revision information for.
    1. Under **{{ ui-key.yacloud.serverless-containers.section-revisions }}**, you can find the list of container revisions and their details.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    {% include [get-revision-list](../../_includes/serverless-containers/get-revision-list.md) %}

    To get detailed information about a container revision, run this command:

    ```bash
    yc serverless container revision get <revision_ID>
    ```
    Result:
    ```text
    id: bbaq84v92qqc********
    container_id: bbab5i36nvda********
    created_at: "2021-09-09T11:22:28.128Z"
    image:
      image_url: {{ registry }}/crpp35hht729********/ubuntu:test
      image_digest: sha256:9f05670784f562f278177e43a9ae0179f29b3cb93b2ef165b935f1k9********
    resources:
      memory: "1207959552"
      cores: "1"
      core_fraction: "100"
    execution_timeout: 0s
    concurrency: "1"
    service_account_id: aje07l4q4vmo********
    status: ACTIVE
    ```

- API {#api}

  To get information about a container revision, use the [getRevision](../../serverless-containers/containers/api-ref/Container/getRevision.md) REST API method for the [Container](../../serverless-containers/containers/api-ref/Container/index.md) resource or the [ContainerService/GetRevision](../../serverless-containers/containers/api-ref/grpc/Container/getRevision.md) gRPC API call.

{% endlist %}