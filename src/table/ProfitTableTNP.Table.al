table 50108 "Profit TableTNP"
{
    Caption = 'Profit Table';
    
    DataClassification = ToBeClassified;

    fields
    {

        field(5; "Entry no"; Integer)
        {
            Caption = 'No';
            AutoIncrement = true;
        }
        field(4; VIN; Code[20])
        {
            Caption = 'VIN';
            TableRelation = HistoryTNP.VIN;
        }
        field(1; "Date of Entry"; Date)
        {
            Caption = 'Date of Entry';
            // FieldClass = FlowField;
            // CalcFormula = lookup(HistoryTNP."Date Of Event" WHERE(VIN = field(VIN),"Event Type" = field("Event")));
        }
        field(2; "Event"; Text[20])
        {
            Caption = 'Event';
        }
        field(3; Price; Decimal)
        {
            Caption = 'Price';
        }

    }
    keys
    {
        key(PK; "Entry no")
        {
            Clustered = true;
        }
    }
}
