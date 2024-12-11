page 50100 "Car PageTNP"
{
    ApplicationArea = All;
    Caption = 'Car Page';
    PageType = List;
    SourceTable = CarTNP;
    UsageCategory = Lists;
    CardPageId = "Car CardTNP";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Brand; Rec.Brand)
                {
                    ToolTip = 'Specifies the value of the Brand field.', Comment = '%';


                }
                field(Model; Rec.Model)
                {

                    ToolTip = 'Specifies the value of the Model field.', Comment = '%';
                }
                field("Registration No"; Rec."Registration No")
                {
                    ToolTip = 'Specifies the value of the Registration No field.', Comment = '%';
                }
                field(VIN; Rec.VIN)
                {
                    ToolTip = 'Specifies the value of the VIN field.', Comment = '%';
                }
                field(Value; Rec."Value")
                {
                    ToolTip = 'Specifies the value of the Value field.', Comment = '%';
                }
                field("Engine Type"; Rec."Engine Type")
                {

                }
                field("Engine Size"; Rec."Engine Size")
                {

                }
                field(Color; Rec.Color)
                {

                }

                field("Sales Price"; Rec."Sales Price")
                {
                    //DataClassification = ToBeClassified;
                }
                field("Purchase Price"; Rec."Purchase Price")
                {
                    //DataClassification = ToBeClassified;
                }

                field(Profit; Rec.Profit)
                {

                }

                field("Allocated to Resources"; Rec."Allocated to Resources")
                {

                }

                // }

                // field("MOT Service Date"; Rec."MOT Service Date")
                // { }

                // field("Next Service Date"; Rec."Next Service Date")
                // { }

            }
        }
    }
    actions
    {
        area(processing)
        {
            action(NewCar)
            {
                ApplicationArea = All;
                Caption = 'New Car';
                Image = Create;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    AddCar: Codeunit CodeSpaceTNP;
                begin
                    AddCar.CopyCar(rec);
                    //CurrPage.Update();
                end;
                //RunObject = Page "Car CardTNP";
            }

            action(Increase)
            {
                Promoted = TRUE;
                PromotedCategory = Process;
                Caption = 'Increase';
                Image = AddAction;
                //RunObject = page "Temp WorkSheetTNP";
                //RunPageLink = Brand = field(Brand);
                //RunPageOnRec = true;

                trigger OnAction()
                var
                    IncreaseRec: Codeunit CodeSpace_2TNP;
                    TempPage: Page "Temp WorkSheetTNP";
                begin
                    //TempPage.SetRecord(Rec);

                    IncreaseRec.IncreasePrice(Rec, 30);
                    //TempPage.Run();
                    //CurrPage.Update();
                end;
            }

            action(Decrease)
            {
                Promoted = TRUE;
                PromotedCategory = Process;
                Caption = 'Decrease';
                Image = Cancel;

                trigger OnAction()
                var
                    DecreaseRec: Codeunit CodeSpace_2TNP;
                begin
                    DecreaseRec.DecreasePrice(Rec, 30);

                end;
            }
        }

        area(Reporting)
        {
            action(Invoice)
            {
                Promoted = true;
                PromotedCategory = Report;
                Caption = 'Report';
                Image = Report;

                trigger OnAction()
                var
                    CarRec: Record CarTNP;
                    List : List of [Text];
                    ToBeSplit : Text;
                begin
                    // ToBeSplit := 'Name: Boy';
                    // List := ToBeSplit.Split(':');
                    // Message(List.Get(2));
                    
                    CarRec.Reset();
                    //CarRec.SetRange(VIN, rec.VIN);
                    Report.Run(50111, true, false, CarRec);
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    var
        Allocate: Codeunit CodeSpaceTNP;
    begin
        Allocate.AllocateResources();
        //CurrPage.Update();
    end;

    //trigger 
    var
        IncreaseRec: Codeunit CodeSpace_2TNP;
}
