---
title: COI releases
description: In this article, you will learn how to find out your COI version and read about the previous COI releases.
---

# COI releases

{% cut "How to find out your COI version" %}

* For version 2.0.4 and higher, run this command to get the version from inside the image:

  ```bash
  cat /etc/ycloud/image-info
  ```

  Result:

  ```text
  coi-version: 2.3.14
  ```

* For version 2.1.0 and higher, run this command to get the version in `description`:

  ```bash
  yc compute image get-latest-from-family container-optimized-image \
    --folder-id standard-images --format json \
  | jq -r '.description'
  ```

  Result:

  ```text
  Container Optimized Image 2.3.14
  ```

{% endcut %}

{% note info %}

In version 2.2.0 and higher, the patch, which is the third number in the version, such as 3 in 1.2.3, means an update of the system components and packages and is not there in the release list.

{% endnote %}

{% include [latest-release](../_includes/cos/latest-release.md) %}

## Previous releases {#previous-releases}

{% include [previous-releases](../_includes/cos/previous-releases.md) %}
