package ecrf

// import "strings"



// IV administration / Monthly Monitorig- labs 
// This page opens if
// - [IV, oral/enteral] phage therapy selected from the treatment page (_trivcl_inclusion)
// - Duration > 2 weeks
// these rely on Repeatable Instruments (Project Settings > Enable Repeatable Instruments)

// _show_labs: "([othmo_phage_cont] = \"1\" or [othmo_phage_stop_mo] = \"1\")"

other_routes_monthly: [
  {othmo_no_inclusion_msg: #Form & {
      _no_inclusion_msg
  }},
  {othmo_descriptive: #Form & {
    type: "descriptive"
    label: "<div class=\"header\"><h2>Other Routes [Monthly Monitoring]</h2> Use this instrument for monthly treatment monitoring.<br><br>This page opens when non IV and/or oral/enteral phage therapy are selected from the Treatment page. </div>"
  }},
  {othmo_noninclusion: #Form & {
    type: "descriptive"
    label: "<div class=\"header\">This patient does not meet IV or oral/enteral phage therapy requirements</div>"
    branch: "\(_trivcl_inclusion)"
  }},
  {othmo_mth: #Form & {
    type: "text"
    label: "Month after first dose of phage administered (e.g. Month 2)"
    validator: "integer"
    branch: "\(_inclusion) and \(_trivcl_noninclusion)"
    req: "y"
  }},

  {othmo_phage_cont: #Form & {
    type: "yesno"
    label: "[Month [othmo_mth]] Is the patient still receiving phage therapy?"
    branch: "\(_inclusion) and \(_trivcl_inclusion)"
    req: "y"
  }},
  {othmo_phage_stop_mo: #Form & {
    type: "yesno"
    label: "[Month [othmo_mth]] Did the patient stop phage therapy within the last month?"
    branch: "[othmo_phage_cont] and [othmo_phage_cont] = 0"
    req: "y"
  }},


  {othmo_phage_resp: #Form & {
    type: "radio"
    label: "[Month [othmo_mth]] What has been the clinical response to phage therapy?"
    choices: "cure, No evidence of ongoing infection: resolution of clinical symptoms and signs, radiological and laboratory parameters of disease, and microbiological clearance of target pathogen from site of infection| partial, Partial response | none, No response – evidence of ongoing infection with worsening clinical signs and symptoms, radiological or laboratory parameters of disease | na, Unable to assess – participant received less than 3 doses of phage in total"
    branch: "[othmo_phage_stop_mo] = \"1\""
    req: "y"
  }},
  {othmo_phage_disability: #Form & {
    type: "radio"
    label: "[Month [othmo_mth]] Any disabilities?"
    choices: "no_disability, Without persisting disability | with_disability, With persisting disability"
    branch: "[othmo_phage_resp] = \"cure\""
    req: "y"
  }},
  {othmo_phage_partial: #Form & {
    type: "radio"
    label: "[Month [othmo_mth]] Partial response:"
    choices: "improvement, Improvement in clinical signs and symptoms, radiological or laboratory parameters of disease, but with evidence that infection is not completely resolved | stabilisation, Stabilisation of previously documented decline in function, but without obvious improvements, and evidence that infection is not completely resolved"
    branch: "[othmo_phage_resp] = \"partial\""
    req: "y"
  }},






  // FBC all within normal range (yes/no)?
  {othmo_fbc_isnorm: #Form & {
    section: "FBC"
    type: "yesno"
    label: "[Month [othmo_mth]] FBC all within normal range (yes/no)?"
    branch: "\(_show_labs)" // skip day 11
  }},
  // if "No" to FBC, do the following (col I-R)
    // Hb result
    {othmo_hb: #Form & {
      section: "Hb results"
      type: "text"
      label: "[Month [othmo_mth]] Hb result (XXX g/L)"
      validator: "integer"
      branch: "[othmo_fbc_isnorm] = '0' and \(_show_labs)" // skip day 11
    }},
    {othmo_hb_na: #Form & {
      type: "checkbox"
      label: "[Month [othmo_mth]] Are Hb results NOT available?"
      choices: "na, Hb results NOT available [Month [othmo_mth]]"
      branch: "[othmo_hb] = '' and [othmo_fbc_isnorm] = '0' and \(_show_labs)" // skip day 11
      req: "y"
    }},

    // Platelet count
    {othmo_platelet: #Form & {
      section: "Platelet count"
      type: "text"
      label: "[Month [othmo_mth]] Platelet result (XXX x10^9/L)"
      validator: "integer"
      branch: "[othmo_fbc_isnorm] = '0' and \(_show_labs)" // skip day 11
    }},
    {othmo_platelet_na: #Form & {
      type: "checkbox"
      label: "[Month [othmo_mth]] Are Platelet count results NOT available?"
      choices: "na, Platelet count results NOT available [Month [othmo_mth]]"
      branch: "[othmo_platelet] = '' and [othmo_fbc_isnorm] = '0' and \(_show_labs)" // skip day 11
      req: "y"
    }},
    
    // WCC
    {othmo_wcc: #Form & {
      section: "WCC"
      type: "text"
      label: "[Month [othmo_mth]] WCC (XXX x10^9/L)"
      validator: "integer"
      branch: "[othmo_fbc_isnorm] = '0' and \(_show_labs)" // skip day 11
    }},
    {othmo_wcc_na: #Form & {
      type: "checkbox"
      label: "[Month [othmo_mth]] Are WCC results NOT available?"
      choices: "na, WCC results NOT available [Month [othmo_mth]]"
      branch: "[othmo_wcc] = '' and [othmo_fbc_isnorm] = '0' and \(_show_labs)" // skip day 11
      req: "y"
    }},

    // Neutrophil count
    {othmo_neutrophil: #Form & {
      section: "Neutrophil count"
      type: "text"
      label: "[Month [othmo_mth]] Neutrophil count (XX.X x10^9/L)"
      validator: "number_1dp"
      branch: "[othmo_fbc_isnorm] = '0' and \(_show_labs)" // skip day 11
    }},
    {othmo_neutrophil_na: #Form & {
      type: "checkbox"
      label: "[Month [othmo_mth]] Are neutrophil count results NOT available?"
      choices: "na, neutrophil count results NOT available [Month [othmo_mth]]"
      branch: "[othmo_neutrophil] = '' and [othmo_fbc_isnorm] = '0' and \(_show_labs)" // skip day 11
      req: "y"
    }},

    // Lymphocyte count
    {othmo_lymphocite: #Form & {
      section: "Lymphocyte count"
      type: "text"
      label: "[Month [othmo_mth]] Lymphocyte count (XX.X x10^9/L)"
      validator: "number_1dp"
      branch: "[othmo_fbc_isnorm] = '0' and \(_show_labs)" // skip day 11
    }},
    {othmo_lymphocite_na: #Form & {
      type: "checkbox"
      label: "[Month [othmo_mth]] Are Lymphocyte count results NOT available?"
      choices: "na, Lymphocyte count results NOT available [Month [othmo_mth]]"
      branch: "[othmo_lymphocite] = '' and [othmo_fbc_isnorm] = '0' and \(_show_labs)" // skip day 11
      req: "y"
    }},




    for x, X in _maxPathogens*[""] {
      "othmo_pth\(x+1)_descriptive": #Form & {
          type: "descriptive"
          label: "<div class=\"header\">Pathogen \(x+1) \"[pre_pth\(x+1)_target]\"</div>"
          branch: "[pre_num_target_pathogen] > \(x) and \(_show_labs)"
      },
      "othmo_pth_\(x+1)_iso": #Form & {
          type: "radio"
          label: "[Pathogen \(x+1): [pre_pth\(x+1)_target]] Pathogen isolated from site of infection?"
          choices: "isolated,Isolated | not_isolated, Not isolated | na, Not performed"
          branch: "[pre_num_target_pathogen] > \(x) and \(_show_labs)"
          req: "y"
      },
      "othmo_pth_\(x+1)_iso_na_desc": #Form & {
          type: "notes"
          label: "[Pathogen \(x+1): [pre_pth\(x+1)_target]] How come isolation wasn't performed?"
          branch: "[othmo_pth_\(x+1)_iso] = 'na' and [pre_num_target_pathogen] > \(x) and \(_show_labs)"
          req: "y"
      },
      "othmo_pth_\(x+1)_iso_lyt_conf": #Form & {
          type: "radio"
          label: "[Pathogen \(x+1): [pre_pth\(x+1)_target]] Is ongoing lytic activity of phage(s) confirmed?"
          choices: "1,Yes | 0,Not tested | resistance,Evidence of anti-phage resistance"
          branch: "[othmo_pth_\(x+1)_iso] = 'isolated' and [pre_num_target_pathogen] > \(x) and \(_show_labs)"
          req: "y"
      },
      "othmo_pth_\(x+1)_iso_lyt_conf_r_d": #Form & {
          type: "notes"
          label: "[Pathogen \(x+1): [pre_pth\(x+1)_target]] Please specify anti-phage resistance activity"
          branch: "[othmo_pth_\(x+1)_iso_lyt_conf] = 'resistance' and [othmo_pth_\(x+1)_iso] = 'isolated' and [pre_num_target_pathogen] > \(x) and \(_show_labs)"
          req: "y"
      },
      "othmo_pth_\(x+1)_iso_oth": #Form & {
          type: "radio"
          label: "[Pathogen \(x+1): [pre_pth\(x+1)_target]] Pathogen isolated from other site?"
          choices: "isolated,Isolated | not_isolated, Not isolated | na, Not performed"
          branch: "[pre_num_target_pathogen] > \(x) and \(_show_labs)"
          req: "y"
      },
      "othmo_pth_\(x+1)_iso_oth_site": #Form & {
          type: "text"
          label: "[Pathogen \(x+1): [pre_pth\(x+1)_target]] Specify other site where pathogen was isolated"
          branch: "[othmo_pth_\(x+1)_iso_oth] = 'isolated' and [pre_num_target_pathogen] > \(x) and \(_show_labs)"
          req: "y"
      },
      "othmo_pth_\(x+1)_iso_oth_lyt_conf": #Form & {
          type: "radio"
          label: "[Pathogen \(x+1): [pre_pth\(x+1)_target]] Is ongoing lytic activity of phage(s) confirmed at [othmo_pth_\(x+1)_iso_oth_site]?"
          choices: "1,Yes | 0,Not tested | resistance,Evidence of anti-phage resistance"
          branch: "[othmo_pth_\(x+1)_iso_oth_site] and [othmo_pth_\(x+1)_iso] = 'isolated' and [pre_num_target_pathogen] > \(x) and \(_show_labs)"
          req: "y"
      },
      "othmo_pth_\(x+1)_iso_oth_lyt_conf_r_d": #Form & {
          type: "notes"
          label: "[Pathogen \(x+1): [pre_pth\(x+1)_target]] Please specify anti-phage resistance activity"
          branch: "[othmo_pth_\(x+1)_iso_oth_lyt_conf] = 'resistance' and [othmo_pth_\(x+1)_iso] = 'isolated' and [pre_num_target_pathogen] > \(x) and \(_show_labs)"
          req: "y"
      },
    },

    // WGS
    {othmo_wgs: #Form & {
      section: "WGS"
      type: "yesno"
      label: "[Month [othmo_mth]] Is WGS data available for current isolate?"
      branch: "\(_show_labs)"
    }},
    {othmo_wgs_loc: #Form & {
      type: "notes"
      label: "[Month [othmo_mth]] Where is the WGS data stored?"
      branch: "[othmo_wgs]='1' and \(_show_labs)"
    }},


]