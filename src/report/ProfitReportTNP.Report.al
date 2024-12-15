report 50101 "Profit  ReportTNP"
{
    ApplicationArea = All;
    Caption = 'Profit  Report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = rdlc;//Word;
    //WordLayout = 'ProfitReport.docx';
    RDLCLayout = 'ProfitReport.rdl';

    dataset
    {
        dataitem(HistoryTNP; HistoryTNP)
        {
           // DataItemTableView = where("Event Type" = filter(Sale), "Event Type" = filter(MOT), "Event Type" = filter(Purchase), "Event Type" = filter(Service));
            column(VIN; VIN)
            {
            }
            column(Date_Of_Event; "Date Of Event")
            {
            }
            column(Event_Type; "Event Type")
            {
            }
            column(Price; Price)
            {
                AutoFormatType = 10;
                AutoFormatExpression = '$<precision, 2:2><standard format, 0>';
            }
            column(AcconutTitle; AccountTitle)
            {
            }

            //trigger OnAfterGetRecord()
            /*
            var
                HistoryRec: Record "HistoryTNP";
            //ProfitTableRec: Record "Profit TableTNP" temporary;
            begin
                HistoryRec.Reset();
                HistoryRec.SetCurrentKey(VIN);
                HistoryRec.SetFilter(VIN, VIN);
                //HistoryRec.SetRange("Event Type", 1, 4);
                if (HistoryRec.FindSet()) then begin
                    HistoryRec.Init();
                    repeat
                    if (//(HistoryRec."Event Type" = HistoryRec."Event Type"::"Price Change") or
                    (HistoryRec."Event Type" = HistoryRec."Event Type"::MOT) or
                    (HistoryRec."Event Type" = HistoryRec."Event Type"::Purchase) or
                    (HistoryRec."Event Type" = HistoryRec."Event Type"::Sale) or
                    (HistoryRec."Event Type" = HistoryRec."Event Type"::Service)) then begin
                        //"Event" := Format(HistoryRec."Event Type");
                        HistoryRec.Price:= GetPrice(HistoryRec."Event Type", HistoryRec.Notes);
                        HistoryRec.Modify(true);
                        //DateOfEntry := HistoryRec."Service Date";
                    end;

                    until HistoryRec.Next() = 0
                end;

            end;
            */


            // trigger OnAfterGetRecord()
            // var
            //     HistoryRec: Record HistoryTNP;
            //     ProfitTableRec: Record "Profit TableTNP" temporary;
            // begin
            //     HistoryRec.Reset();
            //     HistoryRec.SetFilter(VIN, VIN);
            //     IF (HistoryRec.FindSet()) then begin
            //         repeat
            //             if ((HistoryRec."Event Type" = HistoryRec."Event Type"::"Price Change") or
            //             (HistoryRec."Event Type" = HistoryRec."Event Type"::MOT) or
            //             (HistoryRec."Event Type" = HistoryRec."Event Type"::Purchase) or
            //             (HistoryRec."Event Type" = HistoryRec."Event Type"::Sale) or
            //             (HistoryRec."Event Type" = HistoryRec."Event Type"::Service)) then begin
            //                 ProfitTableRec.Init();
            //                 ProfitTableRec.Validate("Event", Format(HistoryRec."Event Type"));
            //                 //ProfitTableRec.Validate("Date of Entry",);
            //                 ProfitTableRec.Validate("Date of Entry", HistoryRec."Service Date");
            //                 ProfitTableRec.Validate(Price, GetPrice(HistoryRec."Event Type", HistoryRec.Notes));
            //                 ProfitTableRec.Insert(true);

            //                 // "Event" := Format(HistoryRec."Event Type");
            //                 // Price := GetPrice(HistoryRec."Event Type", HistoryRec.Notes);
            //                 // DateOfEntry := HistoryRec."Service Date";
            //             end;

            //         until HistoryRec.Next() = 0
            //     end;



            //end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    labels
    {
        Label1 = 'Account Report For', Comment = 'Account Title', MaxLength = 999, Locked = true;
    }


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
        AccountTitle: Label 'Account Report For ';
        //Price: Decimal;
        "Event": Text[20];
        DateOfEntry: Date;
}
