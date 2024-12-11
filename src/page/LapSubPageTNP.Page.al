page 50110 "Lap Sub PageTNP"
{
    ApplicationArea = All;
    Caption = 'Lap History';
    PageType = ListPart;
    SourceTable = LapTNP;
    //Editable= true;
    MultipleNewLines = true;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Lap No."; Rec."Lap No.")
                {
                    ToolTip = 'Empty ToolTip';
                }
                field("Time"; Rec."Time")
                {
                    ToolTip = 'Empty ToolTip';
                }
                field("Best Time"; Rec."Best Time")
                {
                    ToolTip = 'Empty ToolTip';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("New Lap")
            {
                // Promoted = true;
                // PromotedCategory = Process;
                Caption = 'New Lap';
                Image = Timesheet;
                ApplicationArea = Basic, Suite;
            }
        }
    }
}
