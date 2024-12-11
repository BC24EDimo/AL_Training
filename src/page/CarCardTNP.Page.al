page 50101 "Car CardTNP"
{
    ApplicationArea = All;
    Caption = 'Car Card';
    PageType = Card;
    SourceTable = CarTNP;
    UsageCategory = Lists;
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field(VIN; Rec.VIN)
                {
                    ToolTip = 'Specifies the value of the VIN field.', Comment = '%';
                    Editable = not Rec.Sold;
                }

                field(Brand; Rec.Brand)
                {
                    ToolTip = 'Car Brands';
                    Editable = not Rec.Sold;
                }
                field(Model; Rec.Model)
                {
                    ToolTip = 'Model ';
                    Editable = not Rec.Sold;

                }
                field("Registration No"; Rec."Registration No")
                {
                    ToolTip = 'Specifies the value of the Registration No field.', Comment = '%';
                    Editable = not Rec.Sold;
                }

                field(Value; Rec."Value")
                {
                    ToolTip = 'Specifies the value of the Value field.', Comment = '%';
                    Editable = not Rec.Sold;
                }
                field("Engine Type"; Rec."Engine Type")
                {
                    Editable = not Rec.Sold;
                }
                field("Engine Size"; Rec."Engine Size")
                {
                    Editable = not Rec.Sold;
                }
                field(Color; Rec.Color)
                {
                    Editable = not Rec.Sold;
                }

                field(Headline; Rec.Headline)
                {
                    Editable = not Rec.Sold;
                }
                field("Sales Price"; Rec."Sales Price")
                {
                    Editable = not Rec.Sold;
                    trigger OnValidate()
                    var
                        ChangePrice: Codeunit CodeSpace_2TNP;
                    begin
                        ChangePrice.PriceChange(Rec);
                    end;
                }

                field("Purchase Price"; Rec."Purchase Price")
                {
                    Editable = not Rec.Sold;
                }
                field(Profit; Rec.Profit)
                {
                    Editable = not Rec.Sold;
                }
                field("Allocated to Resources"; Rec."Allocated to Resources")
                {
                    Editable = not Rec.Sold;
                }

                field(Sold; Rec.Sold)
                {

                }


            }
            part("Event History"; "Car History Sub PageTNP")
            {
                SubPageLink = VIN = field(VIN);
                Editable = not Rec.Sold;

            }



            // group(History)
            // {
            //     Caption = 'History';

            // }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Sell Car")
            {
                Promoted = true;
                PromotedCategory = Process;
                Caption = 'Sell Car';
                Image = Close;
                ApplicationArea = all;
                Enabled = not Rec.Sold;

                trigger OnAction()
                var
                    SellCar: Codeunit CodeSpace_2TNP;
                begin
                    SellCar.SellCar(Rec);
                    // CurrPage.Editable := not Rec.Sold;
                    // CurrPage.Update();

                end;


            }


            #region Increase/Decrease Group Not Working
            /*
            group("Increase/Decrease")
            {
                Caption = 'Increase/Decrease';

                action(Increase)
                {
                    Caption = 'Increase';
                    ApplicationArea = all;
                }

                action(Decrease)
                {
                    Caption = 'Decrease';
                    ApplicationArea = all;
                }
            }
            */
            #endregion
        }




    }

    trigger OnAfterGetRecord()
    var
        Brand: Record BrandTNP;
        Model: Record ModelTNP;
        Color: Record ColorTNP;
    begin
        Rec.Headline := '';

        IF Brand.Get(Rec.Brand) THEN
            Rec.Headline += Brand.Code + ' ';
        IF Model.Get(Rec.Brand, Rec.Model) THEN
            //Model.Get(Rec.Brand);
            Rec.Headline += Model."Model Code" + ' ';
        IF Color.Get(Rec.Color) THEN
            Rec.Headline += Color.Name + ' ';
    end;




    //trigger OnOpenPage()
}
