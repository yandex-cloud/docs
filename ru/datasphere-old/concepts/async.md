# Фоновые операции

{% include [link-on-new-ui-datasphere-in-old-ui](../../_includes/datasphere/datasphere-old-note.md) %}

Вы можете выполнять долгие операции, например обучение моделей, в фоновом режиме. Для этого используйте специальные ячейки, в которых ваш код выполняется асинхронно. При этом вы можете продолжить работу с ноутбуком.

Если в другой части ноутбука используется та же переменная, что и в асинхронной операции, в ноутбуке появится уведомление, и вам нужно будет явно указать значение переменной после выполнения асинхронной операции.

Особенности выполнения фоновых операций:
* Запуск операций в фоновом режиме не гарантирует немедленный запуск исполнения.
* Фоновые операции в общем случае могут выполняться дольше, чем обычные операции.
* Фоновые операции могут выполняться на [прерываемых](../../compute/concepts/preemptible-vm.md) виртуальных машинах и ресурсах.
* Любые фоновые операции прерываются при попытке выполнения интерактивных функций (например, `input()` или `getpass()`).
* Фоновые операции тарифицируются по другим правилам. Подробнее в разделе [{#T}](../pricing.md).
* Ячейки с запущенными фоновыми операциями имеют доступ к проектному хранилищу только на чтение. Если после завершения фоновой операции возникнет конфликт в значениях переменных, {{ ml-platform-name }} задаст вопрос, сохранить результат вычислений или вернуться к старым значениям.

  {% note tip %}

  Чтобы в процессе выполнения фоновой операции записывать какие-либо данные (например, логи или промежуточные расчеты), используйте объектное хранилище. О работе с хранилищем S3 в проектах {{ ml-platform-name }} см. [{#T}](../operations/data/connect-to-s3.md).

  {% endnote %}


## Запуск фоновой операции {#run}

Для запуска фоновой операции необходимо указать в ячейке комментарий `#pragma async`.

Чтобы запустить тестовую фоновую операцию:
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

1. Запустите обучение модели с комментарием `#pragma async` в начале ячейки:

    ```
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

Пока модель обучается, вы можете выполнять операции в других ячейках.

## Прерывание фоновой операции {#interrupt}

{% include [interrupt](../../_includes/datasphere/interrupt-cell.md) %}
