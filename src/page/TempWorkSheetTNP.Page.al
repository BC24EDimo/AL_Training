page 50111 "Temp WorkSheetTNP"
{
    ApplicationArea = All;
    Caption = 'Temp WorkSheet';
    PageType = Worksheet;
    SourceTable = "Temp TableTNP";
    //PageType = List;
    SourceTableTemporary = true;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                // field(VIN; Rec.VIN)
                // {
                //     ToolTip = 'Specifies the value of the VIN field.', Comment = '%';
                // }
                field(Brand; Rec.Brand)
                {
                    ToolTip = 'Specifies the value of the Brand field.', Comment = '%';
                }
                field(Model; Rec.Model)
                {
                    ToolTip = 'Specifies the value of the Model field.', Comment = '%';
                }
                field("New Price"; Rec."New Price")
                {
                    ToolTip = 'Specifies the value of the New Price field.', Comment = '%';
                }
                field("Old Price"; Rec."Old Price")
                {
                    ToolTip = 'Specifies the value of the Old Price field.', Comment = '%';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Save Changes")
            {
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = all;

                trigger OnAction()
                var
                    CarRec: Record CarTNP;
                begin
                    CarRec.Reset();
                    CarRec.SetCurrentKey(Brand);
                    CarRec.SetRange(Brand, Rec.Brand);
                    if (CarRec.FindSet()) then
                        repeat
                            if (CarRec.Sold = false) then begin
                                CarRec.Validate("Sales Price", Rec."New Price");
                                CarRec.Modify(true);
                            end;
                        until CarRec.Next() = 0;
                end;
            }
        }
    }

    trigger OnOpenPage()
    var
        IncreaseRec: Codeunit CodeSpace_2TNP;
    //CarRec : Record
    begin


        //IncreaseRec.IncreasePrice(Rec., 30);

    end;
}
