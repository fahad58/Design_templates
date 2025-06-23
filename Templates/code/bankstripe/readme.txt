INSTALLATION AND IMPLEMENTATION GUIDE STRIPE FOR FLUTTER
1. step is to install https://pub.dev/packages/flutter_stripe
dart pub add flutter_stripe or just copy the following flutter_stripe: ^11.5.0
http: ^1.2.2

! we also need flutter http

2. you need to update android/app/build.gradle 
change minSdk = flutter.minSdkVersion to minSdk = 21

