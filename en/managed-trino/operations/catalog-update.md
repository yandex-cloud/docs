---
title: Updating a {{ TR }} catalog
description: Follow this guide to update catalog parameters in a {{ mtr-name }} cluster.
---

# Updating a {{ TR }} catalog

{% list tabs group=instructions %}

- Management console {#console}

    1. On the [resource folder]({{ link-console-main }}) page, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
    1. Click the cluster name.
    1. In the left-hand panel, select ![image](../../_assets/console-icons/folder-tree.svg) **{{ ui-key.yacloud.trino.title_catalogs }}**.
    1. Next to the catalog, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.edit }}**.
    1. Update your {{ TR }} catalog parameters and click **{{ ui-key.yacloud.common.update }}**.

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file that defines your infrastructure.

        For more information about creating this file, see [Creating clusters](cluster-create.md).

    1. Edit the catalog settings in the `yandex_trino_catalog` section.

        ```hcl
        resource "yandex_trino_catalog" "<folder_name>" {
          ...
          <connector_type> = {
            <{{ TR }}_catalog_settings>
          }
        }
        ```

        [Learn more about {{ TR }} catalog settings](catalog-create.md#catalog-settings) for various connector types.

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

{% endlist %}