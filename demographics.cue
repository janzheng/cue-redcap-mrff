package ecrf

// import "list"
// import "strings"


demographics: [
    {dm_no_inclusion_msg: #Form & {
        _no_inclusion_msg
    }},
    {dm_picf_signed_date: #Form & {
        type: "text"
        label: "Date PICF signed"
        validator: "date_dmy"
        req: "y"
        branch: _inclusion
    }},
    {dm_consent_age: #Form & {
        type: "calc"
        label: "Age at time of consent"
        choices:"round(datediff([sc_dob], \"today\", \"y\"),2)"
        req: "y"
        branch: _inclusion
    }},
    {dm_gender: #Form & {
        type: "radio"
        label: "Gender"
        choices: "m, M | f, F"
        req: "y"
        branch: _inclusion
    }},
    {dm_recruitment_site: #Form & {
        type: "radio"
        label: "Recruitment Site"
        choices: _sitesStr
        req: "y"
        branch: _inclusion
    }},
],
