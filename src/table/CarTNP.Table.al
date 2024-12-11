table 50102 CarTNP
{
    Caption = 'Car';
    DataClassification = ToBeClassified;
    LookupPageId = "Car PageTNP";
    DrillDownPageId = "Car PageTNP";

    fields
    {
        field(1; VIN; code[20])
        {
            Caption = 'VIN';
            //Editable = Rec.Sold;


        }
        field(2; "Registration No"; code[20])
        {
            Caption = 'Registration No';

            trigger OnValidate()
            var
                ValidRegNo: Codeunit CodeSpaceTNP;
                RegNoWithoutSpace: Text;
            begin
                RegNoWithoutSpace := DelChr(Rec."Registration No", '=', ' ');
                if StrLen(RegNoWithoutSpace) > 7 then begin
                    Message(' the Registration No is too long');
                    exit;
                end;
                ValidRegNo.CheckRegNo(RegNoWithoutSpace);

            end;
        }
        field(3; Brand; Text[20])
        {
            Caption = 'Brand';
            tablerelation = "BrandTNP".Code;

            trigger OnValidate()
            var
            begin
                if Rec.Brand <> xRec.Brand then begin
                    Rec.Model := '';
                end;


                //Headline := Label '%1  %2 %3 %4'
                //UpdateHeadline();
            end;




        }
        //forms relationship between brand and model
        field(4; Model; Text[20])
        {
            Caption = 'Model';
            tablerelation = "ModelTNP"."Model Code" where("Brand Code" = Field(Brand));


            // trigger OnValidate()
            // begin
            //     UpdateHeadline();
            // end;
        }
        field(5; Value; Decimal)
        {
            Caption = 'Value';

            // trigger OnValidate()
            // begin
            //     UpdateHeadline();
            // end;
        }
        field(6; Color; Text[20])
        {
            caption = 'Color';
            tablerelation = "ColorTNP".Name;

            // trigger OnValidate()
            // begin
            //     UpdateHeadline();
            // end;
        }
        field(7; "Engine Type"; enum "Engine TypeTNP")
        {
            caption = 'Engine Type';
        }
        field(8; "Engine Size"; Decimal)
        {
            caption = 'Engine Size';
        }

        field(9; Headline; Text[150])
        {
            Caption = 'Headline';
            DataClassification = ToBeClassified;
            Editable = false;
            //Headline 
        }
        field(10; "Allocated to Resources"; Text[50])
        {
            Caption = 'Allocated to Resources';
        }
        field(11; "Sales Price"; Decimal)
        {
            Caption = 'Sales Price';
            //DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                UpdateProfitValue();
            end;
        }

        field(12; "Purchase Price"; Decimal)
        {
            Caption = 'Purchase Price';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                UpdateProfitValue();
            end;
        }

        field(13; Profit; Decimal)
        {
            Caption = 'Profit';
            Editable = fALSE;
            DataClassification = ToBeClassified;
        }
        field(14; Flag; Boolean)
        {
            Caption = 'Flag';
            DataClassification = ToBeClassified;
        }

        field(15; "MOT Service Date"; date)
        {
            Caption = 'MOT Service Date';
        }

        field(16; "Next Service Date"; date)
        {
            caption = 'Next Service Date';
        }

        field(17; Sold; Boolean)
        {
            Caption = 'Sold';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(18; "Date"; Date)
        {
            Caption = 'Date';
            fieldclass = flowfield;
            CalcFormula = lookup(HistoryTNP."Service Date" WHERE(VIN = FIELD(VIN), "Event Type" = CONST(Sale)));
            //DataClassification = ToBeClassified;

        }
    }
    keys
    {
        key(PK; VIN)
        {
            Clustered = true;
        }
        key(SK; "Engine Type", Color, Brand)
        {
            Clustered = false;
        }
        key(SK2; Value, Brand)
        {
            Clustered = false;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; VIN, "Registration No", Brand, Model)
        {

        }
    }

    trigger OnInsert()
    var
        NewCarHistory: Codeunit CodeSpaceTNP;
        MyiNT: Integer;
    begin
        NewCarHistory.NewEventHistory(VIN);

        // for MyInt := 1 Downto 10 do begin

        // end;
    end;



    procedure UpdateHeadline()
    var
        Brand: Record BrandTNP;
        Model: Record ModelTNP;
        Color: Record ColorTNP;
    //NewText: Label ' %1 %2 %3 %4';

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

    procedure UpdateProfitValue()
    begin
        if (rec."Sales Price" >= 0) and (rec."Purchase Price" >= 0) then
            rec.Profit := rec."Sales Price" - rec."Purchase Price";

    end;

    trigger OnModify()
    var
        AllocResource: Codeunit CodeSpaceTNP;
    begin
        UpdateHeadline();
        //UpdateProfitValue();
        //AllocateResource();
        //AllocResource.AllocateResources(Rec);
    end;



    // procedure CarStatus()
    // var
    // begin

    // end;

    procedure AllocateResource()
    var
        ResourceRec: Record Resource;
    begin
        ResourceRec.Reset();
        ResourceRec.SetCurrentKey("Company Car VINTNP");
        ResourceRec.SetRange("Company Car VINTNP", Rec.VIN);
        if (ResourceRec.FindFirst()) then
            Rec."Allocated to Resources" := ResourceRec.Name
        else
            Rec."Allocated to Resources" := 'Not Allocated';
    end;

    var
        CarStatus: Boolean;
}
