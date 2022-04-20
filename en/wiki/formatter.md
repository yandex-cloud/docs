# Blocks with special formatting

You can format text as a block on {{ wiki-name }}. It will be displayed on the Wiki page in the specified format. For example, you can use block formatting to format source code using [syntax highlighting](static-markup/highlight.md), insert a framed text fragment on a Wiki page, or set up [width and position](static-markup/wrappers.md) of a block.

{{ wiki-name }} also supports [math formula formatting](static-markup/formulas.md) and specialized languages for [diagram](static-markup/diagram.md) visualization.

To add a special formatting block to a WIki page, use the following markup:

```
%%(<format> <parameters>)
Text fragment, program code, or data markup in a specified format
%%
```

Example:

```
%%(php width=300 border="2px solid red")
<?
phpinfo();
$s = "Hello, World!\n";
print $s;
%% 
```

## Block format {#format}

To display special text formatting, specify a value for the `<format>` field in the block markup:

| Format | Description |
| ------ | ----- |
| `wacko` | Plain text |
| Programming language.<br>For example: `c`, `python`, `java` | Code in the specified programming language. See the list of supported languages here: [{#T}](static-markup/highlight.md#formatters-name). |
| `csv` | [Data in CSV format](static-markup/csv.md) |
| `math` | [Math formula in text markup](static-markup/formulas.md) |
| Diagram type:<ul><li>`graphviz`</li><li>`blockdiag`</li><li>`seqdiag`</li></ul> | [Diagram in text markup](static-markup/diagram.md) |
| `comment` | The text in comments is not displayed on Wiki pages |

## Block parameters {#params}

The list of available parameters depends on the selected block format.

The following parameters are supported in all formats: `wrapper`, `align`, `width`, and `border`. Read the description of these parameters here: [{#T}](static-markup/wrappers.md).

#### See also

* [Embedding code with syntax highlighting](static-markup/highlight.md)

* [Embedding data in CSV format](static-markup/csv.md)

* [Embedding formulas](static-markup/formulas.md)

* [Embedding diagrams and flowcharts](static-markup/diagram.md)

* [Adjusting block borders, width, and alignment](static-markup/wrappers.md)

