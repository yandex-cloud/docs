# Repository in {{ container-registry-name }}

A _repository_ is a set of Docker images with the same name. Repositories usually contain several versions of the same Docker image. Tags and digests are used to work with versions inside the repository. For more information, see [Docker image](docker-image.md).

A repository is defined by the `<registry_ID>/<Docker_image_name>` combination.

* In Docker CLI commands, use the full name that includes the {{ container-registry-name }} address:

  ```bash
  docker push {{ registry }}/<registry_ID>/<Docker_image_name>
  ```

* In {{ yandex-cloud }} CLI commands, use the repository name without the {{ container-registry-name }} address:

  ```bash
  yc container image list --repository-name=<registry_ID>/<Docker_image_name>
  ```

For a repository, you can set a [policy for automatically deleting Docker images](lifecycle-policy.md). Based on these rules, Docker images will be deleted automatically.

## Use cases {#examples}

* [{#T}](../tutorials/run-docker-on-vm/index.md)
* [{#T}](../tutorials/sign-cr-with-cosign.md)
* [{#T}](../tutorials/fault-tolerance.md)
* [{#T}](../tutorials/grpc-node.md)
* [{#T}](../tutorials/deploy-app-container.md)
