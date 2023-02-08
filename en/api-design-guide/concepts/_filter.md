# Filtering results

The `List` method allows filtering results by certain criteria. For example, you can get a list of only those resources where the `name` field is
<q>test</q>.

{% note info %}

Currently, you can only filter results by the `name` field.

{% endnote %}

Filtering parameters are passed in the `filter` field in the following format:

```<condition1>AND<condition2>AND<conditionN>```

Note that a logical operator's case is ignored (in other words, both "OR" and "or" are supported).

Each condition contains:
1. The name of the field to filter by. Filtering only supports the `name` field at this time.
2. Can be either `=` or `!=` for single values, or `IN` or `NOT IN` for lists of values.
3. A value from 3 to 63 characters long that matches the regular expression `^[a-z][-a-z0-9]{1,61}[a-z0-9]$`.


Example:
> ```protobuf
> // Method for getting a list of disks in the specified folder.
> rpc List (ListDisksRequest) returns (ListDisksResponse) {
>    option (google.api.http) = { get: "/compute/v1/disks" };
>  }
> message ListDisksRequest {
>   string folder_id = 1;
>   int64 page_size = 2;
>   string page_token = 3;
>   // Expression to filter.
>   string filter = 4;
> }
> ```

Here is an example of sending a REST request to get a list of disks with the name set to <q>test</q>:
> ??? In REST
> ```
> GET https://compute.{{ api-host }}/compute/v1/disks?folderId=a3s17h9sbq5asdgss12&name=test%20and%20name=dev
> ```
