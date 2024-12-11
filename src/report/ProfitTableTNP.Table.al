table 50108 "Profit Table"
{
    Caption = 'Profit Table';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Date of Entry"; Date)
        {
            Caption = 'Date of Entry';
        }
        field(2; "Event"; Text[20])
        {
            Caption = 'Event';
        }
        field(3; Price; Decimal)
        {
            Caption = 'Price';
        }
        field(4; VIN; Code[20])
        {
            Caption = 'VIN';
        }
    }
    keys
    {
        key(PK; "Date of Entry")
        {
            Clustered = true;
        }
    }
}
