# For text representation of data types

## Introduction {#intro}

Since YQL is a strongly typed language, the data type is important for many of its aspects. To make data type management easy, YQL has a data type definition convention in text format. It's mentioned in many places in the documentation. There's also a library that provides functions for building a data type based on a text description (for example, when manually defining the signature for the called value) or for serializing the data type into a string for debugging purposes.

The functions for data types are listed in the article [{#T}](../builtins/types.md). Below is the format used for text representation of data types.

## General conventions {#rules}

* [Primitive data types](../types/primitive.md) are represented in text format simply by referencing their name.

* A complex data type is composed of other data types. If you depict this structure as a tree, it has [primitive data types](../types/primitive.md) as leaves and [containers](../types/containers.md) as other nodes. [You may treat special data types](../types/special.md) as exceptions, because they can function as both.

* The text representation repeats the structure of this tree from the root to the leaves: each node of the tree specifies the name of the current data type, and proceeding to a deeper level is denoted by different types of brackets.

* Feel free to use spaces and line breaks if they improve readability.

* If the ID contains something else except the Latin letters and numbers, put it in single quotes and use C-escaping.

## Containers {#containers}

* Use angle brackets to specify the types of container elements.

  Example: `List<Int32>`.

* If a container can hold multiple heterogeneous elements, they are listed inside angle brackets with a comma.

  Example: `Tuple<Int32, String>`.

* If a container can hold named elements, use comma-separated name-type pairs with a colon in-between instead of comma-separated data types.

  Example: `Struct<a:Int32, b:String>`.

* The underlying type for a `Variant`  container depends on whether its arguments are named.

  Example: `Variant<Int32, String>` is a variant on tuple, `Variant<a:Int32, b:String>` is a variant on structure.

## Types that allow NULL {#optional}

* They are called `Optional` in YQL terms, or nullable in the classic SQL terms.

* From the formal viewpoint, this type is a container. So, you may declare it as `Optional<...>`, but usually the shortcut notation of a question mark suffix is used instead.

  Example: `String?`.

## Called values {#callable}

* The basic form of the called values looks as follows: `(arg1, arg2, ...) -> result`.

  An example of declaring a function signature that accepts two strings and returns a number: `(String, String) -> Int64`.

* The called values can return the called values: in this case, they make up a chain of the required length.

  Example: `(String, String) -> (String, String) -> Int64`.

* Optional arguments must have the `Optional` type at the top level and be enclosed in square brackets.

  Example: `(String, [String?, Double?]) -> Int64`.

* The arguments of the called values can contain flags.

  Currently, the only possible flag is `AutoMap`. It means that if NULL is passed to this argument, the result must also be set to NULL without running the function.

  Example: `(String{Flags: AutoMap}) -> Int64`.

* If you need `Optional<Callable<...>>`, use this format instead of the `?` shortcut, since the end question mark refers to the result of the called value.

## Resources {#resources}

* Unlike containers, a resource isn't parameterized by the element type (it's a pointer in memory and YQL knows nothing about its contents). Instead, a resource is parameterized by a string label that can safeguard against passing resources between incompatible functions.

  Example: `Resource<Foo>`.

