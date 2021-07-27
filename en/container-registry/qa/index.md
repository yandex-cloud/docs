---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Questions and answers about {{ container-registry-short-name }}

#### Why is the "latest" tag missing or why is it assigned to a Docker image that wasn't the last one pushed? {#latest}

The reason is that you specified a different tag when pushing the Docker image.

The Docker client assigns the `latest` tag automatically if the Docker image is created and pushed without a tag. You can also specify the `latest` tag explicitly.

{% include [latest-info](../../_includes/container-registry/info-about-latest.md) %}

#### How do I make a registry public? {#public-registry}

You can issue the [container-registry.images.puller](../security/index.md) role for your registry to the [allUsers](../../iam/concepts/access-control/system-group.md) system group.

{% note alert %}

This makes all images in the registry available without authentication.

Don't assign the `container-registry.images.pusher`, `editor` or `admin` roles to the system group for the registry. This would allow anyone who learns your registry ID to use it at your expense.

{% endnote %}

#### I encountered an error. What should I do? {#error}

See [{#T}](../error/index.md). It lists common errors and ways to solve them.

{% include [qa-logs.md](../../_includes/qa-logs.md) %}

#### What does the "Got permission denied while trying to connect to the Docker daemon socket at unix:///var/run/docker.sock" error mean? {#permission-denied}

You're not running commands as a `root` user.

You can use `sudo` or set up [non-root access](https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as-a-non-root-user).

#### How do I diagnose Credential Helper performance? {#cred-helper}

- Check under which OS user and on which host the CLI commands are run. This must be the user that the Credential Helper is configured for and on whose behalf the `yc container registry configure-docker` command was run. The corresponding line must appear in the `/home/<user>/.docker/config.json` file. If you perform actions on a VM, make sure the Credential Helper is configured on it, too.

- Check if the Credential Helper is displayed in `PATH` when running commands. During authentication in {{ container-registry-short-name }} using the Credential Helper, Docker accesses the `docker-credential-yc` binary file. Make sure this binary file is available in `PATH` for the user working with Docker. For example, if Docker is used with `sudo`, then `configure-docker` must be run with `sudo`, too. You can check this with the `echo cr.yandex | docker-credential-yc get` or `echo cr.yandex | sudo docker-credential-yc get` command if you're running commands with `sudo`. If everything is OK, you'll get a response like `{"Username":"iam","Secret":"***<iam-token>***"}`.

- If the commands run in interactive mode but fail in non-interactive mode, check the `.bashrc` file. The `yc` and `docker-credential-yc` programs are installed in a directory that is not usually available in the default `PATH`. In this case, the following lines are added to the `.bashrc` file:

  ```
  # The next line updates PATH for Yandex Cloud CLI
  if [ -f '/home/<user>/yandex-cloud/path.bash.inc' ]; then source '/home/<user>/yandex-cloud/path.bash.inc'; fi
  ```

  The `.bashrc` file starts with a condition saying that the commands listed in it are not executed in non-interactive mode. That's why the commands can run when connecting to the VM manually, but fail to run when doing so via SSH.

