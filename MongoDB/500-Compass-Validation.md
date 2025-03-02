# Validation

https://www.mongodb.com/docs/compass/current/validation/

```json
{
  $jsonSchema: {
    required: [
      'cuisine',
      'borough'
    ],
    properties: {
      cuisine: {
        type: 'string'
      },
      borough: {
        type: 'string'
      }
    }
  }
}
```
