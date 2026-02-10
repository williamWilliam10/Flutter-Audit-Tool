# Flutter Audit Tool 🚀

![Flutter](https://img.shields.io/badge/Flutter-02569B?logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?logo=dart&logoColor=white)
![License](https://img.shields.io/badge/license-MIT-green)

**Automated Security & Quality Audit for Flutter Applications**

## 📋 Description

Outil d'automatisation d'audit technique destiné aux applications Flutter / Dart. Il permet de générer rapidement un rapport complet couvrant la qualité du code, la sécurité des dépendances et la couverture de tests.

L'outil est pensé pour être simple à utiliser, reproductible et exploitable dans un contexte audit, CI/CD ou revue de code.

## ✨ Fonctionnalités

- 🔍 Analyse statique du code Flutter/Dart
- 🔐 Vérification des dépendances et de leur état
- 🧪 Exécution des tests unitaires avec mesure de couverture
- 📊 Génération automatique de rapports HTML lisibles
- ⚡ Exécution en une seule commande

## 🛠️ Technologies utilisées

- Flutter SDK
- Dart
- Pana (analyse statique)
- Pandoc (génération de rapports)
- LCOV (couverture de tests)

## 📦 Installation

### Prérequis

Avant de lancer l'audit, assurez-vous que les outils suivants sont installés sur votre machine (Kali Linux ou autre distribution Linux) :

**Flutter SDK**
- Installé et correctement configuré dans le `PATH`

**Pandoc**
- Utilisé pour convertir les rapports en HTML
```bash
sudo apt install pandoc
```

**LCOV**
- Utilisé pour la génération des rapports de couverture de tests
```bash
sudo apt install lcov
```

### Installation du script

1. Cloner le repository
```bash
https://github.com/williamWilliam10/Flutter-Audit-Tool.git
cd flutter-audit-tool
```

2. Placer le fichier `audit_flutter.sh` à la racine de votre projet Flutter, au même niveau que `pubspec.yaml`

3. Attribution des permissions
```bash
chmod +x audit_flutter.sh
```

## 🚀 Utilisation

### Lancement de l'audit
```bash
./audit_flutter.sh
```

L'outil s'exécute en une seule commande et génère automatiquement tous les rapports nécessaires.

## 📂 Livrables générés

Un dossier `rapports_audit/` est créé automatiquement et contient :

- **rapport_qualite_final.html** - Rapport détaillé (Pana) incluant la qualité du code et l'état des dépendances
- **couverture_html/** - Rapport de couverture de tests interactif (ouvrir `index.html`)

## 🔍 Détails techniques

- **Analyse statique** via Pana
- **Analyse de sécurité** (licences, compatibilité)
- **Tests unitaires** avec couverture :
```bash
flutter test --coverage
```

- **Reporting HTML** via Pandoc + Water.css

## 👥 Auteur

- **William Lowe** - [lowewilliam.com](https://lowewilliam.com)
 pour plus de détails.

## 📄 License
Ce projet est sous licence MIT. Voir le fichier [LICENSE](LICENSE) pour plus de détails.
---

⭐️ Si cet outil vous a aidé, n'hésitez pas à lui donner une étoile !
