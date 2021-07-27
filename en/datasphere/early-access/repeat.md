---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Special background operations

Special background operations help you run a sequence of operations asynchronously.
As opposed to [running a single operation in the background](../concepts/async.md), a special background operation requires you to specify the desired number of runs, how often intermediate results are saved, and a rule for selecting the end result.

If another part of a notebook uses the same variable as an asynchronous operation, a notification appears in the notebook, and you'll need to specify the variable value explicitly when the asynchronous operation is complete.

Specifics of special background operations:

* Running operations in the background does not guarantee their immediate execution.
* In general, special background operations may take longer than regular ones.
* Background operations can run on [preemptible](../../compute/concepts/preemptible-vm.md) virtual machines and resources.
* The execution of this type of operation may be interrupted if the system doesn't have enough machines with the required configuration. When computing resources are released, execution will resume from the most recently saved result.

Special background operations are billed based on [background operation rules](../pricing.md#async).

## Running a special background operation {#run}

To run sequential operations in the background, enter the `#pragma repeat` command in a cell.

To run sequential operations in the background:

  1. Update the tensorflow package to version 2.3.0:

      ```python
      %pip install tensorflow==2.3.0
      ```

  1. Restart the kernel.
      1. In the top panel in the project window, click **Kernel**.
      1. In the menu that opens, click **Reset kernel**.

  1. Specify a test model, such as:

      ```python
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
      ```

  1. Run model training by putting the `#pragma repeat` utility command at the beginning of a cell:

      ```python
      #pragma repeat --iterations 20 --checkpoint-period 5 --max-by "model.evaluate(x_test, y_test, verbose=0)[1]"
      
      model.fit(x_train, y_train, epochs=1, verbose=0)
      ```

In this example, we run model training 20 times and save the result every 5 iterations. The state of the model that produced the best result using the test data is saved.

## Aborting a special background operation {#interrupt}

{% include [interrupt](../../_includes/datasphere/interrupt-cell.md) %}

