---
title: How to run jobs in {{ ml-platform-name }} Jobs
description: Follow this guide to remotely run Python and bash scripts and executable binary files on a {{ ml-platform-name }} VM.
---

# Running jobs in {{ ml-platform-name }} Jobs

In {{ ml-platform-name }} Jobs, you can remotely run [jobs](../../concepts/jobs/index.md), i.e., Python and bash scripts and executable binary files, on a {{ ml-platform-full-name }} VM.

Jobs are created and run within [projects](../../concepts/project.md). However, they do not depend on project notebooks and running VMs.

Before running a job, [install](../../../cli/quickstart.md) and configure the [{{ yandex-cloud }} CLI](../../../cli/) to use it for authentication in {{ yandex-cloud }}. You should also install the `datasphere` library in your Python environment using the `pip install datasphere` command.

{% include [vscode-extension-info](../../../_includes/datasphere/vscode-extension-info.md) %}

When you run a job, the `datasphere` library analyzes the environment, collects code dependencies, and can provide them to {{ ml-platform-name }} for deploying the environment on a cloud VM. To avoid unnecessary system dependencies that can affect job performance, we recommend using a virtual environment, such as [venv](https://docs.python.org/3/library/venv.html) or [conda](https://docs.conda.io/en/latest/#).

{% include [jobs-info](../../../_includes/datasphere/jobs-environment.md) %}

## Creating a job {#create-job}

1. Install the `datasphere` library:

    ```bash
    pip install datasphere
    ```

1. Prepare a script or an executable binary file.

1. Prepare a file with inputs.

1. Configure the job parameters. In the `config.yaml` file, specify the resources for running your job and its runtime configuration:

    ```yaml
    name: <job_name>
    desc: <job_description>
    cmd: >
        python3 <executable_file> --data ${DATA} --result ${OUTPUT}
    env:
      python: auto
    inputs:
      - <inputs>: DATA
    outputs:
      - <results>: OUTPUT
    cloud-instance-types:
      - <computing_resource_configuration>
      - <computing_resource_configuration>
      - <computing_resource_configuration>
    ```

    Where:

    * `name`: Job name.
    * `desc`: Job description.
    * `cmd`: Script file and variables for inputs and outputs.
    * `env`: Environment parameters. The `python: auto` value indicates that the code and `pip` dependencies should be provided to {{ ml-platform-name }}.
    * `inputs`: File with inputs. You can change the `DATA` variable name.
    * `outputs`: File with outputs. You can change the `OUTPUT` variable name.
    * `cloud-instance-types`: List of valid [computing resource configurations](../../concepts/configurations.md) to run the job, sorted by priority.

    For a single configuration, you may also use the old `cloud-instance-type` field, e.g., `cloud-instance-type: g1.1`; however, it is better to use the new one.

1. Open the command-line shell in the folder containing the files you prepared and run your job:

    ```bash
    datasphere project job execute -p <project_ID> -c config.yaml
    ```

    {% include [get-project-id](../../../_includes/datasphere/get-project-id.md) %}

## Tracking job progress {#progress}

{% list tabs %}

- Interface {{ ml-platform-full-name }}

  1. {% include [include](../../../_includes/datasphere/ui-find-project.md) %}
  1. Navigate to the **{{ ui-key.yc-ui-datasphere.project-page.project-jobs }}** ⟶ **{{ ui-key.yc-ui-datasphere.project-page.launch-history }}** tab and select the job you need.
  1. You will see its progress bar at the top of the page.

- Locally

  The progress is saved to a local file, `job_progress.jsonl`, available in the directory with job [logs](../../concepts/jobs/cli.md#logs). The file is regularly appended with a JSON string stating the current progress. Here is an example:

  ```json
  {"progress": 21, "message": "progress msg 21", "create_time": "2025-06-01T11:00:12+00:00"}
  ```
  
  You can get the file path from the `JOB_PROGRESS_FILENAME` environment variable.

{% endlist %}

## Example {#example}

Let's say you train a classification model on the MNIST dataset with sample handwritten digits. {{ ml-platform-name }} remotely runs training and returns the trained model file as the result. For more job run examples, see the [repository](https://github.com/yandex-cloud-examples/yc-datasphere-jobs-examples) on GitHub.

{% note warning %}

To run a job, you need Python 3.10.0 and TensorFlow 2.12.0.

{% endnote %}

1. Install the `tensorflow` library:

    ```bash
    pip install tensorflow==2.12.0
    ```

1. Prepare a script in a file named `example.py`:

    ```python
    import argparse
    import json
    import os
    import shutil
    import tensorflow as tf

    parser = argparse.ArgumentParser(prog='example')
    parser.add_argument('-i', '--input', required=True, help='Input file')
    parser.add_argument('-m', '--model', required=True, help='Output file')

    def make_archive(source, destination):
        base = os.path.basename(destination)
        name = base.split(".")[0]
        fmt = base.split(".")[1]
        shutil.make_archive(name, fmt, source)

    def main(epoch_count, model_file):
        print("TensorFlow version: ", tf.__version__)
        print("")
        print(os.system("nvidia-smi"))
        print("")

        print("Load MNIST dataset...")
        mnist = tf.keras.datasets.mnist
        (x_train, y_train), (x_test, y_test) = mnist.load_data()
        x_train, x_test = x_train / 255.0, x_test / 255.0

        print("Build Sequential model...")
        model = tf.keras.models.Sequential([
          tf.keras.layers.Flatten(input_shape=(28, 28)),
          tf.keras.layers.Dense(128, activation="relu"),
          tf.keras.layers.Dropout(0.2),
          tf.keras.layers.Dense(10)
        ])

        #predictions = model(x_train[:1]).numpy()
        #tf.nn.softmax(predictions).numpy()

        loss_fn = tf.keras.losses.SparseCategoricalCrossentropy(from_logits=True)
        #loss_fn(y_train[:1], predictions).numpy()

        print("Compile model...")
        model.compile(optimizer="adam", loss=loss_fn, metrics=["accuracy"])

        print("Fit...")
        model.fit(x_train, y_train, epochs=epoch_count)

        print("Evaluate...")
        model.evaluate(x_test,  y_test, verbose=2)

        print(f"Save model to '{model_file}'")
        tf.keras.models.save_model(model, "model", save_format="tf")
        make_archive("model", model_file)

        print("Done")


    if __name__ == "__main__":
        args = parser.parse_args()

        epoch_count = 5

        with open(args.input) as f:
            data = json.load(f)
            epoch_count = int(data["epoch_count"])

        main(epoch_count, args.model)
    ```

1. Prepare the `input.json` file with inputs:

    ```python
    {
        "epoch_count" : 3
    }
    ```

1. Create the `config.yaml` file with job parameters:

    ```yaml
    name: simple-tf-script
    desc: Simple TF script
    cmd: python3 example.py --input ${INPUT} --model ${MODEL}
    env:
      python: auto
    inputs:
      - input.json: INPUT
    outputs:
      - model.zip: MODEL
    cloud-instance-types:
      - g1.1
    ```

1. Run the job:

    ```bash
    datasphere project job execute -p <project_ID> -c config.yaml
    ```

    {% include [get-project-id](../../../_includes/datasphere/get-project-id.md) %}

The model will be saved to the `model.zip` archive in the job folder.


#### See also {#see-also}

* [{#T}](../../concepts/jobs/index.md)
* [GitHub repository](https://github.com/yandex-cloud-examples/yc-datasphere-jobs-examples) with job run examples
