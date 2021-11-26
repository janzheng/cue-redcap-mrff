package ecrf

import "strings"


// IV administration - clinical
// This page opens if
// - [IV, oral/enteral] phage therapy selected from the treatment page
// these rely on Repeatable Instruments (Project Settings > Enable Repeatable Instruments)

// config + prep
_clinDays: ["D0","D1","D2","D3","D4","D5","D6","D7","D8","D9","D10","D11","D12","D13","D14","D15-28","D29",]
_clinDaysKeys: [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,29]
//_clinDaysKeys: [for d, D in _clinDays { strings.Replace(strings.ToLower(D),"-","_",-1) }]
_clinChoices: strings.Join([for d, D in _clinDaysKeys { "\(D), \(_clinDays[d])"}], " | ")
_trivcl_inclusion: strings.Join([for y, Y in _maxPhages*[""] {"([tre_ph_\(y)_rt(iv)] = '1' or [tre_ph_\(y)_rt(oral)] = '1')"}], " or ")

// these are re-used D1-D14
_clin_doses: {
  type: "radio"
  label: "Number of doses (select 1 or 2)"
  choices: "1,1 | 2,2"
  req: "y"
}
_clin_doses_vitals: {
  type: "checkbox"
  label: "Confirm vitals taken pre-dose"
  choices: "confirmed,Confirmed"
  req: "y"
}
_clin_doses_vitals_15m: {
  type: "checkbox"
  label: "Confirm vitals taken 15 minutes after dose"
  choices: "confirmed,Confirmed"
  req: "y"
}
_clin_doses_vitals_30m: {
  type: "checkbox"
  label: "Confirm vitals taken 30 minutes after dose?"
  choices: "confirmed,Confirmed"
  req: "y"
}

_clin_deviation: {
  type: "yesno"
  label: "Protocol deviation?"
  req: "y"
}
_clin_deviation_desc: {
  type: "notes"
  label: "Describe the protocol deviation"
  req: "y"
}

_clin_fever_high: {
  type: "yesno"
  label: "Did fever (temp > 37.9 °C) occur today (yes/no)?"
  req: "y"
}
_clin_fever_high_pre_next_mo: {
  type: "text"
  label: "Specify max temp occurring prior to morning dose of next day (XX.X °C)"
  validator: "number_1dp"
  req: "y"
}
_clin_fever_high_time_of_max: {
  type: "text"
  label: "Specify time of max fever in hours after morning phage dose (X.X hours)"
  validator: "number_1dp"
  req: "y"
}

_clin_tachy: {
  type: "yesno"
  label: "Did tachycardia occur today (yes/no)?"
  req: "y"
}
_clin_tachy_max_hr: {
  type: "text"
  label: "Specify max HR occurring prior to morning dose of next day"
  validator: "integer"
  req: "y"
}
_clin_tachy_time_of_max: {
  type: "text"
  label: "Specify time of max HR in hours after morning phage dose (X.X hours)"
  validator: "number_1dp"
  req: "y"
}

_clin_pain: {
  type: "yesno"
  label: "Did pain occur today (greater than any baseline pain) - yes/no?"
  req: "y"
}
_clin_pain_hours_after: {
  type: "text"
  label: "Specify time of pain occurrence in hours after morning phage dose (X.X hours)"
  validator: "number_1dp"
  req: "y"
}
_clin_pain_site: {
  type: "text"
  label: "Specify site of pain"
  action: "@CHARLIMIT=50"
  req: "y"
}


_clin_inflam: {
  type: "yesno"
  label: "Any other signs or symptoms of inflammatory response (yes/no)?"
  req: "y"
}
_clin_inflam_desc: {
  type: "notes"
  label: "If yes, specify what occurred"
  req: "y"
}
_clin_inflam_hours_after: {
  type: "text"
  label: "Also specify time of occurrence in hours after morning phage dose (X.X hours)"
  validator: "number_1dp"
  req: "y"
}

_clin_dose_adjusted: {
  type: "yesno"
  label: "Dose adjusted based on \"kinetics\" results (yes/no)?"
  req: "y"
}
_clin_dose_adjusted_inc_dec: {
  type: "radio"
  label: string | *"If yes, selected dose increased/dose reduced?"
  choices: "inc, Dose increased | dec, Dose decreased"
  req: "y"
}


// days 1,2
_d1_14: {
  // doses + vitals
  "trivcl_1_doses": #Form & _clin_doses & {
    branch: "([trivcl_day] > 0 and [trivcl_day] <= 14)"
    }
  for _dose in [1,2] {
    "trivcl_1_doses\(_dose)_vitals": #Form & _clin_doses_vitals & {
      branch: "([trivcl_day] > 0 and [trivcl_day] <= 14) and [trivcl_1_doses]>='\(_dose)'"
      fieldnote: "Dose #\(_dose)"
    }
    "trivcl_1_doses\(_dose)_vitals_15m": #Form & _clin_doses_vitals_15m & {
      branch: "([trivcl_day] > 0 and [trivcl_day] <= 14) and [trivcl_1_doses]>='\(_dose)'"
      fieldnote: "Dose #\(_dose)"
      }
    "trivcl_1_doses\(_dose)_vitals_30m": #Form & _clin_doses_vitals_30m & {
      branch: "([trivcl_day] > 0 and [trivcl_day] <= 14) and [trivcl_1_doses]>='\(_dose)'"
      fieldnote: "Dose #\(_dose)"
      }

    // days 3-14 has a few more questions
    "trivcl_1_doses\(_dose)_7_adjusted": #Form & _clin_dose_adjusted & {
      fieldnote: "Dose #\(_dose)"
      branch: "[trivcl_day] > 3 and [trivcl_day] <= 14"
    }
    "trivcl_1_doses\(_dose)_7_adjusted_inc_dec": #Form & _clin_dose_adjusted_inc_dec & {
      label: "[\(_dose)] If yes, selected dose increased/dose reduced?"
      branch: "[trivcl_day] > 3 and [trivcl_day] <= 14 and [trivcl_1_doses\(_dose)_7_adjusted] = '1'"
    }
  }

  // clinical deviation
  "trivcl_2_dev": #Form & _clin_deviation & {
    branch: "([trivcl_day] > 0 and [trivcl_day] <= 14)"
  }
  "trivcl_2_dev_desc": #Form & _clin_deviation_desc & {
    branch: "[trivcl_2_dev] = '1'"
  }

  // high fever
  "trivcl_3_fever_high": #Form & _clin_fever_high & {
    branch: "([trivcl_day] > 0 and [trivcl_day] <= 14)"
  }
  "trivcl_3_fever_high_pre_next_mo": #Form & _clin_fever_high_pre_next_mo & {
    branch: "[trivcl_3_fever_high] = '1'"
  }
  "trivcl_3_fever_high_time_of_max": #Form & _clin_fever_high_time_of_max & {
    branch: "[trivcl_3_fever_high] = '1'"
  }

  // tachy
  "trivcl_4_tachy": #Form & _clin_tachy & {
    branch: "([trivcl_day] > 0 and [trivcl_day] <= 14)"
  }
  "trivcl_4_tachy_max_hr": #Form & _clin_tachy_max_hr & {
    branch: "[trivcl_4_tachy] = '1'"
  }
  "trivcl_4_tachy_time_of_max": #Form & _clin_tachy_time_of_max & {
    branch: "[trivcl_4_tachy] = '1'"
  }

  // pain
  "trivcl_5_pain": #Form & _clin_pain & {
    branch: "([trivcl_day] > 0 and [trivcl_day] <= 14)"
  }
  "trivcl_5_pain_hours_after": #Form & _clin_pain_hours_after & {
    branch: "[trivcl_5_pain] = '1'"
  }
  "trivcl_5_pain_site": #Form & _clin_pain_site & {
    branch: "[trivcl_5_pain] = '1'"
  }

  // inflammation
  "trivcl_6_inflam": #Form & _clin_inflam & {
    branch: "([trivcl_day] > 0 and [trivcl_day] <= 14)"
  }
  "trivcl_6_inflam_hours_after": #Form & _clin_inflam_desc & {
    branch: "[trivcl_6_inflam] = '1'"
  }
  "trivcl_6_inflam_site": #Form & _clin_inflam_hours_after & {
    branch: "[trivcl_6_inflam] = '1'"
  }
}
_d1_14_sorted: #SortByKey & {in: {_d1_14}}



// full implementation
treatment_iv_clinical: [
  {trivcl_no_inclusion_msg: #Form & {
      _no_inclusion_msg
  }},
  {"triv_descriptive": #Form & {
      type: "descriptive"
      label: "<div class=\"header\">Clinical IV Administration. <br><br>This page opens when IV or oral/enteral phage therapy is selected from the Treatment page. </div>"
  }},
  {trivcl_day: #Form & {
    type: "radio"
    label: "Select clinical day of treatment — [trivcl_day]"
    choices: _clinChoices
    branch: "\(_inclusion) and \(_trivcl_inclusion)"
    req: "y"
  }},
  {trivcl_d0_confirm: #Form & {
    type: "checkbox"
    label: "[D0] Confirm full clinical exam"
    choices: "yes, Patient has received full clinical exam"
    branch: "[trivcl_day] = '0'"
    req: "y"
  }},
  // days 1-14
  _d1_14_sorted["sorted"],
  

  // days 15-28
  {trivcl_d15_28_cont_pht: #Form & {
    type: "yesno"
    label: "Is patient still receiving phage therapy (yes/no)? "
    branch: "[trivcl_day] = '15'"
    req: "y"
  }},
  // if Yes, patient still receiving PT
    {trivcl_d15_28_doses: #Form & {
      type: "radio"
      label: "Number of doses/day"
      choices: "1,1 | 2,2 | 3,Has changed during this time"
      branch: "[trivcl_day] = '15' and [trivcl_d15_28_cont_pht] = '1'"
      req: "y"
    }},
    {trivcl_d15_28_pht_vitals: #Form & {
      type: "yesno"
      label: "Were vitals checked each day of treatment as per protocol (yes/no)?"
      branch: "[trivcl_day] = '15' and [trivcl_d15_28_cont_pht] = '1' "
      req: "y"
    }},
    {trivcl_d15_28_4wks: #Form & {
      type: "yesno"
      label: "Will treatment continue >4 weeks (yes/no)?"
      branch: "[trivcl_day] = '15' and [trivcl_d15_28_cont_pht] = '1' "
      req: "y"
    }},
    {trivcl_d15_28_pht_days: #Form & {
      type: "radio"
      label: "How many days of phage therapy did participant receive? Enter a number between 15 to 28 (inclusive)"
      branch: "[trivcl_day] = '15' and [trivcl_d15_28_4wks] = '0' "
      choices: strings.Join([for _,x in 14*[""] {"\(_+15),\(_+15)"}], " | ")
      req: "y"
    }},
    {trivcl_d15_28_hi_fever: #Form & {
      type: "yesno"
      label: "Did fever (temp > 37.9 °C) occur on any (yes/no)?"
      branch: "[trivcl_day] = '15' and [trivcl_d15_28_cont_pht] = '1' "
      req: "y"
    }},
    {trivcl_d15_28_hi_fever_days: #Form & {
      type: "checkbox"
      label: "Specify day(s) of fever"
      choices: strings.Join([for _,x in 14*[""] {"\(_+15),\(_+15)"}], " | ")
      branch: "[trivcl_day] = '15' and [trivcl_d15_28_cont_pht] = '1' and [trivcl_d15_28_hi_fever] = '1'"
      req: "y"
    }},
    for _,x in 14*[""] {
      "trivcl_d15_28_hi_fever_d\(_+15)": #Form & {
        type: "text"
        label: "Specify the max fever occurring in 24 hours after 6am for day D\(_+15)"
        validator: "number"
        branch: "[trivcl_d15_28_hi_fever_days(\(_+15))] = '1' "
      }
    }
    {trivcl_d15_28_tachy: #Form & {
      type: "yesno"
      label: "Did tachycardia on any day (yes/no)?"
      branch: "[trivcl_day] = '15' and [trivcl_d15_28_cont_pht] = '1' "
      req: "y"
    }},
    {trivcl_d15_28_tachy_days: #Form & {
      type: "checkbox"
      label: "Specify day(s) of tachycardia"
      choices: strings.Join([for _,x in 14*[""] {"\(_+15),\(_+15)"}], " | ")
      branch: "[trivcl_day] = '15' and [trivcl_d15_28_cont_pht] = '1' and [trivcl_d15_28_tachy] = '1'"
      req: "y"
    }},
    {trivcl_d15_28_pain: #Form & {
      type: "yesno"
      label: "Did pain occur on any day (greater than any baseline pain)"
      branch: "[trivcl_day] = '15' and [trivcl_d15_28_cont_pht] = '1' "
      req: "y"
    }},
    {trivcl_d15_28_pain_days: #Form & {
      type: "checkbox"
      label: "Specify day(s) of pain"
      choices: strings.Join([for _,x in 14*[""] {"\(_+15),\(_+15)"}], " | ")
      branch: "[trivcl_day] = '15' and [trivcl_d15_28_cont_pht] = '1' and [trivcl_d15_28_pain] = '1'"
      req: "y"
    }},
    for _,x in 14*[""] {
      "trivcl_d15_28_pain_\(_+15)": #Form & {
        type: "text"
        label: "Specify site of pain for day D\(_+15)"
        branch: "[trivcl_d15_28_pain_days(\(_+15))] = '1' "
        action: "@CHARLIMIT='50'"
        req: "y"
      }
    }
    {trivcl_d15_28_inflam: #Form & {
      type: "yesno"
      label: "Any other signs or symptoms of inflammatory response on any day (yes/no)?"
      branch: "[trivcl_day] = '15' and [trivcl_d15_28_cont_pht] = '1' "
      req: "y"
    }},
    {trivcl_d15_28_inflam_days: #Form & {
      type: "checkbox"
      label: "Specify day(s) of inflammatory response"
      choices: strings.Join([for _,x in 14*[""] {"\(_+15),\(_+15)"}], " | ")
      branch: "[trivcl_day] = '15' and [trivcl_d15_28_cont_pht] = '1' and [trivcl_d15_28_inflam] = '1'"
      req: "y"
    }},
    for _,x in 14*[""] {
      "trivcl_d15_28_inflam_\(_+15)": #Form & {
        type: "text"
        label: "Specify what occurred for day D\(_+15)"
        branch: "[trivcl_d15_28_inflam_days(\(_+15))] = '1' "
        action: "@CHARLIMIT='50'"
        req: "y"
      }
    }
    {trivcl_d15_28_dose_adj: #Form & {
      type: "yesno"
      label: "Dose adjusted on any day based on \"kinetics\" results (yes/no)?"
      branch: "[trivcl_day] = '15' and [trivcl_d15_28_cont_pht] = '1' "
      req: "y"
    }},
    {trivcl_d15_28_dose_adj_change: #Form & {
      type: "radio"
      label: "Did the dose:"
      choices: "inc, Dose increased | dec, Dose reduced | both, Both increases and reductions have occurred"
      branch: "[trivcl_day] = '15' and [trivcl_d15_28_cont_pht] = '1' and [trivcl_d15_28_dose_adj] = '1' "
      req: "y"
    }},
  // if no, not receiving anymore
  {trivcl_d15_28_clin_resp: #Form & {
    type: "radio"
    label: "What has been the clinical response to phage therapy?"
    choices: " cure, 1) Cure – no evidence of ongoing infection: resolution of clinical symptoms and signs, radiological and laboratory parameters of disease, and microbiological clearance of target pathogen from site of infection | partial, 2) Partial response | no_response, 3) No response – evidence of ongoing infection with worsening clinical signs and symptoms, radiological or laboratory parameters of disease"
    branch: "[trivcl_day] = '15' and [trivcl_d15_28_cont_pht] = '0'"
    req: "y"
  }},
    {trivcl_d15_28_clin_resp_cure_dis: #Form & {
      type: "radio"
      label: "Select one of:"
      choices: "no_disability, Without persisting disability | disability, With persisting disability"
      branch: "[trivcl_day] = '15' and [trivcl_d15_28_cont_pht] = '0' and [trivcl_d15_28_clin_resp] = 'cure' "
      req: "y"
    }},
    {trivcl_d15_28_clin_resp_partial: #Form & {
      type: "radio"
      label: "Select one of:"
      choices: "improvement, Improvement in clinical signs and symptoms, radiological or laboratory parameters of disease, but with evidence that infection is not completely resolved | stabilisation, Stabilisation of previously documented decline in function, but without obvious improvements, and evidence that infection is not completely resolved"
      branch: "[trivcl_day] = '15' and [trivcl_d15_28_cont_pht] = '0' and [trivcl_d15_28_clin_resp] = 'partial' "
      req: "y"
    }},
],


