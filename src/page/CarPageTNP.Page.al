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
                //List: List of [Text];
                //ToBeSplit: Text;
                begin
                    // ToBeSplit := 'Name: Boy';
                    // List := ToBeSplit.Split(':');
                    // Message(List.Get(2));

                    CarRec.Reset();
                    //CarRec.SetRange(VIN, rec.VIN);

                    Report.Run(50111, true, false, CarRec);
                end;
            }

            action(ProfitReport)
            {
                Promoted = true;
                PromotedCategory = Report;
                Image = Report2;
                Caption = 'Profit Report';

                trigger OnAction()
                var
                    HistoryRec: Record HistoryTNP;//: Record CarTNP;
                    ProfitTableRec: Record "Profit TableTNP";
                begin
                    //PopulateTempTable(Rec.VIN);
                    HistoryRec.Reset();
                    HistoryRec.SetRange(VIN, Rec.VIN);
                    Report.Run(50101, true, false, HistoryRec);
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

     
    // procedure PopulateTempTable(vin: Code[20])
    // var
    //     HistoryRec: Record HistoryTNP;
    //     ProfitTableRec: Record "Profit TableTNP" temporary;
    // begin
    //     HistoryRec.Reset();
    //     HistoryRec.SetFilter(VIN, vin);
    //     IF (HistoryRec.FindSet()) then begin
    //         ProfitTableRec.Init();
    //         ProfitTableRec.Validate("Entry no", 0);
    //         repeat
    //             if ((HistoryRec."Event Type" = HistoryRec."Event Type"::"Price Change") or
    //             (HistoryRec."Event Type" = HistoryRec."Event Type"::MOT) or
    //             (HistoryRec."Event Type" = HistoryRec."Event Type"::Purchase) or
    //             (HistoryRec."Event Type" = HistoryRec."Event Type"::Sale) or
    //             (HistoryRec."Event Type" = HistoryRec."Event Type"::Service)) then begin
    //                 ProfitTableRec.Validate("Event", Format(HistoryRec."Event Type"));
    //                 ProfitTableRec.Validate(VIN, vin);
    //                 ProfitTableRec.Validate("Date of Entry", HistoryRec."Service Date");
    //                 ProfitTableRec.Validate(Price, GetPrice(HistoryRec."Event Type", HistoryRec.Notes));
    //                 ProfitTableRec.Insert(true);
    //                 // "Event" := Format(HistoryRec."Event Type");
    //                 // Price := GetPrice(HistoryRec."Event Type", HistoryRec.Notes);
    //                 // DateOfEntry := HistoryRec."Service Date";
    //             end;

    //         until HistoryRec.Next() = 0
    //     end;



    // end;

    procedure GetPrice(EventType: Enum "Event TypeTNP"; FilterText: Text): Decimal
    var
        Price: Decimal;
        Items: List of [text];
    begin
        if (StrLen(FilterText) = 0) then
            exit(0.00)

        else
            if (FilterText.Contains(':')) then begin
                Items := FilterText.Split(':');
                Evaluate(Price, Items.Get(2).Trim());
                exit(AssignIntegerType(EventType, Price));
            end;
        exit(0.00);
    end;

    procedure AssignIntegerType(EventTypeTNP: Enum "Event TypeTNP"; value: Decimal): Decimal
    begin
        case EventTypeTNP of
            EventTypeTNP::MOT, EventTypeTNP::Service, EventTypeTNP::Purchase:
                exit(-1 * value);
            EventTypeTNP::Sale, EventTypeTNP::"Price Change":
                exit(value);

        end;
    end;

    var
        IncreaseRec: Codeunit CodeSpace_2TNP;
}
