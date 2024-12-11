codeunit 50111 CodeSpaceTNP
{
    trigger OnRun()
    var
    // value1, value2, answer : integer;
    // Label: Label '%1 + %2 = %3';
    begin
        // value1 := 1000;
        // value2 := 2000;
        // MyProcedure('Sum Text');
        // answer := GlobalProcedure(value1, value2);
        // Message(Label, Format(value1), Format(value2), answer);

    end;

    local procedure MyProcedure(MyText: text)
    var
        myInt: Integer;
    //TextLabel: Label 'Hello local procedure %1';
    begin
        Message(TextLabel, MyText);
        //exit();
    end;

    procedure GlobalProcedure(value1: Integer; value2: Integer): Integer
    var
        answer: Integer;
        Label: Label '%1 + %2 = %3';
    begin
        myInt := value1 + value2;
        exit(myInt);

    end;

    procedure GlobalProcedure2(value1: Integer; value2: Integer): Text
    var
        answer: Integer;
        StatemementLabel: Label '%1 + %2 = %3';
    begin
        answer := value1 + value2;
        Message(StatemementLabel, value1, value2, answer);
    end;

    #region ReadingData
    procedure ReadingData()
    var
        DataText: Text;
        Brand: Record BrandTNP;
        Car: Record CarTNP;

    begin
        Car.Reset();
        Brand.Get('BMW');
        // Message(Brand.Description);
        Car.SetRange(Color, 'PINK');

        // Range expression
        //Car.SetRange();
        If Car.FindFirst() then //begin
            Message(Car.Brand + ' ' + '\n' + Car.Color)
        //end
        else
            Message('Not Found');

        /// Filter expression
        Car.Reset();
        Car.SetFilter(Brand, '<>%1', 'BMW');


        ///FindSet Expression
        car.Reset();

        if car.findset then
            repeat
                //Message('Car Brand: '+car.Brand + '\nCarColor: ' + car.Color);
                car.Modify(true) ///TRUE OR FALSE
        until car.next = 0;



    end;
    #endregion


    procedure CheckCar()
    var
        Car: Record CarTNP;
    begin
        car.Reset();

        //Order table data by parameters (value, brand)
        car.SetCurrentKey(Value, Brand);

        /// sets filter on car table getting values (= 0) 
        Car.SetFilter(Value, '=0');
        // if car.FindSet() then
        //     repeat
        //         car.Value := 10000;
        //         car.modify(true);
        //     until car.next = 0

        if not car.IsEmpty then begin
            car.FindSet();
            repeat
                car.Value := 10000;
                //car.Validate(Value, 10000);
                car.modify(true);
            until car.next = 0

        end;
    end;

    procedure SellCar()
    var
        CarRec: Record CarTNP;
        isSold: Boolean;
    begin

    end;

    #region Inserting Records
    procedure InsertRecord()
    var
        Car: Record CarTNP;
    begin
        car.Init();
        car.Validate(VIN, '12345987');
        car.Validate(Brand, 'BMW');
        car.Validate(Color, 'BLUE');
        car.Validate("Engine Size", 2.5);
        car.Validate(Value, 200000);
        car.Validate("Engine Type", car."Engine Type"::Hybrid);

        //car.Validate();
        car.Insert(true);
    end;
    #endregion

    procedure NewEventHistory(VIN: Code[20])
    var
        History: Record HistoryTNP;
    begin
        History.Init();
        History.Validate(VIN, VIN);
        History.Validate("Entry No", 0);
        History.Validate("Event Type", History."Event Type"::"Car Creation");
        History.Validate("Date Of Event", Today);
        History.Validate("Service Date", Today);
        //History.Validate();
        History.Insert(true)
    end;


    #region Split String
    procedure SplitString()
    var
        MyText: text;
        CommaPos, i : Integer;
        MyWords: array[20] of text;
    begin
        MyText := 'one, two,three,four,five,six,seven,eight';

        repeat
            I += 1;
            CommaPos := StrPos(MyText, ',');

            if CommaPos <> 0 then begin
                MyWords[i] := CopyStr(MyText, 1, CommaPos - 1);
                MyText := CopyStr(MyText, CommaPos + 1);

            end else begin
                MyWords[i] := MyText;
            end;
        until MyWords[i] = MyText;
    end;
    #endregion

    procedure SomeStuff(): Text
    var
        myText, myText2 : Text;
        i: Integer;
    begin
        myText := 'lkjhgfdsqqwertyuio98765432';
        for i := 1 to StrLen(myText) do begin
            if myText[1] in ['0' .. '9'] then begin
                myText2[i] := 'N';
            end else begin
                myText2[i] := 'A';
            end;

        end;
        exit(myText2);
    end;

    procedure GetRegNoFormatSequence(RegNo: Text): Text
    var
        RegNoSequence: Text;
        IsValid: Boolean;
        i: Integer;
    begin
        //myText := 'lkjhgfdsqqwertyuio98765432';
        for i := 1 to StrLen(RegNo) do begin
            if RegNo[1] in ['0' .. '9'] then begin
                RegNoSequence[i] := 'N';
            end else begin
                RegNoSequence[i] := 'A';
            end;

        end;
        //IsValid := isRegNoValid(RegNoSequence);
        exit(RegNoSequence);
    end;

    procedure CheckRegNo(RegNo: Text)
    var
        RegNoSequence, FormattedRegNo : Text;
        CarRec: Record CarTNP;
    begin

        RegNoSequence := GetRegNoFormatSequence(RegNo);
        if CarRec.Get(RegNo) then begin
            if isRegNoValid(RegNoSequence) then begin
                CarRec."Registration No" := isRegNoValid(RegNo, RegNoSequence);

                //CarRec."Registration No" := FormattedRegNo;
                CarRec.Modify();
            end
        end

        else
            Message('Invalid Reg No');
        //exit('Invalid Reg No');

    end;

    procedure isRegNoValid(RegNoFormat: Text): Boolean
    begin
        if ((RegNoFormat = 'AANNAAA') or (RegNoFormat = 'AANNAAA') or (RegNoFormat = 'AANNAAA')) then
            exit(true)
        else
            exit(false);
    end;

    procedure isRegNoValid(RegNo: Text; RegNoFormat: Text): Text
    begin
        case RegNoFormat of
            'AANNAAA', 'AAANNNA':
                exit(FormatRegNoTypeA(RegNo));

            'ANNNAAA':
                exit(FormatRegNoTypeB(RegNo));
        end


    end;


    procedure FormatRegNoTypeA(RegNo: Text): Text
    var
        FormattedRegNo: Text;
        i: Integer;
    begin
        for i := 1 to StrLen(RegNo) do begin
            if (i = 4) then
                FormattedRegNo[i] := RegNo[i] + ' '
            else
                FormattedRegNo[i] := RegNo[i];
        end;
        exit(FormattedRegNo);
    end;

    procedure FormatRegNoTypeB(RegNo: Text): Text
    var
        FormattedRegNo: Text;
        i: Integer;
    begin
        for i := 1 to StrLen(RegNo) do begin
            if (i = 3) then
                FormattedRegNo[i] := RegNo[i] + ' '
            else
                FormattedRegNo[i] := RegNo[i];
        end;
        exit(FormattedRegNo);
    end;
    //procedure RegNo

    procedure TypeOf(value: text)
    begin

    end;

    procedure GetTime(): DateTime
    var
    begin
        //exit(To)
    end;


    procedure CopyCar(CarRecord: Record CarTNP)
    var
        NewCar: Record CarTNP;
    begin
        if not CarRecord.IsEmpty() then
            NewCar.Copy(CarRecord);
        NewCar.Validate(VIN, CarRecord.VIN + '1');

        NewCar.Insert(true);
    end;

    #region Car Page Allocate Resources
    procedure AllocateResources()
    var
        CarRec: Record CarTNP;
    begin
        CarRec.Reset();
        CarRec.SetFilter(VIN, '<>%1', '');
        if (CarRec.FindSet()) then
            repeat
                AllocateResources(CarRec);
            until CarRec.Next() = 0;
    end;


    procedure AllocateResources(var pCarRec: Record CarTNP)
    var
        ResourceRec: Record Resource;
    begin
        // pCarRec.Reset();
        // pCarRec.SetCurrentKey(VIN);
        // pCarRec.SetFilter(VIN, '>%1', '');
        //if pCarRec.FindSet() then
        //repeat
        ResourceRec.Reset();
        ResourceRec.SetCurrentKey("Company Car VINTNP");
        ResourceRec.SetRange("Company Car VINTNP", pCarRec.VIN);
        if (ResourceRec.FindFirst()) then
            pCarRec.Validate("Allocated to Resources", ResourceRec.Name)
        else
            pCarRec.Validate("Allocated to Resources", 'Not Allocated');

        //until pCarRec.Next() = 0;
        pCarRec.Modify(true);
    end;
    #endregion

    procedure NextMOTDate(nextDate: date): date
    begin
        exit(CalcDate('+1Y', nextDate));
    end;


    procedure NextServiceDate(nextDate: date): date
    begin
        exit(CalcDate('+6M', nextDate));
    end;


    var
        myInt: Integer;
        Tesco: Text[20];
        TextLabel: Label 'Hello local procedure %1';
        Car: Record CarTNP;
}