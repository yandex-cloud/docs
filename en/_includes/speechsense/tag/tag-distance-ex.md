A tag is assigned the _poor service_ key phrase. The search for this phrase will be performed differently depending on the **{{ ui-key.yc-ui-talkanalytics.tags.words-between-key-value }}** field value:

| Example in a dialog | Distance: `0` | Distance: `1` | Distance: `2` | Distance: `3` | Distance: `4` | Distance: `5` |
| ----------- | ----------- | ----------- | ----------- | ----------- | ----------- | ----------- |
| _poor service_ | found | found | found | found | found | found |
| _poor customer service_ | not found | found | found | found | found | found |
| _poor and slow service_ | not found | not found | found | found | found | found |
| _poor and slow customer service_ | not found | not found | not found | found | found | found |
| _poor and slow customer service today_ | not found | not found | not found | not found | found | found |
| _poor and slow customer service today and yesterday_ | not found | not found | not found | not found | not found | found |