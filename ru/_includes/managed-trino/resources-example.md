```json
{
  "rootGroups": [
    {
      "name": "global",
      "hardConcurrencyLimit": 20,
      "maxQueued": 200,
      "schedulingPolicy": "weighted_fair",
      "subGroups": [
        {
          "name": "adm",
          "hardConcurrencyLimit": 5,
          "maxQueued": 50,
          "schedulingWeight": 5
        },
        {
          "name": "bi",
          "hardConcurrencyLimit": 10,
          "softMemoryLimit": "20%",
          "maxQueued": 100,
          "schedulingWeight": 3,
          "subGroups": [
            {
              "name": "${toolname}",
              "hardConcurrencyLimit": 5,
              "maxQueued": 50,
              "subGroups": [
                {
                  "name": "${USER}",
                  "hardConcurrencyLimit": 2,
                  "maxQueued": 20
                }
              ]
            }
          ]
        },
        {
          "name": "etl",
          "hardConcurrencyLimit": 5,
          "softCpuLimit": "20s",
          "hardCpuLimit": "40s",
          "maxQueued": 50,
          "schedulingWeight": 1
        },
        {
          "name": "adhoc",
          "hardConcurrencyLimit": 5,
          "maxQueued": 100,
          "subGroups": [
            {
              "name": "${USER}",
              "hardConcurrencyLimit": 2,
              "maxQueued": 20
            }
          ]
        }
      ]
    }
  ],
  "selectors": [
    {
      "userGroup": "admins",
      "group": "global.adm"
    },
    {
      "clientTags": ["etl_job"],
      "group": "global.etl"
    },
    {
      "queryType": "DATA_DEFINITION",
      "group": "global.adm"
    },
    {
      "source": "jdbc#(?<toolname>[^#]+)",
      "queryType": "SELECT",
      "group": "global.bi.${toolname}.${USER}"
    },
    {
      "group": "global.adhoc.${USER}"
    }
  ],
  "cpuQuotaPeriod": "1m"
}
```
