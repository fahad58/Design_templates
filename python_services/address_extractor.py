import os
import json
import re
from typing import Dict, Any, Optional
from openai import OpenAI
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

class AddressExtractor:
    def __init__(self):
        # Fix for proxy issue with newer httpx versions
        api_key = os.getenv("OPENAI_API_KEY")
        if not api_key:
            raise ValueError("OPENAI_API_KEY environment variable is not set")
        
        try:
            # Create client with compatible settings
            self.client = OpenAI(api_key=api_key)
        except TypeError as e:
            # Handle proxy compatibility issues
            import httpx
            # Create a custom HTTP client without proxy settings
            http_client = httpx.Client(
                timeout=httpx.Timeout(30.0),
                limits=httpx.Limits(max_connections=100, max_keepalive_connections=20)
            )
            self.client = OpenAI(
                api_key=api_key,
                http_client=http_client
            )
        
        self.model = "gpt-3.5-turbo"
        
    def extract_address_from_text(self, text: str) -> Dict[str, Any]:
        """
        Extract address and property information from OCR text.
        
        Args:
            text: Raw OCR text from document scanning
            
        Returns:
            Dictionary with extracted property data in Flutter-compatible format
        """
        try:
            prompt = self._build_extraction_prompt(text)
            
            response = self.client.chat.completions.create(
                model=self.model,
                messages=[
                    {
                        "role": "system",
                        "content": """You are an expert property data extractor. 
                        Analyze the provided OCR text and extract ALL relevant property information.
                        Return a valid JSON object with the exact Flutter-compatible format including:
                        addressData (with streetAddress, city, state, zipCode, country, fullAddress, houseNumber, streetName)
                        and all property fields (rooms, squareMeters, yearBuilt, floor, apartmentNumber, etc.)"""
                    },
                    {
                        "role": "user",
                        "content": prompt
                    }
                ],
                temperature=0.1,
                max_tokens= 5000,
            )
            
            # Parse the response
            content = response.choices[0].message.content
            return self._parse_response(content)
            
        except Exception as e:
            # Return Flutter-compatible empty structure
            return {
                "addressData": {
                    "streetAddress": "",
                    "city": "",
                    "state": "",
                    "zipCode": "",
                    "country": "",
                    "fullAddress": "",
                    "houseNumber": "",
                    "streetName": ""
                },
                "rooms": "",
                "squareMeters": "",
                "yearBuilt": "",
                "floor": "",
                "apartmentNumber": "",
                "heatingType": "",
                "bathroom": "",
                "balcony": "",
                "garden": "",
                "parking": "",
                "isOccupied": "",
                "isCommercialUnit": "",
                "tenantSurname": "",
                "tenantName": "",
                "tenantEmail": "",
                "tenantPhone": "",
                "tenantIsMarried": "",
                "tenantIdNumber": "",
                "contractStart": "",
                "contractEnd": "",
                "rentAmount": "",
                "rentWithUtilities": "",
                "costOfUtilities": "",
                "depositAmount": "",
                "rentDueDay": "",
                "lastRentIncrease": "",
                "isActive": ""
            }
    
    def _build_extraction_prompt(self, text: str) -> str:
        """Build the extraction prompt for OpenAI."""
        return f"""
Extract ALL address and property information from this OCR text:


 Residential Rental Agreement

This Rental Agreement is made on January 1, 2024, by and between the landlord and the tenant, whose information is provided below.

Property Details
The rented premises is located at 123 Maple Street, Apt. 4B, Springfield, IL 62704, USA. The property consists of 3 rooms with a total area of 85 square meters. It was built in the year 2005, and the apartment is situated on the 2nd floor, apartment number 4B.

The unit includes central heating, 1 bathroom, 1 balcony, and access to a private garden. Additionally, private parking is available. The unit is currently occupied and designated as a residential property (not a commercial unit).

Tenant Information
The tenant, John Doe, residing at the aforementioned property, is married and can be contacted at:

Phone: +1 (555) 123-4567

Email: john.doe@example.com

ID Number: A123456789

Lease Terms
Contract Start Date: January 1, 2024

Contract End Date: December 31, 2024

Monthly Rent Amount: $1,200.00

Rent with Utilities: $1,450.00

Cost of Utilities: $250.00

Security Deposit: $1,200.00

Rent Due Date: 1st of each month

Last Rent Increase: January 1, 2024

The property is active and under a valid rental contract as of the date above.

Agreement
By signing this agreement, both parties agree to the terms and conditions laid out regarding the use, care, and rental payment obligations for the above-mentioned property.

 

Return a JSON object with this exact Flutter-compatible format:
{{
    "addressData": {{
        "streetAddress": "",
        "city": "",
        "state": "",
        "zipCode": "",
        "country": "USA",
        "fullAddress": "",
        "houseNumber": "",
        "streetName": ""
    }},
    "rooms": "",
    "squareMeters": "",
    "yearBuilt": "",
    "floor": "",
    "apartmentNumber": "",
    "heatingType": "",
    "bathroom": "",
    "balcony": "",
    "garden": "",
    "parking": "",
    "isOccupied": "",
    "isCommercialUnit": "",
    "tenantSurname": "",
    "tenantName": "",
    "tenantEmail": "",
    "tenantPhone": "",
    "tenantIsMarried": "",
    "tenantIdNumber": "",
    "contractStart": "",
    "contractEnd": "",
    "rentAmount": "",
    "rentWithUtilities": "",
    "costOfUtilities": "",
    "depositAmount": "",
    "rentDueDay": "",
    "lastRentIncrease": "",
    "isActive": "true"
}}

Extract whatever information is available from the OCR text, even if some fields are missing. Convert any numbers or measurements to string format.
"""
    
    def _parse_response(self, content: str) -> Dict[str, Any]:
        """Parse the OpenAI response and extract JSON."""
        try:
            # Clean the content to extract JSON
            content = content.strip()
            
            # Try to find JSON in the response
            json_start = content.find('{')
            json_end = content.rfind('}') + 1
            
            if json_start != -1 and json_end > json_start:
                json_str = content[json_start:json_end]
                return json.loads(json_str)
            else:
                # Fallback: try to parse as JSON directly
                return json.loads(content)
                
        except json.JSONDecodeError:
            # If JSON parsing fails, return structured data
            return self._fallback_extraction(content)
    
    def _fallback_extraction(self, content: str) -> Dict[str, Any]:
        """Fallback method if JSON parsing fails."""
        # Basic regex extraction for common patterns
        address_patterns = {
            'streetAddress': r'(\d+\s+[A-Za-z\s]+(?:Street|St|Avenue|Ave|Road|Rd|Boulevard|Blvd|Drive|Dr|Lane|Ln|Way|Court|Ct))',
            'city': r'([A-Za-z\s]+),\s*[A-Z]{2}',
            'state': r'[A-Za-z\s]+,\s*([A-Z]{2})',
            'zipCode': r'\b(\d{5}(?:-\d{4})?)\b',
            'houseNumber': r'^(\d+)',
            'streetName': r'^\d+\s+(.+?)(?:,|\s|$)'
        }
        
        extracted = {
            "addressData": {
                "streetAddress": "",
                "city": "",
                "state": "",
                "zipCode": "",
                "country": "USA",
                "fullAddress": "",
                "houseNumber": "",
                "streetName": ""
            },
            "rooms": "",
            "squareMeters": "",
            "yearBuilt": "",
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
        
        # Try to extract basic address components
        for key, pattern in address_patterns.items():
            match = re.search(pattern, content, re.IGNORECASE)
            if match:
                if key == 'streetAddress':
                    extracted['addressData']['streetAddress'] = match.group(1)
                elif key == 'city':
                    extracted['addressData']['city'] = match.group(1)
                elif key == 'state':
                    extracted['addressData']['state'] = match.group(1)
                elif key == 'zipCode':
                    extracted['addressData']['zipCode'] = match.group(1)
                elif key == 'houseNumber':
                    extracted['addressData']['houseNumber'] = match.group(1)
                elif key == 'streetName':
                    extracted['addressData']['streetName'] = match.group(1)
        
        return extracted

# Test function
if __name__ == "__main__":
    extractor = AddressExtractor()
    print(extractor.extract_address_from_text(""" Extract ALL address and property information from this OCR text:


 Residential Rental Agreement

This Rental Agreement is made on January 1, 2024, by and between the landlord and the tenant, whose information is provided below.

Property Details
The rented premises is located at 123 Maple Street, Apt. 4B, Springfield, IL 62704, USA. The property consists of 3 rooms with a total area of 85 square meters. It was built in the year 2005, and the apartment is situated on the 2nd floor, apartment number 4B.

The unit includes central heating, 1 bathroom, 1 balcony, and access to a private garden. Additionally, private parking is available. The unit is currently occupied and designated as a residential property (not a commercial unit).

Tenant Information
The tenant, John Doe, residing at the aforementioned property, is married and can be contacted at:

Phone: +1 (555) 123-4567

Email: john.doe@example.com

ID Number: A123456789

Lease Terms
Contract Start Date: January 1, 2024

Contract End Date: December 31, 2024

Monthly Rent Amount: $1,200.00

Rent with Utilities: $1,450.00

Cost of Utilities: $250.00

Security Deposit: $1,200.00

Rent Due Date: 1st of each month

Last Rent Increase: January 1, 2024

The property is active and under a valid rental contract as of the date above.

Agreement
By signing this agreement, both parties agree to the terms and conditions laid out regarding the use, care, and rental payment obligations for the above-mentioned property.
"""))  # Example text
     # Fix for proxy compatibility
    
    # Test cases
    # test_texts = [
    #     "123 Main Street, New York, NY 10001. 2 bedroom apartment, 850 sq ft, built in 1990. Rent: $2500/month.",
    #     "456 Oak Avenue, Los Angeles, CA 90210. Beautiful 3 bedroom house with garden and parking. Contact: john@email.com",
    #     "789 Pine Road, Chicago, IL 60601. Apartment 5B on 3rd floor. 1200 sq ft, 2 bathrooms, central heating."
    # ]
    
    # for text in test_texts:
    #     print(f"\nTesting: {text}")
    #     result = extractor.extract_address_from_text(text)
    #     print(json.dumps(result, indent=2))
