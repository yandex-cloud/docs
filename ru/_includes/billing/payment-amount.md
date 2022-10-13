Итоговая сумма списания зависит от того, был ли использован [грант](../concepts/bonus-account.md) и пополнялся ли [лицевой счет (ЛС)](../concepts/personal-account.md#balance) в течение отчетного периода.

Сумма списания определяется по формуле:
![image](../_assets/formula.png)


{% list tabs %}

{% if region == "ru" %}

- Пример 1
  
  <br/>Баланс ЛС на начало отчетного периода — 0 рублей.
  <br/>В течение всего отчетного периода на ЛС поступило 0 рублей.
  <br/>Сумма гранта — 1 000 рублей.
  <br/>Порог оплаты — 2 000 рублей.
  <br/>В середине отчетного периода достигнут установленный порог оплаты и количество потребленных ресурсов составило 3 000 рублей.
  <br/>Итоговая сумма: 3 000 - (0 + 0 + 1 000) = 2 000 рублей.
  <br/>В середине отчетного периода с привязанной карты может быть списано 2 000 рублей.
  
- Пример 2
  
  <br/>Баланс ЛС на начало отчетного периода — 0 рублей.
  <br/>В течение всего отчетного периода на ЛС поступило 0 рублей.
  <br/>Сумма гранта — 1 000 рублей.
  <br/>На конец отчетного периода количество потребленных ресурсов составило 800 рублей.
  <br/>Сумма гранта на конец отчетного периода составляет 200 рублей. Баланс ЛС не изменился.
  <br/>В начале следующего отчетного месяца с привязанной банковской карты средства не будут списаны.
  
- Пример 3
  
  <br/>Баланс ЛС на начало отчетного периода — 0 рублей.
  <br/>В течение всего отчетного периода на ЛС поступило 0 рублей.
  <br/>Сумма гранта — 1 000 рублей.
  <br/>Порог оплаты — 2 000 рублей.
  <br/>На конец отчетного периода количество потребленных ресурсов составило 2 300 рублей. Порог оплаты не достигнут, предоставленный грант полностью израсходован.
  <br/>Итоговая сумма: 2 300 - (0 + 0 + 1 000) = 1 300 рублей.
  <br/>В начале следующего отчетного периода с привязанной карты будет списано 1 300 рублей.

{% endif %}

{% if region == "kz" %}

- Пример 1
  
  <br/>Баланс ЛС на начало отчетного периода — 0 тенге.
  <br/>В течение всего отчетного периода на ЛС поступило 0 тенге.
  <br/>Сумма гранта — 1 000 тенге.
  <br/>Порог оплаты — 2 000 тенге.
  <br/>В середине отчетного периода достигнут установленный порог оплаты и количество потребленных ресурсов составило 3 000 тенге.
  <br/>Итоговая сумма: 3 000 - (0 + 0 + 1 000) = 2 000 тенге.
  <br/>В середине отчетного периода с привязанной карты может быть списано 2 000 тенге.
  
- Пример 2
  
  <br/>Баланс ЛС на начало отчетного периода — 0 тенге.
  <br/>В течение всего отчетного периода на ЛС поступило 0 тенге.
  <br/>Сумма гранта — 1 000 тенге.
  <br/>На конец отчетного периода количество потребленных ресурсов составило 800 тенге.
  <br/>Сумма гранта на конец отчетного периода составляет 200 тенге. Баланс ЛС не изменился.
  <br/>В начале следующего отчетного месяца с привязанной банковской карты средства не будут списаны.
  
- Пример 3
  
  <br/>Баланс ЛС на начало отчетного периода — 0 тенге.
  <br/>В течение всего отчетного периода на ЛС поступило 0 тенге.
  <br/>Сумма гранта — 1 000 тенге.
  <br/>Порог оплаты — 2 000 тенге.
  <br/>На конец отчетного периода количество потребленных ресурсов составило 2 300 тенге. Порог оплаты не достигнут, предоставленный грант полностью израсходован.
  <br/>Итоговая сумма: 2 300 - (0 + 0 + 1 000) = 1 300 тенге.
  <br/>В начале следующего отчетного периода с привязанной карты будет списано 1 300 тенге.

{% endif %}
  
{% endlist %}