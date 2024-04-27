# Docker images in jobs

By default, {{ ds-jobs }} [jobs](./index.md) utilize the `nvidia/cuda:11.8.0-cudnn8-runtime-ubuntu22.04` public image with a pre-installed Conda package manager, Python 3.10, and other additional packages. This image is stored in the {{ ml-platform-name }} cache, so using the default environment allows you to run your jobs faster.

You can also use a different Docker image to run a job by specifying it under `env` in the job configuration file. This can be:

* {{ ml-platform-name }} system image

   ```text
   env:
     docker: system-python-3-10   # Python 3.10 system image
   ```

* Custom Docker image available in the job project

   ```text
   env:
     docker: <Docker_image_ID>  # ID as b1gxxxxxxxxxxxxxxxxx
   ```

   {% note warning %}

   When using a project Docker image, the job runtime environment will not include libraries installed in the notebook.

   {% endnote %}

* External image

   You can use any preferred image registry ([{{ container-registry-full-name }}](https://yandex.cloud/en/services/container-registry), [Docker Hub](https://hub.docker.com/), [Docker — Private Registries](https://www.geeksforgeeks.org/docker-private-registries/), etc.) by specifying the username and password to access the image.

   ```text
   env:
     docker:
       image: <image_path>
       username: <username>
       password:
         secret-id: <project_secret_ID>
   ```

   Where:

   * `<image_path>`: Full path to the image in a container registry, e.g., `cr.yandex/b1g**********/myenv:0.1`.
   * `<username>`: Username for accessing your registry. For {{ container-registry-full-name }} authentication, use a [service account](../../../iam/concepts/users/service-accounts.md) and an [authorized key](../../../container-registry/operations/authentication.md#sa-json).
   * `<project_secret_ID>`: Secret ID with a password. The secret must be [created](../../operations/data/secrets.md#create) in a {{ ml-platform-name }} project.

   If you are using a public image, you do not need to specify authentication credentials:

   ```text
   env:
     docker:
       image: ubuntu:focal
   ```

#### See also {#see-also}

* [{#T}](index.md)
* [{#T}](cli.md)
* [{#T}](environment.md)
* [{#T}](../../operations/projects/work-with-jobs.md)
* [GitHub repository](https://github.com/yandex-cloud-examples/yc-datasphere-jobs-examples) with job run examples