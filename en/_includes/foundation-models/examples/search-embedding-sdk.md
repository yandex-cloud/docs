```python
#!/usr/bin/env python3
# pylint: disable=import-outside-toplevel

from __future__ import annotations
from yandex_cloud_ml_sdk import YCloudML

doc_texts = [
    """Alexander Sergeyevich Pushkin (May 26 [June 6], 1799, Moscow – January 29 [February 10], 1837, St. Petersburg)
    was a Russian poet, playwright, and novelist, the progenitor of Russian realism,
    a literary critic and theorist, historian, essay writer, and journalist.""",
    """Matricaria is a genus of annual flowering plants of the aster (composite) family. According to the today's classification, it includes around 70 species of low-rise fragrant herbs that blossom from the first year of life.""",
    
    
]
query_text = "when is Pushkin's birthday?"


def main():
    import numpy as np
    from scipy.spatial.distance import cdist

    sdk = YCloudML(
        folder_id="<folder_ID>",
        auth="<API_key>",
    )

    query_model = sdk.models.text_embeddings("query")
    query_embedding = query_model.run(query_text)

    doc_model = sdk.models.text_embeddings("doc")
    doc_embeddings = [doc_model.run(text) for text in doc_texts]

    query_embedding = np.array(query_embedding)

    dist = cdist([query_embedding], doc_embeddings, metric="cosine")
    sim = 1 - dist
    result = doc_texts[np.argmax(sim)]
    print(result)


if __name__ == "__main__":
    main()
```