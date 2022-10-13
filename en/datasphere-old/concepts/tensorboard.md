# Using TensorBoard in {{ ml-platform-name }}

{% include [link-on-new-ui-datasphere-in-old-ui](../../_includes/datasphere/datasphere-old-note.md) %}

TensorBoard is a dashboard that visualizes your model training logs. You can view results using graphs, histograms, and other tools.

See the full description of TensorBoard features on the [TensorFlow site](https://www.tensorflow.org/tensorboard?hl=en).

## Creating dashboards {#create-dashboard}

There are three ways to run TensorBoard in {{ ml-platform-name }}:

1. From the {{ ml-platform-name }} menu. Open the **File** menu, select **New**, and then **TensorBoard**. A new tab opens with a dashboard that displays the logs of the entire `/home/jupyter/work/resources` working directory.
2. From the **Commands** tab on the left panel. Open this tab and select **Create a new TensorBoard**. In the window that opens, specify a relative path to the log directory. This starts a new instance.
3. From a notebook cell. Run a command like `%tensorboard --logdir <log directory path>` in the cell. This starts a new instance with the dashboard.

## TensorBoard usage example {#example}

This example uses TensorBoard to visualize a test model's training results. TensorBoard is started using a command from a notebook cell.

To use TensorBoard in your notebook:

1. Import TensorFlow:

   ```
   	import tensorflow as tf
   	import datetime
   ```

1. Specify a test model, such as:

   ```
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

1. Start model training:

   ```
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

1. Run TensorBoard:

   ```
   	%tensorboard --logdir logs/fit
   ```
