# Textual representation of data types in YQL

Since YQL is a strongly typed system, the data type is important for many of its aspects. To make data type management easy, YQL provides textual conventions for its data types. It's mentioned in many places in the documentation. There's also a library that provides functions for building a data type based on such a description (for example, when manually defining the signature for the called value) or for serializing the data type into a string for debugging purposes.

The functions for YQL data types are listed in another [article](../builtins/types.md). Below is the format used for the textual representation of data types. If you prefer C++ to English, the following is implemented [here](https://a.yandex-team.ru/arc/trunk/arcadia/yql/ast/yql_type_string.cpp).

## General conventions {#general-rules}

* With the exception of primitive data types (such as numbers and strings) that are represented in text format simply by referencing their name, a specific data type is composed of other data types. If we were illustrate this structure as a tree, the leaves would be primitive data types and the other nodes would be containers. You may treat special data types as exceptions, because they can function as both.
* The text representation repeats the structure of this tree from the root to the leafs: each node of the tree specifies the name of the current data type, and proceeding to a deeper level is denoted by brackets of relevant type.
* Types of primitive data, containers, and special data are listed in the beginning of our [user guide](../types/primitive.md).
* Feel free to use spaces and line breaks, if they improve readability.
* If the ID contains something else except the Latin letters and numbers, put it in single quotes and use C-escaping.

## Containers {#containers}

* Use angle brackets to specify the types of container elements. Example: `List<Int32>`.
* If a container can hold multiple heterogeneous elements, they are listed inside angle brackets with a comma. Example: `Tuple<Int32,String>`.
* If a container can hold named elements, use comma-separated name-type pairs with a colon in-between instead of comma-separated data types. Example: `Struct<a:Int32,b:String>`.
* The underlying type for a variant container depends on whether its arguments are named. Example: `Variant<Int32,String>` is a variant on tuple, `Variant<a:Int32,b:String>` is a variant on structure.

## Types that allow NULL {#nullable-types}

* They are called `Optional` in YQL terms, or nullable in the classic SQL terms.
* From the formal viewpoint, it's a container. So, you may declare it as `Optional<...>`, but usually the shortcut notation of a question mark suffix is used instead. Example: `String?`.

## Called values {#called-values}

* The basic form of the called values looks as follows: `(arg1,arg2,...)->result`. An example of declaring a function signature that accepts two strings and returns a number: `(String, String)->Int64`.
* The called values can return the called values: in this case, they make up a chain of the required length. Example: `(String,String)->(String,String)->Int64`.
* Optional arguments must have the Optional type at the top level and be enclosed in square brackets. Example: `(String,[String?,Double?])->Int64`.
* The arguments of the called values can contain flags. At the time of writing, only one flag is possible, AutoMap. It means that if NULL is passed to this argument, then the result must also be set to NULL without running the function. Example: `(String{Flags:AutoMap})->Int64`.
* Use this format if you need `Optional<Callable...>`, since the end question mark refers to the result of the called value.

## Resources {#resources}

* Unlike containers, resources aren't parameterized by the element type (it's a pointer in the memory and YQL doesn't know anything else about it). Instead, it's parameterized by a string label that can stop resources from being passed between incompatible functions. Example: `Resource<Foo>`.

