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
                rec."Service Date" := SetDate(rec."Date Of Event", rec."Event Type");
            end;
        }
        field(5; "Event Type"; Enum "Event TypeTNP")
        {
            Caption = 'Event Type';
            trigger OnValidate()
            begin
                rec."Service Date" := SetDate(rec."Date Of Event", rec."Event Type");
            end;
        }

        field(6; "Service Date"; Date)
        {
            DataClassification = ToBeClassified;
            editable = false;
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
}

