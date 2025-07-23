# Python Address Extractor Service

This is a Python Flask service that uses OpenAI to extract address and property information from text strings.

## Setup

1. **Install dependencies:**
```bash
cd python_services
pip install -r requirements.txt
```

2. **Configure environment:**
```bash
cp .env.example .env
# Edit .env and add your OpenAI API key
```

3. **Run the service:**
```bash
python server.py
```

## API Endpoints

### POST /extract-address
Extract address and property information from a single text string.

**Request:**
```json
{
  "text": "123 Main Street, New York, NY 10001. 2 bedroom apartment, 850 sq ft, built in 1990."
}
```

**Response:**
```json
{
  "addressData": {
    "streetAddress": "123 Main Street",
    "city": "New York",
    "state": "NY",
    "zipCode": "10001",
    "country": "USA",
    "fullAddress": "123 Main Street, New York, NY 10001",
    "houseNumber": "123",
    "streetName": "Main Street"
  },
  "rooms": "2",
  "squareMeters": "850",
  "yearBuilt": "1990",
  "floor": "",
  "apartmentNumber": "",
  "heatingType": "",
  "bathroom": "",
  "balcony": "",
  "garden": "",
  "parking": "",
  "rentAmount": "",
  "tenantName": "",
  "tenantEmail": "",
  "tenantPhone": ""
}
```

### POST /extract-address/batch
Process multiple texts in a single request.

**Request:**
```json
{
  "texts": [
    "123 Main Street, New York, NY 10001",
    "456 Oak Avenue, Los Angeles, CA 90210"
  ]
}
```

## Usage with Flutter

The service runs on `http://localhost:5000` and can be called from your Flutter app using HTTP requests.

### Example Flutter Integration:
```dart
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map<String, dynamic>> extractAddress(String text) async {
  final response = await http.post(
    Uri.parse('http://localhost:5000/extract-address'),
    headers: {'Content-Type': 'application/json'},
    body: json.encode({'text': text}),
  );
  
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to extract address');
  }
}
```

## Docker Support

Build and run with Docker:
```bash
docker build -t address-extractor .
docker run -p 5000:5000 --env-file .env address-extractor
