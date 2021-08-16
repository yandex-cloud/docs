# Использование TensorBoard в {{ ml-platform-name }}

TensorBoard — это дашборд для визуализации логов обучения ваших моделей. Результаты можно просматривать с помощью графов, гистограмм и других инструментов. 

Полное описание возможностей TensorBoard см. на [сайте TensorFlow](https://www.tensorflow.org/tensorboard?hl=en).

## Создание дашборда {#create-dashboard}

В {{ ml-platform-name }} можно запустить TensorBoard тремя способами:

1. Из меню {{ ml-platform-name }}. Откройте меню **File**, выберите **New** и пункт **TensorBoard**. Откроется новая вкладка с дашбордом, на котором будут отображаться логи всей рабочей папки `/home/jupyter/work/resources`.
2. Из вкладки **Commands** на левой панели. Откройте ее и выберите команду **Create a new TensorBoard**. В открывшемся окне укажите относительный путь к нужной вам папке с логами. Будет запущен новый инстанс.
3. Из ячейки ноутбука. Выполните в ячейке команду вида `%tensorboard --logdir <путь к папке с логами>`. Запустится новый инстанс с дашбордом. 

## Пример использования TensorBoard {#example}

В этом примере c помощью TensorBoard демонстрируются результаты обучения тестовой модели. TensorBoard будет запущен с помощью команды из ячейки ноутбука.

Чтобы использовать TensorBoard в вашем ноутбуке:

1. Импортируйте TensorFlow:

	```
	import tensorflow as tf
	import datetime
	```

1. Задайте тестовую модель, например:

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

1. Запустите обучение модели:

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

1. Запустите TensorBoard:

	```
	%tensorboard --logdir logs/fit
	```