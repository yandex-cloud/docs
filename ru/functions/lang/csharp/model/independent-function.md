# Использование интерфейса Function для задания функции-обработчика на С#

Вы можете задать функцию-обработчик на C#, без необходимости наследования от классов [SDK](https://github.com/yandex-cloud/dotnet-sdk).

{% note warning %}

Метод-обработчик должен быть публичным, иметь имя `FunctionHandler` и один входной параметр.

{% endnote %}

{% include [examples-simple](../../../../_includes/functions/csharp-handler-examples-simple.md) %}

Вы можете использовать любые классы в качестве входного и возвращаемого типов.

{% note info %}

Поля этих классов могут иметь любые [модификаторы доступа](https://docs.microsoft.com/ru-ru/dotnet/csharp/programming-guide/classes-and-structs/access-modifiers). В случае, когда поле непубличное, для него необходим публичный `getter`. В противном случае поле не попадет в ответ.

{% endnote %}


{% include [examples](../../../../_includes/functions/csharp-handler-examples.md) %}
