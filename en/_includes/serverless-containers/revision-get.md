{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), select the folder with your container.
  1. Select **{{ serverless-containers-name }}**.
  1. Select the container to get revision information for.
  1. Under **Revisions**, you can find the list of container revisions and their details.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To find out the name or unique ID of a container revision, [get](../../serverless-containers/operations/revision-list.md) a list of container revisions in the folder.

  To get detailed information about a container revision, run this command:

  ```
  yc serverless container revision get <revision_ID>
  ```
  Result:
  ```
  id: bbaq84v92qqc********
  container_id: bbab5i36nvda********
  created_at: "2021-09-09T11:22:28.128Z"
  image:
     image_url: {{ registry }}/crpp35hht729********/ubuntu:test
     image_digest: sha256:9f05670784f562f278177e43a9ae0179f29b3cb93b2ef165b935f1**********
  resources:
     memory: "1207959552"
     cores: "1"
     core_fraction: "100"
  execution_timeout: 0s
  concurrency: "1"
  service_account_id: aje07l4q4vmo********
  status: ACTIVE
  ```

- API

  To get the details about a container revision, use the [getRevision](../../serverless-containers/containers/api-ref/Container/listRevisions.mdAPI) API method.


{% endlist %}