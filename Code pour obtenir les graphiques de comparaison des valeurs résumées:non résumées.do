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

twoway  (scatter log_value0 log_value1 if export_import=="Imports", mlabel(product_sitc_FR)) (line log_value0 log_value0), name(graph3, replace) title(valeur résumée VS valeur non résumée) legend(off)

twoway  (scatter log_value0 log_value1 if export_import=="Exports", mlabel(product_sitc_FR)) (line log_value0 log_value0), name(graph3, replace) title(valeur résumée VS valeur non résumée) legend(off)

import delimited "/Users/paulchagnaud/Desktop/bdd courante.csv", clear  case(preserve)

keep if year == 1789

generate base_pas_résumé = 1 if source_type != "Résumé"

replace base_pas_résumé = 0 if source_type == "Résumé"

tab partner_grouping 

drop if partner_grouping == "France"

replace export_import = "Exports" if export_import == "Exportations"

collapse (sum) value, by (base_pas_résumé export_import partner_grouping)

br

sort export_import partner_grouping

br 

format value %12.0gc

br

reshape wide value, i(partner_grouping export_import) j(base_pas_résumé)

gen log_value0 = log(value0)

gen log_value1 = log(value1)

twoway  (scatter log_value0 log_value1 if export_import=="Imports", mlabel(partner_grouping)) (line log_value0 log_value0), name(graph3, replace) title(valeur résumée VS valeur non résumée) legend(off)

twoway  (scatter log_value0 log_value1 if export_import=="Exports", mlabel(partner_grouping)) (line log_value0 log_value0), name(graph3, replace) title(valeur résumée VS valeur non résumée) legend(off)

