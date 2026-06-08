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
|| {{ k8s-version.0.name }} | {{ k8s-version.0.rapid }} | {{ k8s-version.0.regular }} | {{ k8s-version.0.stable }} | {{ k8s-version.0.deprecated }} ||
|| {{ k8s-version.1.name }} | {{ k8s-version.1.rapid }} | {{ k8s-version.1.regular }} | {{ k8s-version.1.stable }} | {{ k8s-version.1.deprecated }} ||
|| {{ k8s-version.2.name }} | {{ k8s-version.2.rapid }} | {{ k8s-version.2.regular }} | {{ k8s-version.2.stable }} | {{ k8s-version.2.deprecated }} ||
|| {{ k8s-version.3.name }} | {{ k8s-version.3.rapid }} | {{ k8s-version.3.regular }} | {{ k8s-version.3.stable }} | {{ k8s-version.3.deprecated }} ||
|| {{ k8s-version.4.name }} | {{ k8s-version.4.rapid }} | {{ k8s-version.4.regular }} | {{ k8s-version.4.stable }} | {{ k8s-version.4.deprecated }} ||
|| {{ k8s-version.5.name }} | {{ k8s-version.5.rapid }} | {{ k8s-version.5.regular }} | {{ k8s-version.5.stable }} | {{ k8s-version.5.deprecated }} ||
|| {{ k8s-version.6.name }} | {{ k8s-version.6.rapid }} | {{ k8s-version.6.regular }} | {{ k8s-version.6.stable }} | {{ k8s-version.6.deprecated }} ||
|#

{% note info %}

The estimated release date of the new version in the `RAPID` channel is the quarter following the [official release date of the stable {{ k8s }} version](https://kubernetes.io/releases/).

{% endnote %}

### See also {#see-also}

* [{#T}](./release-channels-and-updates.md)
* [{#T}](../release-notes.md)
* [{{ k8s }} Release History](https://kubernetes.io/releases/)