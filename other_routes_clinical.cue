package ecrf

import "strings"



// Other Routes - Clinical  
// This page should appear if any other routes of administration other than IV or oral/enteral selected from the treatment generic page
// 
// - [IV, oral/enteral] phage therapy NOT selected from the treatment page (_trivcl_noninclusion)
// these rely on Repeatable Instruments (Project Settings > Enable Repeatable Instruments)

_othClinDaysKeys: [15,16,17,18,19,20,21,22,23,24,25,26,27,28]


other_routes_clinical: [
  {othcli_no_inclusion_msg: #Form & {
      _no_inclusion_msg
  }},
  {othcli_descriptive: #Form & {
    type: "descriptive"
    label: "<div class=\"header\"><h2>Other Routes - Clinical</h2><br><br>This page opens when non IV and/or oral/enteral phage therapy are selected from the Treatment page. </div>"
  }},
  {othcli_noninclusion: #Form & {
    type: "descriptive"
    label: "<div class=\"header\">This instrument is for patients who are NOT receiving IV or non-oral/enteral phage therapy</div>"
    branch: "\(_trivcl_inclusion)"
  }},
  {othcli_day: #Form & {
    type: "radio"
    label: "Select clinical day of treatment:"
    choices: strings.Join([for _,x in [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,"15-28"] { "\(x), D\(x)" }], " | ")
    branch: "\(_inclusion) and \(_trivcl_noninclusion)"
    req: "y"
  }},





  // 
  // D0 to D14
  // 

  {othcli_vitals: #Form & {
    type: "yesno"
    label: "[[othcli_day]] Vitals performed 30 minutes after dose? [othcli_day]"
    branch: "\(_inclusion) and \(_trivcl_noninclusion) and [othcli_day] and [othcli_day] < 15"
    req: "y"
  }},

  {othcli_deviation: #Form & {
    type: "yesno"
    label: "[[othcli_day]] Protocol Deviation?"
    branch: "\(_inclusion) and \(_trivcl_noninclusion) and [othcli_day] and [othcli_day] < 15"
    req: "y"
  }},
    {othcli_deviation_notes: #Form & {
      type: "notes"
      label: "[[othcli_day]] Describe the reason for deviation"
      branch: "[othcli_deviation] = \"1\""
      req: "y"
    }},

  {othcli_hi_fev: #Form & {
    type: "yesno"
    label: "[[othcli_day]] Did fever (temp > 37.9°C) occur today?"
    branch: "\(_inclusion) and \(_trivcl_noninclusion) and [othcli_day] and [othcli_day] < 15"
    req: "y"
  }},
    {othcli_hi_fev_temp: #Form & {
      type: "text"
      label: "[[othcli_day]] Specify max temp (XX.X°C)"
      validator: "number_1dp"
      branch: "\(_inclusion) and \(_trivcl_noninclusion) and [othcli_day] and [othcli_day] < 15 and [othcli_hi_fev] = \"1\""
      req: "y"
    }},
    {othcli_hi_fev_time: #Form & {
      type: "text"
      label: "[[othcli_day]] Specify time of max fever in hours after phage dose (X.X hours)"
      validator: "number_1dp"
      branch: "\(_inclusion) and \(_trivcl_noninclusion) and [othcli_day] and [othcli_day] < 15 and [othcli_hi_fev] = \"1\""
      req: "y"
    }},

    // from treatment_iv.cue
    {"othcli_tachy": #Form & _clin_tachy & {
      branch: "\(_inclusion) and \(_trivcl_noninclusion) and [othcli_day] and [othcli_day] < 15"
    }},
      {"othcli_tachy_max_hr": #Form & _clin_tachy_max_hr & {
        branch: "[othcli_tachy] = '1'"
      }},
      {"othcli_tachy_time_of_max": #Form & _clin_tachy_time_of_max & {
        branch: "[othcli_tachy] = '1'"
      }},

    {"othcli_pain": #Form & _clin_tachy & {
      branch: "\(_inclusion) and \(_trivcl_noninclusion) and [othcli_day] and [othcli_day] < 15"
    }},
      {"othcli_pain_max_hr": #Form & _clin_tachy_max_hr & {
        branch: "[othcli_pain] = '1'"
      }},
      {"othcli_pain_time_of_max": #Form & _clin_tachy_time_of_max & {
        branch: "[othcli_pain] = '1'"
      }},

  {othcli_inflam: #Form & {
    type: "yesno"
    label: "[[othcli_day]] Any other signs or symptoms of inflammatory response (yes/no)?"
    branch: "\(_inclusion) and \(_trivcl_noninclusion) and [othcli_day] and [othcli_day] < 15"
    req: "y"
  }},
    {othcli_inflam_notes: #Form & {
      type: "text"
      label: "[[othcli_day]] Specify what occurred"
      validator: "number_1dp"
      branch: "\(_inclusion) and \(_trivcl_noninclusion) and [othcli_day] and [othcli_day] < 15 and [othcli_inflam_notes] = \"1\""
      req: "y"
    }},
    {othcli_inflam_time: #Form & {
      type: "text"
      label: "[[othcli_day]] Also specify time of occurrence in hours after phage dose (X.X hours)"
      validator: "number_1dp"
      branch: "\(_inclusion) and \(_trivcl_noninclusion) and [othcli_day] and [othcli_day] < 15 and [othcli_inflam_notes] = \"1\""
      req: "y"
    }},






  // 
  // D15-28 
  // 

  {othcli_cont: #Form & {
    type: "yesno"
    label: "[[othcli_day]] Is the patient still receiving phage therapy?"
    branch: "\(_inclusion) and \(_trivcl_noninclusion) and [othcli_day] and ([othcli_day] = \"15-28\" or [othcli_day] = \"29\")"
    req: "y"
  }},

  // if "Not receiving PT"
  // TODO / note: these questions need to be asked the day AFTER the day phage therapy stopped
  //  - system needs to ask user to put D## + 1 of the clinical response
  {othcli_phage_resp: #Form & {
    type: "radio"
    label: "What has been the clinical response to phage therapy? (What is the clinical response the day after stopping phage therapy)"
    choices: "cure, No evidence of ongoing infection: resolution of clinical symptoms and signs, radiological and laboratory parameters of disease, and microbiological clearance of target pathogen from site of infection| partial, Partial response | none, No response – evidence of ongoing infection with worsening clinical signs and symptoms, radiological or laboratory parameters of disease | na, Unable to assess – participant received less than 3 doses of phage in total"
    branch: "[othcli_cont] = \"0\""
    req: "y"
  }},
    {othcli_phage_disability: #Form & {
      type: "radio"
      label: "Any disabilities?"
      choices: "no_disability, Without persisting disability | with_disability, With persisting disability"
      branch: "[othcli_phage_resp] = \"cure\""
      req: "y"
    }},
    {othcli_phage_partial: #Form & {
      type: "radio"
      label: "Partial response:"
      choices: "improvement, Improvement in clinical signs and symptoms, radiological or laboratory parameters of disease, but with evidence that infection is not completely resolved | stabilisation, Stabilisation of previously documented decline in function, but without obvious improvements, and evidence that infection is not completely resolved"
      branch: "[othcli_phage_resp] = \"partial\""
      req: "y"
    }},



    // if Receiving // D15-28
    {othcli_1528_vitals: #Form & {
      type: "yesno"
      label: "[[othcli_day]] Were vitals checked each day of treatment as per protocol (yes/no)?"
      branch: "\(_inclusion) and \(_trivcl_noninclusion) and [othcli_day] and [othcli_day] = \"15-28\" "
      req: "y"
    }},
    {othcli_1528_cont4wk: #Form & {
      type: "yesno"
      label: "[[othcli_day]] Will treatment continue >= 4 weeks (yes/no)?"
      branch: "\(_inclusion) and \(_trivcl_noninclusion) and [othcli_day] and [othcli_day] = \"15-28\" "
      req: "y"
    }},
    {othcli_1528_tr_days: #Form & {
      type: "text"
      validator: "integer"
      min: 14
      max: 28
      label: "[[othcli_day]] How many days of phage therapy did participant receive (enter a number from 15 to 28)?"
      branch: "\(_inclusion) and \(_trivcl_noninclusion) and [othcli_day] and [othcli_day] = \"15-28\" "
      req: "y"
    }},

    {othcli_1528_hi_fev: #Form & {
      type: "checkbox"
      label: "[[othcli_day]] Did fever (temp > 37.9°C) occur on any day?"
      choices: strings.Join([for d, D in _othClinDaysKeys { "\(D), D\(D)"}], " | ")
      branch: "\(_inclusion) and \(_trivcl_noninclusion) and [othcli_day] and [othcli_day] = \"15-28\" "
      req: "y"
    }},
    for x, X in _othClinDaysKeys {
      "othcli_1528_d\(X)_fev": #Form & {
        type: "text"
        validator: "number_1dp"
        label: "[[othcli_day]] Specify max temp (XX.X°C) for D\(X) occurring in 24 hours after 6am"
        branch: "[othcli_1528_hi_fev(\(X))] = \"1\" "
        req: "y"
      },
    },

    {othcli_1528_tachy: #Form & {
      type: "checkbox"
      label: "[[othcli_day]] Did tachycardia occur on any day?"
      choices: strings.Join([for d, D in _othClinDaysKeys { "\(D), D\(D)"}], " | ")
      branch: "\(_inclusion) and \(_trivcl_noninclusion) and [othcli_day] and [othcli_day] = \"15-28\" "
      req: "y"
    }},
    for x, X in _othClinDaysKeys {
      "othcli_1528_d\(X)_tachy": #Form & {
        type: "text"
        validator: "integer"
        label: "[[othcli_day]] specify max HR occurring in 24 hours after 6am for D\(X)"
        branch: "[othcli_1528_tachy(\(X))] = \"1\" "
        req: "y"
      },
    },

    {othcli_1528_pain: #Form & {
      type: "checkbox"
      label: "[[othcli_day]] Did pain occur on any day (greater than any baseline pain)?"
      choices: strings.Join([for d, D in _othClinDaysKeys { "\(D), D\(D)"}], " | ")
      branch: "\(_inclusion) and \(_trivcl_noninclusion) and [othcli_day] and [othcli_day] = \"15-28\" "
      req: "y"
    }},
    for x, X in _othClinDaysKeys {
      "othcli_1528_d\(X)_pain": #Form & {
        type: "text"
        label: "[[othcli_day]] specify site of pain for D\(X)"
        branch: "[othcli_1528_pain(\(X))] = \"1\" "
        action: "@CHARLIMIT='50'"
        req: "y"
      },
    }

    {othcli_1528_inflam: #Form & {
      type: "checkbox"
      label: "[[othcli_day]] Any other signs or symptoms of inflammatory response on any day?"
      choices: strings.Join([for d, D in _othClinDaysKeys { "\(D), D\(D)"}], " | ")
      branch: "\(_inclusion) and \(_trivcl_noninclusion) and [othcli_day] and [othcli_day] = \"15-28\" "
      req: "y"
    }},
    for x, X in _othClinDaysKeys {
      "othcli_1528_d\(X)_inflam": #Form & {
        type: "text"
        label: "[[othcli_day]] specify what occurred for D\(X)"
        branch: "[othcli_1528_inflam(\(X))] = \"1\" "
        action: "@CHARLIMIT='50'"
        req: "y"
      },
    },
    {othcli_1528_dose: #Form & {
      type: "radio"
      label: "[[othcli_day]] Dose adjusted on any day based on \"kinetics\" results?"
      choices: "na, Not adjusted | increased, Dose increased | reduced, Dose reduced | both, Both increases and reductions have occurred"
      branch: strings.Join([for d, D in _othClinDaysKeys { "[othcli_1528_inflam(\(D))] = '1'"}], " or ")
      req: "y"
    }},
]