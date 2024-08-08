# {{ ml-platform-full-name }} release notes

This section shows what changed in {{ ml-platform-full-name }}.


{% note tip %}

To keep up to date with the latest changes and updates, subscribe to our [{{ ml-platform-full-name }} Community](https://t.me/yandex_datasphere) news channel on Telegram.

{% endnote %}

## Release on 04/07/2024 {#040724}

* {{ ml-platform-name }} projects now have a new type of resources: [Spark connectors](concepts/spark-connector.md) for integration with [{{ dataproc-full-name }}](../data-proc/).
* Improved [creating nodes](operations/deploy/node-create.md).
* Improved [linking a billing account](operations/community/link-ba.md) to a community.
* Fixed bugs and added minor improvements in service performance.

## Release on 18/06/2024 {#180624}

* Now you can [deploy node instances](operations/deploy/node-create.md) in different [availability zones](../overview/concepts/geo-scope.md): `{{ region-id }}-a` and `{{ region-id }}-b`.
* Now you can [rerun](concepts/jobs/fork.md) jobs.
* Python 3.7 is no longer supported.
* Fixed bugs and added minor improvements in service performance.

## Release on 03/04/2024 {#030424}

1. Updated [configurations](concepts/data-proc-template.md#configurations) of {{ dataproc-name }} temporary clusters.
1. Now you can use XGBoost and LightGBM models to deploy [nodes from models](concepts/deploy/index.md#models-node).
1. Added delivering input variables in [fulfillment APIs](api-ref/overview.md#notebook).
1. Improved [creating nodes](operations/deploy/node-create.md#from-docker) from Docker images.
1. Fixed bugs and added minor improvements in service performance.

## Release on 27/03/2024 {#270324}

Model tuning in {{ ml-platform-name }} now works based on the new {{ gpt-pro }} model.

## Release on 01/03/2024 {#010324}

The Serverless mode is no longer supported.

## Release on 27/02/2024 {#270224}

1. Added the option to run a notebook in Dedicated mode to the [API](api-ref/overview.md).
1. Improved logs and [metrics](concepts/deploy/monitoring.md) for nodes.
1. Fixed bugs and added minor improvements in platform performance.

## Release on 29/01/2024 {#290124}

1. Updated the NVIDIA driver to version 535.
1. Added support for multi-login to multiple organizations in various federations.
1. Added the option to pause and resume a running node.
1. Fixed bugs and added minor improvements in platform performance.

## Release on 15/01/2024 {#150124}

1. Added self-service problem-solving tools to the project page.
1. In [{{ ml-platform-name }} Jobs](concepts/jobs/index.md), now you can use your project resources: secrets, S3 connectors, environment dockers, datasets, and project disk.
1. Fixed bugs and added minor improvements in platform performance.

## Release on 20/12/2023 {#201223}

1. Added new [configuration](concepts/configurations.md), gt4.1 (1 GPU NVIDIA T4).
1. The g2.mig configuration (1 GPU MIG NVIDIA Ampere A100) is obsolete.
1. A [new node type](concepts/deploy/index.md#models-node) from the model resource is available.
1. Selecting a configuration in {{ dd }} mode will display its current availability.
1. Fixed bugs and added minor improvements in platform performance.

## Release on 10/10/2023 {#101023}

1. You can test fine-tuned {{ yagpt-name }} models right in {{ ml-platform-name }}. {{ yagpt-name }} Playground in {{ ml-platform-name }} is available after fine-tuning to users with access to {{ yagpt-full-name }}.
1. You can now [connect](operations/projects/remote-connect.md) your {{ ml-platform-name }} project to {{ jlab }}Lab from a local IDE.
1. Fixed bugs and added minor improvements in platform performance.

## Release on 25/09/2023 {#250923}

1. With [{{ ml-platform-name }} Jobs](concepts/jobs/index.md), cloud computing resources in {{ ml-platform-name }} can now be used from a user's local environment.
1. {{ ml-platform-name }} projects now have a new type of resources: [Models](concepts/models/index.md).
1. Optimized JupyterLab 3 (available in [dedicated](concepts/project.md#dedicated) mode) by adding new extensions.
1. [{{ yagpt-name }} model tuning](concepts/models/foundation-models.md#yagpt-tuning) is now available at the [Preview](../overview/concepts/launch-stages.md) stage.
1. Fixed bugs and added minor improvements in platform performance.

## Release on 18/09/2023 {#180923}

1. A new DS Default (Python 3.10) system image is used by default.
1. Community administrators can now manage permissions to use the functionality.
1. Improved working with community and project lists.
1. Fixed bugs and added minor improvements in platform performance.

## Release on 21/07/2023 {#210723}

1. Updated the {{ jlab }}Lab extension for working with GIT.
1. Community administrators can now manage permissions to use computing resources.
1. Community and project members can now be added before they accept an invitation to join an organization.
1. Improved the [Docker image](concepts/docker.md) build editor.
1. Added an example of operations with {{ yagpt-full-name }} to initial notebooks.
1. The process of starting a project is now more obvious and transparent.
1. Fixed bugs and added minor improvements in platform performance.

## Release on 20/06/2023 {#200623}

1. Added a page with a [list of all {{ link-datasphere-main }} projects] of a user.
1. Updated initial notebooks.
1. Fixed bugs and added minor improvements in platform performance.

## Release on 23/05/2023 {#230523}

1. {{ ml-platform-name }} now supports a new [{{ dd }}](concepts/project.md#dedicated) operation mode.
1. In the {{ dd }} mode, the IDE version is updated to JupyterLab 3.5.3.
1. You can now select an organization in an optimized way.
1. Operations with community and project members are now easier to perform.
1. Fixed bugs and added minor improvements in platform performance.

## Release on 29/03/2023 {#290323}

1. You can now work with [labels](../resource-manager/concepts/labels.md) to label resources.
1. Fixed bugs and added minor improvements.

## Release on 24/03/2023 {#240323}

1. Added a [tool to migrate](operations/migration.md) projects to the new {{ ml-platform-name }} version.
1. Fixed bugs and added minor improvements.

## Release on 02/03/2023 {#020323}

1. You can now use the new {{ ml-platform-name }} version via the API.
1. Fixed bugs and added minor improvements.

## Release on 19/01/2023 {#190123}

1. The service now displays inherited [roles](security/index.md) of community and project members.
1. Optimized the advanced settings for projects.
1. Updated the snippets for working with [S3](operations/data/connect-to-s3.md), [Yandex Disk](operations/data/connect-to-ya-disk.md), and [Google Drive](operations/data/connect-to-google-drive.md).
1. Fixed bugs and added minor improvements.

## Release on 20/10/2022 {#201022}

Greatly improved the Apache Spark™ cluster functionality:
1. {{ ml-platform-name }} now has a new type of resources: [{{ dataproc-name }} templates](concepts/data-proc-template.md).
1. You can now [configure a livy session](concepts/data-proc.md#sessions) when using {{ dataproc-name }} clusters.
1. {{ ml-platform-name }} now supports the [Spark SQL library](concepts/data-proc.md#sql).

## Release on 23/09/2022 {#230922}

Meet our large {{ ml-platform-name }} update: new interface, communities, resources, and many other features for ML development.

{% include [old-releases](../_includes/datasphere/migration/release-notes-old.md) %}

