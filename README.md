General purpose pretty printer for the V programming language.

```v
import prettyprint as pp

fn main() {
  pp.pprint('{"id": 123, "names": ["pretty", "printer"]}')
}
```

```
{
  "id": 123,
  "names": [
    "pretty",
    "printer"
  ]
}
```
