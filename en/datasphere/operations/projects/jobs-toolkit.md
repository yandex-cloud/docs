# Working with jobs from Visual Studio Code

{{ ds-jobs }} Toolkit enables you to work with {{ ml-platform-name }} [jobs](../../concepts/jobs/index.md) from within the [Visual Studio Code](https://code.visualstudio.com/) IDE. You will need a {{ yandex-cloud }} account and a {{ ml-platform-name }} [project](../../concepts/project.md).

{{ ds-jobs }} Toolkit uses the [{{ ds-cli }}](../../concepts/jobs/cli.md) to analyze the environment and identify dependencies. The CLI is automatically installed in the current virtual environment when you run your first job.

{% note info %}

To use the extension, make sure you have installed the [Visual Studio Code](https://code.visualstudio.com/) IDE, [Python 3.10](https://www.python.org/downloads/release/python-3100/), and the [Python extension for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=ms-python.python).

{% endnote %}

When you run a job, the `datasphere` library analyzes the environment, collects code dependencies, and can provide them to {{ ml-platform-name }} for deploying the environment on a cloud VM. To avoid unnecessary system dependencies that can affect job performance, we recommend using a virtual environment, such as [venv](https://docs.python.org/3/library/venv.html) or [conda](https://docs.conda.io/en/latest/#).

{% include [jobs-info](../../../_includes/datasphere/jobs-environment.md) %}

## Install {{ ds-jobs }} Toolkit {#setup}

1. Open the [extension page on the marketplace](https://marketplace.visualstudio.com/items?itemName=yandex-cloud.ds-toolkit-vscode).
1. Click **Install**.
1. The browser will prompt you to open Visual Studio Code. Click **Open app**.
1. On the {{ ds-jobs }} Toolkit page that opens in Visual Studio Code, click **Install**.

Once the extension is successfully installed, you will see **This extension is enabled globally** on its page.

## Get authenticated in {{ ds-jobs }} {#authentication}

To start working with {{ ds-jobs }}, get authenticated using a Yandex or federated account.

{% list tabs group=authentication %}

- Yandex account {#yandex-account}

  1. Get an [OAuth token](../../../iam/concepts/authorization/oauth-token.md).

     {% include [описание](../../../_includes/oauth-token-lifetime.md) %}

  1. In Visual Studio Code, click **Search** at the top of the window and enter this command: `> DataSphere Jobs: Set OAuth token`. In the window that opens, click **Open** to get an OAuth token.

      If you already have an OAuth token, click **Cancel**.
  1. In the **Input OAuth-token** field that opens, enter the OAuth token.

  To delete the OAuth token, use this command: `> DataSphere Jobs: Remove OAuth token`.

- Federated account {#federated-account}

  To authenticate a federated account, you need to install and configure the [CLI](../../../cli/quickstart.md). If the CLI is installed in the default folder or the path to it is specified in the `Path` environment variable, the extension will detect it automatically. If not, specify the CLI executable path in the extension settings:

  1. In the left-hand panel, select **{{ ds-jobs }}** and click **Settings**.
  1. In the **Datasphere: Yandex Cloud Console Path** field, enter the path to the CLI executable, such as the following:

      ```text
      C:\Users\<username>\yandex-cloud\bin\yc.exe
      ```

{% endlist %}

## Run the job {#run-job}

1. In the left-hand panel, select ![logo](../../../_assets/datasphere/ds-logo.svg) **{{ ds-jobs }}** and click **Settings**.
1. In the **Datasphere: Project** field, enter the project ID. To get the project ID, click the **ID** icon on your project page in the [{{ ml-platform-name }} interface]({{ link-datasphere-main }}/projects).
1. Open the Python file using {{ ds-jobs }} Toolkit. To do this, in the Visual Studio Code Explorer, right-click the file you need and select **Run File in DataSphere Jobs**.

    You can also pre-open the file with the job code in Visual Studio Code, click **Run and Debug** in the top-right corner of the edit window, and select **Run File in DataSphere Jobs**.

    You can use [this sample code](./work-with-jobs.md#example) when testing the extension. For more job run examples, see the [repository](https://github.com/yandex-cloud-examples/yc-datasphere-jobs-examples) on GitHub.

1. In the **DataSphere Job Configuration** window that opens, set the following configuration:

    {% list tabs %}

    - BASIC

      Configure the main run parameters that match the values in the `config.yaml` [file](./work-with-jobs.md#create-job):

      * **Working directory**: Working directory containing files required to run the job.
      * **Inputs**: Files with input data in `<path>=<variable_name>` format. Specify each value pair in a separate line.
      * **Outputs**: Files with output data in `<path>=<variable_name>` format. Specify each value pair in a separate line.

    - ADVANCED

      Configure additional parameters:

      * **Project Identifier**: {{ ml-platform-name }} project ID.
      * **Configuration file path**: Path to the completed `config.yaml` configuration file.
      * **Instance Type**: [Configuration](../../concepts/configurations.md) parameters of the VM on which the job will run.
      * **S3 mounts**: IDs of [S3 connectors](../../concepts/s3-connector.md). In case of multiple S3 connectors, specify each ID in a separate line.
      * **Datasets**: [Datasets](../../concepts/dataset.md) in `<dataset>=<variable_name>` format. Specify each value pair in a separate line.

    - ENVIRONMENT

      Configure the [Docker image](../../concepts/docker.md):

      * **Variables**: Variables required to run the code in `<name>:<value>` format. Specify each value pair in a separate line.
      * **Docker**: Docker image parameters:
          * **Image**: Docker image URL.
          * **User**: System account with the password or ID of the secret containing the [authorized key](../../../iam/concepts/authorization/key.md).

    - PYTHON

      Configure your Python working environment:

      * **Environment dependency build method**: Select whether to define environment dependencies manually or automatically.
      * **Extra root paths**: Additional root folders. Specify each value in a separate line.
      * **Extra index urls**: Additional index URLs.
      * If you choose not to define environment dependencies, enable **No Dependencies**.

    {% endlist %}

    To save your current settings to `launch.json` for use in future jobs, click **Save**. To export job configuration to `config.yaml`, click **Export**.

    You can also upload a previously saved and ready-to-use job configuration by clicking **Load**.

1. To run the configuration, click **Invoke**.

    After you successfully run the job from within {{ ds-jobs }} Toolkit, the **DEBUG CONSOLE** window will open. It will contain a link to the same job in {{ ml-platform-name }}:

    ```txt
    creating job ...
    uploading 37 files (129.7MB) ...
    files are uploaded
    created job `bt19qb2pb0ji********`
    executing job ...
    job link: https://datasphere.yandex.ru/communities/bt11e3m29qti********/projects/bt1eq06id8kv********/job/bt19qb2pb0ji********
    ```

    The **OUTPUT** window also features tabs with the following information:

    * **DataSphere Jobs Invocation**: User code execution results.
    * **DataSphere Jobs Toolkit**: Job start, end, or error messages.
    * **DataSphere Jobs Toolkit Logs**: Information about the extension performance.

## View the job history {#job-history}

{{ ds-jobs }} Toolkit allows you to view the job history and manage your jobs.

To see the job history in {{ ds-jobs }}, select ![logo](../../../_assets/datasphere/ds-logo.svg) **{{ ds-jobs }}** in the left-hand panel. This will open the **DATASPHERE JOBS: LAUNCH HISTORY** panel where you will see your jobs sorted by start time.

You can perform the following actions from the {{ ds-jobs }} history panel:

* **Cancel**: Stop the job.
* **Attach**: Connect to the job.
* **Copy job ID**: Copy the job ID.
* **Open job**: Open the job in a browser.

#### See also {#see-also}

* [{#T}](../../concepts/jobs/index.md)
* [{#T}](./work-with-jobs.md)
