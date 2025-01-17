from json import loads, dumps
import pandas as pd
df = pd.DataFrame(
    [["a", "b"], ["c", "d"]],
    index=["row 1", "row 2"],
    columns=["col 1", "col 2"],
)


result = df.to_json(orient="records")
parsed = loads(result)
dumps(parsed, indent=4)  
print(result)
