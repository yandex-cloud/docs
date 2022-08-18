{% list tabs %}

- VM with {{ GL }} image

  To configure {{ GL }} and set up [continuous integration]{% if lang == "ru" %}(https://ru.wikipedia.org/wiki/Непрерывная_интеграция){% endif %}{% if lang == "en" %}(https://en.wikipedia.org/wiki/Continuous_integration){% endif %} (CI), create a new project and enter your CI login credentials:
  1. On the {{ compute-full-name }} page, select the created VM and find its public IP.
  1. In the browser, open a link in the format `http://<public VM IP address>`. The {{ GL }} admin panel opens.
  1. Set the administrator password and click **Change your password**.
  1. Enter the username `root` and administrator password. Click **Sign in**.
  1. Select **Create a project**.
  1. Enter a name for the project, such as `gitlab-test`.
  1. Click **Create project**.

{% endlist %}