package ecrf


followup: [
    {fp_no_inclusion_msg: #Form & {
        _no_inclusion_msg
    }},
    {fp_has_6mo_followup: #Form & {
        type: "yesno"
        label: "Was follow-up performed at least 6 months after completion of phage therapy?"
        req: "y"
        branch: _inclusion
    }},
    {fp_no_followup_reasons: #Form & {
        type: "notes"
        label: "Why wasn't followup performed?"
        req: "y"
        branch: _inclusion + " and [fp_has_6mo_followup] = \"0\""
    }},
    {fp_months_lt_6: #Form & {
        type: "radio"
        label: "How long after completion of phage therapy was last follow-up performed, in months"
        choices: "1, 1 month after completion | 2, 2 months | 3, 3 months | 4, 4 months | 5, 5 months"
        req: "y"
        branch: _inclusion + " and [fp_has_6mo_followup] = \"0\""
    }},
    {fp_months_gt_6: #Form & {
        type: "radio"
        label: "How long after completion of phage therapy was last follow-up performed, in months?"
        choices: "1, 6 months after completion | 2, 6-12 months | 3, > 12 months"
        req: "y"
        branch: _inclusion + " and [fp_has_6mo_followup] = \"1\""
    }},
    {fp_last_visit_date: #Form & {
        type: "text"
        label: "Date of final follow-up visit"
        validator: "date_dmy"
        req: "y"
        branch: _inclusion
    }},
    {fp_clinical_resp_2wk_after: #Form & {
        type: "radio"
        label: "What clinical response to phage therapy was determined 2 weeks after completion of therapy"
        choices: "1, Cure - no evidence of ongoing infection: resolution of clinical symptoms and signs, radiological and laboratory parameters of disease, and microbiological clearance of target pathogen from site of infection | 2, Partial response | 3, No response - evidence of ongoing infection with worsening clinical signs and symptoms, radiological or laboratory parameters of disease | 4, Unable to assess - participant received less than 3 doses of phage in total"
        req: "y"
        branch: _inclusion
    }},
    {fp_resp_cure_disability: #Form & {
        type: "radio"
        label: "If Cure:"
        choices: "0, Without persisting disability | 1, With persisting disability"
        req: "y"
        branch: _inclusion + " and [fp_clinical_resp_2wk_after] = \"1\""
    }},  
    {fp_resp_partial_status: #Form & {
        type: "radio"
        label: "If Partial response:"
        choices: "1, Improvement in clinical signs and symptoms, radiological or laboratory parameters of disease, but with evidence that infection is not completely resolved | 2, Stabilisation of previously documented decline in function, but without obvious improvements, and evidence that infection is not completely resolved"
        req: "y"
        branch: _inclusion + " and [fp_clinical_resp_2wk_after] = \"1\""
    }},  
    {fp_has_ae_reported_2wk: #Form & {
        type: "radio"
        label: "Have all AEs occurring during phage therapy and up to 2 weeks after completion of therapy been documented on the AE page (yes/no/not sure)?"
        choices: "1, Yes | 0, No | 2, Not sure"
        req: "y"
        branch: _inclusion
    }},        
    {fp_has_ae_reported_6mo: #Form & {
        type: "radio"
        label: "Have all SAEs and any AE related to phage therapy occurring up to 6 months following completion of phage therapy  been documented on the AE page"
        choices: "1, Yes | 0, Did not receive | 2, Received but did not complete"
        req: "y"
        branch: _inclusion
    }},
    {fp_has_qol_survey: #Form & {
        type: "radio"
        label: "Has the participant received and completed a QoL survery on D1, D29, 3 and 6 months (yes/did not receive/received but did not complete)?"
        choices: "1, Yes | 0, Did not receive | 2, Received but did not complete"
        req: "y"
        branch: _inclusion
    }},
    {fp_msg_ask_ptp_do_survey: #Form & {
        type: "notes"
        label: "Please ask participant if they are happy to complete the QoL survey now"
        branch: _inclusion + " and [fp_has_qol_survey] != \"1\""
    }},
    {fp_3mo_pt_has_qol_12mo: #Form & {
        type: "radio"
        label: "For participants who have received >3 months phage therapy, has a QoL survey been received and completed at 12 months (yes/did not receive/received but did not complete/not yet 12 months)?"
        choices: "1, Yes | 0, Did not receive | 2, Received but did not complete | 3, Not yet 12 months"
        branch: _inclusion
    }},
],