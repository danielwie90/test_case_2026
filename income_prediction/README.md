# Income Prediction API

A Flask-based REST API for predicting yearly income based on customer data.

## Local Development

The API runs locally at: **<http://localhost:7000>**

## API Endpoint

### POST /income

Predicts yearly income based on customer information.

**URL:** `http://localhost:7000/income`

**Method:** `POST`

**Headers:**

- `Content-Type: application/json`
- `RequestId: <uuid>` (optional)

**Request Body:**

```json
{
  "customer_id": "01010199999",
  "period": "202301",
  "age": 30,
  "employment_status": "employed",
  "income_month": 40000.50
}
```

or for multiple periods:

```json
[
    {  
        "customer_id": "01010199999",
        "period": "202301",
        "age": 30,
        "employment_status": "employed",
        "income_month": 4000.50
    }, 
    {
        "customer_id": "01010199999",
        "period": "202212",
        "age": 30,
        "employment_status": "employed",
        "income_month": 38000.50
    }
]
```

**Field Descriptions:**

- `customer_id` (string, required): 11-digit customer identifier
- `period` (string, required): Period in YYYYMM format
- `age` (integer, required): Customer age (minimum: 0)
- `employment_status` (string, required): One of: `employed`, `unemployed`, `student`
- `income_month` (number, required): Monthly income (minimum: 0.0)

**Response (200 OK):**

```json
{
  "predicted_yearly_income": 48000.75
}
```
