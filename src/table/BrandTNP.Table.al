table 50100 BrandTNP
{
    Caption = 'Brand';
    DataClassification = ToBeClassified;
    LookupPageId = "Brand ListTNP";
    DrillDownPageId = "Brand ListTNP";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(3; Value; Decimal)
        {
            Caption = 'Value';
            FieldClass = FlowField;
            CalcFormula = sum(CarTNP.Value where(Brand = field(Code), "Engine Type" = field("Engine Type Filter")));
        }

        field(4; "Engine Type Filter"; enum "Engine TypeTNP")
        {
            FieldClass = FlowFilter;
            //CalcFormula = lookup(CarTNP."Engine Type" where ("Engine Type" = field("Engine Type Filter")));
            //DataClassification = ToBeClassified;
        }
        field(5; "Car Color"; Text[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "ColorTNP";
            //DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
}
