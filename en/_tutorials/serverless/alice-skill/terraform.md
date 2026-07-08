1. [Get your cloud ready](#before-you-begin).
1. [Create the infrastructure](#deploy).
1. [Add the function link to the Alice's skill](#add-link).
1. [Test the skill](#test).

If you no longer need the resources you created, [delete](#clear-out) them.

## Getting started {#before-you-begin}

{% include [before-you-begin](../../_tutorials_includes/before-you-begin.md) %}

## Create the infrastructure {#deploy}

{% include [terraform-definition](../../_tutorials_includes/terraform-definition.md) %}

To create an infrastructure with {{ TF }}:

1. [Install {{ TF }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [get the authentication credentials](../../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials), and specify the {{ yandex-cloud }} provider source (see [{#T}](../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), Step 1).
1. Set up your infrastructure description file:

    {% list tabs group=infrastructure_description %}

    - Ready-made configuration {#ready}

      1. Clone the repository containing the configuration files and function code examples:

          ```bash
          git clone https://github.com/yandex-cloud-examples/yc-serverless-alice-skill
          ```
      1. Navigate to the repository directory. It should now contain the following files:

          * `alice-skill.tf`: New infrastructure configuration.
          * `alice-skill.auto.tfvars`: User data.
          * `parrot.py`: File with the function code in Python.
          * `index.js`: File with the function code in Node.js.
      1. Prepare the code for the Alice's skill. To create a new function [version](*function_version), you will upload its code to {{ sf-full-name }} as a [ZIP archive](*upload_formats).

          {% list tabs group=programming_language %}

          - Python {#python}

              Add the `parrot.py` file from the cloned repository to the `parrot-py.zip` archive.

          - Node.js {#node}

              Add the `index.js` file from the cloned repository to the `parrot-js.zip` archive.

          {% endlist %}

    - Manually {#manual}

      1. Prepare the code for the Alice's skill. To create a new function [version](*function_version), you will upload its code to {{ sf-full-name }} as a [ZIP archive](*upload_formats).

          {% include [prepare-code](../../_tutorials_includes/alice-skill/prepare-code.md) %}

      1. Create a folder for the infrastructure description file.
      1. Create a configuration file named `alice-skill.tf` in the folder:

          {% cut "alice-skill.tf" %}

          {% include [alice-skill-tf-config](../../_tutorials_includes/alice-skill/alice-skill-tf-config.md) %}

          {% endcut %}

      1. In the folder, create a user data file named `alice-skill.auto.tfvars`:

          {% cut "alice-skill.auto.tfvars" %}

          {% include [alice-skill-tf-vars](../../_tutorials_includes/alice-skill/alice-skill-tf-vars.md) %}

          {% endcut %}

    {% endlist %}

    Learn more about the properties of resources used in {{ TF }} in [this provider guide]({{ tf-provider-resources-link }}).

1. In the `alice-skill.auto.tfvars` file, set the following user-defined properties:

    * `folder_id`: [Folder ID](../../../resource-manager/operations/folder/get-id.md).
    * `file_path`: Local path to the archive file with the function code. Here is an example: `/Users/myuser/Temp/parrot-py.zip`.
    * `language`: Depending on the function language, specify:

        * `python` if using the `Python` example.
        * `nodejs` if using the `Node.js` example.

1. Create the resources:

    {% include [terraform-validate-plan-apply](../../_tutorials_includes/terraform-validate-plan-apply.md) %}

{% include [add-link](../../_tutorials_includes/alice-skill/add-link.md) %}

{% include [test](../../_tutorials_includes/alice-skill/test.md) %}

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:

1. Open the `alice-skill.tf` file and delete your infrastructure description from it.
1. Apply the changes:

    {% include [terraform-validate-plan-apply](../../_tutorials_includes/terraform-validate-plan-apply.md) %}

[*function_version]: A version contain the function code, execution parameters, as well as all required dependencies. You can use different versions of the same function at different development stages. For more information, see [{#T}](../../../functions/concepts/function.md#version).

[*upload_formats]: There are several ways to upload a function version code: in the editor in the management console, from local files and directories, or as an archive. For more information, see [{#T}](../../../functions/concepts/function.md#upload).