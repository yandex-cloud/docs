# Choosing a Python version

{% include [link-on-new-ui-datasphere-in-old-ui](../../../_includes/datasphere/datasphere-old-note.md) %}

Python 3.8 is used in {{ ml-platform-short-name }} projects by default. To change the version for the project:

1. {% include [include](../../../_includes/datasphere/first-step.md) %}
1. Go to the **Projects** tab.
1. Select the project you want to edit and click it.
1. Go to the ![docker](../../../_assets/datasphere/docker.svg) **Docker images** tab.
1. Select a template of the Docker image with the Python version you need.
1. Click **Set image to project**.

{% note warning %}

The Python 3.7 system image won't work with the g2.x (GPU A100) [configurations](../../concepts/configurations.md).

{% endnote %}