# Checking GPU load

{{ ml-platform-full-name }} supports [computing resource configurations](../../concepts/configurations.md) with GPUs.

You can check the GPU performance, load, and resource utilization statistics using the [TensorFlow](https://www.tensorflow.org/) library or the `nvidia-smi` utility.

## Getting started {#before-begin}

{% include [include](../../../_includes/datasphere/ui-before-begin.md) %}

## Checking GPU performance {#check-gpu}

### Checking a connection using TensorFlow {#check-with-TensorFlow}

1. [Select](control-compute-resources.md) the desired GPU configuration. In our example, we use the `g1.1` configuration.
1. Enter the following code in the cell:

    ```bash
    import tensorflow as tf


    tf.config.list_physical_devices('GPU')
    ```

1. Run the cell. To do this, click ![Run](../../../_assets/datasphere/jupyterlab/run.svg).
1. This will output a list of all GPUs used in the notebook.

### Checking a connection using nvidia-smi {#check-with-nvidia-smi}

1. [Select](control-compute-resources.md) the desired GPU configuration. In our example, we use the `g1.1` configuration.
1. Enter the following code in the cell:

    ```bash
    #!:bash
    nvidia-smi
    ```

1. Run the cell. To do this, click ![Run](../../../_assets/datasphere/jupyterlab/run.svg).
1. This will output GPU status details.

## Writing GPU utilization statistics while training a model {#record-usage}

1. Enter the following code in the cell:

    ```bash
    import subprocess

    with open("stdout.txt","wb") as out:
    proc = subprocess.Popen(["nvidia-smi", "dmon"], stdout=out, stderr=subprocess.STDOUT)

    <GPU_utilization_code>

    proc.terminate()
    proc.kill()
    ```

    The code uses the `nvidia-smi dmon` command that collects GPU performance statistics every second.

1. Run the cell. To do this, click ![Run](../../../_assets/datasphere/jupyterlab/run.svg).
1. As a result, the `stdout.txt` file with detailed GPU statistics will appear in the model directory.

## Example of writing GPU utilization statistics {#record-example}

Use a ready-made model to test GPU configurations. When executing the code on the `g1.1` and `g2.1` configurations, the model uses 18% to 25% of GPU resources. You can view the data in the `sm` column of the `stdout.txt` file.

1. Enter the following code in the cell:

    ```bash
    import subprocess
    import tensorflow as tf
    import datetime

    mnist = tf.keras.datasets.mnist

    (x_train, y_train),(x_test, y_test) = mnist.load_data()
    x_train, x_test = x_train / 255.0, x_test / 255.0

    def create_model():
      return tf.keras.models.Sequential([
        tf.keras.layers.Flatten(input_shape=(28, 28)),
        tf.keras.layers.Dense(512, activation='relu'),
        tf.keras.layers.Dropout(0.2),
        tf.keras.layers.Dense(10, activation='softmax')
      ])

    with open("stdout.txt","wb") as out:
        proc = subprocess.Popen(["nvidia-smi", "dmon"], stdout=out, stderr=subprocess.STDOUT)

        model = create_model()
        model.compile(optimizer='adam',
                      loss='sparse_categorical_crossentropy',
                      metrics=['accuracy'])
        model.fit(x=x_train,
                  y=y_train,
                  epochs=5,
                  validation_data=(x_test, y_test))
        model = create_model()
        model.compile(optimizer='adam',
                      loss='sparse_categorical_crossentropy',
                      metrics=['accuracy'])

        proc.terminate()
        proc.kill()
    ```

1. Run the cell. To do this, click ![Run](../../../_assets/datasphere/jupyterlab/run.svg).
1. As a result, the `stdout.txt` file with detailed GPU statistics will appear in the model directory.
