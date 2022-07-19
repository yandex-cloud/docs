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

{% include [latest-release](../_includes/cos/latest-release.md) %}

## Previous releases {#previous-releases}

{% include [previous-releases](../_includes/cos/previous-releases.md) %}