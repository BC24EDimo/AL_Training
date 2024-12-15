codeunit 50100 "CodeSpace_2TNP"
{


    procedure SellCar(var CarRec: Record CarTNP)
    var
        HistoryRec: Record HistoryTNP;
        CarSalesPrice: Text;
    begin
        // HistoryRec.SetRange(VIN, CarRec.VIN);
        // if (HistoryRec.FindFirst()) then begin
        CarSalesPrice := 'Sales Price: ' + Format(CarRec."Sales Price");
        HistoryRec.Init();
        HistoryRec.Validate("Event Type", HistoryRec."Event Type"::Sale);
        HistoryRec.Validate("Date Of Event", Today);
        HistoryRec.Validate("Service Date", Today);
        HistoryRec.Validate(VIN, CarRec.VIN);
        HistoryRec.Validate(Notes, CarSalesPrice);
        //HistoryRec.Validate("Entry No", HistoryRec."Entry No");
        HistoryRec.Insert(true);

        if (CreateSalesOrder(CarRec)) then begin
            CarRec.Validate(Sold, true);
            CarRec.Validate("Sales Price", 0);
            CarRec.Modify(true);
        end;
        // CarRec.Validate(Sold, true);
        // CarRec.Validate("Sales Price", 0);
        // CarRec.Modify(true);
        //end;


    end;


    procedure CreateSalesOrder(CarRec: Record CarTNP): Boolean
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        Customer: Record Customer;
    begin
        SalesHeader.Reset();
        SalesLine.Reset();
        Customer.Reset();
        Customer.SetFilter("No.", '');

        SalesHeader.Init();
        SalesHeader.Validate("Document Type", SalesHeader."Document Type"::Invoice);
        SalesHeader.Validate("Posting Date", Today);
        SalesHeader.Validate("Sell-to Customer No.", 'C00040');
        SalesHeader.Validate("Registration NoTNP", CarRec."Registration No");
        SalesHeader.Validate(VINTNP, CarRec.VIN);
        SalesHeader.Insert(true);

        SalesLine.Init();
        SalesLine.Validate("Document Type", SalesHeader."Document Type");
        SalesLine.Validate("Document No.", SalesHeader."No.");
        SalesLine.Validate(Type, SalesLine.Type::Item);
        SalesLine.Validate("No.", '70061');
        SalesLine.Validate(Quantity, 1);
        SalesLine.Validate("Unit Price", CarRec."Sales Price");
        //SalesLine.Validate("Location Code", );
        SalesLine.Insert(true);

        //Post Sales Header
        Codeunit.run(Codeunit::"Sales-Post", SalesHeader);
        exit(true);

    end;

    procedure PriceChange(var CarRec: Record CarTNP)
    var
        HistoryRec: Record HistoryTNP;
        NewCarPrice: Text;
    begin
        // HistoryRec.SetFilter(VIN, CarRec.VIN);
        // if (HistoryRec.FindFirst()) then begin
        NewCarPrice := 'New Car Price: ' + Format(CarRec."Sales Price");

        HistoryRec.Init();
        HistoryRec.Validate("Event Type", HistoryRec."Event Type"::"Price Change");
        HistoryRec.Validate("Date Of Event", Today);
        HistoryRec.Validate("Service Date", Today);
        HistoryRec.Validate(VIN, CarRec.VIN);
        //HistoryRec.Validate("Entry No", HistoryRec."Entry No");
        HistoryRec.Validate(Notes, NewCarPrice);
        HistoryRec.Insert(true);

        // CarRec.Validate(Sold, true);
        // CarRec.Validate("Sales Price", 0);
        // CarRec.Modify(true);
        //end;
    end;


    // procedure IncreasePrice(CarRec: Record CarTNP; IncreaseValue: Integer)
    // var
    //     AllCar: Record CarTNP;
    //     Increment: Integer;
    // begin
    //     AllCar.SetRange(Brand, CarRec.Brand);
    //     if (AllCar.FindSet()) then
    //         repeat
    //             if (AllCar.Sold = false) then begin
    //                 AllCar.Validate("Sales Price", Increment(AllCar."Sales Price", IncreaseValue));
    //                 AllCar.Modify(true);
    //             end;
    //         until AllCar.Next() = 0;
    // end;

    procedure DecreasePrice(CarRec: Record CarTNP; value: Integer)
    var
        AllCar: Record CarTNP;
        Increment: Integer;
    begin
        AllCar.SetRange(Brand, CarRec.Brand);
        if (AllCar.FindSet()) then
            repeat
                if not AllCar.Sold then begin
                    AllCar.Validate("Sales Price", Decrement(AllCar."Sales Price", value));
                    AllCar.Modify(true);
                end;
            until AllCar.Next() = 0;
    end;

    procedure IncreasePrice(CarRec: Record CarTNP; IncreaseValue: Integer)
    var
        AllCar: Record CarTNP;
        //Increment: Integer;
        TempTableRec: Record "Temp TableTNP" temporary;
    begin
        AllCar.SetRange(Brand, CarRec.Brand);
        if (AllCar.FindSet()) then
            repeat
                if not AllCar.Sold then begin
                    TempTableRec.Validate(Brand, AllCar.Brand);
                    TempTableRec.Validate(Model, AllCar.Model);
                    TempTableRec.Validate(VIN, AllCar.VIN);
                    TempTableRec.Validate("Old Price", AllCar."Sales Price");
                    TempTableRec.Validate("New Price", Increment(AllCar."Sales Price", IncreaseValue));
                    TempTableRec.Insert(true);
                    // AllCar.Validate("Sales Price", Increment(AllCar."Sales Price", IncreaseValue));
                    // AllCar.Modify(true);
                end;
            until AllCar.Next() = 0;
        //Binds TempTableRec to Worksheet
        Page.Run(Page::"Temp WorkSheetTNP", TempTableRec);
    end;

    procedure Increment(OgValue: Decimal; value: Integer): Decimal
    begin
        exit(OgValue + (OgValue * (value / 100)));

    end;

    procedure Decrement(OgValue: Decimal; value: Integer): Decimal
    begin
        exit(OgValue - (OgValue * (value / 100)));
    end;

}

