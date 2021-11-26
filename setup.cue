package ecrf

// import "list"
import "strings"




_maxPathogens: 5

// NOTE: Currently playing with implementation from one or the other; should probably have
// a selector where you can enter your own and/or enter a custom
_maxPhages: 5 // used for user-entered phages
// used for pre-populated phages from biobank
_phages: ["phage1", "phage2", "phage3", "phage4", "phage5", "phage6", "phage7", "phage8"]
_phagesStr: strings.Join([for f in _phages {"\(f),\(f)"}], " | ")


_sites: [
    "westmd, Westmead Hospital",
    "schn, Sydney Children's Hospitals Network",
    "alfred, The Alfred Hospital",
    "melb_roy, Royal Melbourne Hospital",
    "adel_ctr, Central Adelaide Local",
    "healthnet, Health Network",
    "brisbane_roy, Royal Brisbane and Women's Hospital",
    "queen_ch, Queensland Children's Hospital",
    "fiona, Fiona Stanley Hospital",
    "murdoch, Murdoch",
    "perth_ch, Perth Children's Hospital", 
]
_sitesStr: strings.Join([for #,f in _sites {"\(f)"}], " | ")

_abx: [
    "1, amikacin",
    "2, amoxycillin",
    "3, amoxycillin-clavulanate",
    "4, ampicillin",
    "5, azithromycin",
    "6, aztreonam",
    "7, benzylpenicillin sodium",
    "8, cefaclor",
    "9, cefepime",
    "10, cefotaxime",
    "11, cefoxitin",
    "12, ceftaroline",
    "13, ceftazidime",
    "14, ceftazidime-avibactam",
    "15, ceftriaxone",
    "16, cefuroxime",
    "17, cephalexin",
    "18, cephazolin",
    "19, ciprofloxacin",
    "20, clarithromycin",
    "21, clindamycin",
    "22, clofazimine",
    "23, colistin",
    "24, daptomycin",
    "25, doxycycline",
    "26, ertapenem",
    "27, erythromycin",
    "28, ethambutol",
    "29, flucloxacillin",
    "30, fusidate sodium",
    "31, gentamicin",
    "32, imipenem-cilastatin",
    "33, isoniazid",
    "34, linezolid",
    "35, meropenem",
    "36, metronidazole",
    "37, minocycline",
    "38, moxifloxacin",
    "39, nitazoxanide",
    "40, nitrofurantoin",
    "41, norfloxacin",
    "42, phenoxymethylpenicillin benzathine",
    "43, phenoxymethylpenicillin potassium",
    "44, piperacillin-tazobactam",
    "45, procaine penicillin",
    "46, rifabutin",
    "47, rifampicin",
    "48, rifaximin",
    "49, roxithromycin",
    "50, sulfamethoxazole-trimethoprim",
    "51, teicoplanin",
    "52, tetracycline",
    "53, tigecycline",
    "54, tobramycin",
    "55, trimethoprim",
    "56, vancomycin",
    "0, other",
]
_abxStr: strings.Join([for #,f in _abx {"\(f)"}], " | ")

_pathogen: [
    "1, E. coli",
    "2, P. aeruginosa",
    "3, M. abscessus",
    "4, S. aureus",
    "11, Klebsiella species",
    "12, Acinetobacter species",
    "13, Shigella species",
    "14, Enterobacter species",
    "15, Salmonella species",
    "16, Enterococcus species",
    "17, Other staphylococci",
    "18, Other mycobacteria",
    "19, Other"
]
_pathogenStr: strings.Join([for #,f in _pathogen {"\(f)"}], " | ")


_adminRoutes: [
    "aero, Aerosolised / Nebulised",
    "instl, Instillation",
    "iv, Intravenous (IV)",
    "oral, Oral / Enteral",
    "topic, Topical",
    "other, Other"
]
_adminRouteKeys: [for f in _adminRoutes {strings.Split(f,",")[0]}]
_adminRouteVals: [for f in _adminRoutes {strings.Split(f,",")[1]}]
_adminRoutesStr: strings.Join([for #,f in _adminRoutes {"\(f)"}], " | ")



_no_inclusion_msg: #Form & {
    type: "descriptive"
    label: "<div class=\"rich-text-field-label\"><h3><span style=\"background-color: #e03e2d; color: #ffffff;\">     Patient DOES NOT MEET INCLUSION CRITERIA     </span></h3></div>"
    branch: "[sc_meets_inclusion] < 1"
}
_inclusion: "[sc_meets_inclusion] = \"1\""

