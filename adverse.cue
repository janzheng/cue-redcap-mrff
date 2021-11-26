package ecrf


adverse_events: [
    {ae_no_inclusion_msg: #Form & {
        _no_inclusion_msg
    }},
    {ae_date_of_event: #Form & {
        type: "text"
        label: "Date of Event — this is a change!"
        validator: "date_dmy"
        req: "y"
    }},
    {ae_day_of_therapy: #Form & {
        type: "text"
        label: "If still receiving phage therapy, specify day of therapy (day 1 = day of first dose administration)"
        validator: "integer"
        min: 1
    }},
    {ae_last_dose_within_72h: #Form & {
        type: "radio"
        label: "Did the patient receive the last phage dose within 72 hours?"
        choices: "1, Yes, within 72 hours ( <= 72h ) | 2, No"
        req: "y"
    }},
    {ae_hours_since_phage_dose: #Form & {
        type: "text"
        label: "If last dose of phage administered < 72 hours prior, specify time of onset of event in hours since last dose of phage (XX.X hours - must be < 72)"
        choices: "If last dose of phage administered < 72 hours prior, specify time of onset of event in hours since last dose of phage (XX.X hours - must be < 72)"
        validator: "number_1dp"
        min: 0
        max: 72
        branch: "[ae_last_dose_within_72h] = \"1\""
        req: "y"
    }},
    {ae_days_since_phage_dose: #Form & {
        type: "text"
        label: "If last dose of phage administered at least 72 hours prior, specify time of onset of event in days since last dose of phage (XXX.X days - should be less than 180)"
        validator: "number_1dp"
        min: 0
        max: 180
        branch: "[ae_last_dose_within_72h] = \"2\""
        req: "y"
    }},
    {ae_phages_recv: #Form & {
        type: "checkbox"
        label: "Which phages has participant received at least 1 dose of to date?"
        choices: _phagesStr
        req: "y"
    }},
    {ae_meddra_classification: #Form & {
        type: "text"
        label: "Event term (MedDRA Classification)"
        choices: "BIOPORTAL:MEDDRA"
    }},
    {ae_details: #Form & {
        type: "notes"
        label: "<div class=\"rich-text-field-label\"><p>Details of Event</p></div>"
        req: "y"
    }},
    {ae_severity: #Form & {
        type: "radio"
        label: "Severity (mild/moderate/severe)?"
        choices: "1, Mild | 2, Moderate | 3, Severe"
        req: "y"
    }},
    {ae_is_serious: #Form & {
        type: "yesno"
        label: "Is this a Serious Adverse Event?"
        req: "y"
    }},
    {ae_serious_event_criteria: #Form & {
        type: "checkbox"
        label: "How does event meet seriousness criteria?"
        choices: "1, Resulted in death | 2, Was immediately life threatening | 3, Required inpatient hospitalisation or prolongation of existing hospitalisation | 4, Resulted in persistent or significant disability/incapacity | 5, Congenital anomaly/birth defect | 6, Other, may jeopardise the participant or may require medical or surgical intervention to prevent one of the outcomes listed above"
        branch: "[ae_is_serious] = \"1\""
        req: "y"
    }},
    {ae_has_reported_sponsor: #Form & {
        type: "checkbox"
        label: "Confirm SAE has been reported to the trial sponsor at: WSLHD-ResearchOffice@health.nsw.gov.au"
        choices: "1, Yes, I have reported to the trial sponsor"
        branch: "[ae_is_serious] = \"1\""
        req: "y"
    }},
    {ae_related_to_pt: #Form & {
        type: "radio"
        label: "Is adverse event related to phage therapy?"
        choices: "1, Unrelated | 2, Unlikely | 3, Possible | 4, Probably | 5, Definite"
        req: "y"
    }},
    {ae_related_phages: #Form & {
        type: "checkbox"
        label: "What phages are related to adverse event?"
        choices: "0, Other trial-related procedure (e.g. blood draw) | " + _phagesStr
        branch: "[ae_related_to_pt] > 3"
        req: "y"
    }},
    {ae_has_confirmed_w_pi: #Form & {
        type: "checkbox"
        label: "Confirm Serious Adverse Event has been discussed with site PI"
        choices: "1, Yes, I have confirmed with the site PI"
        branch: "[ae_is_serious] = \"1\" and [ae_related_to_pt] > 3"
        req: "y"
    }},
    {ae_is_susar: #Form & {
        type: "yesno"
        label: "Does event qualify as a SUSAR?"
        branch: "[ae_is_serious] = \"1\" and [ae_related_to_pt] > 3"
        req: "y"
    }},
    {ae_has_reported_susar: #Form & {
        type: "checkbox"
        label: "<div class=\"rich-text-field-label\"><p><span style=\"font-weight: normal; font-family: 'Open Sans', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Helvetica, Arial, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol';\">Confirm SUSAR has been reported:</span></p> <ul> <li><span style=\"font-weight: normal;\">To the sponsor (WSLHD-ResearchOffice@health.nsw.gov.au)</span></li> <li><span style=\"font-weight: normal;\">To the chair of the DSMB (ian.seppelt@sydney.edu.au)</span></li> <li><span style=\"font-weight: normal;\">To the CPI (jonathan.iredell@sydney.edu.au)</span></li> </ul></div>"
        choices: "1, Yes, SUSAR reported to Sponsor, Chair of the DSMB, and the CPI"
        branch: "[ae_is_serious] = \"1\" and [ae_related_to_pt] > 3"
        req: "y"
    }},
    {ae_req_treatment_eval: #Form & {
        type: "notes"
        label: "Any required treatment or evaluation?"
    }},
    {ae_final_outcome: #Form & {
        type: "radio"
        label: "Final outcome"
        choices: "1, Resolution | 2, Stabilisation | 3, No longer clinically significant | 4, Participant lost to follow-up"
        req: "y"
    }},
    {ae_date_final_outcome: #Form & {
        type: "text"
        label: "Date of final outcome"
        validator: "date_dmy"
    }},
],