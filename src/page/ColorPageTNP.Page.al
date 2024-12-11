page 50104 "Color PageTNP"
{
    ApplicationArea = All;
    Caption = 'Color Page';
    PageType = List;
    SourceTable = ColorTNP;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }

            }
        }
    }
}
