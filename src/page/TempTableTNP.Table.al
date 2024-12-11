table 50107 "Temp Table"
{
    Caption = 'Temp Table';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; Brand; Text[20])
        {
            Caption = 'Brand';
        }
        field(2; Model; Text[20])
        {
            Caption = 'Model';
        }
        field(3; VIN; Code[20])
        {
            Caption = 'VIN';
        }
        field(4; "Old Price"; Decimal)
        {
            Caption = 'Old Price';
        }
        field(5; "New Price"; Decimal)
        {
            Caption = 'New Price';
        }
    }
    keys
    {
        key(PK; VIN)
        {
            Clustered = true;
        }
    }
}
