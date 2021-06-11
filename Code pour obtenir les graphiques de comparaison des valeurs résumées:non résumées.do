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

twoway  (scatter log_value0 log_value1 if export_import=="Imports", mlabel(product_sitc_FR)) (line log_value0 log_value0), name(graph3, replace) title("Valeurs résumées VS Valeurs non résumées" " par produit (Imports 1789)") legend(off) xtitle(Base non résumée) ytitle(Base résumée)

graph export /Users/paulchagnaud/StagePaulChagnaud/Valeurs_résumées_VS_Valeurs_non_résumées_par_produit_Imports_1789.png, replace

twoway  (scatter log_value0 log_value1 if export_import=="Exports", mlabel(product_sitc_FR)) (line log_value0 log_value0), name(graph3, replace)  title("Valeurs résumées VS Valeurs non résumées" " par produit (Exports 1789)") legend(off) xtitle(Base non résumée) ytitle(Base résumée)

graph export /Users/paulchagnaud/StagePaulChagnaud/Valeurs_résumées_VS_Valeurs_non_résumées_par_produit_Exports_1789.png, replace

*---------------------
restore


tab partner_grouping 

drop if partner_grouping == "France"

replace export_import = "Exports" if export_import == "Exportations"


replace partner_grouping = "Outre-mers" if partner_grouping == "Afrique" | partner_grouping == "Asie" | partner_grouping == "Amériques"


collapse (sum) value, by (base_pas_résumé export_import partner_grouping)

sort export_import partner_grouping

format value %12.0gc




reshape wide value, i(partner_grouping export_import) j(base_pas_résumé)

gen log_value0 = log(value0)

gen log_value1 = log(value1)



twoway  (scatter log_value0 log_value1 if export_import=="Imports", mlabel(partner_grouping)) (line log_value0 log_value0), name(graph3, replace)  title("Valeurs résumées VS Valeurs non résumées" " par partenaire (Imports 1789)") legend(off) xtitle(Base non résumée) ytitle(Base résumée)

graph export /Users/paulchagnaud/StagePaulChagnaud/Valeurs_résumées_VS_Valeurs_non_résumées_par_partenaire_Imports_1789.png, replace

twoway  (scatter log_value0 log_value1 if export_import=="Exports", mlabel(partner_grouping)) (line log_value0 log_value0), name(graph3, replace) title("Valeurs résumées VS Valeurs non résumées" " par partenaire (Exports 1789)") legend(off) xtitle(Base non résumée) ytitle(Base résumée)

graph export /Users/paulchagnaud/StagePaulChagnaud/Valeurs_résumées_VS_Valeurs_non_résumées_par_partenaire_Exports_1789.png, replace 



