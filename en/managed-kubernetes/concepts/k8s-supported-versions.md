---
title: Support for {{ k8s }} versions in {{ managed-k8s-full-name }}
description: In this tutorial, you will learn which {{ k8s }} versions are supported in different {{ managed-k8s-name }} release channels.
---

# Support for {{ k8s }} versions in {{ managed-k8s-full-name }}

The table below lists the supported {{ k8s }} versions for various {{ managed-k8s-name }} [release channels](./release-channels-and-updates.md) together with release and end-of-support dates.

#|
|| **{{ k8s }} version**

([Release dates](https://kubernetes.io/releases/)) {align="center"} | **Release channel** {align="center"} | > | > | **End of support** {align="center"} ||
|| ^ | `RAPID` {align="center"} | `REGULAR` {align="center"} | `STABLE` {align="center"} | ^ ||
|| {{ version.name }} | {{ version.rapid }} | {{ version.regular }} | {{ version.stable }} | {{ version.deprecated }} ||
|| {{ version.name }} | {{ version.rapid }} | {{ version.regular }} | {{ version.stable }} | {{ version.deprecated }} ||
|| {{ version.name }} | {{ version.rapid }} | {{ version.regular }} | {{ version.stable }} | {{ version.deprecated }} ||
|| {{ version.name }} | {{ version.rapid }} | {{ version.regular }} | {{ version.stable }} | {{ version.deprecated }} ||
|| {{ version.name }} | {{ version.rapid }} | {{ version.regular }} | {{ version.stable }} | {{ version.deprecated }} ||
|| {{ version.name }} | {{ version.rapid }} | {{ version.regular }} | {{ version.stable }} | {{ version.deprecated }} ||
|| {{ version.name }} | {{ version.rapid }} | {{ version.regular }} | {{ version.stable }} | {{ version.deprecated }} ||
|#

{% note info %}

The estimated release date of the new version in the `RAPID` channel is the quarter following the [official release date of the stable {{ k8s }} version](https://kubernetes.io/releases/).

{% endnote %}

### See also {#see-also}

* [{#T}](./release-channels-and-updates.md)
* [{#T}](../release-notes.md)
* [{{ k8s }} Release History](https://kubernetes.io/releases/)