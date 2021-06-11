/*
import delimited "/Users/paulchagnaud/Desktop/bdd courante.csv", clear case(preserve)

keep if year == 1789

tab source_type

generate base_pas_résumé = 1 if source_type != "Résumé"

replace base_pas_résumé = 0 if source_type == "Résumé"

collapse (sum) value, by (base_pas_résumé export_import)

br 

import delimited "/Users/paulchagnaud/Desktop/bdd courante.csv", clear 

keep if year == 1789

generate base_pas_résumé = 1 if source_type != "Résumé"

replace base_pas_résumé = 0 if source_type == "Résumé"

tab partner_grouping 

drop if partner_grouping == "France"

replace export_import = "Exports" if export_import == "Exportations"

collapse (sum) value, by (base_pas_résumé export_import)

br 

import delimited "/Users/paulchagnaud/Desktop/bdd courante.csv", clear 

keep if year == 1789

generate base_pas_résumé = 1 if source_type != "Résumé"

replace base_pas_résumé = 0 if source_type == "Résumé"

tab partner_grouping 

drop if partner_grouping == "France"

replace export_import = "Exports" if export_import == "Exportations"

collapse (sum) value, by (base_pas_résumé export_import partner_grouping)

br

sort partner_grouping export_import

br 
*/

*-----------------------------------------------------------------------*

* Nous tentons d'identifier quels sont les produits pour lesquels les valeurs des exportations/importations diffèrent d'une base de donnée à l'autre. Ceci va nous permettre d'identifier ainsi que de quantifier les erreurs dans la retranscriptions des données concernant la valeurs des exportations et par importations. Pour cela nous comparons les valeurs des exportations et des importations provenant d'une source résumée et celles provenant d'une source non résumées. * 

import delimited "/Users/paulchagnaud/Desktop/bdd courante.csv", clear  case(preserve)

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

twoway  (scatter log_value0 log_value1 if export_import=="Imports", mlabel(product_sitc_FR)) (line log_value0 log_value0), name(graph3, replace) title("Valeurs résumées VS Valeurs non résumées" " par produit (Imports 1789)") legend(off) xtitle(Source : autre) ytitle(Sources : Résumés) xscale(range(12 20))

graph export /Users/paulchagnaud/StagePaulChagnaud/Valeurs_résumées_VS_Valeurs_non_résumées_par_produit_Imports_1789.png, replace

twoway  (scatter log_value0 log_value1 if export_import=="Exports", mlabel(product_sitc_FR)) (line log_value0 log_value0), name(graph3, replace)  title("Valeurs résumées VS Valeurs non résumées" " par produit (Exports 1789)") legend(off) xtitle(Sources : autres) ytitle(Source Résumé) xscale(range(12 20))

graph export /Users/paulchagnaud/StagePaulChagnaud/Valeurs_résumées_VS_Valeurs_non_résumées_par_produit_Exports_1789.png, replace

*-----------------------------------------------------------------------*

* Nous tentons d'identifier quels sont les partenaires commerciaux pour lesquels les valeurs des exportations/importations diffèrent d'une base de donnée à l'autre. Ceci va nous permettre d'identifier ainsi que de quantifier les erreurs dans la retranscriptions des données concernant la valeurs des exportations et par importations. Pour cela nous comparons les valeurs des exportations et des importations provenant d'une source résumée et celles provenant d'une source non résumées. * 

restore

tab partner_grouping 

drop if partner_grouping == "France"

replace export_import = "Exports" if export_import == "Exportations"

replace partner_grouping = "Outre-mers" if partner_grouping == "Afrique" | partner_grouping == "Asie" | partner_grouping == "Amériques"

collapse (sum) value, by (base_pas_résumé export_import partner_grouping)

sort export_import partner_grouping

format value %15.0fc

reshape wide value, i(partner_grouping export_import) j(base_pas_résumé)

gen log_value0 = log(value0)

gen log_value1 = log(value1)

twoway  (scatter log_value0 log_value1 if export_import=="Imports" & log_value0!=., mlabel(partner_grouping)) (line log_value0 log_value0), name(graph3, replace)  title("Valeurs résumées VS Valeurs non résumées" " par partenaire (Imports 1789)") legend(off) xtitle(Sources : autres) ytitle(Source : Résumé) xscale(range(14 20)) 

graph export /Users/paulchagnaud/StagePaulChagnaud/Valeurs_résumées_VS_Valeurs_non_résumées_par_partenaire_Imports_1789.png, replace

twoway  (scatter log_value0 log_value1 if export_import=="Exports", mlabel(partner_grouping)) (line log_value0 log_value0), name(graph3, replace) title("Valeurs résumées VS Valeurs non résumées" " par partenaire (Exports 1789)") legend(off) xtitle(Sources : autres) ytitle(Source : Résumé) xscale(range(14 20))

graph export /Users/paulchagnaud/StagePaulChagnaud/Valeurs_résumées_VS_Valeurs_non_résumées_par_partenaire_Exports_1789.png, replace 

*-----------------------------------------------------------------------*

* Nous tentons d'identifier quels sont les produits par partenaire commercial pour lesquels les valeurs des exportations/importations diffèrent d'une base de donnée à l'autre. Ceci va nous permettre d'identifier ainsi que de quantifier les erreurs dans la retranscriptions des données concernant la valeurs des  exportés et importés. Pour cela nous comparons les valeurs des exportations et des importations provenant d'une source résumée et celles provenant d'une source non résumées. * 

import delimited "/Users/paulchagnaud/Desktop/bdd courante.csv", clear  case(preserve)

keep if year == 1789

generate base_pas_résumé = 1 if source_type != "Résumé"

replace base_pas_résumé = 0 if source_type == "Résumé"

preserve

tab partner_grouping 

drop if partner_grouping == "France"

replace export_import = "Exports" if export_import == "Exportations"

gen part_x_prod = partner_grouping + " " + product_sitc_FR

collapse (sum) value, by (base_pas_résumé export_import  part_x_prod)

sort export_import part_x_prod

format value %12.0gc

reshape wide value, i(export_import part_x_prod) j(base_pas_résumé)

gen log_value0 = log(value0)

gen log_value1 = log(value1)

gen diff_value = log_value0-log_value1

br

twoway  (scatter log_value0 log_value1 if export_import=="Imports") (line log_value0 log_value0), name(graph3, replace)  title("Valeurs résumées VS Valeurs non résumées" " par partenaire et produit (Imports 1789)") legend(off) xtitle(Sources : autres) ytitle(Source : Résumé) xscale(log) yscale(log)

graph export /Users/paulchagnaud/StagePaulChagnaud/Valeurs_résumées_VS_Valeurs_non_résumées_par_partenaire_et_par_produit_Imports_1789.png, replace

twoway  (scatter log_value0 log_value1 if export_import=="Exports") (line log_value0 log_value0), name(graph3, replace)  title("Valeurs résumées VS Valeurs non résumées" " par partenaire et produit (Exports 1789)") legend(off) xtitle(Sources : autres) ytitle(Source : Résumé) xscale(log) yscale(log)

graph export /Users/paulchagnaud/StagePaulChagnaud/Valeurs_résumées_VS_Valeurs_non_résumées_par_partenaire_et_par_produit_Exports_1789.png, replace

*-----------------------------------------------------------------------*

* À présent nous calculons la différence entre les valeurs des produits par partenaire commercial provenant de la source : Résumé et des autres sources. Puis nous établirons un classement des produits par partenaire commercial pour lesquels la différence de valeurs entre les deux sources est la plus élevée. *  

gen diff_value = log(value0-value1)


br


