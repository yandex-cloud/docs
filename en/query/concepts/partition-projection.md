# Extended partitioning

[Partitioning](partitioning.md) lets you prompt {{yq-full-name}} what rules for storing data in {{objstorage-full-name}} should be used.

Let's say data in {{objstorage-full-name}} is stored using the following folder structure:

```
year=2021
    month=01
    month=02
    month=03
year=2022
    month=01
```

When running the query below, {{yq-full-name}} does the following:
1. Gets a full list of subfolders within '/'.
1. For each subfolder, tries to handle a subfolder name in "year=\<DIGITS\>" format.
1. For each "year=\<DIGITS\>" subfolder, gets a list of all subfolders in "month=\<DIGITS\>" format.
1. Processes the data read.

```sql
SELECT
    *
FROM
    objectstorage.'/'
    WITH
    (
        Schema =
        (
            data String,
            year Int,
            month Int
        ),
        partitioned_by =
        (
            year,
            month
        )
    )
WHERE
    year=2021
    AND month=02
```

This means that when working with partitioned data, a full listing of the contents of {{objstorage-full-name}} is performed, which may take a long time in large buckets.

To optimize operations with large amounts of data, use "extended partitioning". This mode doesn't involve {{ objstorage-full-name }} folder scanning. Instead, all paths are determined in advance and data is only accessed using them.

To enable extended partitioning, set the rules for operations via a special parameter called "projection". This parameter describes the rules for storing data in {{ objstorage-full-name}} folders.

## Syntax { #syntax }

Extended partitioning is called "partition projection" and set using the `projection` parameter.

Example of setting partition projection:

```sql

$projection =
@@
{
    "projection.enabled" : true,

    "projection.year.type" : "integer",
    "projection.year.min" : 2010,
    "projection.year.max" : 2022,
    "projection.year.interval" : 1,

    "projection.month.type" : "integer",
    "projection.month.min" : 1,
    "projection.month.max" : 12,
    "projection.month.interval" : 1,
    "projection.month.digits" : 2,

    "storage.location.template" : "${year}/${month}"
}
@@;

SELECT
    *
FROM
    <connection>.`/`
WITH
(
    schema=
    (
        data String,
        year Int,
        month Int
    ),
    partitioned_by=(year, month),
    projection=@projection
)
```

The example above indicates that there is data for each year and each month from 2010 to 2022 and bucket data is stored in folders like `2022/12`.

In general, partition projection setup is as follows:

```sql

$projection =
@@
{
    "projection.enabled" : <true|false>,

    "projection.<field1_name>.type" : "<type>",
    "projection.<field1_name>...." : "<extended_properties>",

    "projection.<field2_name>.type" : "<type>",
    "projection.<field2_name>...." : "<extended_properties>",

    "storage.location.template" : ".../${field2}/${field1}/..."
}
@@;

SELECT
    *
FROM
    <connection>.<path>
WITH
(
    schema=(<fields>, <field1>, <field2>),
    partitioned_by=(field1, field2),
    projection=@projection
)
```

## Description of fields { #field_types }

| Field name | Field description | Acceptable values |
|----|----|----|
| `projection.enabled` | Shows if partition projection is enabled | true, false |
| `projection.<field1_name>.type` | Field data type | integer, enum, or date |
| `projection.<field1_name>.XXX` | Type properties |

### Field of integer type { #integer_type }

Used for columns whose values can be represented as integers in the range from 2^-63^ to 2^63^-1.

| Field name | Required | Field description | Sample value |
|----|----|----|----|
| `projection.<field_name>.type` | Yes | Field data type | integer |
| `projection.<field_name>.min` | Yes | Defines the minimum allowed value. Set as an integer | -100<br>004 |
| `projection.<field_name>.max` | Yes | Defines the maximum allowed value. Set as an integer | -10<br>5000 |
| `projection.<field_name>.interval` | No, defaults to `1` | Defines a step between elements within a value range. For example, step 3 under the 2, 10 value range will result in the following values: 2, 5, 8. | 2<br>11 |
| `projection.<field_name>.digits` | No, defaults to `0` | Sets the number of digits in a number. If the amount of non-zero digits is less than the specified value, zeros are added in front until the specified amount of digits is reached. For example, if the set value is .digits=3 while 2 is passed, it's converted to 002 | 2<br>4 |

### Field of enum type { #enum_type }

Used for columns whose values can be represented as an enumeration.

| Field name | Required | Field description | Sample value |
|----|----|----|----|
| `projection.<field_name>.type` | Yes | Field data type | enum |
| `projection.<field_name>.values` | Yes | Specifies the allowed values separated by a comma. Spaces are not ignored. | 1, 2<br>A,B,C |

### Field of date type { #date_type }

Used for columns whose values can be represented as a date.

| Field name | Required | Field description | Sample value |
|----|----|----|----|
| `projection.<field_name>.type` | Yes | Field data type | date |
| `projection.<field_name>.min` | Yes | Defines the minimum allowed date. Values in `YYYY-MM-DD` format or expressions with the special macro substitution NOW are allowed. Using the NOW macro substitution, you can perform arithmetic operations such as <br>NOW-3DAYS, <br> NOW+1MONTH, <br>NOW-6YEARS, <br>NOW+4HOURS, <br>NOW-5MINUTES, or <br> NOW+6SECONDS. | 2020-01-01<br/>NOW-5DAYS<br/>NOW+3HOURS |
| `projection.<field_name>.max` | Yes | Defines the maximum allowed date. Values in `YYYY-MM-DD` format or expressions with the special macro substitution NOW are allowed. Using the NOW macro substitution, you can perform arithmetic operations such as <br>NOW-3DAYS, <br> NOW+1MONTH, <br>NOW-6YEARS, <br>NOW+4HOURS, <br>NOW-5MINUTES, or <br> NOW+6SECONDS. | 2020-01-01<br/>NOW-5DAYS<br/>NOW+3HOURS |
| `projection.<field_name>.format` | Yes | Date formatting string based on [strptime](https://cplusplus.com/reference/ctime/strftime/) | %Y-%m-%d<br/>%D |
|`projection.<field_name>.unit`|No|Interval units. Acceptable values: DAYS|DAYS|
|`projection.<field_name>.interval`|No, defaults to `1`|Defines a step between elements within a value range with the unit set in `projection.<field_name>.unit`. For example, for the range 2021-02-02, 2021-03-05, step 15 with the DAYS unit will result in the values: 2021-02-17, 2021-03-04|2<br/>6|

## Path templates { #storage_location_template}

{{ objstorage-full-name }} bucket data can be stored in folders with any name. Using the `storage.location.template` setting, you can specify the rules for naming folders with data.

| Field name | Field description | Sample value |
|----|----|----|
| `storage.location.template` | Folder name path template. Set in "${<field_name...>}/${<field_name...>}" format. | root/a/${year}/b/${month}/d<br/>${year}/${month} |