# Questions and answers about {{ container-registry-name }}

#### Why is the `latest` tag missing or why is it assigned to a Docker image that was not the last one pushed? {#latest}

The reason is that you specified a different [tag](../concepts/docker-image.md#version) when pushing the [Docker image](../concepts/docker-image.md).

The Docker client assigns the `latest` tag automatically if the Docker image is created and pushed without a tag. You can also specify the `latest` tag explicitly.

{% include [latest-info](../../_includes/container-registry/info-about-latest.md) %}

#### How do I make a registry public? {#public-registry}

You can issue the [container-registry.images.puller](../security/index.md) [role](../../iam/concepts/access-control/roles.md) for your [registry](../concepts/registry.md) to the [allUsers](../../iam/concepts/access-control/system-group.md) system group.

{% note alert %}

This makes all Docker images in the registry available without [authentication](../operations/authentication.md).

Do not assign the `container-registry.images.pusher`, `editor` or `admin` roles to the system group for the registry. This will enable anyone with your registry ID to use the registry.

{% endnote %}

#### I encountered an error. What should I do? {#error}

See [{#T}](../error/index.md). It lists common errors and ways to solve them.

{% include [logs](../../_qa/logs.md) %}

#### What does the "Got permission denied while trying to connect to the Docker daemon socket at unix:///var/run/docker.sock" error mean? {#permission-denied}

You are not running commands as a `root` user.

You can use `sudo` or configure [non-root access](https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as-a-non-root-user).

#### How do I diagnose Credential Helper performance? {#cred-helper}

* Check under which OS user and on which host the [CLI](../../cli/) commands are run. This must be the user that the [Credential Helper](../operations/authentication.md#cred-helper) is configured for and on whose behalf the `yc container registry configure-docker` command was run. The corresponding line must appear in the file `/home/<user>/.docker/config.json`. If you are working on a [virtual machine](../../compute/concepts/vm.md), make sure you have the Credential helper configured there as well.
* Check if the Credential Helper is displayed in `PATH` when running commands. During authentication in {{ container-registry-name }} using the Credential Helper, Docker accesses the `docker-credential-yc` binary file. Make sure this binary file is available in `PATH` for the user working with Docker. For example, if Docker is used with `sudo`, then `configure-docker` must be run with `sudo`, too. You can check this with the `echo {{ registry }} | docker-credential-yc get` command or with `echo {{ registry }} | sudo docker-credential-yc get` if you're running commands with `sudo`. If everything is working, you'll get a response in the format `{"Username":"iam","Secret":"***<iam-token>***"}`.
* If the commands run in interactive mode but fail in non-interactive mode, check the `.bashrc` file. The `yc` and `docker-credential-yc` programs are installed in a directory that is not usually available in the default `PATH`. In this case, the following lines are added to the `.bashrc` file:

  ```text
  # The next line updates PATH for {{ yandex-cloud }} CLI
  if [ -f '/home/<user>/yandex-cloud/path.bash.inc' ]; then source '/home/<user>/yandex-cloud/path.bash.inc'; fi
  ```

  The top section of the `.bashrc` file contains a condition preventing its commands from running non-interactively. That is why the commands can run when connecting to the VM manually, but fail to run when doing so via SSH.

#### What does "Error response from daemon: pull access denied for <cr.yandex/registry_ID/Docker_image_name>, repository does not exist or may require 'docker login': denied: Permission denied ; requestId = <request_ID>" mean? {#permission-denied-ip}

The [IP address](../../vpc/concepts/address.md) that the pull Docker image request is received from has no PULL permission.

[Add rules that allow pulling image](../operations/registry/registry-access.md) for this IP in the registry settings or delete all rules and try again.