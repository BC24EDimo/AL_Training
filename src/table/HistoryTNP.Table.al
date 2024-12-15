table 50104 HistoryTNP
{
    Caption = 'History';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No"; Integer)
        {
            Caption = 'Entry No';
            AutoIncrement = true;
        }
        field(2; VIN; Code[20])
        {
            Caption = 'VIN';
        }
        field(3; Notes; Text[250])
        {
            Caption = 'Notes';
        }

        field(4; "Date Of Event"; Date)
        {
            Caption = 'DateOf Event';

            trigger OnValidate()
            begin
                //rec."Date Of Event" := Today;
                rec."Service Date" := SetDate(rec."Date Of Event", rec."Event Type");
            end;
        }
        field(5; "Event Type"; Enum "Event TypeTNP")
        {
            Caption = 'Event Type';
            trigger OnValidate()
            begin
                rec."Date Of Event" := Today;
                rec."Service Date" := SetDate(rec."Date Of Event", rec."Event Type");
            end;
        }

        field(6; "Service Date"; Date)
        {
            DataClassification = ToBeClassified;
            editable = false;
        }

        field(7; Price; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Entry No")
        {
            Clustered = true;
        }
        key(SK; "Date Of Event")
        {
            Clustered = false;
        }
    }

    procedure SetDate(ServiceDate: Date; EventType: enum "Event TypeTNP"): Date
    begin
        case EventType of
            EventType::MOT:
                exit(CalcDate('+1Y', ServiceDate));
            EventType::Service:
                exit(CalcDate('+6M', ServiceDate));
            EventType::"Car Creation":
                exit(ServiceDate);
        end;
    end;


    trigger OnInsert()
    begin
        rec."Date Of Event" := today;
        rec.Price:=  GetPrice(rec."Event Type", rec.Notes);
    end;


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
            EventTypeTNP::Sale:
                exit(value);

        end;
    end;
}

