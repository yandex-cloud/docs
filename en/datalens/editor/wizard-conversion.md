
# Converting old wizards to an Editor script

You can convert your Wizard charts to an Editor script by using an API method.


The script uses the `libs/legacy-wizard/v1` auxiliary module and the configuration described on the Shared tab.
Because of this, the result of running the Editor script is the same as the result of running the Wizard chart.


We recommend adding changes to your scripts before `module.exports = result;` by modifying the content of the `result`.
The configuration hasn't yet been documented, and you can change it only intuitively.

## API {#api}

[Authentication](../api/auth.md)

`POST` `https://charts.yandex-team.ru/api/wizard/v1/convert`

* `wizardKey`: A path to the Wizard chart
* `editorKey`: A path to the Editor script (**Note**: be sure to create the directories in advance).

### Sample request {#example-request}

```bash
curl -X POST https://charts.yandex-team.ru/api/wizard/v1/convert \
  -H "Authorization: OAuth $CHARTS_OAUTH_TOKEN" \
  -H "Content-Type: application/json;charset=UTF-8" \
  -d '{
    "wizardKey": "Examples/simple-graph-wizard",
    "editorKey": "Wizard to Editor Convert Test/simple-graph-wizard"
  }'
```

### Response example {#example-response}

```json
{
   "entryId": "wvo8n6c0uy9cs",
   "key": "Wizard to Editor Convert Test/simple-graph-wizard",
   "data": {
     ...
   },
   ...
 }

```

## Examples {#examples}

* [Wizard to Editor Convert Test/simple-graph-wizard-converted](https://charts.yandex-team.ru/editor/Wizard%20to%20Editor%20Convert%20Test/simple-graph-wizard-converted)

   Converted from [Examples/simple-graph-wizard](https://charts.yandex-team.ru/wizard/Examples/simple-graph-wizard).
   We added a new source and lines to the chart based on [Examples/plot-lines](https://charts.yandex-team.ru/editor/examples/plot-lines).
   You can see your code changes in the script's changelog.
