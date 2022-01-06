package ecrf

import "strings"



// IV administration - labs
// This page opens if
// - [IV, oral/enteral] phage therapy selected from the treatment page (_trivcl_inclusion)
// these rely on Repeatable Instruments (Project Settings > Enable Repeatable Instruments)

treatment_iv_labs: [
  {trivlab_no_inclusion_msg: #Form & {
      _no_inclusion_msg
  }},
  {trivlab_descriptive: #Form & {
    type: "descriptive"
    label: "<div class=\"header\"><h2>Clinical IV Labs</h2> For treatments over TWO weeks, use the Monthly instrument. <br><br>This page opens when IV and/or oral/enteral phage therapy are selected from the Treatment page. </div>"
  }},
  {trivlab_noninclusion: #Form & {
    type: "descriptive"
    label: "<div class=\"header\">This patient does not meet oral/enteral phage therapy requirements</div>"
    branch: "\(_trivcl_noninclusion)"
  }},
  {trivlab_day: #Form & {
    type: "radio"
    label: "Select clinical day of treatment:"
    choices: strings.Join([for _,x in [0,2,4,8,11,15,29] { "\(x), D\(x)" }], " | ") + " | other,Other Day (If additional relevant testing performed on any other day)"
    branch: "\(_inclusion) and \(_trivcl_inclusion)"
    req: "y"
  }},
  {trivlab_other_day: #Form & {
    type: "text"
    label: "Enter day of treatment (enter a number between 0-29, inclusive)"
    validator: "integer"
    branch: "[trivlab_day] = 'other'"
    req: "y"
  }},
  {trivlab_other_day_test: #Form & {
    type: "notes"
    label: "Test performed for day [trivlab_other_day]"
    branch: "[trivlab_other_day] >= 0"
    req: "y"
  }},
  {trivlab_other_day_result: #Form & {
    type: "notes"
    label: "Result for day [trivlab_other_day]"
    branch: "[trivlab_other_day] >= 0"
    req: "y"
  }},














  // CRP - C-reactive Protein
  {trivlab_crp: #Form & {
    section: "CRP results"
    type: "text"
    label: "[[trivlab_day]] CRP result (XXX.X mg/mL)"
    validator: "number_1dp"
    branch: "[trivlab_day] >= 0 and [trivlab_day] and [trivlab_day] != 11" // skip day 11
  }},
  {trivlab_crp_na: #Form & {
    type: "checkbox"
    label: "[[trivlab_day]] Are CRP results NOT available?"
    choices: "na, CRP results NOT available for [[trivlab_day]]"
    branch: "[trivlab_crp] = '' and [trivlab_day] and [trivlab_day] >= 0 and [trivlab_day] != 11" // skip day 11
    req: "y"
  }},

  // ESR - Erythrocyte Sedimentation Rate
  {trivlab_esr: #Form & {
    section: "ESR results"
    type: "text"
    label: "[[trivlab_day]] ESR result (XXX mm/h)"
    validator: "integer"
    branch: "[trivlab_day] >= 0 and [trivlab_day] and [trivlab_day] != 2 and [trivlab_day] != 11" // skip day 11
  }},
  {trivlab_esr_na: #Form & {
    type: "checkbox"
    label: "[[trivlab_day]] Are ESR results NOT available?"
    choices: "na, ESR results NOT available for [[trivlab_day]]"
    branch: "[trivlab_esr] = '' and [trivlab_day] and [trivlab_day] >= 0 and [trivlab_day] != 2 and [trivlab_day] != 11" // skip day 11
    req: "y"
  }},

  // Procalcitonin
  {trivlab_procalc: #Form & {
    section: "Procalcitonin results"
    type: "text"
    label: "[[trivlab_day]] Procalcitonin result (XX.XX ng/mL)"
    validator: "number_2dp"
    branch: "[trivlab_day] and [trivlab_day] >= 0 and [trivlab_day] != 11 and [trivlab_day] != 29" // skip day 11
  }},
  {trivlab_procalc_na: #Form & {
    type: "checkbox"
    label: "[[trivlab_day]] Are Procalcitonin results NOT available?"
    choices: "na, ESR results NOT available for [[trivlab_day]]"
    branch: "[trivlab_procalc] = '' and [trivlab_day] and [trivlab_day] >= 0 and [trivlab_day] != 11 and [trivlab_day] != 29" // skip day 11
    req: "y"
  }},























  // FBC all within normal range (yes/no)?
  {trivlab_fbc_isnorm: #Form & {
    section: "FBC"
    type: "yesno"
    label: "[[trivlab_day]] FBC all within normal range (yes/no)?"
    branch: "[trivlab_day] and [trivlab_day] >= 0" // skip day 11
  }},
  // if "No" to FBC, do the following (col I-R)
    // Hb result
    {trivlab_hb: #Form & {
      section: "Hb results"
      type: "text"
      label: "[[trivlab_day]] Hb result (XXX g/L)"
      validator: "integer"
      branch: "[trivlab_fbc_isnorm] = '0' and [trivlab_day] and [trivlab_day] >= 0" // skip day 11
    }},
    {trivlab_hb_na: #Form & {
      type: "checkbox"
      label: "[[trivlab_day]] Are Hb results NOT available?"
      choices: "na, Hb results NOT available for [[trivlab_day]]"
      branch: "[trivlab_hb] = '' and [trivlab_fbc_isnorm] = '0' and [trivlab_day] and [trivlab_day] >= 0" // skip day 11
      req: "y"
    }},

    // Platelet count
    {trivlab_platelet: #Form & {
      section: "Platelet count"
      type: "text"
      label: "[[trivlab_day]] Platelet result (XXX x10^9/L)"
      validator: "integer"
      branch: "[trivlab_fbc_isnorm] = '0' and [trivlab_day] and [trivlab_day] >= 0" // skip day 11
    }},
    {trivlab_platelet_na: #Form & {
      type: "checkbox"
      label: "[[trivlab_day]] Are Platelet count results NOT available?"
      choices: "na, Platelet count results NOT available for [[trivlab_day]]"
      branch: "[trivlab_platelet] = '' and [trivlab_fbc_isnorm] = '0' and [trivlab_day] and [trivlab_day] >= 0" // skip day 11
      req: "y"
    }},
    
    // WCC
    {trivlab_wcc: #Form & {
      section: "WCC"
      type: "text"
      label: "[[trivlab_day]] WCC (XXX x10^9/L)"
      validator: "integer"
      branch: "[trivlab_fbc_isnorm] = '0' and [trivlab_day] and [trivlab_day] >= 0" // skip day 11
    }},
    {trivlab_wcc_na: #Form & {
      type: "checkbox"
      label: "[[trivlab_day]] Are WCC results NOT available?"
      choices: "na, WCC results NOT available for [[trivlab_day]]"
      branch: "[trivlab_wcc] = '' and [trivlab_fbc_isnorm] = '0' and [trivlab_day] and [trivlab_day] >= 0" // skip day 11
      req: "y"
    }},

    // Neutrophil count
    {trivlab_neutrophil: #Form & {
      section: "Neutrophil count"
      type: "text"
      label: "[[trivlab_day]] Neutrophil count (XX.X x10^9/L)"
      validator: "number_1dp"
      branch: "[trivlab_fbc_isnorm] = '0' and [trivlab_day] and [trivlab_day] >= 0" // skip day 11
    }},
    {trivlab_neutrophil_na: #Form & {
      type: "checkbox"
      label: "[[trivlab_day]] Are neutrophil count results NOT available?"
      choices: "na, neutrophil count results NOT available for [[trivlab_day]]"
      branch: "[trivlab_neutrophil] = '' and [trivlab_fbc_isnorm] = '0' and [trivlab_day] and [trivlab_day] >= 0" // skip day 11
      req: "y"
    }},

    // Lymphocyte count
    {trivlab_lymphocite: #Form & {
      section: "Lymphocyte count"
      type: "text"
      label: "[[trivlab_day]] Lymphocyte count (XX.X x10^9/L)"
      validator: "number_1dp"
      branch: "[trivlab_fbc_isnorm] = '0' and [trivlab_day] and [trivlab_day] >= 0" // skip day 11
    }},
    {trivlab_lymphocite_na: #Form & {
      type: "checkbox"
      label: "[[trivlab_day]] Are Lymphocyte count results NOT available?"
      choices: "na, Lymphocyte count results NOT available for [[trivlab_day]]"
      branch: "[trivlab_lymphocite] = '' and [trivlab_fbc_isnorm] = '0' and [trivlab_day] and [trivlab_day] >= 0" // skip day 11
      req: "y"
    }},

  // Lymphopenia?
  {trivlab_lymphopenia: #Form & {
    section: "Lymphopenia"
    type: "yesno"
    label: "[[trivlab_day]] Lymphopenia?"
    branch: "[trivlab_day] and [trivlab_day] >= 0 and [trivlab_day] != 0 and [trivlab_day] != 2" // skip day 11
  }},




















  // Lymphocyte
  {trivlab_lymphocyte_isnorm: #Form & {
    type: "yesno"
    label: "[[trivlab_day]] Lymphocyte subsets all within normal range (yes/no)?"
    branch: "[trivlab_procalc] = '' and [trivlab_day] and [trivlab_day] >= 0"
    req: "y"
  }},
  // if "No" to Lymphocyte, do the following (col U-AI)
    // CD3 count
    {trivlab_cd3: #Form & {
      section: "CD3 count"
      type: "text"
      label: "[[trivlab_day]] CD3 count (XX.XX x10^9/L)"
      validator: "number_2dp"
      branch: "([trivlab_lymphocyte_isnorm] = '0' or [trivlab_lymphopenia]='1') and [trivlab_day] and [trivlab_day] >= 0"
    }},
    {trivlab_cd3_pct: #Form & {
      type: "text"
      label: "[[trivlab_day]] CD3 % (XX%)"
      validator: "integer"
      branch: "([trivlab_lymphocyte_isnorm] = '0' or [trivlab_lymphopenia]='1') and [trivlab_day] and [trivlab_day] >= 0"
    }},
    {trivlab_cd3_na: #Form & {
      type: "checkbox"
      label: "[[trivlab_day]] Is CD3 NOT available?"
      choices: "na, CD3 results NOT available for [[trivlab_day]]"
      branch: "[trivlab_cd3] = '' and ([trivlab_lymphocyte_isnorm] = '0' or [trivlab_lymphopenia]='1') and [trivlab_day] and [trivlab_day] >= 0"
      req: "y"
    }},

    // CD4 count
    {trivlab_cd4: #Form & {
      section: "CD4 count"
      type: "text"
      label: "[[trivlab_day]] CD4 count (XX.XX x10^9/L)"
      validator: "number_2dp"
      branch: "([trivlab_lymphocyte_isnorm] = '0' or [trivlab_lymphopenia]='1') and [trivlab_day] and [trivlab_day] >= 0"
    }},
    {trivlab_cd4_pct: #Form & {
      type: "text"
      label: "[[trivlab_day]] CD4 % (XX%)"
      validator: "integer"
      branch: "([trivlab_lymphocyte_isnorm] = '0' or [trivlab_lymphopenia]='1') and [trivlab_day] and [trivlab_day] >= 0"
    }},
    {trivlab_cd4_na: #Form & {
      type: "checkbox"
      label: "[[trivlab_day]] Is CD4 NOT available?"
      choices: "na, CD4 results NOT available for [[trivlab_day]]"
      branch: "[trivlab_cd4] = '' and ([trivlab_lymphocyte_isnorm] = '0' or [trivlab_lymphopenia]='1') and [trivlab_day] and [trivlab_day] >= 0"
      req: "y"
    }},

    // CD8 count
    {trivlab_cd8: #Form & {
      section: "CD8 count"
      type: "text"
      label: "[[trivlab_day]] CD8 count (XX.XX x10^9/L)"
      validator: "number_2dp"
      branch: "([trivlab_lymphocyte_isnorm] = '0' or [trivlab_lymphopenia]='1') and [trivlab_day] and [trivlab_day] >= 0"
    }},
    {trivlab_cd8_pct: #Form & {
      type: "text"
      label: "[[trivlab_day]] CD8 % (XX%)"
      validator: "integer"
      branch: "([trivlab_lymphocyte_isnorm] = '0' or [trivlab_lymphopenia]='1') and [trivlab_day] and [trivlab_day] >= 0"
    }},
    {trivlab_cd8_na: #Form & {
      type: "checkbox"
      label: "[[trivlab_day]] Is CD8 NOT available?"
      choices: "na, CD8 results NOT available for [[trivlab_day]]"
      branch: "[trivlab_cd8] = '' and ([trivlab_lymphocyte_isnorm] = '0' or [trivlab_lymphopenia]='1') and [trivlab_day] and [trivlab_day] >= 0"
      req: "y"
    }},

    // NK Cell count
    {trivlab_nkcell: #Form & {
      section: "CD8 count"
      type: "text"
      label: "[[trivlab_day]] NK cell count (XX.XX x10^9/L)"
      validator: "number_2dp"
      branch: "([trivlab_lymphocyte_isnorm] = '0' or [trivlab_lymphopenia]='1') and [trivlab_day] and [trivlab_day] >= 0"
    }},
    {trivlab_nkcell_pct: #Form & {
      type: "text"
      label: "[[trivlab_day]] NK cell % (XX%)"
      validator: "integer"
      branch: "([trivlab_lymphocyte_isnorm] = '0' or [trivlab_lymphopenia]='1') and [trivlab_day] and [trivlab_day] >= 0"
    }},
    {trivlab_nkcell_na: #Form & {
      type: "checkbox"
      label: "[[trivlab_day]] Is NK cell count NOT available?"
      choices: "na, NK cell count results NOT available for [[trivlab_day]]"
      branch: "[trivlab_nkcell] = '' and ([trivlab_lymphocyte_isnorm] = '0' or [trivlab_lymphopenia]='1') and [trivlab_day] and [trivlab_day] >= 0"
      req: "y"
    }},

    // CD19 count
    {trivlab_cd19: #Form & {
      section: "CD19 count"
      type: "text"
      label: "[[trivlab_day]] CD19 count (XX.XX x10^9/L)"
      validator: "number_2dp"
      branch: "([trivlab_lymphocyte_isnorm] = '0' or [trivlab_lymphopenia]='1') and [trivlab_day] and [trivlab_day] >= 0"
    }},
    {trivlab_cd19_pct: #Form & {
      type: "text"
      label: "[[trivlab_day]] CD19 % (XX%)"
      validator: "integer"
      branch: "([trivlab_lymphocyte_isnorm] = '0' or [trivlab_lymphopenia]='1') and [trivlab_day] and [trivlab_day] >= 0"
    }},
    {trivlab_cd19_na: #Form & {
      type: "checkbox"
      label: "[[trivlab_day]] Is CD19 NOT available?"
      choices: "na, CD19 results NOT available for [[trivlab_day]]"
      branch: "[trivlab_cd19] = '' and ([trivlab_lymphocyte_isnorm] = '0' or [trivlab_lymphopenia]='1') and [trivlab_day] and [trivlab_day] >= 0"
      req: "y"
    }},




  // LFTs
  {trivlab_lft_isnorm: #Form & {
    type: "yesno"
    label: "[[trivlab_day]] LFTs all within normal range (yes/no)?"
    branch: "[trivlab_procalc] = '' and [trivlab_day] and [trivlab_day] >= 0 and [trivlab_day] != 11"
    req: "y"
  }},
    // if No to LFTs:

    // Albumin
    {trivlab_albumin: #Form & {
      section: "Albumin"
      type: "text"
      label: "[[trivlab_day]] Albumin (XX g/L)"
      validator: "integer"
      branch: "[trivlab_lft_isnorm] = '0' and [trivlab_day] and [trivlab_day] >= 0 and [trivlab_day] != 11"
    }},
    {trivlab_albumin_na: #Form & {
      type: "checkbox"
      label: "[[trivlab_day]] Is Albumin not available?"
      choices: "na, Albumin results are NOT available for [[trivlab_day]]"
      branch: "[trivlab_albumin] = '' and [trivlab_lft_isnorm] = '0' and [trivlab_day] and [trivlab_day] >= 0 and [trivlab_day] != 11"
      req: "y"
    }},

    // AST
    {trivlab_ast: #Form & {
      section: "AST"
      type: "text"
      label: "[[trivlab_day]] AST (XXXX U/L)"
      validator: "integer"
      branch: "[trivlab_lft_isnorm] = '0' and [trivlab_day] and [trivlab_day] >= 0 and [trivlab_day] != 11"
    }},
    {trivlab_ast_na: #Form & {
      type: "checkbox"
      label: "[[trivlab_day]] Is AST not available?"
      choices: "na, AST results are NOT available for [[trivlab_day]]"
      branch: "[trivlab_ast] = '' and [trivlab_lft_isnorm] = '0' and [trivlab_day] and [trivlab_day] >= 0 and [trivlab_day] != 11"
      req: "y"
    }},

    // ALT
    {trivlab_alt: #Form & {
      section: "ALT"
      type: "text"
      label: "[[trivlab_day]] ALT (XXXX U/L)"
      validator: "integer"
      branch: "[trivlab_lft_isnorm] = '0' and [trivlab_day] and [trivlab_day] >= 0 and [trivlab_day] != 11"
    }},
    {trivlab_alt_na: #Form & {
      type: "checkbox"
      label: "[[trivlab_day]] Is ALT not available?"
      choices: "na, ALT results are NOT available for [[trivlab_day]]"
      branch: "[trivlab_alt] = '' and [trivlab_lft_isnorm] = '0' and [trivlab_day] and [trivlab_day] >= 0 and [trivlab_day] != 11"
      req: "y"
    }},

    // GGT
    {trivlab_ggt: #Form & {
      section: "GGT"
      type: "text"
      label: "[[trivlab_day]] GGT (XXXX U/L)"
      validator: "integer"
      branch: "([trivlab_lft_isnorm] = '0' or [trivlab_lymphopenia]='1') and [trivlab_day] and [trivlab_day] >= 0 and [trivlab_day] != 11"
    }},
    {trivlab_ggt_na: #Form & {
      type: "checkbox"
      label: "[[trivlab_day]] Is GGT not available?"
      choices: "na, GGT results are NOT available for [[trivlab_day]]"
      branch: "[trivlab_ggt] = '' and ([trivlab_lft_isnorm] = '0' or [trivlab_lymphopenia]='1') and [trivlab_day] and [trivlab_day] >= 0 and [trivlab_day] != 11"
      req: "y"
    }},

    // ALP
    {trivlab_alp: #Form & {
      section: "ALP"
      type: "text"
      label: "[[trivlab_day]] ALP (XXXX U/L)"
      validator: "integer"
      branch: "[trivlab_lft_isnorm] = '0' and [trivlab_day] and [trivlab_day] >= 0 and [trivlab_day] != 11"
    }},
    {trivlab_alp_na: #Form & {
      type: "checkbox"
      label: "[[trivlab_day]] Is ALP not available?"
      choices: "na, ALP results are NOT available for [[trivlab_day]]"
      branch: "[trivlab_alp] = '' and [trivlab_lft_isnorm] = '0' and [trivlab_day] and [trivlab_day] >= 0 and [trivlab_day] != 11"
      req: "y"
    }},















  // UECs
  {trivlab_uec_isnorm: #Form & {
    type: "yesno"
    label: "[[trivlab_day]] UECs all within normal range (yes/no)?"
    branch: "[trivlab_procalc] = '' and [trivlab_day] and [trivlab_day] >= 0 and [trivlab_day] != 11"
    req: "y"
  }},
    // if No to UECs:

    // Sodium
    {trivlab_sodium: #Form & {
      section: "Sodium"
      type: "text"
      label: "[[trivlab_day]] Sodium (XXX mmol/L)"
      validator: "integer"
      branch: "[trivlab_uec_isnorm] = '0' and [trivlab_day] and [trivlab_day] >= 0 and [trivlab_day] != 11"
    }},
    {trivlab_sodium_na: #Form & {
      type: "checkbox"
      label: "[[trivlab_day]] Is Sodium not available?"
      choices: "na, Sodium results are NOT available for [[trivlab_day]]"
      branch: "[trivlab_sodium] = '' and [trivlab_uec_isnorm] = '0' and [trivlab_day] and [trivlab_day] >= 0 and [trivlab_day] != 11"
      req: "y"
    }},

    // Urea
    {trivlab_urea: #Form & {
      section: "Urea"
      type: "text"
      label: "[[trivlab_day]] Urea (XX.X mmol/L)"
      validator: "number_1dp"
      branch: "[trivlab_uec_isnorm] = '0' and [trivlab_day] and [trivlab_day] >= 0 and [trivlab_day] != 11"
    }},
    {trivlab_urea_na: #Form & {
      type: "checkbox"
      label: "[[trivlab_day]] Is Urea not available?"
      choices: "na, Urea results are NOT available for [[trivlab_day]]"
      branch: "[trivlab_urea] = '' and [trivlab_uec_isnorm] = '0' and [trivlab_day] and [trivlab_day] >= 0 and [trivlab_day] != 11"
      req: "y"
    }},

    // Creatinine
    {trivlab_creatinine: #Form & {
      section: "Creatinine"
      type: "text"
      label: "[[trivlab_day]] Creatinine (XXX umol/L)"
      validator: "integer"
      branch: "[trivlab_uec_isnorm] = '0' and [trivlab_day] and [trivlab_day] >= 0 and [trivlab_day] != 11"
    }},
    {trivlab_creatinine_na: #Form & {
      type: "checkbox"
      label: "[[trivlab_day]] Is Creatinine not available?"
      choices: "na, Creatinine results are NOT available for [[trivlab_day]]"
      branch: "[trivlab_creatinine] = '' and [trivlab_uec_isnorm] = '0' and [trivlab_day] and [trivlab_day] >= 0 and [trivlab_day] != 11"
      req: "y"
    }},





  // Total IgG - D0 and D29 only
  {trivlab_igg: #Form & {
    section: "IgG"
    type: "text"
    label: "[[trivlab_day]] IgG (XX.XX g/L)"
    validator: "number_2dp"
    branch: "[trivlab_day] and ([trivlab_day] = 0 or [trivlab_day] = 29)"
  }},
  {trivlab_igg_na: #Form & {
    type: "checkbox"
    label: "[[trivlab_day]] Is IgG not available?"
    choices: "na, IgG results are NOT available for [[trivlab_day]]"
    branch: "[trivlab_igg] = '' and [trivlab_day] and ([trivlab_day] = 0 or [trivlab_day] = 29)"
    req: "y"
  }},

  // C3 result - D0, D15, D29 only
  {trivlab_c3: #Form & {
    section: "C3"
    type: "text"
    label: "[[trivlab_day]] C3 (X.XX g/L)"
    validator: "number_2dp"
    branch: "[trivlab_day] and ([trivlab_day] = 0 or [trivlab_day] = 15 or [trivlab_day] = 29)"
  }},
  {trivlab_c3_na: #Form & {
    type: "checkbox"
    label: "[[trivlab_day]] Is C3 not available?"
    choices: "na, C3 results are NOT available for [[trivlab_day]]"
    branch: "[trivlab_c3] = '' and [trivlab_day] and ([trivlab_day] = 0 or [trivlab_day] = 15 or [trivlab_day] = 29)"
    req: "y"
  }},

  // C4 result - D0, D15, D29 only
  {trivlab_c4: #Form & {
    section: "C4"
    type: "text"
    label: "[[trivlab_day]] C4 (X.XX g/L)"
    validator: "number_2dp"
    branch: "[trivlab_day] and ([trivlab_day] = 0 or [trivlab_day] = 15 or [trivlab_day] = 29)"
  }},
  {trivlab_c4_na: #Form & {
    type: "checkbox"
    label: "[[trivlab_day]] Is C4 not available?"
    choices: "na, C4 results are NOT available for [[trivlab_day]]"
    branch: "[trivlab_c4] = '' and [trivlab_day] and ([trivlab_day] = 0 or [trivlab_day] = 15 or [trivlab_day] = 29)"
    req: "y"
  }},

  // CH50 result - D0, D15, D29 only
  {trivlab_ch50: #Form & {
    section: "CH50"
    type: "text"
    label: "[[trivlab_day]] CH50 (XX U/mL)"
    validator: "integer"
    branch: "[trivlab_day] and ([trivlab_day] = 0 or [trivlab_day] = 15 or [trivlab_day] = 29)"
  }},
  {trivlab_ch50_na: #Form & {
    type: "checkbox"
    label: "[[trivlab_day]] Is CH50 not available?"
    choices: "na, CH50 results are NOT available for [[trivlab_day]]"
    branch: "[trivlab_ch50] = '' and [trivlab_day] and ([trivlab_day] = 0 or [trivlab_day] = 15 or [trivlab_day] = 29)"
    req: "y"
  }},





  // these question are per phage (as entered in pre-treatment)

  // user-entered phages; selected route is PER PHAGE (e.g. only iv and oral show up in this list), as entered in treatment
  for y, Y in _maxPhages*[""] {
    "trivlab_ph\(y)": #Form & {
        type: "descriptive"
        label: "<div class=\"header\">Phage: \"[pre_phage\(y+1)_name]\"</div>"
        branch: "([tre_ph_\(y)_rt(iv)] = '1' or [tre_ph_\(y)_rt(oral)] = '1')" + " and [pre_phage\(y+1)_name] and [pre_phage\(y+1)_name] !='' and [pre_num_phage]>\(y) and [trivlab_day] and ([trivlab_day] = 0 or [trivlab_day] = 15 or [trivlab_day] = 29)"
    },
    "trivlab_ph_\(y)_anti": #Form & {
        type: "yesno"
        label: "[Phage: \"[pre_phage\(y+1)_name]\"] Antiphage antibodies tested (yes/no)?"
        branch: "([tre_ph_\(y)_rt(iv)] = '1' or [tre_ph_\(y)_rt(oral)] = '1')" + " and [pre_phage\(y+1)_name] and [pre_phage\(y+1)_name] !='' and [pre_num_phage]>\(y) and [trivlab_day] and ([trivlab_day] = 0 or [trivlab_day] = 15 or [trivlab_day] = 29)"
        req: "y"
    },
    "trivlab_ph_\(y)_anti_assay": #Form & {
        type: "checkbox"
        label: "[Phage: \"[pre_phage\(y+1)_name]\"] Assay types used?"
        choices: "neutralising,Neutralising antibody assay | igmigg, IgM/IgG assay | other,Other please specify"
        branch: "[trivlab_ph_\(y)_anti]='1' and ([tre_ph_\(y)_rt(iv)] = '1' or [tre_ph_\(y)_rt(oral)] = '1')" + " and [pre_phage\(y+1)_name] and [pre_phage\(y+1)_name] !='' and [pre_num_phage]>\(y) and [trivlab_day] and ([trivlab_day] = 0 or [trivlab_day] = 15 or [trivlab_day] = 29)"
        req: "y"
    },
    "trivlab_ph_\(y)_anti_assay_oth": #Form & {
        type: "text"
        label: "[Phage: \"[pre_phage\(y+1)_name]\"] Other assay type"
        branch: "[trivlab_ph_\(y)_anti]='1' and [trivlab_ph_\(y)_anti_assay(other)]='1' and ([tre_ph_\(y)_rt(iv)] = '1' or [tre_ph_\(y)_rt(oral)] = '1')" + " and [pre_phage\(y+1)_name] and [pre_phage\(y+1)_name] !='' and [pre_num_phage]>\(y) and [trivlab_day] and ([trivlab_day] = 0 or [trivlab_day] = 15 or [trivlab_day] = 29)"
        req: "y"
        action: "@CHARLIMIT='50'"
    },
    "trivlab_ph_\(y)_anti_res": #Form & {
        type: "notes"
        label: "[Phage: \"[pre_phage\(y+1)_name]\"] Antiphage antibody result"
        branch: "[trivlab_ph_\(y)_anti]='1' and ([tre_ph_\(y)_rt(iv)] = '1' or [tre_ph_\(y)_rt(oral)] = '1')" + " and [pre_phage\(y+1)_name] and [pre_phage\(y+1)_name] !='' and [pre_num_phage]>\(y) and [trivlab_day] and ([trivlab_day] = 0 or [trivlab_day] = 15 or [trivlab_day] = 29)"
        req: "y"
    },
  },


  for x, X in _maxPathogens*[""] {
    "trivlab_pth\(x+1)_descriptive": #Form & {
        type: "descriptive"
        label: "<div class=\"header\">Pathogen \(x+1) \"[pre_pth\(x+1)_target]\"</div>"
        branch: "[pre_num_target_pathogen] > \(x) and [trivlab_day] and ([trivlab_day] = 0 or [trivlab_day] = 4 or [trivlab_day] = 8 or [trivlab_day] = 15 or [trivlab_day] = 29)"
    },
    "trivlab_pth_\(x+1)_iso": #Form & {
        type: "radio"
        label: "[Pathogen \(x+1): [pre_pth\(x+1)_target]] Pathogen isolated from site of infection?"
        choices: "isolated,Isolated | not_isolated, Not isolated | na, Not performed"
        branch: "[pre_num_target_pathogen] > \(x) and [trivlab_day] and ([trivlab_day] = 0 or [trivlab_day] = 4 or [trivlab_day] = 8 or [trivlab_day] = 15 or [trivlab_day] = 29)"
        req: "y"
    },
    "trivlab_pth_\(x+1)_iso_na_desc": #Form & {
        type: "notes"
        label: "[Pathogen \(x+1): [pre_pth\(x+1)_target]] How come isolation wasn't performed?"
        branch: "[trivlab_pth_\(x+1)_iso] = 'na' and [pre_num_target_pathogen] > \(x) and [trivlab_day] and ([trivlab_day] = 0 or [trivlab_day] = 4 or [trivlab_day] = 8 or [trivlab_day] = 15 or [trivlab_day] = 29)"
        req: "y"
    },
    "trivlab_pth_\(x+1)_iso_lyt_conf": #Form & {
        type: "radio"
        label: "[Pathogen \(x+1): [pre_pth\(x+1)_target]] Is ongoing lytic activity of phage(s) confirmed?"
        choices: "1,Yes | 0,Not tested | resistance,Evidence of anti-phage resistance"
        branch: "[trivlab_pth_\(x+1)_iso] = 'isolated' and [pre_num_target_pathogen] > \(x) and [trivlab_day] and ([trivlab_day] = 4 or [trivlab_day] = 8 or [trivlab_day] = 15 or [trivlab_day] = 29)"
        req: "y"
    },
    "trivlab_pth_\(x+1)_iso_lyt_conf_r_d": #Form & {
        type: "notes"
        label: "[Pathogen \(x+1): [pre_pth\(x+1)_target]] Please specify anti-phage resistance activity"
        branch: "[trivlab_pth_\(x+1)_iso_lyt_conf] = 'resistance' and [trivlab_pth_\(x+1)_iso] = 'isolated' and [pre_num_target_pathogen] > \(x) and [trivlab_day] and ([trivlab_day] = 4 or [trivlab_day] = 8 or [trivlab_day] = 15 or [trivlab_day] = 29)"
        req: "y"
    },
    "trivlab_pth_\(x+1)_iso_oth": #Form & {
        type: "radio"
        label: "[Pathogen \(x+1): [pre_pth\(x+1)_target]] Pathogen isolated from other site?"
        choices: "isolated,Isolated | not_isolated, Not isolated | na, Not performed"
        branch: "[pre_num_target_pathogen] > \(x) and [trivlab_day] and ([trivlab_day] = 0 or [trivlab_day] = 4 or [trivlab_day] = 8 or [trivlab_day] = 15 or [trivlab_day] = 29)"
        req: "y"
    },
    "trivlab_pth_\(x+1)_iso_oth_site": #Form & {
        type: "text"
        label: "[Pathogen \(x+1): [pre_pth\(x+1)_target]] Specify other site where pathogen was isolated"
        branch: "[trivlab_pth_\(x+1)_iso_oth] = 'isolated' and [pre_num_target_pathogen] > \(x) and [trivlab_day] and ([trivlab_day] = 0 or [trivlab_day] = 4 or [trivlab_day] = 8 or [trivlab_day] = 15 or [trivlab_day] = 29)"
        req: "y"
    },
    "trivlab_pth_\(x+1)_iso_oth_lyt_conf": #Form & {
        type: "radio"
        label: "[Pathogen \(x+1): [pre_pth\(x+1)_target]] Is ongoing lytic activity of phage(s) confirmed at [trivlab_pth_\(x+1)_iso_oth_site]?"
        choices: "1,Yes | 0,Not tested | resistance,Evidence of anti-phage resistance"
        branch: "[trivlab_pth_\(x+1)_iso_oth_site] and [trivlab_pth_\(x+1)_iso] = 'isolated' and [pre_num_target_pathogen] > \(x) and [trivlab_day] and ([trivlab_day] = 4 or [trivlab_day] = 8 or [trivlab_day] = 15 or [trivlab_day] = 29)"
        req: "y"
    },
    "trivlab_pth_\(x+1)_iso_oth_lyt_conf_r_d": #Form & {
        type: "notes"
        label: "[Pathogen \(x+1): [pre_pth\(x+1)_target]] Please specify anti-phage resistance activity"
        branch: "[trivlab_pth_\(x+1)_iso_oth_lyt_conf] = 'resistance' and [trivlab_pth_\(x+1)_iso] = 'isolated' and [pre_num_target_pathogen] > \(x) and [trivlab_day] and ([trivlab_day] = 4 or [trivlab_day] = 8 or [trivlab_day] = 15 or [trivlab_day] = 29)"
        req: "y"
    },
  },




  // WGS
  {trivlab_wgs: #Form & {
    section: "WGS"
    type: "yesno"
    label: "[[trivlab_day]] Is WGS data available for current isolate?"
    branch: "[trivlab_day] and ([trivlab_day] = 0 or [trivlab_day] = 4 or [trivlab_day] = 8 or [trivlab_day] = 15 or [trivlab_day] = 29)"
  }},
  {trivlab_wgs_loc: #Form & {
    type: "notes"
    label: "[[trivlab_day]] Where is the WGS data stored?"
    branch: "[trivlab_wgs]='1' and [trivlab_day] and ([trivlab_day] = 0 or [trivlab_day] = 4 or [trivlab_day] = 8 or [trivlab_day] = 15 or [trivlab_day] = 29)"
  }},

  {trivlab_rnatr: #Form & {
    type: "radio"
    label: "[[trivlab_day]] RNA (immune panel) transcriptomics performed?"
    choices: "yes, Yes/Sample obtained + stored | not_analysed,Sample processed but not analysed | no,No"
    branch: "[trivlab_day] and [trivlab_day] >= 0"
  }},
    {trivlab_rnatr_loc: #Form & {
      type: "notes"
      label: "[[trivlab_day]] Where is the RNA transcriptomics data stored?"
      branch: "[trivlab_rnatr]='yes' and [trivlab_day] and [trivlab_day] >= 0"
    }},
    {trivlab_rnatr_sample_loc: #Form & {
      type: "notes"
      label: "[[trivlab_day]] Where is the RNA transcriptomics sample stored?"
      branch: "([trivlab_rnatr]='yes' or [trivlab_rnatr]='not_analysed') and [trivlab_day] and [trivlab_day] >= 0"
    }},



  {trivlab_metag_samples: #Form & {
    section: "Metagenomics"
    type: "yesno"
    label: "[[trivlab_day]] Are clinical samples available for metagenomics?"
    branch: "[trivlab_day] and [trivlab_day] >= 0"
  }},
    {trivlab_metag_type: #Form & {
      type: "text"
      label: "[[trivlab_day]] Specify type of sample"
      branch: "[trivlab_metag_samples]='1' and [trivlab_day] and [trivlab_day] >= 0"
    }},
    {trivlab_metag_has: #Form & {
      type: "radio"
      label: "[[trivlab_day]] Have metagenomics been performed?"
      choices: "1,Yes | 0, No, samples stored"
      branch: "[trivlab_metag_samples]='1' and [trivlab_day] and [trivlab_day] >= 0"
    }},
    {trivlab_metag_data_loc: #Form & {
      type: "notes"
      label: "[[trivlab_day]] Where is the metagenome data stored?"
      branch: "[trivlab_metag_has]='1' and [trivlab_day] and [trivlab_day] >= 0"
    }},
    {trivlab_metag_sample_loc: #Form & {
      type: "notes"
      label: "[[trivlab_day]] Where is the sample stored?"
      branch: "[trivlab_metag_has]='0' and [trivlab_day] and [trivlab_day] >= 0"
    }},

],





