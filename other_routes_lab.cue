package ecrf

import "strings"



// Other Routes - Lab  
// This page should appear if any other routes of administration other than IV or oral/enteral selected from the treatment generic page
// 
// - [IV, oral/enteral] phage therapy NOT selected from the treatment page (_trivcl_noninclusion)
// these rely on Repeatable Instruments (Project Settings > Enable Repeatable Instruments)


other_routes_lab: [
  {othro_no_inclusion_msg: #Form & {
      _no_inclusion_msg
  }},
  {othro_descriptive: #Form & {
    type: "descriptive"
    label: "<div class=\"header\"><h2>Other Routes - Lab</h2><br><br>This page opens when non IV and/or oral/enteral phage therapy are selected from the Treatment page. </div>"
  }},
  {othro_noninclusion: #Form & {
    type: "descriptive"
    label: "<div class=\"header\">This instrument is for patients who are NOT receiving IV or non-oral/enteral phage therapy</div>"
    branch: "\(_trivcl_inclusion)"
  }},
  {othro_iv: #Form & {
    type: "yesno"
    label: "Is IV phage also being administered (yes/no)?"
    branch: "\(_inclusion) and \(_trivcl_noninclusion)"
    req: "y"
  }},
  {othro_day: #Form & {
    type: "radio"
    label: "Select clinical day of treatment:"
    choices: strings.Join([for _,x in [0,2,4,8,15,29] { "\(x), D\(x)" }], " | ") + " | other,Other Day (If additional relevant testing performed on any other day)"
    branch: "\(_inclusion) and \(_trivcl_inclusion) and [othro_iv] = \"1\""
    req: "y"
  }},
  {othro_other_day: #Form & {
    type: "text"
    label: "Enter day of treatment (enter a number between 0-29, inclusive)"
    validator: "integer"
    branch: "[othro_day] = 'other'"
    req: "y"
  }},
  {othro_other_day_test: #Form & {
    type: "notes"
    label: "Test performed for day [othro_other_day]"
    branch: "[othro_other_day] >= 0"
    req: "y"
  }},
  {othro_other_day_result: #Form & {
    type: "notes"
    label: "Result for day [othro_other_day]"
    branch: "[othro_other_day] >= 0"
    req: "y"
  }},



  // CRP - C-reactive Protein
  {othro_crp: #Form & {
    section: "CRP results"
    type: "text"
    label: "[[othro_day]] CRP result (XXX.X mg/mL)"
    validator: "number_1dp"
    branch: "[othro_day] >= 0 and [othro_day] and [othro_day] != 11" // skip day 11
  }},
  {othro_crp_na: #Form & {
    type: "checkbox"
    label: "[[othro_day]] Are CRP results NOT available?"
    choices: "na, CRP results NOT available for [[othro_day]]"
    branch: "[othro_crp] = '' and [othro_day] and [othro_day] >= 0 and [othro_day] != 11" // skip day 11
    req: "y"
  }},




  // FBC all within normal range (yes/no)?
  {othro_fbc_isnorm: #Form & {
    section: "FBC"
    type: "yesno"
    label: "[[othro_day]] FBC all within normal range (yes/no)?"
    branch: "[othro_day] and [othro_day] >= 0" // skip day 11
  }},
  // if "No" to FBC, do the following (col I-R)
    // Hb result
    {othro_hb: #Form & {
      section: "Hb results"
      type: "text"
      label: "[[othro_day]] Hb result (XXX g/L)"
      validator: "integer"
      branch: "[othro_fbc_isnorm] = '0' and [othro_day] and [othro_day] >= 0" // skip day 11
    }},
    {othro_hb_na: #Form & {
      type: "checkbox"
      label: "[[othro_day]] Are Hb results NOT available?"
      choices: "na, Hb results NOT available for [[othro_day]]"
      branch: "[othro_hb] = '' and [othro_fbc_isnorm] = '0' and [othro_day] and [othro_day] >= 0" // skip day 11
      req: "y"
    }},

    // Platelet count
    {othro_platelet: #Form & {
      section: "Platelet count"
      type: "text"
      label: "[[othro_day]] Platelet result (XXX x10^9/L)"
      validator: "integer"
      branch: "[othro_fbc_isnorm] = '0' and [othro_day] and [othro_day] >= 0" // skip day 11
    }},
    {othro_platelet_na: #Form & {
      type: "checkbox"
      label: "[[othro_day]] Are Platelet count results NOT available?"
      choices: "na, Platelet count results NOT available for [[othro_day]]"
      branch: "[othro_platelet] = '' and [othro_fbc_isnorm] = '0' and [othro_day] and [othro_day] >= 0" // skip day 11
      req: "y"
    }},
    
    // WCC
    {othro_wcc: #Form & {
      section: "WCC"
      type: "text"
      label: "[[othro_day]] WCC (XXX x10^9/L)"
      validator: "integer"
      branch: "[othro_fbc_isnorm] = '0' and [othro_day] and [othro_day] >= 0" // skip day 11
    }},
    {othro_wcc_na: #Form & {
      type: "checkbox"
      label: "[[othro_day]] Are WCC results NOT available?"
      choices: "na, WCC results NOT available for [[othro_day]]"
      branch: "[othro_wcc] = '' and [othro_fbc_isnorm] = '0' and [othro_day] and [othro_day] >= 0" // skip day 11
      req: "y"
    }},

    // Neutrophil count
    {othro_neutrophil: #Form & {
      section: "Neutrophil count"
      type: "text"
      label: "[[othro_day]] Neutrophil count (XX.X x10^9/L)"
      validator: "number_1dp"
      branch: "[othro_fbc_isnorm] = '0' and [othro_day] and [othro_day] >= 0" // skip day 11
    }},
    {othro_neutrophil_na: #Form & {
      type: "checkbox"
      label: "[[othro_day]] Are neutrophil count results NOT available?"
      choices: "na, neutrophil count results NOT available for [[othro_day]]"
      branch: "[othro_neutrophil] = '' and [othro_fbc_isnorm] = '0' and [othro_day] and [othro_day] >= 0" // skip day 11
      req: "y"
    }},

    // Lymphocyte count
    {othro_lymphocite: #Form & {
      section: "Lymphocyte count"
      type: "text"
      label: "[[othro_day]] Lymphocyte count (XX.X x10^9/L)"
      validator: "number_1dp"
      branch: "[othro_fbc_isnorm] = '0' and [othro_day] and [othro_day] >= 0" // skip day 11
    }},
    {othro_lymphocite_na: #Form & {
      type: "checkbox"
      label: "[[othro_day]] Are Lymphocyte count results NOT available?"
      choices: "na, Lymphocyte count results NOT available for [[othro_day]]"
      branch: "[othro_lymphocite] = '' and [othro_fbc_isnorm] = '0' and [othro_day] and [othro_day] >= 0" // skip day 11
      req: "y"
    }},








  // LFTs
  {othro_lft_isnorm: #Form & {
    type: "yesno"
    label: "[[othro_day]] LFTs all within normal range (yes/no)?"
    branch: "[othro_day] and [othro_day] >= 0 and [othro_day] != 11"
    req: "y"
  }},
    // if No to LFTs:

    // Albumin
    {othro_albumin: #Form & {
      section: "Albumin"
      type: "text"
      label: "[[othro_day]] Albumin (XX g/L)"
      validator: "integer"
      branch: "[othro_lft_isnorm] = '0' and [othro_day] and [othro_day] >= 0 and [othro_day] != 11"
    }},
    {othro_albumin_na: #Form & {
      type: "checkbox"
      label: "[[othro_day]] Is Albumin not available?"
      choices: "na, Albumin results are NOT available for [[othro_day]]"
      branch: "[othro_albumin] = '' and [othro_lft_isnorm] = '0' and [othro_day] and [othro_day] >= 0 and [othro_day] != 11"
      req: "y"
    }},

    // AST
    {othro_ast: #Form & {
      section: "AST"
      type: "text"
      label: "[[othro_day]] AST (XXXX U/L)"
      validator: "integer"
      branch: "[othro_lft_isnorm] = '0' and [othro_day] and [othro_day] >= 0 and [othro_day] != 11"
    }},
    {othro_ast_na: #Form & {
      type: "checkbox"
      label: "[[othro_day]] Is AST not available?"
      choices: "na, AST results are NOT available for [[othro_day]]"
      branch: "[othro_ast] = '' and [othro_lft_isnorm] = '0' and [othro_day] and [othro_day] >= 0 and [othro_day] != 11"
      req: "y"
    }},

    // ALT
    {othro_alt: #Form & {
      section: "ALT"
      type: "text"
      label: "[[othro_day]] ALT (XXXX U/L)"
      validator: "integer"
      branch: "[othro_lft_isnorm] = '0' and [othro_day] and [othro_day] >= 0 and [othro_day] != 11"
    }},
    {othro_alt_na: #Form & {
      type: "checkbox"
      label: "[[othro_day]] Is ALT not available?"
      choices: "na, ALT results are NOT available for [[othro_day]]"
      branch: "[othro_alt] = '' and [othro_lft_isnorm] = '0' and [othro_day] and [othro_day] >= 0 and [othro_day] != 11"
      req: "y"
    }},

    // GGT
    {othro_ggt: #Form & {
      section: "GGT"
      type: "text"
      label: "[[othro_day]] GGT (XXXX U/L)"
      validator: "integer"
      branch: "([othro_lft_isnorm] = '0') and [othro_day] and [othro_day] >= 0 and [othro_day] != 11"
    }},
    {othro_ggt_na: #Form & {
      type: "checkbox"
      label: "[[othro_day]] Is GGT not available?"
      choices: "na, GGT results are NOT available for [[othro_day]]"
      branch: "[othro_ggt] = '' and ([othro_lft_isnorm] = '0') and [othro_day] and [othro_day] >= 0 and [othro_day] != 11"
      req: "y"
    }},

    // ALP
    {othro_alp: #Form & {
      section: "ALP"
      type: "text"
      label: "[[othro_day]] ALP (XXXX U/L)"
      validator: "integer"
      branch: "[othro_lft_isnorm] = '0' and [othro_day] and [othro_day] >= 0 and [othro_day] != 11"
    }},
    {othro_alp_na: #Form & {
      type: "checkbox"
      label: "[[othro_day]] Is ALP not available?"
      choices: "na, ALP results are NOT available for [[othro_day]]"
      branch: "[othro_alp] = '' and [othro_lft_isnorm] = '0' and [othro_day] and [othro_day] >= 0 and [othro_day] != 11"
      req: "y"
    }},









  // UECs
  {othro_uec_isnorm: #Form & {
    type: "yesno"
    label: "[[othro_day]] UECs all within normal range (yes/no)?"
    branch: "[othro_day] and [othro_day] >= 0 and [othro_day] != 11"
    req: "y"
  }},
    // if No to UECs:

    // Sodium
    {othro_sodium: #Form & {
      section: "Sodium"
      type: "text"
      label: "[[othro_day]] Sodium (XXX mmol/L)"
      validator: "integer"
      branch: "[othro_uec_isnorm] = '0' and [othro_day] and [othro_day] >= 0 and [othro_day] != 11"
    }},
    {othro_sodium_na: #Form & {
      type: "checkbox"
      label: "[[othro_day]] Is Sodium not available?"
      choices: "na, Sodium results are NOT available for [[othro_day]]"
      branch: "[othro_sodium] = '' and [othro_uec_isnorm] = '0' and [othro_day] and [othro_day] >= 0 and [othro_day] != 11"
      req: "y"
    }},

    // Urea
    {othro_urea: #Form & {
      section: "Urea"
      type: "text"
      label: "[[othro_day]] Urea (XX.X mmol/L)"
      validator: "number_1dp"
      branch: "[othro_uec_isnorm] = '0' and [othro_day] and [othro_day] >= 0 and [othro_day] != 11"
    }},
    {othro_urea_na: #Form & {
      type: "checkbox"
      label: "[[othro_day]] Is Urea not available?"
      choices: "na, Urea results are NOT available for [[othro_day]]"
      branch: "[othro_urea] = '' and [othro_uec_isnorm] = '0' and [othro_day] and [othro_day] >= 0 and [othro_day] != 11"
      req: "y"
    }},

    // Creatinine
    {othro_creatinine: #Form & {
      section: "Creatinine"
      type: "text"
      label: "[[othro_day]] Creatinine (XXX umol/L)"
      validator: "integer"
      branch: "[othro_uec_isnorm] = '0' and [othro_day] and [othro_day] >= 0 and [othro_day] != 11"
    }},
    {othro_creatinine_na: #Form & {
      type: "checkbox"
      label: "[[othro_day]] Is Creatinine not available?"
      choices: "na, Creatinine results are NOT available for [[othro_day]]"
      branch: "[othro_creatinine] = '' and [othro_uec_isnorm] = '0' and [othro_day] and [othro_day] >= 0 and [othro_day] != 11"
      req: "y"
    }},









  // these question are per phage (as entered in pre-treatment)

  // user-entered phages; selected route is PER PHAGE (e.g. only iv and oral show up in this list), as entered in treatment
  for y, Y in _maxPhages*[""] {
    "othro_ph\(y)": #Form & {
        type: "descriptive"
        label: "<div class=\"header\">Phage: \"[pre_phage\(y+1)_name]\"</div>"
        branch: "([tre_ph_\(y)_rt(iv)] = '1' or [tre_ph_\(y)_rt(oral)] = '1')" + " and [pre_phage\(y+1)_name] and [pre_phage\(y+1)_name] !='' and [pre_num_phage]>\(y) and [othro_day] and ([othro_day] = 0 or [othro_day] = 15 or [othro_day] = 29)"
    },
    "othro_ph_\(y)_anti": #Form & {
        type: "yesno"
        label: "[Phage: \"[pre_phage\(y+1)_name]\"] Antiphage antibodies tested (yes/no)?"
        branch: "([tre_ph_\(y)_rt(iv)] = '1' or [tre_ph_\(y)_rt(oral)] = '1')" + " and [pre_phage\(y+1)_name] and [pre_phage\(y+1)_name] !='' and [pre_num_phage]>\(y) and [othro_day] and ([othro_day] = 0 or [othro_day] = 15 or [othro_day] = 29)"
        req: "y"
    },
    "othro_ph_\(y)_anti_assay": #Form & {
        type: "checkbox"
        label: "[Phage: \"[pre_phage\(y+1)_name]\"] Assay types used?"
        choices: "neutralising,Neutralising antibody assay | igmigg, IgM/IgG assay | other,Other please specify"
        branch: "[othro_ph_\(y)_anti]='1' and ([tre_ph_\(y)_rt(iv)] = '1' or [tre_ph_\(y)_rt(oral)] = '1')" + " and [pre_phage\(y+1)_name] and [pre_phage\(y+1)_name] !='' and [pre_num_phage]>\(y) and [othro_day] and ([othro_day] = 0 or [othro_day] = 15 or [othro_day] = 29)"
        req: "y"
    },
    "othro_ph_\(y)_anti_assay_oth": #Form & {
        type: "text"
        label: "[Phage: \"[pre_phage\(y+1)_name]\"] Other assay type"
        branch: "[othro_ph_\(y)_anti]='1' and [othro_ph_\(y)_anti_assay(other)]='1' and ([tre_ph_\(y)_rt(iv)] = '1' or [tre_ph_\(y)_rt(oral)] = '1')" + " and [pre_phage\(y+1)_name] and [pre_phage\(y+1)_name] !='' and [pre_num_phage]>\(y) and [othro_day] and ([othro_day] = 0 or [othro_day] = 15 or [othro_day] = 29)"
        req: "y"
        action: "@CHARLIMIT='50'"
    },
    "othro_ph_\(y)_anti_res": #Form & {
        type: "notes"
        label: "[Phage: \"[pre_phage\(y+1)_name]\"] Antiphage antibody result"
        branch: "[othro_ph_\(y)_anti]='1' and ([tre_ph_\(y)_rt(iv)] = '1' or [tre_ph_\(y)_rt(oral)] = '1')" + " and [pre_phage\(y+1)_name] and [pre_phage\(y+1)_name] !='' and [pre_num_phage]>\(y) and [othro_day] and ([othro_day] = 0 or [othro_day] = 15 or [othro_day] = 29)"
        req: "y"
    },
  },


  for x, X in _maxPathogens*[""] {
    "othro_pth\(x+1)_descriptive": #Form & {
        type: "descriptive"
        label: "<div class=\"header\">Pathogen \(x+1) \"[pre_pth\(x+1)_target]\"</div>"
        branch: "[pre_num_target_pathogen] > \(x) and [othro_day] and ([othro_day] = 0 or [othro_day] = 4 or [othro_day] = 8 or [othro_day] = 15 or [othro_day] = 29)"
    },
    "othro_pth_\(x+1)_iso": #Form & {
        type: "radio"
        label: "[Pathogen \(x+1): [pre_pth\(x+1)_target]] Pathogen isolated from site of infection?"
        choices: "isolated,Isolated | not_isolated, Not isolated | na, Not performed"
        branch: "[pre_num_target_pathogen] > \(x) and [othro_day] and ([othro_day] = 0 or [othro_day] = 4 or [othro_day] = 8 or [othro_day] = 15 or [othro_day] = 29)"
        req: "y"
    },
    "othro_pth_\(x+1)_iso_na_desc": #Form & {
        type: "notes"
        label: "[Pathogen \(x+1): [pre_pth\(x+1)_target]] How come isolation wasn't performed?"
        branch: "[othro_pth_\(x+1)_iso] = 'na' and [pre_num_target_pathogen] > \(x) and [othro_day] and ([othro_day] = 0 or [othro_day] = 4 or [othro_day] = 8 or [othro_day] = 15 or [othro_day] = 29)"
        req: "y"
    },
    "othro_pth_\(x+1)_iso_lyt_conf": #Form & {
        type: "radio"
        label: "[Pathogen \(x+1): [pre_pth\(x+1)_target]] Is ongoing lytic activity of phage(s) confirmed?"
        choices: "1,Yes | 0,Not tested | resistance,Evidence of anti-phage resistance"
        branch: "[othro_pth_\(x+1)_iso] = 'isolated' and [pre_num_target_pathogen] > \(x) and [othro_day] and ([othro_day] = 4 or [othro_day] = 8 or [othro_day] = 15 or [othro_day] = 29)"
        req: "y"
    },
    "othro_pth_\(x+1)_iso_lyt_conf_r_d": #Form & {
        type: "notes"
        label: "[Pathogen \(x+1): [pre_pth\(x+1)_target]] Please specify anti-phage resistance activity"
        branch: "[othro_pth_\(x+1)_iso_lyt_conf] = 'resistance' and [othro_pth_\(x+1)_iso] = 'isolated' and [pre_num_target_pathogen] > \(x) and [othro_day] and ([othro_day] = 4 or [othro_day] = 8 or [othro_day] = 15 or [othro_day] = 29)"
        req: "y"
    },
    "othro_pth_\(x+1)_iso_oth": #Form & {
        type: "radio"
        label: "[Pathogen \(x+1): [pre_pth\(x+1)_target]] Pathogen isolated from other site?"
        choices: "isolated,Isolated | not_isolated, Not isolated | na, Not performed"
        branch: "[pre_num_target_pathogen] > \(x) and [othro_day] and ([othro_day] = 0 or [othro_day] = 4 or [othro_day] = 8 or [othro_day] = 15 or [othro_day] = 29)"
        req: "y"
    },
    "othro_pth_\(x+1)_iso_oth_site": #Form & {
        type: "text"
        label: "[Pathogen \(x+1): [pre_pth\(x+1)_target]] Specify other site where pathogen was isolated"
        branch: "[othro_pth_\(x+1)_iso_oth] = 'isolated' and [pre_num_target_pathogen] > \(x) and [othro_day] and ([othro_day] = 0 or [othro_day] = 4 or [othro_day] = 8 or [othro_day] = 15 or [othro_day] = 29)"
        req: "y"
    },
    "othro_pth_\(x+1)_iso_oth_lyt_conf": #Form & {
        type: "radio"
        label: "[Pathogen \(x+1): [pre_pth\(x+1)_target]] Is ongoing lytic activity of phage(s) confirmed at [othro_pth_\(x+1)_iso_oth_site]?"
        choices: "1,Yes | 0,Not tested | resistance,Evidence of anti-phage resistance"
        branch: "[othro_pth_\(x+1)_iso_oth_site] and [othro_pth_\(x+1)_iso] = 'isolated' and [pre_num_target_pathogen] > \(x) and [othro_day] and ([othro_day] = 4 or [othro_day] = 8 or [othro_day] = 15 or [othro_day] = 29)"
        req: "y"
    },
    "othro_pth_\(x+1)_iso_oth_lyt_conf_r_d": #Form & {
        type: "notes"
        label: "[Pathogen \(x+1): [pre_pth\(x+1)_target]] Please specify anti-phage resistance activity"
        branch: "[othro_pth_\(x+1)_iso_oth_lyt_conf] = 'resistance' and [othro_pth_\(x+1)_iso] = 'isolated' and [pre_num_target_pathogen] > \(x) and [othro_day] and ([othro_day] = 4 or [othro_day] = 8 or [othro_day] = 15 or [othro_day] = 29)"
        req: "y"
    },
  },




  // WGS
  {othro_wgs: #Form & {
    section: "WGS"
    type: "yesno"
    label: "[[othro_day]] Is WGS data available for current isolate?"
    branch: "[othro_day] and ([othro_day] = 0 or [othro_day] = 4 or [othro_day] = 8 or [othro_day] = 15 or [othro_day] = 29)"
  }},
  {othro_wgs_loc: #Form & {
    type: "notes"
    label: "[[othro_day]] Where is the WGS data stored?"
    branch: "[othro_wgs]='1' and [othro_day] and ([othro_day] = 0 or [othro_day] = 4 or [othro_day] = 8 or [othro_day] = 15 or [othro_day] = 29)"
  }},



]