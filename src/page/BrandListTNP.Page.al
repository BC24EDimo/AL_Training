page 50102 "Brand ListTNP"
{
    ApplicationArea = All;
    Caption = 'Brand List';
    PageType = List;
    SourceTable = BrandTNP;
    UsageCategory = Lists;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field(Value; Rec."Value")
                {
                    ToolTip = 'Specifies the value of the Value field.', Comment = '%';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Model List")
            {
                RunObject = page "ModelTNP";
                RunPageLink = "Brand Code" = field(Code);
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = List;
            }

        }

        area(Navigation)
        {

            action("Car List")
            {
                RunObject = page "Car PageTNP";
                RunPageLink = "Brand" = field(Code), Sold = const(false);
            }
        }
    }
}
