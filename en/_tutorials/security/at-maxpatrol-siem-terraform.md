# Exporting audit logs to MaxPatrol SIEM using {{ TF }}


[MaxPatrol SIEM](https://www.ptsecurity.com/ru-ru/products/mpsiem/) enables reading {{ yandex-cloud }} [audit logs](../../audit-trails/concepts/events.md) from a data stream in [{{ yds-full-name }}](../../data-streams/index.yaml). To complete this tutorial, you need access to a MaxPatrol SIEM instance.

To set up audit log export using {{ TF }}:

1. [Get your cloud ready](#before-you-begin).
1. [Deploy the infrastructure for audit log export to MaxPatrol SIEM](#deploy).
1. [In MaxPatrol SIEM, set up a task to collect data from the stream in {{ yds-name }}](#configure-maxpatrol).

If you no longer need the resources you created, [delete them](#clear-out).

## Get your cloud ready {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

{% include [paid-resources](../_tutorials_includes/at-maxpatrol-siem/paid-resources.md) %}

## Deploy the infrastructure for audit log export to MaxPatrol SIEM {#deploy}

{% include [terraform-definition](../_tutorials_includes/terraform-definition.md) %}

To create an infrastructure using {{ TF }}:
1. [Install {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [get the credentials](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials), and specify the source for installing {{ yandex-cloud }} (see [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), step 1).
1. Set up your infrastructure description files:

    {% list tabs group=infrastructure_description %}

    - Ready-made configuration {#ready}

      1. Clone the repository with configuration files:

         ```bash
         git clone https://github.com/yandex-cloud-examples/yc-export-audit-logs-maxpatrol
         ```

      1. Navigate to the repository directory. It should now contain the following files:
          * `audit-trails-maxpatrol-export.tf`: New infrastructure configuration file.
          * `audit-trails-maxpatrol-export.auto.tfvars`: File with the values of user-defined variables.

    - Manually {#manual}

      1. Create a folder for configuration files. In this folder:

          1. Create a configuration file named `audit-trails-maxpatrol-export.tf`:

              {% cut "**audit-trails-maxpatrol-export.tf**" %}

              {% include [audit-trails-maxpatrol-export-config](../_tutorials_includes/at-maxpatrol-siem/audit-trails-maxpatrol-export-config.md) %}

              {% endcut %}

          1. Create a file with user data named `audit-trails-maxpatrol-export.auto.tfvars`:

              **audit-trails-maxpatrol-export.auto.tfvars**

              ```hcl
              folder_id       = "<folder_ID>"
              organization_id = "<organization_ID>"
              ```

    {% endlist %}

    For more information about {{ TF }} resource parameters, see the relevant provider guides:

    * [Service account](../../iam/concepts/users/service-accounts.md): [yandex_iam_service_account]({{ tf-provider-resources-link }}/iam_service_account).
    * [Role](../../iam/concepts/access-control/roles.md) assigned to the service account for the folder: [yandex_resourcemanager_folder_iam_member]({{ tf-provider-resources-link }}/resourcemanager_folder_iam_member).
    * Role assigned to the service account for the organization: [yandex_organizationmanager_organization_iam_binding]({{ tf-provider-resources-link }}/organizationmanager_organization_iam_binding).
    * [Static access key](../../iam/concepts/authorization/access-key.md): [yandex_iam_service_account_static_access_key]({{ tf-provider-resources-link }}/iam_service_account_static_access_key).
    * [Serverless database (YDB)](../../ydb/concepts/serverless-and-dedicated.md#serverless): [yandex_ydb_database_serverless]({{ tf-provider-resources-link }}/ydb_database_serverless).
    * [Data stream in {{ yds-full-name }}](../../data-streams/concepts/glossary.md#stream-concepts): [yandex_ydb_topic]({{ tf-provider-resources-link }}/ydb_topic).
    * [Trail](../../audit-trails/concepts/trail.md): [yandex_audit_trails_trail]({{ tf-provider-resources-link }}/audit_trails_trail).

1. In the `audit-trails-maxpatrol-export.auto.tfvars` file, set the values of the user-defined variables:
    * `folder_id`: [Folder ID](../../resource-manager/operations/folder/get-id.md).
    * `organization_id`: [ID of the organization](../../organization/operations/organization-get-id.md) to create the trail and store audit logs in.

1. Create the resources:

    {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}

    This will create and configure all the required infrastructure in the folder you selected.

1. Get the static access key ID and secret key, as well as the ID of the database you created; you will need them later to configure MaxPatrol SIEM. Do it by running these commands:

    ```bash
    echo "Static access key: $(terraform output static-access-key)"
    echo "Secret key: $(terraform output static-secret-key)"
    echo "YDB database ID: $(terraform output database-id)"
    ```

    Result:

    ```text
    Static access key: "YCAJEnmnfsV8GpAMk********"
    Secret key: "YCMVxx-n0t8Y6s48zJDdKw9lWMB1iGU-********"
    YDB database ID: "etnvs692elpn********"
    ```

## Configure MaxPatrol SIEM {#configure-maxpatrol}

{% include [the-maxpatrol-part](../_tutorials_includes/at-maxpatrol-siem/the-maxpatrol-part.md) %}

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:

1. Open the `audit-trails-maxpatrol-export.tf` file and delete your infrastructure description from it.
1. Apply the changes:

    {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}