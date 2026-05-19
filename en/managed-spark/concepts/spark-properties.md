---
title: '{{ SPRK }} properties in {{ msp-full-name }}'
description: In this tutorial, you will learn about {{ SPRK }} job properties and how they are stored.
---

# {{ SPRK }} properties

{{ SPRK }} properties define the job configuration, e.g., run resources, dynamic allocation and parallelism parameters, SQL parameters, etc. To override a configuration, you can update {{ SPRK }} properties at individual job level when creating the job.

{{ SPRK }} properties are set and stored in "key-value" format. You can set any of the properties specified in the [official {{ SPRK }} documentation](https://spark.apache.org/docs/latest/configuration.html), except for the following:

* `spark.kubernetes.*`: You cannot override {{ k8s }} properties as this may cause the {{ msp-full-name }} cluster to work incorrectly.
* `spark.yarn.*`: {{ msp-full-name }} does not use YARN.
