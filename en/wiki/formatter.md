# Blocks with special formatting

You can add formatted blocks to your [Wiki page](pages-types.md#page). For example, you can [highlight syntax](static-markup/highlight.md) in the source code, add bordered blocks, and set up the [width and position](static-markup/wrappers.md) of a block on your Wiki page.

{{ wiki-name }} also supports markup of [mathematical formulas](static-markup/formulas.md) and special languages for visualizing [diagrams](static-markup/diagram.md).

To add a formatted block to your Wiki page, use the following markup:

```
%%(<format> <parameters>)
A text fragment, software code, or data markup in a specified format
%%
```

For example:

```
%%(php width=300 border="2px solid red")
<?
phpinfo();
$s = "Hello, World!\n";
print $s;
%% 
```

## Block formatting {#format}

To add special formatting to your text, specify a value for the `<format>` field in the block's markup:

| Format | Description |
------ | -----
| `wacko` | Plain text |
| Programming language.<br>For example: `C`, `Python`, or `Java` | Code in the specified programming language. View the list of supported languages in [{#T}](static-markup/highlight.md#formatters-name). |
| `csv` | [Data in CSV format](static-markup/csv.md) |
| `math` | [A mathematical formula using text markup](static-markup/formulas.md) |
| Diagram type:<ul><li>`graphviz`</li><li>`blockdiag`</li><li>`seqdiag`</li></ul> | [A diagram in text markup](static-markup/diagram.md) |
| `comment` | Comments: Text that won't be displayed on your Wiki page. |

## Block parameters {#params}

The list of available parameters depends on the selected block format.

These parameters are supported for all formats: `wrapper`, `align`, `width`, and `border`. For parameter descriptions, see [{#T}](static-markup/wrappers.md).

#### See also

* [Inserting code with syntax highlighting](static-markup/highlight.md)

* [Inserting data in CSV format](static-markup/csv.md)

* [Inserting formulas](static-markup/formulas.md)

* [Inserting diagrams and flowcharts](static-markup/diagram.md)

* [Setting up block borders, width, and alignment](static-markup/wrappers.md)