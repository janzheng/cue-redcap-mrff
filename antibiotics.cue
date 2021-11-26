package ecrf



antibiotics: [
    {abx_no_inclusion_msg: #Form & {
        _no_inclusion_msg
    }},

    {abx_name: #Form & {
        type: "dropdown"
        label: "Antibiotic name"
        choices: _abxStr
        validator: "autocomplete"
        req: "y"
        branch: _inclusion
    }},
    {abx_other: #Form & {
        type: "text"
        label: "Other antibiotic"
        req: "y"
        branch: _inclusion + " and [abx_name] = \"0\""
        action: "@CHARLIMIT=50"
    }},
    {abx_usage: #Form & {
        type: "checkbox"
        label: "Specify antibiotic usages for [abx_name]:"
        choices: "used_prev, Used previously | used_curr, Used currently | use_cont, Will continue to use"
        req: "y"
        branch: _inclusion + " and [abx_name]"
    }},
    {abx_admin_types: #Form & {
        type: "checkbox"
        label: "How is [abx_name] administered?"
        choices: _adminRoutesStr
        req: "y"
        branch: _inclusion + " and [abx_name]"
    }},
    {"abx_admin_types_other": #Form & {
        type: "text"
        label: "Specify administration method"
        branch: _inclusion + " and [abx_admin_types(other)] = '1'"
        req: "y"
        action: "@CHARLIMIT='50'"
    }},
    for x, X in _maxPathogens*[""] {
        "abx_pth\(x+1)_descriptive": #Form & {
            type: "descriptive"
            label: "<div class=\"header\">Pathogen \(x+1)</div>"
            branch: _inclusion + " and [pre_num_target_pathogen] > \(x)"
        },
        "abx_pth\(x+1)_pxb_data_spc": #Form & {
            type: "yesno"
            label: "[Pathogen \(x+1)] Is phage-antibiotic synergy testing data available for [abx_name] against [pre_pth\(x+1)_species]?"
            branch: "[abx_name] and [pre_num_target_pathogen] > \(x) and [pre_pth\(x+1)_species]"
            req: "y"
        },
        "abx_pth\(x+1)_pxb_data_tgt": #Form & {
            type: "yesno"
            label: "[Pathogen \(x+1)] Is phage-antibiotic synergy testing data available for [abx_name] against [pre_pth\(x+1)_target]?"
            branch: "[abx_name] and [pre_num_target_pathogen] > \(x) and [pre_pth\(x+1)_target] and ![pre_pth\(x+1)_species]"
            req: "y"
        },

        // pre-defined phages
        // "abx_pth\(x+1)_pxb_ph": #Form & {
        //     type: "checkbox"
        //     label: "[Pathogen \(x+1)] Which phages?"
        //     choices: _phagesStr
        //     branch: "[abx_pth\(x+1)_pxb_data_spc] or [abx_pth\(x+1)_pxb_data_tgt]"
        //     req: "y"
        // },
        // for y, Y in _phages {
        //   "abx_pth\(x+1)_pxb_\(Y)": #Form & {
        //       type: "radio"
        //       label: "[Pathogen \(x+1)] vs. \(Y)"
        //       choices: "synergy, Synergy | none, No interaction | antagonism, Antagonism"
        //       branch: "([abx_pth\(x+1)_pxb_data_spc] and [abx_pth\(x+1)_pxb_ph(\(Y))] = '1') or ([abx_pth\(x+1)_pxb_data_tgt] and [abx_pth\(x+1)_pxb_ph(\(Y))] = '1')"
        //       req: "y"
        //   },
        // },
        // "abx_pth\(x+1)_pxb_ph_notes": #Form & {
        //     type: "notes"
        //     label: "[Pathogen \(x+1)] Additional phage-antibiotic-pathogen synergy notes"
        //     branch: "[abx_pth\(x+1)_pxb_data_spc] or [abx_pth\(x+1)_pxb_data_tgt]"
        //     req: "y"
        // },
        // end pre-defined phages


        // user-defined phages (in pretreatment)
        for y, Y in _maxPhages*[""] {
          "abx_pth\(x+1)_pxb_ds_\(y)": #Form & {
              type: "descriptive"
              label: "<div class=\"header\">[Pathogen \(x+1)] :: Phage: \"[pre_phage\(y+1)_name]\"</div>"
              branch: "[pre_phage\(y+1)_name] and [pre_num_phage]>\(y) and ([abx_pth\(x+1)_pxb_data_spc] or [abx_pth\(x+1)_pxb_data_tgt])"
          },
          "abx_pth\(x+1)_pxb_ph_\(y)": #Form & {
              type: "yesno"
              label: "[Pathogen \(x+1)] Data available against phage: \"[pre_phage\(y+1)_name]\"?"
              branch: "[pre_phage\(y+1)_name] and [pre_num_phage]>\(y) and ([abx_pth\(x+1)_pxb_data_spc] or [abx_pth\(x+1)_pxb_data_tgt])"
              req: "y"
          },
          "abx_pth\(x+1)_pxb_syn_\(y)": #Form & {
              type: "radio"
              label: "[Pathogen \(x+1)] Synergism vs. phage: \"[pre_phage\(y+1)_name]\""
              choices: "synergy, Synergy | none, No interaction | antagonism, Antagonism"
              branch: "([abx_pth\(x+1)_pxb_data_spc] and [abx_pth\(x+1)_pxb_ph_\(y)] = '1') or ([abx_pth\(x+1)_pxb_data_tgt] and [abx_pth\(x+1)_pxb_ph_\(y)] = '1')"
              req: "y"
          },
          "abx_pth\(x+1)_pxb_\(y)_notes": #Form & {
              type: "notes"
              label: "[Pathogen \(x+1)] Additional phage-antibiotic-pathogen synergy notes against phage \"[pre_phage\(y+1)_name]\""
              branch: "([abx_pth\(x+1)_pxb_data_spc] and [abx_pth\(x+1)_pxb_ph_\(y)] = '1') or ([abx_pth\(x+1)_pxb_data_tgt] and [abx_pth\(x+1)_pxb_ph_\(y)] = '1')"
              req: "y"
          },
        }
        // end user-defined phages


    },
],
