---
title: COI releases
description: In this article, you will learn how to find out your COI version and read about the previous COI releases.
---

# COI releases

{% cut "How to find out your COI version" %}

* To find out the version from inside the image (version 2.0.4 and higher), run this command:

  ```bash
  cat /etc/ycloud/image-info
  ```

  Result:

  ```text
  coi-version: 2.3.14
  ```

* To find out the version in `description` (version 2.1.0 and higher), run this command:

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

In version 2.2.0 and higher, the patch (the third number in the version, such as 3 in 1.2.3) indicates an update of system components and packages and is not mentioned in the list of releases.

{% endnote %}

{% include [latest-release](../_includes/cos/latest-release.md) %}

## Previous releases {#previous-releases}

{% include [previous-releases](../_includes/cos/previous-releases.md) %}
