pageextension 50103 "Company Card PageTNP" extends "Resource Card"
{
    layout
    {
        addlast(content)
        {
            group("company CarTNP")
            {
                Caption = 'Company Car';
                field("Company Car VINTNP"; Rec."Company Car VINTNP")
                {
                    Caption = 'Company Car VIN';
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Company Car Reg. No.TNP"; Rec."Company Car Reg. No.TNP")
                {
                    Caption = 'Company Car Reg. No.';
                    ApplicationArea = all;
                }
                field("Company Car BrandTNP"; Rec."Company Car BrandTNP")
                {
                    Caption = 'Company car Brand';
                    ApplicationArea = all;
                }
                field("Company Car ModelTNP"; Rec."Company Car ModelTNP")
                {
                    Caption = 'Company Car Model';
                    ApplicationArea = all;
                }
            }
        }
    }
}
