# Retail SID — Système d'Information Décisionnel

> Data Warehouse, ETL, Cube OLAP et rapports décisionnels pour l'analyse des ventes retail, construit avec SQL Server (SSMS, SSAS, SSRS).

Projet académique de bout en bout : à partir de 9994 commandes retail brutes (CSV), construction d'un entrepôt de données en schéma étoile, d'un cube OLAP multidimensionnel interrogé en MDX, et de cinq rapports décisionnels — révélant notamment qu'une catégorie de produits ne dégage que 2,5% de marge malgré un fort chiffre d'affaires.

## Contexte

Ce projet reproduit le pipeline décisionnel classique — Extraction, Transformation, Loading, Entrepôt de données, Analyse multidimensionnelle, Restitution, Décision — inspiré des concepts couverts par la certification **Microsoft Fabric DP-600**, mais implémenté intégralement avec la suite **SQL Server on-premise** (SSMS + SSAS + SSRS), sans dépendance à un environnement cloud.

## Architecture

Fichiers CSV (Superstore)
│
▼
Extraction (ETL) — SSMS Import Flat File
│
▼
Data Warehouse — SQL Server (RetailDW)
│
▼
Schéma en étoile (approche Kimball)
│
▼
Cube OLAP — SQL Server Analysis Services (SSAS)
│
▼
Rapports décisionnels — SSRS (requêtes MDX)
│
▼
Prise de décision


## Technologies utilisées

| Composant | Outil |
|---|---|
| Moteur de base de données | SQL Server 2025 (Developer Edition) |
| Client SQL | SQL Server Management Studio (SSMS) |
| Cube OLAP | SQL Server Analysis Services (SSAS), édition Evaluation |
| Rapports décisionnels | SQL Server Reporting Services (SSRS) |
| Environnement de développement | Visual Studio + SQL Server Data Tools (SSDT) |
| Dataset | [Superstore Dataset](https://www.kaggle.com/datasets/ankumagawa/dataset-superstore-20152018) (9994 lignes, 2014–2017) |

## Modélisation dimensionnelle

**Grain** : une ligne de `FactSales` représente une ligne de commande.

**Schéma en étoile** :
                    DimDate
                       │

DimCustomer ───────── FactSales ───────── DimProduct
│
DimRegion
│
DimShipMode


- **Dimensions** : `DimDate`, `DimProduct`, `DimCustomer`, `DimRegion`, `DimShipMode`
- **Table de faits** : `FactSales` (mesures : Sales, Quantity, Discount, Profit)
- **Hiérarchies** : Temps (Year→Quarter→Month→Day), Produit (Category→SubCategory→ProductName), Géographie (Country→Region→State→City)
- **Mesure calculée** : `Marge_Profit = Profit / Sales`

## Structure du dépôt

retail-sid-datawarehouse/
├── sql/ Scripts SQL (création DW, ETL, requêtes décisionnelles)
├── mdx/ Requêtes MDX interrogeant le cube OLAP
├── ssas/ Projet Visual Studio du cube OLAP (SSAS)
├── ssrs/ Projet Visual Studio des rapports décisionnels (SSRS)
├── screenshots/ Captures d'écran (schéma étoile, cube, rapports)
└── docs/ Rapport LaTeX, présentation Beamer, script de soutenance


## Comment reproduire ce projet

1. Installer **SQL Server Developer Edition** + **SSMS**
2. Installer **Visual Studio** + extensions *Analysis Services Projects* et *Reporting Services Projects*
3. Exécuter les scripts du dossier `sql/` dans l'ordre numérique (01 → 06)
4. Importer le dataset Superstore comme table de staging (voir `sql/03_import_staging.md` pour la procédure détaillée)
5. Ouvrir le projet `ssas/RetailDW_Cube` dans Visual Studio, déployer le cube sur une instance Analysis Services
6. Ouvrir le projet `ssrs/RetailDW_Dashboard`, adapter la chaîne de connexion à ton serveur SSAS local, prévisualiser les rapports

## Résultats clés

| Catégorie | Ventes ($) | Profit ($) | Marge |
|---|---:|---:|---:|
| Furniture | 741 999.79 | 18 871.13 | **2.54 %** |
| Office Supplies | 719 046.93 | 122 490.08 | 17.04 % |
| Technology | 836 154.04 | 145 455.35 | 17.40 % |

**Insight principal** : la catégorie *Furniture* génère un chiffre d'affaires comparable aux autres catégories mais une marge quasi nulle — recommandation : revoir la politique de remise ou les coûts d'approvisionnement sur cette catégorie.

| Région | Ventes ($) | Profit ($) |
|---|---:|---:|
| Central | 501 239.78 | 39 706.26 |
| East | 678 781.28 | 91 522.50 |
| South | 391 721.86 | 47 169.48 |
| West | 725 457.84 | 108 418.32 |

## Rapports décisionnels disponibles

1. Vue exécutive (Sales/Profit/Quantity par Catégorie)
2. Ventes par région
3. Top 10 produits
4. Évolution annuelle des ventes
5. Impact des remises sur la marge

## Opérations OLAP démontrées

- **Roll-up** : Day → Month → Year
- **Drill-down** : Year → Quarter → Month → Day
- **Slice** : filtrer sur une dimension (ex. Year = 2016)
- **Dice** : filtrer sur plusieurs dimensions (Year = 2016 ET Region = West)
- **Pivot** : permutation des axes d'analyse


## Auteur

Projet réalisé dans le cadre d'un cours de Systèmes d'Information Décisionnels (SID).
