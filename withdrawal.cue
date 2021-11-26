
package ecrf

withdrawal: [
    {wd_no_inclusion_msg: #Form & {
        _no_inclusion_msg
    }},
    {wd_reason: #Form & {
        type: "radio"
        label: "Withdrawal reason. To be completed for all withdrawn participants. "
        choices: "1, Participant completed trial including at least 6 month follow-up | 2, Participant lost to follow-up | 3, Participant has withdrawn consent for all data collection | 4, Participant has withdrawn consent for monitoring samples to be drawn but ongoing collection of clinical data is permitted"
        req: "y"
        branch: _inclusion
    }},

    {wd_withdrawal_date: #Form & {
        type: "text"
        label: "Date of Withdrawal"
        validator: "date_dmy"
        req: "y"
        branch: _inclusion + " and [wd_reason] = \"2\" or [wd_reason]=\"3\""
    }},
],