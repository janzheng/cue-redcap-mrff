package ecrf

// import "list"
import "strings"


pretreatment: [
    {pre_no_inclusion_msg: #Form & {
        _no_inclusion_msg
    }},
    {pre_primary_infect_diag: #Form & {
        type: "radio"
        label: "Primary infectious diagnosis"
        choices: "1, Endovascular infection | 2, Lung infection | 3, Musculoskeletal infection | 4, Genitourinary infection | 5, Gastrointestinal infection | 6, Intra-abdominal infection (including hepatobiliary) | 7, CNS infection (includes eyes and ears) | 0, Other, please specify (limit text to 50 characters)"
        req: "y"
        branch: _inclusion
    }},
    {pre_primary_infect_other: #Form & {
        type: "notes"
        label: "Other primary infectious diagnosis"
        choices: "1, Endovascular infection | 2, Lung infection | 3, Musculoskeletal infection | 4, Genitourinary infection | 5, Gastrointestinal infection | 6, Intra-abdominal infection (including hepatobiliary) | 7, CNS infection (includes eyes and ears) | 0, Other, please specify (limit text to 50 characters)"
        req: "y"
        branch: _inclusion + " and [pre_primary_infect_diag] = \"0\""
        action: "@CHARLIMIT='50'"
    }},
    {pre_infection_duration: #Form & {
        type: "radio"
        label: "Duration of infection"
        choices: "1, Acute (< 2 weeks) | 2, Subacute (2 weeks-2 months) | 3, Chronic (>2 months)"
        req: "y"
        branch: _inclusion
    }},
    {pre_other_med_surg_diag: #Form & {
        type: "notes"
        label: "Other medical or surgical diagnoses (please list if directly relevant to infection e.g. CF in patient with lung infection)"
        req: "y"
        branch: _inclusion
    }},
    {pre_has_immu_suppr: #Form & {
        type: "yesno"
        label: "Immune suppression"
        req: "y"
        branch: _inclusion
    }},
    {pre_immu_suppr_pri: #Form & {
        type: "radio"
        label: "Primary condition"
        choices: "1, HIV | 2, Malignancy with or without chemotherapy | 3, SOT | 4, HSCT for malignant or non-malignant condition | 5, Drug or biological agent for autoimmune/inflammatory condition, please specify | 0, Other, please specify (limit text to 50 characters)"
        req: "y"
        branch: _inclusion + " and [pre_has_immu_suppr] = \"1\""
    }},
    {pre_immu_suppr_pri_other: #Form & {
        type: "text"
        label: "Other primary condition"
        req: "y"
        branch: _inclusion + " and [pre_immu_suppr_pri] = \"0\""
        action: "@CHARLIMIT='50'"
    }},
    {pre_immu_suppr_acq: #Form & {
        type: "checkbox"
        label: "Acquired condition(s)"
        choices: "1, HIV | 2, Malignancy with or without chemotherapy | 3, SOT | 4, HSCT for malignant or non-malignant condition | 5, Drug or biological agent for autoimmune/inflammatory condition, please specify | 0, Other, please specify (limit text to 50 characters)"
        req: "y"
        branch: _inclusion + " and [pre_has_immu_suppr] = \"1\""
    }},
    {pre_immu_suppr_acq_other: #Form & {
        type: "text"
        label: "Other acquired conditions"
        req: "y"
        branch: _inclusion + " and [pre_immu_suppr_acq(0)] = \"1\""
        action: "@CHARLIMIT='50'"
    }},
    {pre_has_prosthesis: #Form & {
        type: "yesno"
        label: "Prosthesis involved"
        req: "y"
        branch: _inclusion
    }},
    {pre_prosthesis_types: #Form & {
        type: "checkbox"
        label: "Types of prosthesis"
        choices: "1, Prosthetic valve | 2, Vascular shunt | 3, Ventricular assist device | 4, Pacemaker or wires | 5, Prosthetic joint | 6, Spinal rod(s) | 7, Bone plates | 8, Screws or nails | 9, Cochlear implant | 10, Ventriculo-peritoneal or pleural drain | 11, Lumbar drain | 12, Biobrane | 13, Endotracheal tube/tracheostomy | -4, Other endovascular prosthesis | -3, Other osteoarticular prosthesis | -2, Other drain | -1, Other"
        req: "y"
        branch: _inclusion + " and [pre_has_prosthesis] = \"1\""
    }},
    {pre_prosthesis_endo_other: #Form & {
        type: "text"
        label: "Please specify Other endovascular prosthesis"
        req: "y"
        branch: _inclusion + " and [pre_prosthesis_types(-4)] = \"1\""
        action: "@CHARLIMIT='50'"
    }},
    {pre_prosthesis_osteo_other: #Form & {
        type: "text"
        label: "Please specify Other osteoartciular prosthesis"
        req: "y"
        branch: _inclusion + " and [pre_prosthesis_types(-3)] = \"1\""
        action: "@CHARLIMIT='50'"
    }},
    {pre_prosthesis_drain_other: #Form & {
        type: "text"
        label: "Please specify Other drain"
        req: "y"
        branch: _inclusion + " and [pre_prosthesis_types(-2)] = \"1\""
        action: "@CHARLIMIT='50'"
    }},
    {pre_prosthesis_other: #Form & {
        type: "text"
        label: "Please specify Other prosthesis"
        req: "y"
        branch: _inclusion + " and [pre_prosthesis_types(-1)] = \"1\""
        action: "@CHARLIMIT='50'"
    }},
    {"pre_pt_indications": #Form & {
        type: "checkbox"
        label: "Indication for phage therapy"
        choices: "1, Intolerance of standard therapy due to side effects | 2, Failure of standard therapy | 3, Extensive drug resistance profile of target pathogen(s) | 0, Other (to be specified)"
        branch: _inclusion
        req: "y"
    }},
    {"pre_pt_indications_other": #Form & {
        type: "text"
        label: "Specify other indication for phage therapy"
        branch: _inclusion + " and [pre_pt_indications(0)] = '1'"
        req: "y"
        action: "@CHARLIMIT='50'"
    }},
    {pre_num_target_pathogen: #Form & {
        type: "radio"
        section: "Pathogen Section"
        label: "How many target pathogens have been identified?"
        choices: strings.Join([for #,x in _maxPathogens*[""] {"\(#+1),\(#+1)"}], " | ")
        req: "y"
        branch: _inclusion
    }},

    for x, X in _maxPathogens*[""] {
        "pre_pth\(x+1)_descriptive": #Form & {
            type: "descriptive"
            label: "<div class=\"header\">Pathogen \(x+1)</div>"
            branch: _inclusion + " and [pre_num_target_pathogen] > \(x)"
        },
        "pre_pth\(x+1)_target": #Form & {
            type: "radio"
            label: "[Pathogen \(x+1)] Target"
            choices: _pathogenStr
            req: "y"
            branch: _inclusion + " and [pre_num_target_pathogen] > \(x)"
        },
        "pre_pth\(x+1)_species": #Form & {
            type: "text"
            label: "[Pathogen \(x+1)] Full Genus Species"
            req: "y"
            fieldnote: "e.g. Salmonella enterica"
            branch: _inclusion + " and [pre_pth\(x+1)_target] > 10"
            action: "@CHARLIMIT='50'"
        },
        "pre_pth\(x+1)_is_esbl": #Form & {
            type: "yesno"
            label: "[Pathogen \(x+1)] ESBL?"
            req: "y"
            branch: _inclusion + " and ([pre_pth\(x+1)_target] = \"1\" or [pre_pth\(x+1)_target] = \"11\")"
        },
        "pre_pth\(x+1)_is_mrsa": #Form & {
            type: "yesno"
            label: "[Pathogen \(x+1)] MRSA?"
            req: "y"
            branch: _inclusion + " and [pre_pth\(x+1)_target] = \"4\""
        },
        "pre_pth\(x+1)_is_vre": #Form & {
            type: "yesno"
            label: "[Pathogen \(x+1)] VRE?"
            req: "y"
            branch: _inclusion + " and [pre_pth\(x+1)_target] = \"16\""
        },
        "pre_pth\(x+1)_status": #Form & {
            type: "radio"
            label: "[Pathogen \(x+1)] Confirmed or Suspected pathogen?"
            choices: "confirmed, Confirmed (isolated from site of infection) | suspected, Suspected"
            req: "y"
            branch: _inclusion + " and [pre_pth\(x+1)_target]"
        },
        "pre_pth\(x+1)_iso_site": #Form & {
            type: "checkbox"
            label: "[Pathogen \(x+1)] Site(s) of isolation"
            choices: "1, Blood | 2, Sputum/endotracheal aspirate | 3, BAL fluid | 4, Joint aspirate/washout fluid | 5, Non-operative aspirate | 6, CSF | 7, Urine | 11, Intra-operative pus | 12, Intra-operative tissue | 13, Non-operative swab"
            req: "y"
            branch: _inclusion + " and [pre_pth\(x+1)_target]"
        },
        "pre_pth\(x+1)_iso_site_pus": #Form & {
            type: "text"
            label: "[Pathogen \(x+1)] Specify Intra-operative pus site"
            req: "y"
            branch: _inclusion + " and [pre_pth\(x+1)_iso_site(11)] = '1'"
            action: "@CHARLIMIT='50'"
        },
        "pre_pth\(x+1)_iso_site_tissue": #Form & {
            type: "text"
            label: "[Pathogen \(x+1)] Specify Intra-operative tissue type"
            req: "y"
            branch: _inclusion + " and [pre_pth\(x+1)_iso_site(12)] = '1'"
            action: "@CHARLIMIT='50'"
        },
        "pre_pth\(x+1)_iso_site_swab": #Form & {
            type: "text"
            label: "[Pathogen \(x+1)] Specify Non-operative swab site"
            req: "y"
            branch: _inclusion + " and [pre_pth\(x+1)_iso_site(13)] = '1'"
            action: "@CHARLIMIT='50'"
        },
        "pre_pth\(x+1)_has_wgs": #Form & {
            type: "yesno"
            label: "[Pathogen \(x+1)] Is WGS data available?"
            req: "y"
            branch: _inclusion + " and [pre_pth\(x+1)_target]"
        },
        "pre_pth\(x+1)_wgs_loc": #Form & {
            type: "notes"
            label: "[Pathogen \(x+1)] Where is the WGS data stored?"
            branch: _inclusion + " and [pre_pth\(x+1)_has_wgs] = '1'"
            req: "y"
        },
        "pre_pth\(x+1)_has_isolate": #Form & {
            type: "yesno"
            label: "[Pathogen \(x+1)] Is the isolate available for further testing?"
            branch: _inclusion + " and [pre_pth\(x+1)_target]"
            req: "y"
        },
        "pre_pth\(x+1)_isoloc": #Form & {
            type: "notes"
            label: "[Pathogen \(x+1)] Where is the isolate stored?"
            branch: _inclusion + " and [pre_pth\(x+1)_has_isolate] = '1'"
            req: "y"
        },
    },



    // 
    // Pre-treatment - phages
    // — user-entered phages or pre-defined enums? 
    // 

    {pre_num_phage: #Form & {
        type: "radio"
        section: "Phages"
        label: "How many phages will be used?"
        choices: strings.Join([for #,x in _maxPhages*[""] {"\(#+1),\(#+1)"}], " | ") + " | -1, Proprietary cocktail | 0, Unable to define separately"
        req: "y"
    }},

    for x, X in _maxPhages*[""] {

        "pre_phage\(x+1)_descriptive": #Form & {
            type: "descriptive"
            label: "<div class=\"header\">Phage \(x+1)</div>"
            branch: _inclusion + " and abs([pre_num_phage]) > \(x)"
        },
        "pre_phage\(x+1)_name": #Form & {
            type: "text"
            label: "[Phage \(x+1)] Phage \(x+1) name or identifier"
            branch: _inclusion + " and abs([pre_num_phage]) > \(x)"
            req: "y"
        },
        "pre_phage\(x+1)_active_target": #Form & {
            type: "radio"
            label: "[Phage \(x+1)] Active against"
            choices: _pathogenStr
            branch: _inclusion + " and abs([pre_num_phage]) > \(x)"
            req: "y"
        },
        "pre_phage\(x+1)_active_tgt_spc": #Form & {
            type: "text"
            label: "[Phage \(x+1)] Active against species name"
            choices: _pathogenStr
            fieldnote: "Enter both genus and species name, e.g. (Pseudomonas aeruginosa)"
            branch: _inclusion + " and abs([pre_phage\(x+1)_active_target]) > 10"
            action: "@CHARLIMIT='50'"
        },
        "pre_phage\(x+1)_eop": #Form & {
            type: "radio"
            label: "[Phage \(x+1)] EOP"
            choices: "1, >= 0.9 | 2, 0.5-0.899 | 3, 0.1-0.499 | 4, <0.1"
            branch: _inclusion + " and abs([pre_num_phage]) > \(x)"
            req: "y"
        },
        "pre_phage\(x+1)_source": #Form & {
            type: "notes"
            label: "[Phage \(x+1)] Source/supplier"
            branch: _inclusion + " and abs([pre_num_phage]) > \(x)"
            req: "y"
        },
        "pre_phage\(x+1)_endotox": #Form & {
            type: "text"
            label: "[Phage \(x+1)] Endotoxin level (XXXX.X EU/mL)"
            validator: "number_1dp"
            branch: _inclusion + " and abs([pre_num_phage]) > \(x)"
            req: "y"
        },
        "pre_phage\(x+1)_has_seq": #Form & {
            type: "yesno"
            label: "[Phage \(x+1)] Is sequencing data for the phage available?"
            branch: _inclusion + " and abs([pre_num_phage]) > \(x)"
            req: "y"
        },
        "pre_phage\(x+1)_seq_loc": #Form & {
            type: "text"
            label: "[Phage \(x+1)] Where is the sequencing data stored?"
            branch: _inclusion + " and (abs([pre_num_phage]) > \(x)) and ([pre_phage\(x+1)_has_seq] = 1)"
            req: "y"
        },
    },
],
