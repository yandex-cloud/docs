# Устранение ошибки ERR.DS_API.FORMULA.VALIDATION.AGG.INCONSISTENT


## Описание проблемы {#issue-description}

При смене способа отображения графика с типа «Линейный» на тип «Индикатор» отображается сообщение об ошибке:

```json

{
"cggk06m72id82_result": {
"code": "ERR.DS_API.FORMULA.VALIDATION.AGG.INCONSISTENT",
"status": 400,
"sourceType": "bi_datasets",
"message": "Inconsistent aggregation among operands",
"details": {}
}
}
"Error: Request failed with status code 427
at t.exports (https://yastatic.net/s3/cloud/datalens/static/freeze/js/vendors.0dfa929f.js:2:6017)
at t.exports (https://yastatic.net/s3/cloud/datalens/static/freeze/js/vendors.0dfa929f.js:2:8466)
at XMLHttpRequest.y (https://yastatic.net/s3/cloud/datalens/static/freeze/js/vendors.0dfa929f.js:2:1286)"

```

## Решение {#issue-resolution}

Группировку по AGO можно использовать только в тех чартах, где по оси X задана дата, по оси Y - измерение.
В поле с индикатором оси X нет, поэтому AGO использовать не получится.
