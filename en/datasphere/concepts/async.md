# Background operations

In [{{ ds }} mode](project.md#serverless) in {{ ml-platform-name }}, you can run such time-consuming operations as model training, in the background. To do this, use special cells where your code is executed asynchronously. In this case, you can continue working with a notebook.

If another part of a notebook uses the same variable as an asynchronous operation, a notification appears in the notebook, and you will need to specify the variable value explicitly when the asynchronous operation is complete.

{% note info %}

Background operations are not available in [{{ dd }} mode](project.md#dedicated).

{% endnote %}

Specifics of background operations:
* Running operations in the background does not guarantee their immediate execution.
* In general, background operations may take longer than regular ones.
* Background operations can run on [preemptible](../../compute/concepts/preemptible-vm.md) virtual machines and resources.
* Any background operations are suspended if there is an attempt to run interactive functions (such as, `input()` or `getpass()`).
* Background operations are priced differently. For more information, see [{#T}](../pricing.md).
* Cells with running background operations have read-only access to project storage. If there is a conflict in variable values after a background operation is complete, {{ ml-platform-name }} will ask whether to save the computation result or to roll back to the previous values.

   {% note tip %}

   Use object storage to save data, such as logs or intermediate results, during a background operation. To learn how to use S3 storage in {{ ml-platform-name }} projects, see [{#T}](../operations/data/connect-to-s3.md).

   {% endnote %}


## Running background operations {#run}

To run a background operation, add the `#pragma async` comment to the cell.

To run a test background operation:
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

1. Create and compile a model:

   ```python
   model = create_model()
   model.compile(optimizer='adam',
             loss='sparse_categorical_crossentropy',
             metrics=['accuracy'])
   ```

1. Start model training by adding the `#pragma async` comment at the beginning of the cell:

   ```python
   #pragma async
   model = create_model()
   model.compile(optimizer='adam',
                 loss='sparse_categorical_crossentropy',
                 metrics=['accuracy'])

   log_dir = "logs/fit/" + datetime.datetime.now().strftime("%Y%m%d-%H%M%S")
   tensorboard_callback = tf.keras.callbacks.TensorBoard(log_dir=log_dir, histogram_freq=1)

   model.fit(x=x_train,
             y=y_train,
             epochs=5,
             validation_data=(x_test, y_test),
             callbacks=[tensorboard_callback])
   ```

While the model is being trained, you can perform operations in other cells.

## Aborting background operations {#interrupt}

{% include [interrupt](../../_includes/datasphere/interrupt-cell.md) %}
