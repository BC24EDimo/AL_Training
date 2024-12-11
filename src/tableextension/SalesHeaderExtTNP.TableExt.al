tableextension 50102 "Sales Header ExtTNP" extends "Sales Header"
{
    fields
    {
        field(50100; "Invoice TypeTNP"; enum "Invoice Types TNP")
        {
            Caption = 'Invoice Type';
            DataClassification = ToBeClassified;
        }

        field(50101; "Credit ControllerTNP"; Code[20])
        {
            Caption = 'Credit Controller';
            FieldClass = FlowField;
            CalcFormula = lookup(customer."Credit ControllerTNP" where("No." = field("Sell-to Customer No.")));
            //Editable= false;
        }

        field(50102; "Credit Controller Name TNP"; Text[50])
        {

            Caption = 'CC Name';
            ToolTip = 'Credit Controller Name';
            FieldClass = Flowfield;
            CalcFormula = lookup("Salesperson/Purchaser".name where(Code = field("Credit ControllerTNP")));
            //DataClassification = ToBeClassified;
        }
        field(50103; "Registration NoTNP"; Code[20])
        {
            caption = 'Registration No';

        }
        field(50104; VINTNP; Code[20])
        {
            caption = 'VIN';
            
        }
    }
}
