
/// extended customer table to include salesperson 
tableextension 50103 CustomerExtTNP extends Customer
{
    fields
    {
        field(50100; "Credit ControllerTNP"; Code[20])
        {
            Caption = 'Credit Controller TNP';
            DataClassification = ToBeClassified;
            TableRelation = "Salesperson/Purchaser".Code;
        }

        field(50101; "Credit Controller Name TNP"; Text[50])
        {

            Caption = 'CC Name';
            ToolTip = 'Credit Controller Name';
            FieldClass = Flowfield;
            CalcFormula = lookup("Salesperson/Purchaser".name where(Code = field("Credit ControllerTNP")));
            //DataClassification = ToBeClassified;
        }
    }

}