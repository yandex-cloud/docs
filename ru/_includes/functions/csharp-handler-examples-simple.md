Пример корректного обработчика:

```C#
public class Handler {
  public String FunctionHandler(int i) {
    return i.ToString();
  }
}
```

Пример некорректного обработчика:

```C#
// у Handler не должно быть типов-параметров
public class Handler<T> {
  public int FunctionHandler(T i) {
    return 2;
  }
}
```