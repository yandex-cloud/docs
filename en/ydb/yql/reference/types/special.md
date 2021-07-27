---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Special data types

* **Callable** is a callable value that can be executed by passing, in parentheses, the arguments in the YQL SQL syntax.
* **Resource** is an opaque pointer to a resource you can pass between the user defined functions (UDF). The type of the returned and accepted resource is declared inside a function using a string label. When passing a resource, YQL checks for label matching to prevent passing of resources between incompatible functions. If the labels mismatch, a type error occurs.
* **Tagged** is the option to assign an application name to any other type.
* **Generic** is the data type used for data types.
* **Unit** is the data type used for non-enumerable entities (data sources and data sinks, atoms, etc.).
* **Null** is a singular data type with the only possible null value. It's the type of the `NULL` literal and can be converted to any `Optional` type.
* **Void** is a singular data type with the only possible "null" value.

