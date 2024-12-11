page 50105 "History ListTNP"
{
    ApplicationArea = All;
    Caption = 'History List';
    PageType = List;
    SourceTable = HistoryTNP;
    UsageCategory = Lists;
    

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Description; Rec.Notes)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field("Entry No"; Rec."Entry No")
                {
                    ToolTip = 'Specifies the value of the Entry No field.', Comment = '%';
                }
                field(VIN; Rec.VIN)
                {
                    ToolTip = 'Specifies the value of the VIN field.', Comment = '%';
                }

                field("Date Of Event"; Rec."Date Of Event")
                {

                }
            }
        }
    }


    // actions{
    //     area(Processing)
    //     {
    //         action("Next MOT Service")
    //         {

    //         }

    //         action("Next Service")
    //         {

    //         }
    //     }
    // }
}
