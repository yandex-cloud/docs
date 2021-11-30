To create a revision, make the Docker image public or, in the command, pass the [ID of the service account](../../iam/operations/sa/get-id.md) with permission to pull the image.

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), go to the folder where the container is located.
  1. Open **{{ serverless-containers-name }}**.
  1. Select the container to create a revision for.
  1. Go to the **Editor** tab.
  1. Specify the revision parameters.
  1. Click **Create revision**.

- CLI

  To create a container revision, run the command:

  ```
  yc serverless container revision deploy \
    --container-name <container name> \
    --image <Docker_image_URL> \
    --cores 1 \
    --memory 1GB \
    --service-account-id <service-account-id>
  ```

  Where:
    * `--cores`: Number of cores available for the container.
    * `--memory`: Required memory. The default is 128 MB.

  Result:

  ```
  id: bbajn5q2d74c********
  container_id: bba3fva6ka5g********
  created_at: "2021-07-09T15:04:55.135Z"
  image:
    image_url: cr.yandex/crpd3cicopk7********/test-container:latest
    image_digest: sha256:de8e1dce7ceceeafaae122f7670084a1119c961cd9ea1795eae92bd********
  resources:
    memory: "1073741824"
    cores: "1"
  execution_timeout: 3s
  service_account_id: ajeqnasj95o7********
  status: ACTIVE
  ```

{% endlist %}

