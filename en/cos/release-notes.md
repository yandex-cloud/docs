# COI releases

{% cut "How to find out the COI version" %}

* To find out the version from inside the image (version 2.0.4 and higher), run the command:

  ```bash
  cat /etc/ycloud/image-info
  ```

  Result:

  ```bash
  coi-version: 2.0.4
  ```

* To find out the version in `description` (version 2.1.0 and higher), run the command:

  ```bash
  yc compute image get <image ID or name> --profile preprod --format json | jq -r '.description'
  ```

  Result:

  ```bash
  Container Optimized Image 2.1.0
  ```

{% endcut %}

{% note info %}

In version 2.2.0 and higher, the patch (the third number in the version, such as 3 in 1.2.3) indicates an update of system components and packages and is not mentioned in the list of releases.

{% endnote %}

{% include [latest-release](../_includes/cos/latest-release.md) %}

## Previous releases {#previous-releases}

{% include [previous-releases](../_includes/cos/previous-releases.md) %}