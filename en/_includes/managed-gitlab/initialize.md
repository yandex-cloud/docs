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

  To configure {{ GL }} and enable Continuous Integration (CI), create a new project and enter the CI login credentials.
  1. On the {{ compute-name }} page, select the created VM and find its public IP.
  1. In the browser, open a link in the format `http://<public VM IP address>`. The {{ GL }} admin panel opens.
  1. Set the administrator password and click **Change your password**.
  1. Enter the `root` username and your administrator password.
  1. Click **Sign in**.
  1. Select **Create a project**.
  1. Set the project name: `gitlab-test`.
  1. Click **Create project**.

{% endlist %}