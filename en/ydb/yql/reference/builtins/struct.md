# Functions for structures

## ExpandStruct {#expandstruct}

Adding one or more new fields to the structure.

If the field set contains duplicate values, an error is returned.

Arguments:

* The first argument passes the source structure to be expanded.
* All the other arguments must be named, each argument adds a new field and the argument's name is used as the field's name (as in [AsStruct](basic.md#asstruct)).

**Examples**

```sql
$struct = AsStruct(1 AS a);
SELECT
  ExpandStruct(
    $struct,
    2 AS b,
    "3" AS c
  ) AS abc;
```

## AddMember {#addmember}

Adding one new field to the structure. If you need to add multiple fields, better use [ExpandStruct](#expandstruct).

If the field set contains duplicate values, an error is returned.

Arguments:

1. Source structure.
2. Name of the new field.
3. Value of the new field.

**Examples**

```sql
$struct = AsStruct(1 AS a);
SELECT
  AddMember(
    $struct,
    "b",
    2
  ) AS ab;
```

## RemoveMember {#removemember}

Removing a field from the structure.

If the entered field hasn't existed, an error is returned.

Arguments:

1. Source structure.
2. Field name.

**Examples**

```sql
$struct = AsStruct(1 AS a, 2 AS b);
SELECT
  RemoveMember(
    $struct,
    "b"
  ) AS a;
```

## ForceRemoveMember {#forceremovemember}

Removing a field from the structure.

If the entered field hasn't existed, unlike [RemoveMember](#removemember), the error is not returned.

Arguments:

1. Source structure.
2. Field name.

**Examples**

```sql
$struct = AsStruct(1 AS a, 2 AS b);
SELECT
  ForceRemoveMember(
    $struct,
    "c"
  ) AS ab;
```

## CombineMembers {#combinemembers}

Combining the fields from multiple new structures into another new structure.

If the resulting field set contains duplicate values, an error is returned.

Arguments:

1. Two or more structures.

**Examples**

```sql
$struct1 = AsStruct(1 AS a, 2 AS b);
$struct2 = AsStruct(3 AS c);
SELECT
  CombineMembers(
    $struct1,
    $struct2
  ) AS abc;
```

## FlattenMembers {#flattenmembers}

Combining the fields from multiple new structures into another new structure with prefix support.

If the resulting field set contains duplicate values, an error is returned.

Arguments:

1. Two or more tuples of two elements: prefix and structure.

**Examples**

```sql
$struct1 = AsStruct(1 AS a, 2 AS b);
$struct2 = AsStruct(3 AS c);
SELECT
  FlattenMembers(
    AsTuple("foo", $struct1), -- fooa, foob
    AsTuple("bar", $struct2)  -- barc
  ) AS abc;
```

