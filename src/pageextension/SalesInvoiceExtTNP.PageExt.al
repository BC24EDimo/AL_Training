/// extended sales invoice to include invoice type and credit controller
pageextension 50101 "Sales Invoice ExtTNP" extends "Sales Invoice"
{
    layout
    {
        addafter(Status)
        {
            field("Invoice TypeTNP"; Rec."Invoice TypeTNP")
            {
                Caption = 'Invoice Type';
                ApplicationArea = all;
            }

            field("Credit Controller TNP"; Rec."Credit ControllerTNP")
            {
                Caption = 'Credit Controller';
                ApplicationArea = all;
            }

            field("Credit Controller TNP name"; Rec."Credit Controller Name TNP")
            {
                Caption = 'CC Name';
                ApplicationArea = all;
                ToolTip = 'Credit Controller Name';

            }
        }

    }
}
