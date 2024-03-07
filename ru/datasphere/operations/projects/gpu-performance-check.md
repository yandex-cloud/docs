# Проверить загрузку GPU

В {{ ml-platform-full-name }} доступны [конфигурации вычислительных ресурсов](../../concepts/configurations.md) с [GPU](../../../glossary/gpu.md).

Вы можете проверить работу, уровень загрузки и статистику потребления ресурсов GPU с помощью библиотеки [TensorFlow](https://www.tensorflow.org/) и утилиты `nvidia-smi`.

## Перед началом работы {#before-begin}

{% include [include](../../../_includes/datasphere/ui-before-begin.md) %}

## Проверить работу GPU {#check-gpu}

### Проверить подключение с помощью TensorFlow {#check-with-TensorFlow}

1. [Выберите](control-compute-resources.md) необходимую конфигурацию GPU. В примере используется конфигурация g1.1.
1. В ячейке введите следующий код:

    ```bash
    import tensorflow as tf


    tf.config.list_physical_devices('GPU')
    ```

1. Выполните ячейку. Для этого нажмите значок ![Run](../../../_assets/datasphere/jupyterlab/run.svg).
1. В результате отобразятся все используемые в ноутбуке GPU.

### Проверить подключение с помощью nvidia-smi {#check-with-nvidia-smi}

1. [Выберите](control-compute-resources.md) необходимую конфигурацию GPU. В примере используется конфигурация g1.1.
1. В ячейке введите следующий код:

    ```bash
    #!:bash
    nvidia-smi
    ```

1. Выполните ячейку. Для этого нажмите значок ![Run](../../../_assets/datasphere/jupyterlab/run.svg).
1. В результате отобразится подробная информация о статусе GPU.

## Записать статистику использования GPU во время обучения модели {#record-usage}

1. В ячейке введите следующий код:

    ```bash
    import subprocess

    with open("stdout.txt","wb") as out:
    proc = subprocess.Popen(["nvidia-smi", "dmon"], stdout=out, stderr=subprocess.STDOUT)

    <код_который_должен_потреблять_GPU>

    proc.terminate()
    proc.kill()
    ```

    В коде используется команда `nvidia-smi dmon`, которая ежесекундно собирает статистику работы GPU.

1. Выполните ячейку. Для этого нажмите значок ![Run](../../../_assets/datasphere/jupyterlab/run.svg).
1. В результате в директории модели появится файл `stdout.txt` с подробной статистикой работы GPU.

## Пример записи статистики использования GPU {#record-example}

Воспользуйтесь готовой моделью для тестирования конфигураций GPU. При выполнении кода на конфигурациях g1.1 и g2.1 модель потребляет 18-25% ресурсов GPU. Данные можно посмотреть в столбце `sm` файла `stdout.txt`.

1. В ячейке введите следующий код:

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

1. Выполните ячейку. Для этого нажмите значок ![Run](../../../_assets/datasphere/jupyterlab/run.svg).
1. В результате в директории модели появится файл `stdout.txt` с подробной статистикой работы GPU.
