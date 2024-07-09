---
title: "How to change the Python version for a project in {{ ml-platform-full-name }}"
description: "Follow this guide to change the Python version for your project."
---

# Selecting a Python version

Python 3.10 is used in {{ ml-platform-short-name }} projects by default. To change the version for the project:

1. {% include [include](../../../_includes/datasphere/ui-find-project.md) %}
1. Under **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}**, select ![docker](../../../_assets/console-icons/logo-docker.svg) **{{ ui-key.yc-ui-datasphere.resources.docker }}**.
1. Select a template of the [Docker image](../../concepts/docker.md) with the Python version you need.
1. Click **{{ ui-key.yc-ui-datasphere.common.activate }}**.