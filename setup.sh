#!/bin/bash
set -e
mkdir -p "$(dirname "README.md")"
cat > "README.md" <<'NEXUS_EOF'
# NEXUS VR - Etapa 1 (base do app)

Inclui: projeto Gradle, CameraX com preview da câmera frontal, tela de configurações
(sensibilidade, IPD, campo de visão, modo celular fraco) salvas localmente.
Ainda NÃO inclui: rastreamento de mãos, interface VR, sensores, modo headset (próximas etapas).

## Compilar no PC
Abra a pasta no Android Studio e clique em Run, ou Build > Build APK.

## Compilar na nuvem (GitHub Actions, grátis)
Veja o workflow em .github/workflows/build.yml. O APK sai em Actions > Artifacts.
NEXUS_EOF
mkdir -p "$(dirname "build.gradle.kts")"
cat > "build.gradle.kts" <<'NEXUS_EOF'
plugins {
    id("com.android.application") version "8.5.2" apply false
    id("org.jetbrains.kotlin.android") version "1.9.24" apply false
}
NEXUS_EOF
mkdir -p "$(dirname "gradle.properties")"
cat > "gradle.properties" <<'NEXUS_EOF'
org.gradle.jvmargs=-Xmx2g -Dfile.encoding=UTF-8
android.useAndroidX=true
kotlin.code.style=official
NEXUS_EOF
mkdir -p "$(dirname "settings.gradle.kts")"
cat > "settings.gradle.kts" <<'NEXUS_EOF'
pluginManagement {
    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}
dependencyResolutionManagement {
    repositoriesMode.set(RepositoriesMode.FAIL_ON_PROJECT_REPOS)
    repositories {
        google()
        mavenCentral()
    }
}
rootProject.name = "NexusVR"
include(":app")
NEXUS_EOF
mkdir -p "$(dirname "app/build.gradle.kts")"
cat > "app/build.gradle.kts" <<'NEXUS_EOF'
plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
}

android {
    namespace = "com.nexusvr.app"
    compileSdk = 34

    defaultConfig {
        applicationId = "com.nexusvr.app"
        minSdk = 26
