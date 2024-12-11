table 50101 ModelTNP
{
    Caption = 'Model';
    DataClassification = ToBeClassified;
    LookupPageId = ModelTNP;
    DrillDownPageId = ModelTNP;

    fields
    {
        field(1; "Brand Code"; Code[20])
        {
            Caption = 'Brand Code';
            TableRelation = "BrandTNP".Code;
        }
        field(2; "Model Code"; Code[20])
        {
            Caption = 'Model Code';
        }
        field(3; Value; Decimal)
        {
            Caption = 'Value';
            FieldClass = FlowField;
            CalcFormula = sum(CarTNP.Value where(Model = field("Model Code"), Brand = field("Brand Code")));
        }


    }
    keys
    {

        key(PK; "Brand Code", "Model Code")
        {
            Clustered = true;
        }
        // key(SK; "Model Code")
        // {
        //     Clustered = false;
        // }

    }
}
