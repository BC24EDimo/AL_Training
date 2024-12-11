///extended customer page to include credit controller field
pageextension 50100 CustomerPgExtTNP extends "Customer Card"
{
    layout
    {
        addafter("Balance (LCY)")
        {
            field("Credit ControllerTNP"; Rec."Credit ControllerTNP")
            {
                ApplicationArea = all;
                Caption = 'Credit Controller';

                ///triggers change in CC Name on customer selection
                trigger OnValidate()
                begin
                    CurrPage.Update();
                end;
            }

            field("Credit Contorller TNP nameTNP"; Rec."Credit Controller Name TNP")
            {
                ApplicationArea = all;
                Caption = 'CC Name';
                ToolTip = 'Credit Controller name';
            }


        }


        modify("Home Page")
        {
            Visible = false;
        }

        moveafter(MobilePhoneNo; "Phone No.")



    }



    // actions
    // {
    //     // Add changes to page actions here
    // }

    // var
    //     myInt: Integer;
}