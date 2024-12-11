page 50103 ModelTNP
{
    ApplicationArea = All;
    Caption = 'Model';
    PageType = List;
    SourceTable = ModelTNP;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Brand Code"; Rec."Brand Code")
                {
                    ToolTip = 'Specifies the value of the Brand Code field.', Comment = '%';
                }

                field("Model Code"; Rec."Model Code")
                {
                    ToolTip = 'Specifies the value of the Model Code field.', Comment = '%';
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
            action("Car List")
            {
                RunObject = page "Car PageTNP";
                RunPageLink = Model = field("Model Code");
                Promoted = true;
                PromotedCategory = Process;
                Image = Action;
            }
        }
    }
}
