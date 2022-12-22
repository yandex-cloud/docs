## General information {#about}

A comment can be one of the following types:
* **line-x**: Line.
* **band-x**: Band.
* **flag-x**: Flag.
* **dot-x-y**: Dot.

A comment has the following parameters:

* Service

   | Parameter | Type | Description |
   |:---|:---|:---
   | id | `number` | ID |
   | creatorLogin | `string` | Username of the user who created the comment. |
   | createdDate | `string` | ISO date when the comment was created. |
   | modifierLogin | `string` | Username of the user who edited the comment last. |
   | modifiedDate | `string` | ISO date when the comment was last edited. |

* General:

   | Parameter | Type | Description | Required |
   |:---|:---|:---|:---
   | feed | `string` | Feed that the comment belongs to. | ✓ |
   | date | `string` | ISO date that the comment pertains to. | ✓ |
   | dateUntil | `string` | ISO date of the end of the interval the comment pertains to, while the `date` parameter is the start of the interval (only makes sense for `band-x` comments). |
   | type | `string` | Comment type. | ✓ |
   | text | `string` | Text | ✓ |
   | meta | `object` | Metadata.  | ✓ |
   | params | `object` | Clarifying parameters |

Depending on the comment type, metadata is described as follows:

| Comment type. | Parameter | Type | Description | Required / By default |
|:---|:---|:---|:---|:---
| All types | color | `string` | Color | `#ffcc00` or the line color (for `dot-x-y`) |
| line-x | dashStyle | `string` | [Dash style](http://jsfiddle.net/es6ejm5v/embedded/result/) | `solid` |
|  | width | `number` | Width | `2` |
| band-x | visible | `boolean` | Visibility | `false` |
|  | zIndex | `number` | Priority (in case of overlay). | `0` |
| flag-x | y | `number` | Height | `-30` |
|  | shape | `string` | [Form](http://jsfiddle.net/rb1zadgd/embedded/result/) | `circlepin` |
| dot-x-y | graphId | `string` | Line ID. | Required |
|  | visible | `boolean` | Indicates if a tooltip should be displayed. | `false` |
|  | fillColor | `string` | Tooltip color. | `#000000` |
|  | textColor | `string` | Tooltip text color. | `#ffffff` |

You can specify clarifying parameters for comments, such as:
```
{
    scale: ['d'],
    region: ['*']
}
```
where `*` stands for any value.
You can also set parameters in unnormalized format (without wrapping single values in an array), but they are saved in normalized format anyway.
