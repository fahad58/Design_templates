from flask import Flask, request, jsonify
from flask_cors import CORS
import os
import sys
from address_extractor import AddressExtractor

# Initialize Flask app
app = Flask(__name__)
CORS(app)  # Enable CORS for all routes

# Initialize address extractor
address_extractor = AddressExtractor()

@app.route('/extract-address', methods=['POST'])
def extract_address():
    """
    Endpoint to extract address and property information from OCR text.
    
    Expected JSON payload:
    {
        "text": "Raw OCR text from document scanning"
    }
    
    Returns:
    {
        "success": true,
        "data": {...extracted property data...}
    }
    """
    try:
        # Get JSON data from request
        data = request.get_json()
        
        if not data or 'text' not in data:
            return jsonify({
                "success": False,
                "error": "Missing 'text' field in request"
            }), 400
        
        # Extract text from request
        ocr_text = data['text']
        
        if not ocr_text.strip():
            return jsonify({
                "success": False,
                "error": "Empty text provided"
            }), 400
        
        # Process text with address extractor
        extracted_data = address_extractor.extract_address_from_text(ocr_text)
        
        return jsonify({
            "success": True,
            "data": extracted_data
        })
        
    except Exception as e:
        return jsonify({
            "success": False,
            "error": str(e)
        }), 500

@app.route('/health', methods=['GET'])
def health_check():
    """Health check endpoint"""
    return jsonify({
        "status": "healthy",
        "service": "address_extractor"
    })

if __name__ == '__main__':
    # Get port from environment variable or default to 5000
    port = int(os.environ.get('PORT', 5000))
    
    # Run the Flask app
    app.run(host='0.0.0.0', port=port, debug=True)
