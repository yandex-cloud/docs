# Selecting a Python version

Python 3.8 is used in {{ ml-platform-short-name }} projects by default. To change the version for the project:

1. {% include [include](../../../_includes/datasphere/ui-find-project.md) %}
1. Under **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}**, select ![docker](../../../_assets/datasphere/docker.svg) **{{ ui-key.yc-ui-datasphere.resources.docker }}**.
1. Select a template of the [Docker image](../../concepts/docker.md) with the Python version you need.
1. Click **{{ ui-key.yc-ui-datasphere.common.activate }}**.

{% note warning %}

The Python 3.7 system image won't work with the g2.x (GPU A100) [configurations](../../concepts/configurations.md).

{% endnote %}