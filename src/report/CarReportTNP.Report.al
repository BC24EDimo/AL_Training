report 50111 "Car ReportTNP"
{
    ApplicationArea = All;
    Caption = 'Car Report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;

    RDLCLayout = 'CarSoldList.rdl';
    dataset
    {
        dataitem(CarTNP; CarTNP)
        {
            DataItemTableView = WHERE(Sold = const(TRUE));
            column(Brand; Brand)
            {
            }
            column(Model; Model)
            {
            }
            column(VIN; VIN)
            {
            }
            column(PrevSalesPrice; PrevSalesPrice)
            {

            }
            column("Date"; "Date")
            {
                AutoCalcField = true;
            }
            column(CompanyName; CompanyName)
            {

            }

            column(CarRpeportTitle; CarRpeportTitle)
            {

            }

            trigger OnAfterGetRecord()
            var
                HistoryRec: Record HistoryTNP;
                //Found: Boolean;
                ListOfFoundItems: List of [text];


            begin
                if (StrLen(VIN) > 0) then begin
                    HistoryRec.Reset();
                    HistoryRec.SetFilter(VIN, VIN);
                    HistoryRec.SetRange("Event Type", HistoryRec."Event Type"::Sale);
                    if (HistoryRec.FindSet()) then begin
                        //repeat
                        ListOfFoundItems := HistoryRec.Notes.Split(':');
                        //Message('List of items: %1', ListOfFoundItems.Get(2).trim());
                        //Evaluate(PrevSalesPrice, ListOfFoundItems.Get(2).trim());
                        PrevSalesPrice := ListOfFoundItems.Get(2).trim();
                        //until found = true;
                    end;
                end;
            end;
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

    var
        PrevSalesPrice: Text;
        CarRpeportTitle: Label 'MOTO M24 LTD';
}
