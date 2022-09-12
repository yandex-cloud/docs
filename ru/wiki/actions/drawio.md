# Диаграммы из сервиса draw.io

[Draw.io](https://drawio.yandex-team.ru/) — сервис для создания диаграмм онлайн.

Чтобы добавить диаграмму на вики-страницу:
1. Нарисуйте в draw.io диаграмму.
1. В меню **File** выберите **Embed** → **Yandex Wiki**.
1. Настройте параметры диаграммы и нажмите кнопку **Create**.
1. Скопируйте код.

Используйте полученный блок `iframe` для вставки на страницу:

```
{{iframe frameborder="0" width="100%" height="300px" src="https://drawio.yandex-team.ru?lightbox=1&highlight=0000ff&layers=1&nav=1#R%3Cmxfile%3E%3Cdiagram%20id%3D%22OFWNq7cRspgGEalt9z8W%22%20name%3D%22Page-1%22%3E3ZZdT4MwFIZ%2FDZdLgMo%2BLt2c7kKjyS5MvGvgCDWFQ7rDl7%2FeMsoYwS2YmM14U9q3p5yep28DFlvF5YPiafSEAUjLtYPSYneW6zrMXehHrVSNMvPcRgiVCExQJ2zFJxjRNmomAtj1AglRkkj7oo9JAj71NK4UFv2wd5T9rCkPYSBsfS6H6qsIKGrUuTvr9A2IMGozO1NTcMzbYFPJLuIBFkcSW1tspRCp6cXlCmQNr%2BXSrLs%2FMXvYmIKExiyY5C%2Fz0hcbL9zYq2Lx5j9LnNw0b8m5zEzBZrNUtQQg0EDMEBVFGGLC5bpTlwqzJIA6ja1HXcwjYqpFR4sfQFSZ0%2BUZoZYiiqWZbXLWiU7WZqQdZsqHMwW1HuEqBDoTxw4noK0LGAOpSq9TIDmJvL8PbjwUHuI6zLpjSP%2BAujOkrtHdzut2ae9bvT%2FbGZxFn3QRCYJtyvdACn3%2FvqOagyIoz3MdcmgX2Ma85vZOzbDoroLT%2Bjs6ugZt3K%2BTm%2F43v7KRfvWu6Vc2zq%2FDs7i0X9lf86s3jhy7OjnvcuT0sPvq7eeO%2Fh3Y%2Bgs%3D%3C%2Fdiagram%3E%3Cdiagram%20id%3D%22V1xrHwwLz41-KOCnK6mP%22%20name%3D%22Page-2%22%3E5ZdRb6JAEMc%2FDY9NcLeKfTytvcv1TJr4cI%2BXjUxhm4Uh6yDYT99FBpGjsaVpY5u%2BKPtj2GH%2B8x8FT86T8qdVWbzEEIwn%2FLD05LUnxEiKK%2FdVkV1NgrGoQWR1yEEtWOlHYOgzzXUIm04gIRrSWReuMU1hTR2mrMWiG3aPpps1UxH0wGqtTJ%2F%2B1SHFNZ2KoOW%2FQEdxk3k04YIT1QRzJZtYhVgcIbnw5NwiUn2UlHMwlXiNLssZKpjc%2Fgvu8sVS3vom%2FS0u6s1uhlxyKMFCSu%2B79WW99VaZnPXiWmnXCAih05OXaCnGCFNlFi2dWczTEKo0vlu1MX8QMwdHDj4A0Y7NoXJCh2JKDJ%2Btc1aJ%2FuvZCwVz3AZzu4YTcVwUKRvBqf3koatuHAATILtz11kwivS2e3OKfRkd4lrt3QHLP6AVot8Kp%2BfVD89JNPX3n7IiM3eX%2FqjfJmPcSFXtKGJNsMrUXpLCTXVXbLXJ6jm712XVNFZ%2FC5agfIP%2Bfb2aXXwenOaXg5fF0Rgyio8msGHvLvDkW3hdvtLr43N6XQ7x%2BjNt%2BvReF%2FLMZp9%2BC7OPX2n24JxmHw8xu%2FwCZheTT2b2YIjCl19Q4Y%2F763TL9gl2f%2B7oPUAungA%3D%3C%2Fdiagram%3E%3C%2Fmxfile%3E"}}
```
Подробнее о параметрах блока `iframe` читайте в разделе [{#T}](iframe.md).

{% note info %}

Чтобы отредактировать диаграмму, снова перейдите в draw.io, заново сгенерируйте код и вставьте его на страницу. В противном случае диаграмма на {{ wiki-name }} не обновится.

Если вы отредактируете диаграмму на вики-странице, в draw.io будет создана ее копия. При этом в исходную диаграмму изменения не попадут.

{% endnote %}