package ecrf

// import "list"
// import "strings"





screening_log: [
    {phage_patient_id: #Form & { // necessary for every data dict
        label: "Phage Patient ID" // used as label for dashboard
    }},
    {sc_date: #Form & {
        type: "text"
        label: "Date of referral"
        validator: "date_dmy"
        req: "y"
    }},
    {sc_ptp_initials: #Form & {
        type: "text"
        label: "Patient initials"
        fieldnote: "Only two letters allowed"
        req: "y"
        action: "@CHARLIMIT=2"
    }},
    {sc_dob: #Form & {
        type: "text"
        label: "DOB"
        validator: "date_dmy"
        PII: "y"
        req: "y"
    }},
    {sc_meets_inclusion: #Form & {
        type: "yesno"
        label: "Meets inclusion criteria"
        req: "y"
    }},
    {sc_exclusion_reasons: #Form & {
        type: "checkbox"
        label: "Reason for exclusion"
        choices: "1, Source control sub-optimal | 2, Polymicrobial infection (>2 key pathogens) | 3, Pathogen driving infectious syndrome not appropriately confirmed | 4, Phage product identified unsuitable | 5, Patient/parent or guardian/responsible person unable or unlikely to adhere to schedule of treatment and monitoring | 6, Patient/parent or guardian/responsible person did not provide informed consent | 0, Other"
        branch: "[sc_meets_inclusion] = \"0\""
        req: "y"
    }},
    {sc_exclusion_ph_unsuitable: #Form & {
        type: "checkbox"
        label: "If phage product identified unsuitable:"
        choices: "1, Phage activity against target pathogen(s) limited/undocumented | 2, Formulation not safe for clinical use | 3, Regulatory approvals not completed"
        branch: "[sc_exclusion_reasons(4)] = \"1\""
        req: "y"
        action: "@CHARLIMIT=100"
    }},
    {sc_exclusion_other: #Form & {
        type: "notes"
        label: "Specify other exclusion reasons"
        branch: "[sc_exclusion_reasons(0)] = \"1\""
        req: "y"
    }},
],
