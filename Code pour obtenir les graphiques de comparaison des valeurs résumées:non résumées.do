* Nous tentons d'identifier quels sont les produits pour lesquels les valeurs des exportations/importations diffèrent d'une base de donnée à l'autre. Ceci va nous permettre d'identifier ainsi que de quantifier les erreurs dans la retranscriptions des données concernant la valeurs des exportations et des importations. Pour cela nous comparons les valeurs des exportations et des importations provenant d'une source résumée et celles provenant d'une source non résumées. * 

if  "`c(username)'" == "paulchagnaud" import delimited "/Users/paulchagnaud/Desktop/bdd courante.csv", clear  case(preserve)
if  "`c(username)'" == "guillaumedaudin" use "~/Documents/Recherche/Commerce International Français XVIIIe.xls/Balance du commerce/Retranscriptions_Commerce_France/Données Stata/bdd courante.dta", clear

if  "`c(username)'" == "guillaumedaudin" global dir "~/Répertoires Git/StagePaulChagnaud"
if  "`c(username)'" == "paulchagnaud" global dir "~/StagePaulChagnaud/"

* Nous décidons de nous intéresser uniquement aux observations de l'année 1789 et nous choisissons d'exclure les observations pour lesquels la France est un partenaire commercial * 

keep if year == 1789

generate base_pas_résumé = 1 if source_type != "Résumé"

replace base_pas_résumé = 0 if source_type == "Résumé"

preserve

tab partner_grouping 

drop if partner_grouping == "France"

replace export_import = "Exports" if export_import == "Exportations"

collapse (sum) value, by (base_pas_résumé export_import product_sitc_FR)

br

sort export_import product_sitc_FR

br 

format value %12.0gc

br

reshape wide value, i(product_sitc_FR export_import) j(base_pas_résumé)

gen log_value0 = log(value0)

gen log_value1 = log(value1)

* La représentation graphique concernant les importations est la suivante : *

twoway  (scatter log_value0 log_value1 if export_import=="Imports", mlabel(product_sitc_FR)) (line log_value0 log_value0), name(graph3, replace) title("Valeurs résumées VS Valeurs non résumées" " par produit (Imports 1789)") legend(off) xtitle(Source : autre) ytitle(Sources : Résumés) xscale(range(12 20))

graph export "$dir/Valeurs_résumées_VS_Valeurs_non_résumées_par_produit_Imports_1789.png", replace

* La représentation graphique concernant les exportations est la suivante : *

twoway  (scatter log_value0 log_value1 if export_import=="Exports", mlabel(product_sitc_FR)) (line log_value0 log_value0), name(graph3, replace)  title("Valeurs résumées VS Valeurs non résumées" " par produit (Exports 1789)") legend(off) xtitle(Sources : autres) ytitle(Source Résumé) xscale(range(12 20))

graph export "$dir/Valeurs_résumées_VS_Valeurs_non_résumées_par_produit_Exports_1789.png", replace

*-----------------------------------------------------------------------*

* Nous tentons d'identifier quels sont les partenaires commerciaux pour lesquels les valeurs des exportations/importations diffèrent d'une base de donnée à l'autre. Ceci va nous permettre d'identifier ainsi que de quantifier les erreurs dans la retranscriptions des données concernant la valeurs des exportations et par importations. Pour cela nous comparons les valeurs des exportations et des importations provenant d'une source résumée et celles provenant d'une source non résumées. * 

restore

tab partner_grouping 

* Nous décidons de nous intéresser uniquement aux observations de l'année 1789 et nous choisissons d'exclure les observations pour lesquels la France est un partenaire commercial. De plus, nous choisissons d'exclure les observations pour lesquels les produits importés sont des "Monnaies et métaux précieux" puisque ce type de bien ne peut être comptabilisé comme faisant parti des échanges commerciaux entre deux pays * 

drop if partner_grouping == "France"

drop if product_sitc_FR == "Monnaies et métaux précieux"

replace export_import = "Exports" if export_import == "Exportations"

replace partner_grouping = "Outre-mers" if partner_grouping == "Afrique" | partner_grouping == "Asie" | partner_grouping == "Amériques"

collapse (sum) value, by (base_pas_résumé export_import partner_grouping)

sort export_import partner_grouping

format value %15.0fc

reshape wide value, i(partner_grouping export_import) j(base_pas_résumé)

gen log_value0 = log(value0)

gen log_value1 = log(value1)

* La représentation graphique concernant les importations est la suivante : *

twoway  (scatter log_value0 log_value1 if export_import=="Imports" & log_value0!=., mlabel(partner_grouping)) (line log_value0 log_value0), name(graph3, replace)  title("Valeurs résumées VS Valeurs non résumées" " par partenaire (Imports 1789)") legend(off) xtitle(Sources : autres) ytitle(Source : Résumé) xscale(range(14 20)) 

graph export "$dir/Valeurs_résumées_VS_Valeurs_non_résumées_par_partenaire_Imports_1789.png", replace

* La représentation graphique concernant les exportations est la suivante : *

twoway  (scatter log_value0 log_value1 if export_import=="Exports", mlabel(partner_grouping)) (line log_value0 log_value0), name(graph3, replace) title("Valeurs résumées VS Valeurs non résumées" " par partenaire (Exports 1789)") legend(off) xtitle(Sources : autres) ytitle(Source : Résumé) xscale(range(14 20))

graph export "$dir/Valeurs_résumées_VS_Valeurs_non_résumées_par_partenaire_Exports_1789.png", replace 

*-----------------------------------------------------------------------*

* Nous tentons d'identifier quels sont les produits par partenaire commercial pour lesquels les valeurs des exportations/importations diffèrent d'une base de donnée à l'autre. Ceci va nous permettre d'identifier ainsi que de quantifier les erreurs dans la retranscriptions des données concernant la valeurs des  exportés et importés. Pour cela nous comparons les valeurs des exportations et des importations provenant d'une source résumée et celles provenant d'une source non résumées. * 

if  "`c(username)'" == "paulchagnaud" import delimited "/Users/paulchagnaud/Desktop/bdd courante.csv", clear  case(preserve)
if  "`c(username)'" == "guillaumedaudin" use "~/Documents/Recherche/Commerce International Français XVIIIe.xls/Balance du commerce/Retranscriptions_Commerce_France/Données Stata/bdd courante.dta", clear

* Nous décidons de nous intéresser uniquement aux observations de l'année 1789 et nous choisissons d'exclure les observations pour lesquels la France est un partenaire commercial * 

keep if year == 1789

generate base_pas_résumé = 1 if source_type != "Résumé"

replace base_pas_résumé = 0 if source_type == "Résumé"

tab partner_grouping 

drop if partner_grouping == "France"

replace export_import = "Exports" if export_import == "Exportations"

gen part_x_prod = partner_grouping + " " + product_sitc_FR

collapse (sum) value, by (base_pas_résumé export_import  part_x_prod product_sitc_FR partner_grouping)

sort export_import part_x_prod

format value %12.0gc

reshape wide value, i(export_import part_x_prod) j(base_pas_résumé)

gen log_value0 = log(value0)

gen log_value1 = log(value1)

br

* La représentation graphique concernant les importations est la suivante : *

twoway  (scatter log_value0 log_value1 if export_import=="Imports") (line log_value0 log_value0), name(graph3, replace)  title("Valeurs résumées VS Valeurs non résumées" " par partenaire et produit (Imports 1789)") legend(off) xtitle(Sources : autres) ytitle(Source : Résumé) /*xscale(log) yscale(log)*/

graph export "$dir/Valeurs_résumées_VS_Valeurs_non_résumées_par_partenaire_et_par_produit_Imports_1789.png", replace

* La représentation graphique concernant les exportations est la suivante : *

twoway  (scatter log_value0 log_value1 if export_import=="Exports") (line log_value0 log_value0), name(graph3, replace)  title("Valeurs résumées VS Valeurs non résumées" " par partenaire et produit (Exports 1789)") legend(off) xtitle(Sources : autres) ytitle(Source : Résumé) /*xscale(log) yscale(log)*/

graph export "$dir/Valeurs_résumées_VS_Valeurs_non_résumées_par_partenaire_et_par_produit_Exports_1789.png", replace

*-----------------------------------------------------------------------*

* À présent nous calculons la différence entre les valeurs des produits par partenaire commercial provenant de la source : Résumé et des autres sources. Puis nous établissons un classement des produits par partenaire commercial pour lesquels la différence de valeurs entre les deux sources est la plus élevée. *  

gen diff_value_log = log_value0-log_value1
gen diff_value_log_abs = abs(diff_value_log)
gsort - diff_value_log_abs

format value* %15.0fc

br if product_sitc_FR !="Produits agricoles alimentaires des régions de colonisation européenne"


br if product_sitc_FR !="Produits agricoles alimentaires des régions de colonisation européenne" & partner_grouping=="Espagne"


* Classement des 10 produits par partenaire commercial pour lesquels la différence des log des valeurs entre les deux sources est la plus importante *

gsort -diff_value_log 

list diff_value_log part_x_prod in 1/10

br 

* Classement des 10 produits par partenaire commercial pour lesquels la différence des log des valeurs en valeur absolue entre les deux sources est la plus importante *

gsort -diff_value_log_abs

list diff_value_log_abs part_x_prod in 1/10

* Nous calculons la différence des valeurs sans utiliser le log. Nous décidons par ailleurs de remplacer les données manquantes par la valeur : 0. *

replace value0 = 0 if missing(value0)
replace value1 = 1 if missing(value1)

gen diff_value = value0-value1
gen diff_value_abs = abs(diff_value)

format value* %15.0fc

br if product_sitc_FR !="Produits agricoles alimentaires des régions de colonisation européenne"

br if product_sitc_FR !="Produits agricoles alimentaires des régions de colonisation européenne" & partner_grouping=="Espagne"

* Le classement des 10 produits par partenaire commercial pour lesquels la différence des valeurs entre les deux sources est la plus importante est le suivant *

gsort -diff_value

list diff_value part_x_prod in 1/10

br 



* Le classement des 10 produits par partenaire commercial pour lesquels la différence des log des valeurs en valeur absolue entre les deux sources est la plus importante est le suivant *

gsort -diff_value_abs

list diff_value_abs part_x_prod in 1/10 






