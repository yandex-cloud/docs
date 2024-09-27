# Получить результаты мобильной выдачи

Мобильная выдача отличается от результатов по умолчанию формулой ранжирования и наличием ссылок на сайты, оптимизированные для мобильных устройств.

Чтобы получить результаты мобильной выдачи, добавьте заголовок `user-agent` со спецификацией устройства и браузера. Например, для поискового запроса `query=youtube`:

{% list tabs group=programming_language %}

- cURL {#curl}

  ```bash
  curl \
    --header 'user-agent: Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1' \
    'https://yandex.ru/search/xml?query=youtube&user={USER}&key={KEY}&lr=2&l10n=en&page=0&groupby=attr%3Dd.mode%3Ddeep.groups-on-page%3D100.docs-in-group%3D1&filter=moderate&noredirect=1&nocache=da'
  ```

- Python {#python}

  ```python
  import subprocess
  
  MOBILE_HEADER = 'user-agent: Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1'
  URL = f'https://yandex.ru/search/xml?query=youtube&user={USER}&key={KEY}&lr=2&l10n=en&page=0&groupby=attr%3Dd.mode%3Ddeep.groups-on-page%3D100.docs-in-group%3D1&filter=moderate&noredirect=1&nocache=da'
  with open('mob.xml', 'w') as f:
    subprocess.run(['curl', '-H', MOBILE_HEADER, URL], stdout=f)
  ```

{% endlist %}

Результаты мобильной выдачи: 

```text
https://m.youtube.com/
https://apps.apple.com/ru/app/youtube/id544007664
https://youtubego.com/?ref=website-popularity
https://ru.m.wikipedia.org/wiki/YouTube
https://en.m.wikipedia.org/wiki/YouTube
https://www.pinterest.com/YouTube/
https://ria.ru/organization_YouTube_LLC/
https://about.youtube/
https://youtube.fandom.com/wiki/YouTube
https://iz.ru/tag/youtube
```

Результаты по умолчанию при запросе без заголовка `user-agent`: 

```text
https://www.youtube.com/
https://youtubego.com/?ref=website-popularity
https://en.wikipedia.org/wiki/YouTube
https://ru.wikipedia.org/wiki/YouTube
https://www.pinterest.com/YouTube/
https://iz.ru/tag/youtube
https://about.youtube/
https://ria.ru/organization_YouTube_LLC/
https://www.RBC.ru/tags/?tag=YouTube
https://lenta.ru/news/2023/08/24/block_to_come/
```
