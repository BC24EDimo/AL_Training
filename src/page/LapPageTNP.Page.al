page 50109 "Lap PageTNP"
{
    ApplicationArea = All;
    Caption = 'Lap Page';
    PageType = List;
    SourceTable = LapTNP;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Lap No."; Rec."Lap No.")
                {
                    ToolTip = 'Empty ToolTip';
                    ApplicationArea = All;
                }

                field("Time"; Rec."Time")
                {
                    ToolTip = 'Empty ToolTip';
                    ApplicationArea = All;
                }
                field("Best Time"; Rec."Best Time")
                {
                    ToolTip = 'Empty ToolTip';
                    ApplicationArea = All;
                }
            }
        }
    }

    // actions
    // {
    //     area(Processing)
    //     {
    //         action("New Lap")
    //         {
    //             Promoted = true;
    //             PromotedCategory = Process;
    //             Caption = 'New Lap';
    //             Image = Timesheet;
    //             ApplicationArea = all;
    //         }
    //     }
    // }

}
