---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/UTF8.md
---

# UTF8



#### Syntax {#syntax}


```
UTF8( string, old_encoding )
```

#### Description {#description}
Converts the `string` string encoding to `UTF8`.

**Argument types:**
- `string` — `String`
- `old_encoding` — `String`


**Return type**: `String`

#### Example {#examples}

```
UTF8([Name], "CP-1251")
```


#### Data source support {#data-source-support}

`ClickHouse 21.8`.
