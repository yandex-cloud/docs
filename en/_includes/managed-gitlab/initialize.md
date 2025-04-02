## Configure {{ GL }} {#configure-gitlab}

To configure {{ GL }} and enable Continuous Integration (CI), create a new project and enter the CI authorization parameters:

{% list tabs group=gl_installation %}

- {{ mgl-name }} instance {#instance-mgl}

  1. Log in to the [{{ mgl-name }}](../../managed-gitlab/concepts/index.md#instance) instance web interface.
  1. Click **Create a project**.
  1. Click **Create blank project**.
  1. Fill in the fields as follows:
     * **Project name**: `gitlab-test`.
     * **Project URL**: Select the administrator user in the field next to the {{ mgl-name }} instance FQDN.

     Leave the other fields unchanged.
  1. Click **Create project**.

- VM with a {{ GL }} image {#gl-image-vm}

  1. On the {{ compute-full-name }} page, select the created [VM](../../compute/concepts/vm.md) and copy its [public IP](../../vpc/concepts/address.md#public-addresses).
  1. [Connect](../../compute/operations/vm-connect/ssh.md) to the VM over SSH.
  1. Get the {{ GL }} administrator password with the following VM command:

     ```bash
     sudo cat /etc/gitlab/initial_root_password
     ```

  1. Copy the password without spaces from the `Password` line to the clipboard or a separate file.
  1. In your browser, open `http://<VM_public_IP_address>`. This will take you to the {{ GL }} web interface.
  1. Log in as the administrator:
     * **Username or email**: `root`.
     * **Password**: Password you copied in the previous step.

     If you are unable to log in, [reset the administrator password](https://docs.gitlab.com/ee/security/reset_user_password.html#reset-your-root-password).
  1. [Change the administrator password](https://docs.gitlab.com/ee/user/profile/user_passwords.html#change-your-password).
  1. Log in as the administrator with the new password.
  1. Select **Create a project**.
  1. Specify the project name: `gitlab-test`.
  1. Click **Create project**.

{% endlist %}