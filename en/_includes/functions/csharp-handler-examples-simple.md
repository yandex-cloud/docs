Example of a valid handler:

```C#
public class Handler {
  public String FunctionHandler(int i) {
    return i.ToString();
  }
}
```

Example of an invalid handler:

```C#
// Handler should not have any type parameters
public class Handler<T> {
  public int FunctionHandler(T i) {
    return 2;
  }
}
```