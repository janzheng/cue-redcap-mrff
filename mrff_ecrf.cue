package ecrf

import "encoding/csv"
// import "encoding/json"
import "list"
import "strings"
// import "math"


// cue export mrff_ecrf.cue -e encoded -o text:mrff_ecrf.csv -f

// define the entire package "package ecrf" on each file
// cue export -p ecrf -e encoded -o text:mrff_ecrf.csv -f



    

_forms: #Forms & {
  screening_log_beta: screening_log,
  demographics_beta: demographics,
  pretreatment_beta: pretreatment,
  treatment_beta: treatment,
  treatment_iv_clinical_beta: treatment_iv_clinical,
  treatment_iv_labs_beta: treatment_iv_labs,
  adverse_events_beta: adverse_events,
  withdrawal_beta: withdrawal,
  followup_beta: followup,
  antibiotics_beta: antibiotics
}









#Forms: {
    [FormName=_]: [... {
        [Name=_]: #Form & {
            name: Name
            form: FormName
        }
    }]
}


#Form: {
    // every field here is required in the output, and will default to ""

    // uses field name as the object/key name
    //"Variable / Field Name":                      string
    name: string

    // fields with same form name are grouped in the same form
    form: string

    // creates a hr / header label above the field
    section: string | *""

    // "Field Type"
    type: string | *"text" | "notes" | "dropdown" | "descriptive" | "radio" | "checkbox" | "calc" | "file"

    // "Field Label"
    label: string
    
    // TODO: expand in v2
    // "Choices, Calculations, OR Slider Labels"
    choices: string | *""

    // Appears under the entry form
    // "Field Note"
    fieldnote: string | *""

    // "Text Validation Type OR Show Slider Number"
    validator: string | *"" | "autocomplete" | "date_dmy" | "integer" | "number_1dp" | "date_ymd" | "phone" | "email" | "number"

    // TODO: these need to match validation type; e.g. if type is "number" this can only be number
    // "min"
    min: number | int | *""
    // "max"
    max: number | int | *""

    // is it PII? "y" = true, "" (blank) = false
    // "Identifier?"
    PII: string | "y" | *""


    // example: [field_name] > 0
    // note: equals comparisons need to be wrapped in " — [field] = "5"
    // multiple choice checkbox are confusing: [field(option_name)] = "1"; 
    // option_name can be a number or string;
    // "1" means "is selected" / true
    // TODO: field_name needs to exist as a key in the rest of the fields
    // "Branching Logic (Show field only if...)"
    branch: string | *""

    // "Required Field?"
    req: string | "y" | *""

    // TODO: figure out options
    // "Custom Alignment"
    cAlign: string | *""

    // identifier for survey
    // "Question Number (surveys only)"
    qNum: string | *""


    // for checkboxes + radios; if supply a name, will assemble questions
    // into a grid of likert-scale choices
    // TODO: validate these
    // "Matrix Group Name"
    mxGroup: string | *""
    // "Matrix Ranking?"
    mxRank: string | *""

    // these are the @actions like @CHARLIMIT="50"
    // "Field Annotation"
    action: string | *"" // "field annotation"
}
// translate min form 
_FormMap: {
    name: "Variable / Field Name"
    form: "Form Name"
    section: "Section Header"
    type: "Field Type"
    label: "Field Label"
    choices: "Choices, Calculations, OR Slider Labels"
    fieldnote: "Field Note"
    validator: "Text Validation Type OR Show Slider Number"
    min: "min"
    max: "max"
    PII: "Identifier?"
    branch: "Branching Logic (Show field only if...)"
    req: "Required Field?"
    cAlign: "Custom Alignment"
    qNum: "Question Number (surveys only)"
    mxGroup: "Matrix Group Name"
    mxRank: "Matrix Group Ranking?"
    action: "Field Annotation"
}



// 
// "Functions"
// 

// Call SortByKey by "passing" it a value
// usage:
// ex1: {
//     for x,a in [1,2] {
//         "loop_\(a)": "hi"
//     }
//     zis_shouldbe: "at the end"
// }
// _ex1_sorted: #SortByKey & {in: {ex1}}
// ex1_sorted: _ex1_sorted["sorted"]
#SortByKey: {
	_input="in": {...}
    sorted: {for _ in list.Sort([for x,y in _input {
        key: x
        val:y
    }], {x: {}, y: {}, less: x.key < y.key} )
    { "\(_.key)": _.val}}
}

















_listOfFieldNames: list.FlattenN([ for fields in _forms { 
    [for field in fields { 
        [for form in field {
            for _,x in form {"\(_FormMap[_])":x}
        }]
    }]
}], 3)


_header: [ for k, _ in _listOfFieldNames[0] { k } ]
_values: [ for _, elem in _listOfFieldNames { [for _, v in elem { v } ] } ]
csvlist: [_header] + _values
encoded: strings.Trim(csv.Encode(csvlist), "\n")

