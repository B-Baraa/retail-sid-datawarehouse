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

## Documentation complète

- [`docs/rapport_sid.tex`](docs/rapport_sid.tex) — rapport complet (à compiler sur Overleaf)
- [`docs/presentation_sid.tex`](docs/presentation_sid.tex) — présentation Beamer
- [`docs/Script_Soutenance_Orale.pdf`](docs/Script_Soutenance_Orale.pdf) — script de soutenance orale

## Auteur

Projet réalisé dans le cadre d'un cours de Systèmes d'Information Décisionnels (SID).
