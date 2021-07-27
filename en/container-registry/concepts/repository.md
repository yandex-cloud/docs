---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Repository

_A repository_ is a set of Docker images with the same name. Repositories usually contain several versions of the same Docker image. Tags and digests are used to work with versions inside the repository. For more information, see [Docker image](docker-image.md).

A repository is defined by the `<registry ID>/<Docker image name>` combination.

- In Docker CLI commands, use the full name that includes the {{ container-registry-short-name }} address:

    ```
    $ docker push cr.yandex/<registry ID>/<Docker image name>
    ```

- In YC CLI commands, use the repository name without the {{ container-registry-short-name }} address:

    ```
    $ yc container image list --repository-name=<registry ID>/<Docker image name>
    ```

For a repository, you can set a [policy for automatically deleting Docker images](lifecycle-policy.md). Based on its rules, Docker images will be deleted automatically.