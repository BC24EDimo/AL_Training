page 50106 "Car History Sub PageTNP"
{
    ApplicationArea = All;
    Caption = 'Car History Sub Page';
    PageType = ListPart;
    SourceTable = HistoryTNP;
    PopulateAllFields = true;
    SourceTableView = sorting("Date Of Event") order(descending);

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Date Of Event"; Rec."Date Of Event")
                {

                    ToolTip = 'Specifies the value of the DateOf Event field.', Comment = '%';
                }
                // field("Entry No"; Rec."Entry No")
                // {
                //     ToolTip = 'Specifies the value of the Entry No field.', Comment = '%';
                // }
                field("Event Type"; Rec."Event Type")
                {
                    ToolTip = 'Specifies the value of the Event Type field.', Comment = '%';
                }
                field(Notes; Rec.Notes)
                {
                    ToolTip = 'Specifies the value of the Notes field.', Comment = '%';
                }

                field("Service Date"; Rec."Service Date")
                {
                    //FieldPropertyName = FieldPropertyValue;
                }
                // field(VIN; Rec.VIN)
                // {
                //     ToolTip = 'Specifies the value of the VIN field.', Comment = '%';
                // }
            }
        }
    }



}