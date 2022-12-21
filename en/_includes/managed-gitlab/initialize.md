To configure {{ GL }} and enable Continuous Integration (CI), create a new project and enter the CI login credentials.

{% list tabs %}

- {{ mgl-name }} instance

  1. Log in to the {{ mgl-name }} instance web interface.
  1. Click **Create a project**.
  1. Click **Create blank project**.
  1. Complete the fields below:
     * **Project name**: `gitlab-test`.
     * **Project URL**: Select the administrator user in the field next to the {{ mgl-name }} instance FQDN.

     Leave the other fields as they are.
  1. Click **Create project**.

- VM instance with a {{ GL }} image

  To configure {{ GL }} and enable Continuous Integration (CI), create a new project and enter the CI login credentials:
  1. On the {{ compute-full-name }} page, select the created VM and copy its public IP.
  1. [Connect](../../compute/operations/vm-connect/ssh.md) to the VM over SSH.
  1. Get the {{ GL }} administrator password using the VM command:

     ```bash
     sudo cat /etc/gitlab/initial_root_password
     ```

  1. Copy the password (without spaces) from the `Password` row to the clipboard or a separate file.
  1. In the browser, open a link in the format `http://<public VM IP address>`. The {{ GL }} web interface will open.
  1. Log in using the administrator account:
     * **Username or email**: `root`.
     * **Password**: The previously copied password.

     If you are unable to log in, [reset the administrator account password](https://docs.gitlab.com/ee/security/reset_user_password.html#reset-your-root-password).
  1. [Change the administrator account password](https://docs.gitlab.com/ee/user/profile/#change-your-password).
  1. Log in to the system again using the administrator account and the new password.
  1. Select **Create a project**.
  1. Set the project name: `gitlab-test`.
  1. Click **Create project**.

{% endlist %}