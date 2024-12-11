table 50103 ColorTNP
{
    Caption = 'Color';
    DataClassification = ToBeClassified;
    DrillDownPageId = "Color PageTNP";
    LookupPageId = "Color PageTNP";

    fields
    {
        field(1; Name; Code[20])
        {
            Caption = 'Name';
        }
        field(2; Description; Text[20])
        {
            Caption = 'Description';
        }
    }
    keys
    {
        key(PK; Name)
        {
            Clustered = true;
        }
    }
}
