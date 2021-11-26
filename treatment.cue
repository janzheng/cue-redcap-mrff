
package ecrf

//
//  treatments
//

// generic — this leads to other specialties
treatment: [
  {tre_no_inclusion_msg: #Form & {
      _no_inclusion_msg
  }},
  {tre_start_weight: #Form & {
      type: "text"
      label: "Weight at start of treatment"
      fieldnote: "XXX.X kg"
      validator: "number_1dp"
      req: "y"
      branch: _inclusion
  }},

  // user-entered phages
  for y, Y in _maxPhages*[""] {
    "tre_ph\(y)": #Form & {
        type: "descriptive"
        label: "<div class=\"header\">Phage: \"[pre_phage\(y+1)_name]\"</div>"
        branch: _inclusion + " and [pre_phage\(y+1)_name] and [pre_num_phage]>\(y)"
    },
    "tre_ph_\(y)_rt": #Form & {
        type: "checkbox"
        label: "[Phage: \"[pre_phage\(y+1)_name]\"] Route of administration"
        choices: _adminRoutesStr
        branch: _inclusion + " and [pre_phage\(y+1)_name] and [pre_num_phage]>\(y)"
        req: "y"
    },
    "tre_ph_\(y)_rt_instl_site": #Form & {
        type: "text"
        label: "[Phage: \"[pre_phage\(y+1)_name]\"] Specify instillation site"
        branch: _inclusion + " and [pre_phage\(y+1)_name] and [pre_num_phage]>\(y)" + " and ([tre_ph_\(y)_rt(\('instl'))] = '1')"
        req: "y"
        action: "@CHARLIMIT='50'"
    },
    "tre_ph_\(y)_rt_other": #Form & {
        type: "text"
        label: "[Phage: \"[pre_phage\(y+1)_name]\"] Specify 'other'"
        branch: _inclusion + " and [pre_phage\(y+1)_name] and [pre_num_phage]>\(y)" + " and ([tre_ph_\(y)_rt(\('other'))] = '1')"
        req: "y"
        action: "@CHARLIMIT='50'"
    },
    

    for z, Z in _adminRoutes {
      "tre_ph_\(y)_duration": #Form & {
          type: "radio"
          label: "[Phage: \"[pre_phage\(y+1)_name]\"] Planned duration of treatment"
          choices: "under2wks, Less than or equal to 2 weeks | over2wks, Longer than 2 weeks "
          branch: _inclusion + " and [pre_phage\(y+1)_name] and [pre_num_phage]>\(y)"
          req: "y"
      },
      "tre_ph_\(y)_duration_value": #Form & {
          type: "text"
          label: "[Phage: \"[pre_phage\(y+1)_name]\"] Duration:"
          validator: "integer"
          branch: _inclusion + " and [pre_phage\(y+1)_name] and [pre_num_phage]>\(y) and [tre_ph_\(y)_duration]"
          req: "y"
      },
      "tre_ph_\(y)_dur_u2wk_unit": #Form & {
          type: "radio"
          label: "[Phage: \"[pre_phage\(y+1)_name]\"] [tre_ph_\(y)_duration_value] [tre_ph_\(y)_dur_u2wk_unit]"
          choices: "days, Days | doseperapp, Doses/applications"
          branch: _inclusion + " and [pre_phage\(y+1)_name] and [pre_num_phage]>\(y) and [tre_ph_\(y)_duration_value] and ([tre_ph_\(y)_duration]='under2wks' and [tre_ph_\(y)_duration_value] > 0)"
          req: "y"
      },
      "tre_ph_\(y)_dur_o2wk_unit": #Form & {
          type: "radio"
          label: "[Phage: \"[pre_phage\(y+1)_name]\"] [tre_ph_\(y)_duration_value] [tre_ph_\(y)_dur_o2wk_unit]"
          choices: "days, Days | weeks, Weeks | months, Months"
          branch: _inclusion + " and [pre_phage\(y+1)_name] and [pre_num_phage]>\(y) and ([tre_ph_\(y)_duration]='over2wks' and [tre_ph_\(y)_duration_value] > 0)"
          req: "y"
      },
      "tre_ph_\(y)_dose_titre": #Form & {
          type: "radio"
          label: "[Phage: \"[pre_phage\(y+1)_name]\"] Phage titre to be administered/dose"
          choices: "10e8, 10^8 pfu/mL | 10e9, 10^9 pfu/mL | 10e10, 10^10 pfu/mL | 10e11, 10^11 pfu/mL"
          branch: _inclusion + " and [pre_phage\(y+1)_name] and [pre_num_phage]>\(y)"
          req: "y"
      },
      "tre_ph_\(y)_dose_volume": #Form & {
          type: "text"
          label: "[Phage: \"[pre_phage\(y+1)_name]\"] Volume to be administered/dose"
          fieldnote: "XXX.X mL"
          branch: _inclusion + " and [pre_phage\(y+1)_name] and [pre_num_phage]>\(y)"
          validator: "number_1dp"
          req: "y"
      },
      "tre_ph_\(y)_\(_adminRouteKeys[z])_rt_endo": #Form & {
          type: "text"
          label: "[Phage: \"[pre_phage\(y+1)_name]\"][Route: \(_adminRouteVals[z])] Endotoxin amount administered/dose"
          fieldnote: "X.X EU/kg"
          validator: "number_1dp"
          min: 0
          max: 5.1
          branch: _inclusion + " and [pre_phage\(y+1)_name] and [pre_num_phage]>\(y)" + " and ([tre_ph_\(y)_rt(\(_adminRouteKeys[z]))] = '1')"
          req: "y"
      },
      "tre_ph_\(y)_first_dose_date": #Form & {
          type: "text"
          label: "[Phage: \"[pre_phage\(y+1)_name]\"] Date of first dose of phage administered"
          branch: _inclusion + " and [pre_phage\(y+1)_name] and [pre_num_phage]>\(y)"
          req: "y"
          validator: "date_dmy"
      },
    },

  }
],
