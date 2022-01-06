package ecrf

// import "strings"



// IV administration / Monthly Monitorig- labs 
// This page opens if
// - [IV, oral/enteral] phage therapy selected from the treatment page (_trivcl_inclusion)
// - Duration > 2 weeks
// these rely on Repeatable Instruments (Project Settings > Enable Repeatable Instruments)

_show_labs: "([trivmo_phage_cont] = \"1\" or [trivmo_phage_stop_mo] = \"1\")"

treatment_iv_monthly: [
  {trivmo_no_inclusion_msg: #Form & {
      _no_inclusion_msg
  }},
  {trivmo_descriptive: #Form & {
    type: "descriptive"
    label: "<div class=\"header\"><h2>Clinical IV Labs [Monthly]</h2> Use this instrument for monthly treatment monitoring.<br><br>This page opens when IV and/or oral/enteral phage therapy are selected from the Treatment page. </div>"
  }},
  {trivmo_noninclusion: #Form & {
    type: "descriptive"
    label: "<div class=\"header\">This patient does not meet IV or oral/enteral phage therapy requirements</div>"
    branch: "\(_trivcl_noninclusion)"
  }},
  // {trivmo_2wk: #Form & {
  //   type: "checkbox"
  //   label: "Is treatment planned for > 2 weeks?"
  //   branch: "\(_inclusion) and \(_trivcl_inclusion)"
  //   req: "y"
  // }},
  {trivmo_mth: #Form & {
    type: "text"
    label: "Month after first dose of phage administered (e.g. Month 2)"
    validator: "integer"
    branch: "\(_inclusion) and \(_trivcl_inclusion)"
    req: "y"
  }},




  {trivmo_phage_cont: #Form & {
    type: "yesno"
    label: "[Month [trivmo_mth]] Is the patient still receiving phage therapy?"
    branch: "\(_inclusion) and \(_trivcl_inclusion)"
    req: "y"
  }},
  {trivmo_phage_stop_mo: #Form & {
    type: "yesno"
    label: "[Month [trivmo_mth]] Did the patient stop phage therapy within the last month?"
    branch: "[trivmo_phage_cont] and [trivmo_phage_cont] = 0"
    req: "y"
  }},


  {trivmo_phage_resp: #Form & {
    type: "radio"
    label: "[Month [trivmo_mth]] What has been the clinical response to phage therapy?"
    choices: "cure, No evidence of ongoing infection: resolution of clinical symptoms and signs, radiological and laboratory parameters of disease, and microbiological clearance of target pathogen from site of infection| partial, Partial response | none, No response – evidence of ongoing infection with worsening clinical signs and symptoms, radiological or laboratory parameters of disease | na, Unable to assess – participant received less than 3 doses of phage in total"
    branch: "[trivmo_phage_stop_mo] = \"1\""
    req: "y"
  }},

  {trivmo_phage_disability: #Form & {
    type: "radio"
    label: "[Month [trivmo_mth]] Any disabilities?"
    choices: "no_disability, Without persisting disability | with_disability, With persisting disability"
    branch: "[trivmo_phage_resp] = \"cure\""
    req: "y"
  }},

  {trivmo_phage_partial: #Form & {
    type: "radio"
    label: "[Month [trivmo_mth]] Partial response:"
    choices: "improvement, Improvement in clinical signs and symptoms, radiological or laboratory parameters of disease, but with evidence that infection is not completely resolved | stabilisation, Stabilisation of previously documented decline in function, but without obvious improvements, and evidence that infection is not completely resolved"
    branch: "[trivmo_phage_resp] = \"partial\""
    req: "y"
  }},




  // questions brought in from treatment_iv_labs
  // NO factory function bc avoiding premature optim.

  // CRP - C-reactive Protein
  {trivmo_crp: #Form & {
    section: "CRP results"
    type: "text"
    label: "[Month [trivmo_mth]] CRP result (XXX.X mg/mL)"
    validator: "number_1dp"
    branch: "\(_show_labs)" // skip day 11
  }},
  {trivmo_crp_na: #Form & {
    type: "checkbox"
    label: "[Month [trivmo_mth]] Are CRP results NOT available?"
    choices: "na, CRP results NOT available [Month [trivmo_mth]]"
    branch: "[trivmo_crp] = '' and \(_show_labs)" // skip day 11
    req: "y"
  }},


  // FBC all within normal range (yes/no)?
  {trivmo_fbc_isnorm: #Form & {
    section: "FBC"
    type: "yesno"
    label: "[Month [trivmo_mth]] FBC all within normal range (yes/no)?"
    branch: "\(_show_labs)" // skip day 11
  }},
  // if "No" to FBC, do the following (col I-R)
    // Hb result
    {trivmo_hb: #Form & {
      section: "Hb results"
      type: "text"
      label: "[Month [trivmo_mth]] Hb result (XXX g/L)"
      validator: "integer"
      branch: "[trivmo_fbc_isnorm] = '0' and \(_show_labs)" // skip day 11
    }},
    {trivmo_hb_na: #Form & {
      type: "checkbox"
      label: "[Month [trivmo_mth]] Are Hb results NOT available?"
      choices: "na, Hb results NOT available [Month [trivmo_mth]]"
      branch: "[trivmo_hb] = '' and [trivmo_fbc_isnorm] = '0' and \(_show_labs)" // skip day 11
      req: "y"
    }},

    // Platelet count
    {trivmo_platelet: #Form & {
      section: "Platelet count"
      type: "text"
      label: "[Month [trivmo_mth]] Platelet result (XXX x10^9/L)"
      validator: "integer"
      branch: "[trivmo_fbc_isnorm] = '0' and \(_show_labs)" // skip day 11
    }},
    {trivmo_platelet_na: #Form & {
      type: "checkbox"
      label: "[Month [trivmo_mth]] Are Platelet count results NOT available?"
      choices: "na, Platelet count results NOT available [Month [trivmo_mth]]"
      branch: "[trivmo_platelet] = '' and [trivmo_fbc_isnorm] = '0' and \(_show_labs)" // skip day 11
      req: "y"
    }},
    
    // WCC
    {trivmo_wcc: #Form & {
      section: "WCC"
      type: "text"
      label: "[Month [trivmo_mth]] WCC (XXX x10^9/L)"
      validator: "integer"
      branch: "[trivmo_fbc_isnorm] = '0' and \(_show_labs)" // skip day 11
    }},
    {trivmo_wcc_na: #Form & {
      type: "checkbox"
      label: "[Month [trivmo_mth]] Are WCC results NOT available?"
      choices: "na, WCC results NOT available [Month [trivmo_mth]]"
      branch: "[trivmo_wcc] = '' and [trivmo_fbc_isnorm] = '0' and \(_show_labs)" // skip day 11
      req: "y"
    }},

    // Neutrophil count
    {trivmo_neutrophil: #Form & {
      section: "Neutrophil count"
      type: "text"
      label: "[Month [trivmo_mth]] Neutrophil count (XX.X x10^9/L)"
      validator: "number_1dp"
      branch: "[trivmo_fbc_isnorm] = '0' and \(_show_labs)" // skip day 11
    }},
    {trivmo_neutrophil_na: #Form & {
      type: "checkbox"
      label: "[Month [trivmo_mth]] Are neutrophil count results NOT available?"
      choices: "na, neutrophil count results NOT available [Month [trivmo_mth]]"
      branch: "[trivmo_neutrophil] = '' and [trivmo_fbc_isnorm] = '0' and \(_show_labs)" // skip day 11
      req: "y"
    }},

    // Lymphocyte count
    {trivmo_lymphocite: #Form & {
      section: "Lymphocyte count"
      type: "text"
      label: "[Month [trivmo_mth]] Lymphocyte count (XX.X x10^9/L)"
      validator: "number_1dp"
      branch: "[trivmo_fbc_isnorm] = '0' and \(_show_labs)" // skip day 11
    }},
    {trivmo_lymphocite_na: #Form & {
      type: "checkbox"
      label: "[Month [trivmo_mth]] Are Lymphocyte count results NOT available?"
      choices: "na, Lymphocyte count results NOT available [Month [trivmo_mth]]"
      branch: "[trivmo_lymphocite] = '' and [trivmo_fbc_isnorm] = '0' and \(_show_labs)" // skip day 11
      req: "y"
    }},





  // LFTs
  {trivmo_lft_isnorm: #Form & {
    type: "yesno"
    label: "[Month [trivmo_mth]] LFTs all within normal range (yes/no)?"
    branch: "\(_show_labs)"
    req: "y"
  }},
    // if No to LFTs:

    // Albumin
    {trivmo_albumin: #Form & {
      section: "Albumin"
      type: "text"
      label: "[Month [trivmo_mth]] Albumin (XX g/L)"
      validator: "integer"
      branch: "[trivmo_lft_isnorm] = '0' and \(_show_labs)"
    }},
    {trivmo_albumin_na: #Form & {
      type: "checkbox"
      label: "[Month [trivmo_mth]] Is Albumin not available?"
      choices: "na, Albumin results are NOT available [Month [trivmo_mth]]"
      branch: "[trivmo_albumin] = '' and [trivmo_lft_isnorm] = '0' and \(_show_labs)"
      req: "y"
    }},

    // AST
    {trivmo_ast: #Form & {
      section: "AST"
      type: "text"
      label: "[Month [trivmo_mth]] AST (XXXX U/L)"
      validator: "integer"
      branch: "[trivmo_lft_isnorm] = '0' and \(_show_labs)"
    }},
    {trivmo_ast_na: #Form & {
      type: "checkbox"
      label: "[Month [trivmo_mth]] Is AST not available?"
      choices: "na, AST results are NOT available [Month [trivmo_mth]]"
      branch: "[trivmo_ast] = '' and [trivmo_lft_isnorm] = '0' and \(_show_labs)"
      req: "y"
    }},

    // ALT
    {trivmo_alt: #Form & {
      section: "ALT"
      type: "text"
      label: "[Month [trivmo_mth]] ALT (XXXX U/L)"
      validator: "integer"
      branch: "[trivmo_lft_isnorm] = '0' and \(_show_labs)"
    }},
    {trivmo_alt_na: #Form & {
      type: "checkbox"
      label: "[Month [trivmo_mth]] Is ALT not available?"
      choices: "na, ALT results are NOT available [Month [trivmo_mth]]"
      branch: "[trivmo_alt] = '' and [trivmo_lft_isnorm] = '0' and \(_show_labs)"
      req: "y"
    }},

    // GGT
    {trivmo_ggt: #Form & {
      section: "GGT"
      type: "text"
      label: "[Month [trivmo_mth]] GGT (XXXX U/L)"
      validator: "integer"
      branch: "\(_show_labs)"
    }},
    {trivmo_ggt_na: #Form & {
      type: "checkbox"
      label: "[Month [trivmo_mth]] Is GGT not available?"
      choices: "na, GGT results are NOT available [Month [trivmo_mth]]"
      branch: "[trivmo_ggt] = '' and \(_show_labs)"
      req: "y"
    }},

    // ALP
    {trivmo_alp: #Form & {
      section: "ALP"
      type: "text"
      label: "[Month [trivmo_mth]] ALP (XXXX U/L)"
      validator: "integer"
      branch: "[trivmo_lft_isnorm] = '0' and \(_show_labs)"
    }},
    {trivmo_alp_na: #Form & {
      type: "checkbox"
      label: "[Month [trivmo_mth]] Is ALP not available?"
      choices: "na, ALP results are NOT available [Month [trivmo_mth]]"
      branch: "[trivmo_alp] = '' and [trivmo_lft_isnorm] = '0' and \(_show_labs)"
      req: "y"
    }},





  // UECs
  {trivmo_uec_isnorm: #Form & {
    type: "yesno"
    label: "[Month [trivmo_mth]] UECs all within normal range (yes/no)?"
    branch: "\(_show_labs)"
    req: "y"
  }},
    // if No to UECs:

    // Sodium
    {trivmo_sodium: #Form & {
      section: "Sodium"
      type: "text"
      label: "[Month [trivmo_mth]] Sodium (XXX mmol/L)"
      validator: "integer"
      branch: "[trivmo_uec_isnorm] = '0' and \(_show_labs)"
    }},
    {trivmo_sodium_na: #Form & {
      type: "checkbox"
      label: "[Month [trivmo_mth]] Is Sodium not available?"
      choices: "na, Sodium results are NOT available [Month [trivmo_mth]]"
      branch: "[trivmo_sodium] = '' and [trivmo_uec_isnorm] = '0' and \(_show_labs)"
      req: "y"
    }},

    // Urea
    {trivmo_urea: #Form & {
      section: "Urea"
      type: "text"
      label: "[Month [trivmo_mth]] Urea (XX.X mmol/L)"
      validator: "number_1dp"
      branch: "[trivmo_uec_isnorm] = '0' and \(_show_labs)"
    }},
    {trivmo_urea_na: #Form & {
      type: "checkbox"
      label: "[Month [trivmo_mth]] Is Urea not available?"
      choices: "na, Urea results are NOT available [Month [trivmo_mth]]"
      branch: "[trivmo_urea] = '' and [trivmo_uec_isnorm] = '0' and \(_show_labs)"
      req: "y"
    }},

    // Creatinine
    {trivmo_creatinine: #Form & {
      section: "Creatinine"
      type: "text"
      label: "[Month [trivmo_mth]] Creatinine (XXX umol/L)"
      validator: "integer"
      branch: "[trivmo_uec_isnorm] = '0' and \(_show_labs)"
    }},
    {trivmo_creatinine_na: #Form & {
      type: "checkbox"
      label: "[Month [trivmo_mth]] Is Creatinine not available?"
      choices: "na, Creatinine results are NOT available [Month [trivmo_mth]]"
      branch: "[trivmo_creatinine] = '' and [trivmo_uec_isnorm] = '0' and \(_show_labs)"
      req: "y"
    }},


  // Total IgG - D0 and D29 only
  {trivmo_igg: #Form & {
    section: "IgG"
    type: "text"
    label: "[Month [trivmo_mth]] IgG (XX.XX g/L)"
    validator: "number_2dp"
    branch: "\(_show_labs)"
  }},
  {trivmo_igg_na: #Form & {
    type: "checkbox"
    label: "[Month [trivmo_mth]] Is IgG not available?"
    choices: "na, IgG results are NOT available [Month [trivmo_mth]]"
    branch: "[trivmo_igg] = '' and \(_show_labs)"
    req: "y"
  }},

  // C3 result - D0, D15, D29 only
  {trivmo_c3: #Form & {
    section: "C3"
    type: "text"
    label: "[Month [trivmo_mth]] C3 (X.XX g/L)"
    validator: "number_2dp"
    branch: "\(_show_labs)"
  }},
  {trivmo_c3_na: #Form & {
    type: "checkbox"
    label: "[Month [trivmo_mth]] Is C3 not available?"
    choices: "na, C3 results are NOT available [Month [trivmo_mth]]"
    branch: "[trivmo_c3] = '' and \(_show_labs)"
    req: "y"
  }},

  // C4 result - D0, D15, D29 only
  {trivmo_c4: #Form & {
    section: "C4"
    type: "text"
    label: "[Month [trivmo_mth]] C4 (X.XX g/L)"
    validator: "number_2dp"
    branch: "\(_show_labs)"
  }},
  {trivmo_c4_na: #Form & {
    type: "checkbox"
    label: "[Month [trivmo_mth]] Is C4 not available?"
    choices: "na, C4 results are NOT available [Month [trivmo_mth]]"
    branch: "[trivmo_c4] = '' and \(_show_labs)"
    req: "y"
  }},

  // CH50 result - D0, D15, D29 only
  {trivmo_ch50: #Form & {
    section: "CH50"
    type: "text"
    label: "[Month [trivmo_mth]] CH50 (XX U/mL)"
    validator: "integer"
    branch: "\(_show_labs)"
  }},
  {trivmo_ch50_na: #Form & {
    type: "checkbox"
    label: "[Month [trivmo_mth]] Is CH50 not available?"
    choices: "na, CH50 results are NOT available [Month [trivmo_mth]]"
    branch: "[trivmo_ch50] = '' and \(_show_labs)"
    req: "y"
  }},





  // these question are per phage (as entered in pre-treatment)

  // user-entered phages; selected route is PER PHAGE (e.g. only iv and oral show up in this list), as entered in treatment
  for y, Y in _maxPhages*[""] {
    "trivmo_ph\(y)": #Form & {
        type: "descriptive"
        label: "<div class=\"header\">Phage: \"[pre_phage\(y+1)_name]\"</div>"
        branch: "([tre_ph_\(y)_rt(iv)] = '1' or [tre_ph_\(y)_rt(oral)] = '1')" + " and [pre_phage\(y+1)_name] and [pre_phage\(y+1)_name] !='' and [pre_num_phage]>\(y) and \(_show_labs)"
    },
    "trivmo_ph_\(y)_anti": #Form & {
        type: "yesno"
        label: "[Phage: \"[pre_phage\(y+1)_name]\"] Antiphage antibodies tested (yes/no)?"
        branch: "([tre_ph_\(y)_rt(iv)] = '1' or [tre_ph_\(y)_rt(oral)] = '1')" + " and [pre_phage\(y+1)_name] and [pre_phage\(y+1)_name] !='' and [pre_num_phage]>\(y) and \(_show_labs)"
        req: "y"
    },
    "trivmo_ph_\(y)_anti_assay": #Form & {
        type: "checkbox"
        label: "[Phage: \"[pre_phage\(y+1)_name]\"] Assay types used?"
        choices: "neutralising,Neutralising antibody assay | igmigg, IgM/IgG assay | other,Other please specify"
        branch: "[trivmo_ph_\(y)_anti]='1' and ([tre_ph_\(y)_rt(iv)] = '1' or [tre_ph_\(y)_rt(oral)] = '1')" + " and [pre_phage\(y+1)_name] and [pre_phage\(y+1)_name] !='' and [pre_num_phage]>\(y) and \(_show_labs)"
        req: "y"
    },
    "trivmo_ph_\(y)_anti_assay_oth": #Form & {
        type: "text"
        label: "[Phage: \"[pre_phage\(y+1)_name]\"] Other assay type"
        branch: "[trivmo_ph_\(y)_anti]='1' and [trivmo_ph_\(y)_anti_assay(other)]='1' and ([tre_ph_\(y)_rt(iv)] = '1' or [tre_ph_\(y)_rt(oral)] = '1')" + " and [pre_phage\(y+1)_name] and [pre_phage\(y+1)_name] !='' and [pre_num_phage]>\(y) and \(_show_labs)"
        req: "y"
        action: "@CHARLIMIT='50'"
    },
    "trivmo_ph_\(y)_anti_res": #Form & {
        type: "notes"
        label: "[Phage: \"[pre_phage\(y+1)_name]\"] Antiphage antibody result"
        branch: "[trivmo_ph_\(y)_anti]='1' and ([tre_ph_\(y)_rt(iv)] = '1' or [tre_ph_\(y)_rt(oral)] = '1')" + " and [pre_phage\(y+1)_name] and [pre_phage\(y+1)_name] !='' and [pre_num_phage]>\(y) and \(_show_labs)"
        req: "y"
    },
  },


  for x, X in _maxPathogens*[""] {
    "trivmo_pth\(x+1)_descriptive": #Form & {
        type: "descriptive"
        label: "<div class=\"header\">Pathogen \(x+1) \"[pre_pth\(x+1)_target]\"</div>"
        branch: "[pre_num_target_pathogen] > \(x) and \(_show_labs)"
    },
    "trivmo_pth_\(x+1)_iso": #Form & {
        type: "radio"
        label: "[Pathogen \(x+1): [pre_pth\(x+1)_target]] Pathogen isolated from site of infection?"
        choices: "isolated,Isolated | not_isolated, Not isolated | na, Not performed"
        branch: "[pre_num_target_pathogen] > \(x) and \(_show_labs)"
        req: "y"
    },
    "trivmo_pth_\(x+1)_iso_na_desc": #Form & {
        type: "notes"
        label: "[Pathogen \(x+1): [pre_pth\(x+1)_target]] How come isolation wasn't performed?"
        branch: "[trivmo_pth_\(x+1)_iso] = 'na' and [pre_num_target_pathogen] > \(x) and \(_show_labs)"
        req: "y"
    },
    "trivmo_pth_\(x+1)_iso_lyt_conf": #Form & {
        type: "radio"
        label: "[Pathogen \(x+1): [pre_pth\(x+1)_target]] Is ongoing lytic activity of phage(s) confirmed?"
        choices: "1,Yes | 0,Not tested | resistance,Evidence of anti-phage resistance"
        branch: "[trivmo_pth_\(x+1)_iso] = 'isolated' and [pre_num_target_pathogen] > \(x) and \(_show_labs)"
        req: "y"
    },
    "trivmo_pth_\(x+1)_iso_lyt_conf_r_d": #Form & {
        type: "notes"
        label: "[Pathogen \(x+1): [pre_pth\(x+1)_target]] Please specify anti-phage resistance activity"
        branch: "[trivmo_pth_\(x+1)_iso_lyt_conf] = 'resistance' and [trivmo_pth_\(x+1)_iso] = 'isolated' and [pre_num_target_pathogen] > \(x) and \(_show_labs)"
        req: "y"
    },
    "trivmo_pth_\(x+1)_iso_oth": #Form & {
        type: "radio"
        label: "[Pathogen \(x+1): [pre_pth\(x+1)_target]] Pathogen isolated from other site?"
        choices: "isolated,Isolated | not_isolated, Not isolated | na, Not performed"
        branch: "[pre_num_target_pathogen] > \(x) and \(_show_labs)"
        req: "y"
    },
    "trivmo_pth_\(x+1)_iso_oth_site": #Form & {
        type: "text"
        label: "[Pathogen \(x+1): [pre_pth\(x+1)_target]] Specify other site where pathogen was isolated"
        branch: "[trivmo_pth_\(x+1)_iso_oth] = 'isolated' and [pre_num_target_pathogen] > \(x) and \(_show_labs)"
        req: "y"
    },
    "trivmo_pth_\(x+1)_iso_oth_lyt_conf": #Form & {
        type: "radio"
        label: "[Pathogen \(x+1): [pre_pth\(x+1)_target]] Is ongoing lytic activity of phage(s) confirmed at [trivmo_pth_\(x+1)_iso_oth_site]?"
        choices: "1,Yes | 0,Not tested | resistance,Evidence of anti-phage resistance"
        branch: "[trivmo_pth_\(x+1)_iso_oth_site] and [trivmo_pth_\(x+1)_iso] = 'isolated' and [pre_num_target_pathogen] > \(x) and \(_show_labs)"
        req: "y"
    },
    "trivmo_pth_\(x+1)_iso_oth_lyt_conf_r_d": #Form & {
        type: "notes"
        label: "[Pathogen \(x+1): [pre_pth\(x+1)_target]] Please specify anti-phage resistance activity"
        branch: "[trivmo_pth_\(x+1)_iso_oth_lyt_conf] = 'resistance' and [trivmo_pth_\(x+1)_iso] = 'isolated' and [pre_num_target_pathogen] > \(x) and \(_show_labs)"
        req: "y"
    },
  },




  // WGS
  {trivmo_wgs: #Form & {
    section: "WGS"
    type: "yesno"
    label: "[Month [trivmo_mth]] Is WGS data available for current isolate?"
    branch: "\(_show_labs)"
  }},
  {trivmo_wgs_loc: #Form & {
    type: "notes"
    label: "[Month [trivmo_mth]] Where is the WGS data stored?"
    branch: "[trivmo_wgs]='1' and \(_show_labs)"
  }},

  {trivmo_rnatr: #Form & {
    type: "radio"
    label: "[Month [trivmo_mth]] RNA (immune panel) transcriptomics performed?"
    choices: "yes, Yes/Sample obtained + stored | not_analysed,Sample processed but not analysed | no,No"
    branch: "\(_show_labs)"
  }},
    {trivmo_rnatr_loc: #Form & {
      type: "notes"
      label: "[Month [trivmo_mth]] Where is the RNA transcriptomics data stored?"
      branch: "[trivmo_rnatr]='yes' and \(_show_labs)"
    }},
    {trivmo_rnatr_sample_loc: #Form & {
      type: "notes"
      label: "[Month [trivmo_mth]] Where is the RNA transcriptomics sample stored?"
      branch: "([trivmo_rnatr]='yes' or [trivmo_rnatr]='not_analysed') and \(_show_labs)"
    }},



  {trivmo_metag_samples: #Form & {
    section: "Metagenomics"
    type: "yesno"
    label: "[Month [trivmo_mth]] Are clinical samples available for metagenomics?"
    branch: "\(_show_labs)"
  }},
    {trivmo_metag_type: #Form & {
      type: "text"
      label: "[Month [trivmo_mth]] Specify type of sample"
      branch: "[trivmo_metag_samples]='1' and \(_show_labs)"
    }},
    {trivmo_metag_has: #Form & {
      type: "radio"
      label: "[Month [trivmo_mth]] Have metagenomics been performed?"
      choices: "1,Yes | 0, No, samples stored"
      branch: "[trivmo_metag_samples]='1' and \(_show_labs)"
    }},
    {trivmo_metag_data_loc: #Form & {
      type: "notes"
      label: "[Month [trivmo_mth]] Where is the metagenome data stored?"
      branch: "[trivmo_metag_has]='1' and \(_show_labs)"
    }},
    {trivmo_metag_sample_loc: #Form & {
      type: "notes"
      label: "[Month [trivmo_mth]] Where is the sample stored?"
      branch: "[trivmo_metag_has]='0' and \(_show_labs)"
    }},














  // 
  // Pre-Dose / Morning
  // 

  // Phage result plaque assay
  {trivmo_kino_pre_plaque: #Form & {
    section: "Pre-dose / morning"
    type: "text"
    label: "[Pre-Dose] Phage result plaque assay (XX PFU/mL)"
    validator: "integer"
    branch: "\(_show_labs)"
  }},
  {trivmo_kino_pre_plaque_na: #Form & {
    type: "checkbox"
    label: "[Pre-Dose] Are plaque assays not available?"
    choices: "na, Plaque assays are NOT available "
    branch: "[trivmo_kino_pre_plaque] = '' and \(_show_labs)"
    req: "y"
  }},

  // Phage result qPCR
  {trivmo_kino_pre_ph_qpcr: #Form & {
    type: "text"
    label: "[Pre-Dose] Phage qPCR results (XX genome copies/mL)"
    validator: "integer"
    branch: "\(_show_labs) "
  }},
  {trivmo_kino_pre_ph_qpcr_na: #Form & {
    type: "checkbox"
    label: "[Pre-Dose] Are phage qPCR results not available?"
    choices: "na, Phage qPCR results are NOT available "
    branch: "[trivmo_kino_pre_ph_qpcr] = '' and \(_show_labs) "
    req: "y"
  }},

  // Phage result qPCR
  {trivmo_kino_pre_bact_qpcr: #Form & {
    type: "text"
    label: "[Pre-Dose] Bacterial load qPCR results (XX genome copies/mL)"
    validator: "integer"
    branch: "\(_show_labs) "
  }},
  {trivmo_kino_pre_bact_qpcr_na: #Form & {
    type: "checkbox"
    label: "[Pre-Dose] Are bacterial load qPCR results not available?"
    choices: "na, Phage qPCR results are NOT available "
    branch: "[trivmo_kino_pre_bact_qpcr] = '' and \(_show_labs) "
    req: "y"
  }},



  // 
  // 30-60 minutes post-dose
  // only ask this if patient still receiving phage therapy
  // 

  // Phage result qPCR
  {trivmo_kino_post_ph_qpcr: #Form & {
    section: "30-60 minutes post-dose"
    type: "text"
    label: "[30-60 minutes post-dose] Phage qPCR results (XX genome copies/mL)"
    validator: "integer"
    branch: "\(_show_labs) and [trivmo_phage_stop_mo] = \"0\""
  }},
  {trivmo_kino_post_ph_qpcr_na: #Form & {
    type: "checkbox"
    label: "[30-60 minutes post-dose] Are phage qPCR results not available?"
    choices: "na, Phage qPCR results are NOT available "
    branch: "[trivmo_kino_post_ph_qpcr] = '' and \(_show_labs) and [trivmo_phage_stop_mo] = \"0\""
    req: "y"
  }},

  // Phage result qPCR
  {trivmo_kino_post_bact_qpcr: #Form & {
    type: "text"
    label: "[30-60 minutes post-dose] Bacterial load qPCR results (XX genome copies/mL)"
    validator: "integer"
    branch: "\(_show_labs) and [trivmo_phage_stop_mo] = \"0\""
  }},
  {trivmo_kino_post_bact_qpcr_na: #Form & {
    type: "checkbox"
    label: "[30-60 minutes post-dose] Are bacterial load qPCR results not available?"
    choices: "na, Phage qPCR results are NOT available "
    branch: "[trivmo_kino_post_bact_qpcr] = '' and \(_show_labs) and [trivmo_phage_stop_mo] = \"0\""
    req: "y"
  }},







  // 
  // 2-3 hours post-dose
  // 

  // Phage result plaque assay
  {trivmo_kino_lngpost_plaque: #Form & {
    section: "2-3 hours post-dose"
    type: "text"
    label: "[2-3 hours post-dose] Phage result plaque assay (XX PFU/mL)"
    validator: "integer"
    branch: "\(_show_labs) and [trivmo_phage_stop_mo] = \"0\""
  }},
  {trivmo_kino_lngpost_plaque_na: #Form & {
    type: "checkbox"
    label: "[2-3 hours post-dose] Are plaque assays not available?"
    choices: "na, Plaque assays are NOT available "
    branch: "[trivmo_kino_lngpost_plaque] = '' and \(_show_labs) and [trivmo_phage_stop_mo] = \"0\""
    req: "y"
  }},

  // Phage result qPCR
  {trivmo_kino_lngpost_ph_qpcr: #Form & {
    type: "text"
    label: "[2-3 hours post-dose] Phage qPCR results (XX genome copies/mL)"
    validator: "integer"
    branch: "\(_show_labs) and [trivmo_phage_stop_mo] = \"0\""
  }},
  {trivmo_kino_lngpost_ph_qpcr_na: #Form & {
    type: "checkbox"
    label: "[2-3 hours post-dose] Are phage qPCR results not available?"
    choices: "na, Phage qPCR results are NOT available "
    branch: "[trivmo_kino_lngpost_ph_qpcr] = ''  and \(_show_labs) and [trivmo_phage_stop_mo] = \"0\""
    req: "y"
  }},

  // Phage result qPCR
  {trivmo_kino_lngpost_bact_qpcr: #Form & {
    type: "text"
    label: "[2-3 hours post-dose] Bacterial load qPCR results (XX genome copies/mL)"
    validator: "integer"
    branch: "\(_show_labs) and [trivmo_phage_stop_mo] = \"0\""
  }},
  {trivmo_kino_lngpost_bact_qpcr_na: #Form & {
    type: "checkbox"
    label: "[2-3 hours post-dose] Are bacterial load qPCR results not available?"
    choices: "na, Phage qPCR results are NOT available "
    branch: "[trivmo_kino_lngpost_bact_qpcr] = ''  and \(_show_labs) and [trivmo_phage_stop_mo] = \"0\""
    req: "y"
  }},

]