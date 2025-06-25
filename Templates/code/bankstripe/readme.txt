INSTALLATION AND IMPLEMENTATION GUIDE STRIPE FOR FLUTTER
1. step is to install https://pub.dev/packages/flutter_stripe
dart pub add flutter_stripe or just copy the following flutter_stripe: ^11.5.0
http: ^1.2.2

! we also need flutter http

2. you need to update android/app/build.gradle 
change minSdk = flutter.minSdkVersion to minSdk = 21

3. you need to update android/settings.gradle
we need version "1.8.22" apply false (or higher)

4. we need to update android/app/scr/main/res/values/styles.xml
<style name="NormalTheme" parent="@android:style/Theme.Light.NoTitleBar">

this has to become <style name="NormalTheme" parent="Theme.MaterialComponents">

and the same under android/app/scr/main/res/values-right. 
<style name="NormalTheme" parent="Theme.MaterialComponents">

5. make sure that Using an up-to-date Android gradle build tools version: example and an up-to-date gradle version accordingly: example
android/build.gradle

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

rootProject.buildDir = '../build'
subprojects {
    project.buildDir = "${rootProject.buildDir}/${project.name}"
}
subprojects {
    project.evaluationDependsOn(':app')
}

tasks.register("clean", Delete) {
    delete rootProject.buildDir
}


and for the gradle version: 
android/gradle/wrapper/gradle-wrapper.properties

#Mon Nov 13 19:26:48 WET 2023
distributionBase=GRADLE_USER_HOME
distributionPath=wrapper/dists
distributionUrl=https\://services.gradle.org/distributions/gradle-8.9-bin.zip
zipStoreBase=GRADLE_USER_HOME
zipStorePath=wrapper/dists

6. we have to update android/app/src/main/kotlin/com/example/application/MainActivity.kt

package com.example.meineapp.meineapp

import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity()


we have to change FlutterActivity to 

package com.example.meineapp.meineapp

import io.flutter.embedding.android.FlutterFragmentActivity

class MainActivity: FlutterFragmentActivity()

7. create a file under android/app proguard-rules.pro
and add the following content to the file:

-dontwarn com.stripe.android.pushProvisioning.PushProvisioningActivity$g
-dontwarn com.stripe.android.pushProvisioning.PushProvisioningActivityStarter$Args
-dontwarn com.stripe.android.pushProvisioning.PushProvisioningActivityStarter$Error
-dontwarn com.stripe.android.pushProvisioning.PushProvisioningActivityStarter
-dontwarn com.stripe.android.pushProvisioning.PushProvisioningEphemeralKeyProvider

8. after that add the following to android/gradle.properties:

android.enableR8.fullMode=false

9. the following is for IOS !!!

***Still to be updated....

AFTER YOU ARE FINISHED WITH THE SET UP YOU NEED TO DO THE FOLLOWINg:

11.  register your stripe dashboard account. 

12. in lib we create a file constants.dart:

we add the variables 

const String stripePublishableKey = "INSERT PUBLISH KEY ";
const String stripeSecretKey = "INSERT SECRET KEY";







FOR MORE INFORMATION AND A VISUAL GUIDE WATCH THE FOLLOWING: https://www.youtube.com/watch?v=brFIYmoblJU&t=7s
