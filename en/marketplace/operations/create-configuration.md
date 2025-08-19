# Creating a configuration for {{ cloud-apps-name }}

## Creating a configuration {#create}

1. Log in to the [{{ marketplace-short-name }}]({{ link-cloud-partners }}) partner dashboard.
1. Select the product for which you want to create a configuration.
1. Navigate the **Configurations** tab.
1. Click ![image](../../_assets/console-icons/plus.svg) **Create configuration**.
1. Select how you want to create your configuration:

    {% list tabs %}

    - From scratch

        To create an empty configuration:

        1. Select a folder to host your configuration. You need the `cloudapps.editor` role for that folder.
        1. Name the configuration.
        1. Optionally, provide a description for the configuration.

    - Based on another configuration

        To create a configuration based on an existing one:

        1. Select the configuration based on which you want to create a new one.
        1. Select a folder to save your configuration. You need the `cloudapps.editor` role for that folder.
        1. Name the configuration.
        1. Optionally, provide a description for the configuration.

        All artifacts, fields, and resources in the configuration based on which you are creating the new one will be automatically added to the new configuration.

    - Based on preset

        To create a configuration with a predefined set of typical fields and resources:

        1. Select the preset based on which you want to create a configuration. A preset is a set of {{ yandex-cloud }} services based on your app will operate. The following presets are currently available:
            
            * {{ network-load-balancer-name }} + {{ ig-name }} + {{ mpg-name }}
            * {{ network-load-balancer-name }} + {{ ig-name }} + {{ mmy-name }}
            * {{ network-load-balancer-name }} + {{ ig-name }} + {{ objstorage-name }}
            * {{ network-load-balancer-name }} + {{ ig-name }}.
            
        1. Select a folder to host your configuration. You need the `cloudapps.editor` role for that folder.
        1. Name the configuration.
        1. Optionally, provide a description for the configuration.
        1. Optionally, under **Preset parameters**, specify default parameter values for the resources that will be created during application installation. Make sure the {{ ig-name }} VM [disk image](../../compute/concepts/image.md) meets the [requirements](create-image.md).

    {% endlist %}

## Setting up a configuration {#configure}

### Adding an artifact {#artifact}

Add artifacts: {{ compute-full-name }} [disk images](../../compute/concepts/image.md), {{ container-registry-full-name }} [Docker images](../../container-registry/concepts/docker-image.md), and static files used by the application, placed in {{ objstorage-full-name }} [buckets](../../storage/concepts/bucket.md).

To add an artifact:

1. The configuration you created will appear in the list with the `Draft` status. Select it.
1. Add the artifacts required for the application to work:
    1. Click **Add artifact**.
    1. Select the artifact type:

        * `Disk image`:

            1. Name the artifact.
            1. Select the {{ compute-full-name }} disk image. It must meet [these requirements](create-image.md).
            1. Click **Add**.

        * `Container image`:

            1. Name the artifact.
            1. Select the Docker image uploaded to {{ container-registry-full-name }}. It must meet [these requirements](create-container.md).
            1. Click **Add**.

        * `{{ objstorage-name }}`:

            1. Name the artifact.
            1. Select the {{ objstorage-full-name }} bucket that stores the files required for the application to function correctly.
            1. Provide the full path to the file, e.g., `prefix/subprefix/data.json`.
            1. Click **Add**.


### Create a form {#form}

Create a form, i.e., a set of fields for the user to fill out before installing the application. You can use the values obtained from the fields both when configuring application resources and during its execution.

If you created a configuration based on another configuration or a preset, the configuration already has form fields. Modify them if required.

To add a field:

1. Navigate to the **Startup options** tab.
1. Add a field to the form for the user to fill out when installing the application:

    1. Click **Add field**.
    1. Specify the field parameters. For a description of the field parameters, see [this section](../concepts/form-fields-ref.md).

### Adding resources {#resources}

Describe the {{ yandex-cloud }} resources that the user must create before installing the application and that will be automatically created in the user folder during application deployment.

If you created a configuration based on another configuration or a preset, the configuration already has resources. Modify them if required.

To add a resource:

1. Navigate to the **Resources** tab.
1. Click **Add resource**.
1. Select:
    * `New resource`, so that a new resource is automatically created in the user folder when installing the application.
    * `User resource`, so that when installing the application, the user can select a resource from those already existing in their folder or create a new one at their own discretion.
1. Select a resource from those available.
1. In the right pane, select the resource you added. User resources are distinguished from new ones by the ![image](../../_assets/console-icons/person-magnifier.svg) icon.
1. Edit the resource name. To do this, click ![image](../../_assets/console-icons/pencil.svg) next to the resource name that was generated automatically. The resource name must be unique within the configuration. The user will see it when installing the application.
1. Specify the resource parameters. The possible types of parameter values:

    * **Value**: Static value you specify in the field.
    * **Application attribute**: Value of one of the application attributes, e.g., the ID of the folder in which the user will install the application.
    * **Reference**: Value of one of the parameters pertaining to the resource you added.
    * **Input field**: Value obtained from a form field the user fills out when installing the application.
    * **No value**: Empty value.
    * **Resource**: Selecting one of the resources you added.

    For descriptions of the resource parameters, see the [{{ TF }} provider documentation]({{ tf-docs-link }}). The options available when creating resources and those described in the documentation may differ.

    {% cut "Example of adding a resource" %}

    1. Select the resource type: `{{ vpc-short-name }} cloud network`.
    1. Click ![image](../../_assets/console-icons/pencil.svg) next to the `yandex-vpc-network-1` cloud network name; this name was generated automatically. Edit the cloud network name. It must be unique within the configuration. The user will see this name when installing the application.
    1. In the **ID** field, select `Input field` and select a variable to get the cloud network ID from. The variable name is specified when adding a field to the form. The user specifies the field value when installing the application.

    {% endcut %}

1. Click **Save** to save the configuration.

## See also {#see-also}

* [{#T}](../tutorials/demo-cloud-apps.md)
