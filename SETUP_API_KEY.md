# 🔑 OpenAI API Key Setup Guide

This guide will help you fix the "error extracting text you must set the api key" error.

## 🚨 Problem
You're seeing this error because the OpenAI API key is not configured in your application.

## ✅ Solution

### Step 1: Get Your OpenAI API Key
1. Go to [OpenAI API Keys](https://platform.openai.com/api-keys)
2. Sign in with your OpenAI account (or create one)
3. Click "Create new secret key"
4. Copy the generated API key

### Step 2: Configure Flutter/Dart Service

**Option A: Quick Setup (Recommended)**
1. Open `lib/services/openai_config.dart`
2. Replace line 5:
   ```dart
   static const String apiKey = 'YOUR_OPENAI_API_KEY_HERE';
   ```
   With your actual API key:
   ```dart
   static const String apiKey = 'sk-your-actual-api-key-here';
   ```

**Option B: Environment Variables (Advanced)**
1. Copy `.env.example` to `.env`:
   ```bash
   cp lib/services/.env.example lib/services/.env
   ```
2. Edit `lib/services/.env` and add your API key:
   ```
   OPENAI_API_KEY=sk-your-actual-api-key-here
   ```
3. Update `openai_config.dart` to use environment variables

### Step 3: Configure Python Service

1. Copy `.env.example` to `.env`:
   ```bash
   cp python_services/.env.example python_services/.env
   ```
2. Edit `python_services/.env` and add your API key:
   ```
   OPENAI_API_KEY=sk-your-actual-api-key-here
   ```

### Step 4: Test Your Setup

**Test Flutter Service:**
```dart
// In your main.dart or wherever you initialize
import 'package:image_picker_demo_flutter/services/openai_service.dart';

void main() {
  try {
    OpenAIService.initialize();
    print("✅ OpenAI API key configured successfully!");
  } catch (e) {
    print("❌ Error: $e");
  }
  runApp(MyApp());
}
```

**Test Python Service:**
```bash
cd python_services
python server.py
```

### Step 5: Verify Everything Works

1. **Flutter**: Run your app and test the address extraction feature
2. **Python**: Test the API endpoint:
   ```bash
   curl -X POST http://localhost:5000/extract-address \
     -H "Content-Type: application/json" \
     -d '{"text": "123 Main St, New York, NY 10001"}'
   ```

## 🔍 Troubleshooting

### Common Issues:

1. **"Invalid API key"**
   - Ensure your API key starts with `sk-`
   - Check for extra spaces or quotes

2. **"API key not found"**
   - Verify the key is correctly placed in the configuration file
   - Restart your development server

3. **"Rate limit exceeded"**
   - You're making too many requests too quickly
   - Add delays between requests or upgrade your OpenAI plan

### Security Notes:
- Never commit your actual API key to version control
- Use environment variables in production
- Consider using a secrets management service for production apps

## 🎯 Quick Checklist
- [ ] Got OpenAI API key from platform.openai.com
- [ ] Updated `lib/services/openai_config.dart` with actual key
- [ ] Updated `python_services/.env` with actual key
- [ ] Tested both services
- [ ] App is working without API key errors

## 📞 Need Help?
If you're still having issues:
1. Double-check your API key is correct
2. Ensure no extra spaces or quotes
3. Restart your development server
4. Check the console for detailed error messages
