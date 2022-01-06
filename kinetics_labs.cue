package ecrf

import "strings"



// Kinetics - labs
// This page opens if
// - [IV, oral/enteral] phage therapy selected from the treatment page (_trivcl_inclusion)
// these rely on Repeatable Instruments (Project Settings > Enable Repeatable Instruments)

kinetics_labs: [
  {kino_no_inclusion_msg: #Form & {
      _no_inclusion_msg
  }},
  {kino_descriptive: #Form & {
    type: "descriptive"
    label: "<div class=\"header\"><h2>Kinetics Labs</h2> <br><br>This page opens when IV and/or oral/enteral phage therapy are selected from the Treatment page. </div>"
  }},
  {kino_noninclusion: #Form & {
    type: "descriptive"
    label: "<div class=\"header\">This patient does not meet IV or oral/enteral phage therapy requirements</div>"
    branch: "\(_trivcl_noninclusion)"
  }},
  {kino_day: #Form & {
    type: "radio"
    label: "Select clinical day of treatment:"
    choices: strings.Join([for _,x in [2,4,8,11,15,29] { "\(x), D\(x)" }], " | ")
    branch: "\(_inclusion) and \(_trivcl_inclusion)"
    req: "y"
  }},



  // 
  // Pre-Dose / Morning
  // 

  // Phage result plaque assay
  {kino_pre_plaque: #Form & {
    section: "Pre-dose / morning"
    type: "text"
    label: "[[kino_day]][Pre-Dose] Phage result plaque assay (XX PFU/mL)"
    validator: "integer"
    branch: "[kino_day] >= 0 and [kino_day]"
  }},
  {kino_pre_plaque_na: #Form & {
    type: "checkbox"
    label: "[[kino_day]][Pre-Dose] Are plaque assays not available?"
    choices: "na, Plaque assays are NOT available for [[kino_day]]"
    branch: "[kino_pre_plaque] = '' and [kino_day] and [kino_day] >= 0"
    req: "y"
  }},

  // Phage result qPCR
  {kino_pre_ph_qpcr: #Form & {
    type: "text"
    label: "[[kino_day]][Pre-Dose] Phage qPCR results (XX genome copies/mL)"
    validator: "integer"
    branch: "[kino_day] >= 0 and [kino_day]"
  }},
  {kino_pre_ph_qpcr_na: #Form & {
    type: "checkbox"
    label: "[[kino_day]][Pre-Dose] Are phage qPCR results not available?"
    choices: "na, Phage qPCR results are NOT available for [[kino_day]]"
    branch: "[kino_pre_ph_qpcr] = '' and [kino_day] and [kino_day] >= 0"
    req: "y"
  }},

  // Phage result qPCR
  {kino_pre_bact_qpcr: #Form & {
    type: "text"
    label: "[[kino_day]][Pre-Dose] Bacterial load qPCR results (XX genome copies/mL)"
    validator: "integer"
    branch: "[kino_day] >= 0 and [kino_day]"
  }},
  {kino_pre_bact_qpcr_na: #Form & {
    type: "checkbox"
    label: "[[kino_day]][Pre-Dose] Are bacterial load qPCR results not available?"
    choices: "na, Phage qPCR results are NOT available for [[kino_day]]"
    branch: "[kino_pre_bact_qpcr] = '' and [kino_day] and [kino_day] >= 0"
    req: "y"
  }},



  // 
  // 30-60 minutes post-dose
  // 

  // Phage result qPCR
  {kino_post_ph_qpcr: #Form & {
    section: "30-60 minutes post-dose"
    type: "text"
    label: "[[kino_day]][30-60 minutes post-dose] Phage qPCR results (XX genome copies/mL)"
    validator: "integer"
    branch: "[kino_day] >= 0 and [kino_day] and [kino_day] != 15 and [kino_day] != 29"
  }},
  {kino_post_ph_qpcr_na: #Form & {
    type: "checkbox"
    label: "[[kino_day]][30-60 minutes post-dose] Are phage qPCR results not available?"
    choices: "na, Phage qPCR results are NOT available for [[kino_day]]"
    branch: "[kino_post_ph_qpcr] = '' and [kino_day] and [kino_day] >= 0 and [kino_day] != 15 and [kino_day] != 29"
    req: "y"
  }},

  // Phage result qPCR
  {kino_post_bact_qpcr: #Form & {
    type: "text"
    label: "[[kino_day]][30-60 minutes post-dose] Bacterial load qPCR results (XX genome copies/mL)"
    validator: "integer"
    branch: "[kino_day] >= 0 and [kino_day] and [kino_day] != 15 and [kino_day] != 29"
  }},
  {kino_post_bact_qpcr_na: #Form & {
    type: "checkbox"
    label: "[[kino_day]][30-60 minutes post-dose] Are bacterial load qPCR results not available?"
    choices: "na, Phage qPCR results are NOT available for [[kino_day]]"
    branch: "[kino_post_bact_qpcr] = '' and [kino_day] and [kino_day] >= 0 and [kino_day] != 15 and [kino_day] != 29"
    req: "y"
  }},







  // 
  // 2-3 hours post-dose
  // 

  // Phage result plaque assay
  {kino_lngpost_plaque: #Form & {
    section: "2-3 hours post-dose"
    type: "text"
    label: "[[kino_day]][2-3 hours post-dose] Phage result plaque assay (XX PFU/mL)"
    validator: "integer"
    branch: "[kino_day] >= 0 and [kino_day]"
  }},
  {kino_lngpost_plaque_na: #Form & {
    type: "checkbox"
    label: "[[kino_day]][2-3 hours post-dose] Are plaque assays not available?"
    choices: "na, Plaque assays are NOT available for [[kino_day]]"
    branch: "[kino_lngpost_plaque] = '' and [kino_day] and [kino_day] >= 0 and [kino_day] != 15 and [kino_day] != 29"
    req: "y"
  }},

  // Phage result qPCR
  {kino_lngpost_ph_qpcr: #Form & {
    type: "text"
    label: "[[kino_day]][2-3 hours post-dose] Phage qPCR results (XX genome copies/mL)"
    validator: "integer"
    branch: "[kino_day] >= 0 and [kino_day] and [kino_day] != 15 and [kino_day] != 29"
  }},
  {kino_lngpost_ph_qpcr_na: #Form & {
    type: "checkbox"
    label: "[[kino_day]][2-3 hours post-dose] Are phage qPCR results not available?"
    choices: "na, Phage qPCR results are NOT available for [[kino_day]]"
    branch: "[kino_lngpost_ph_qpcr] = '' and [kino_day] and [kino_day] >= 0 and [kino_day] != 15 and [kino_day] != 29"
    req: "y"
  }},

  // Phage result qPCR
  {kino_lngpost_bact_qpcr: #Form & {
    type: "text"
    label: "[[kino_day]][2-3 hours post-dose] Bacterial load qPCR results (XX genome copies/mL)"
    validator: "integer"
    branch: "[kino_day] >= 0 and [kino_day] and [kino_day] != 15 and [kino_day] != 29"
  }},
  {kino_lngpost_bact_qpcr_na: #Form & {
    type: "checkbox"
    label: "[[kino_day]][2-3 hours post-dose] Are bacterial load qPCR results not available?"
    choices: "na, Phage qPCR results are NOT available for [[kino_day]]"
    branch: "[kino_lngpost_bact_qpcr] = '' and [kino_day] and [kino_day] >= 0 and [kino_day] != 15 and [kino_day] != 29"
    req: "y"
  }},




]