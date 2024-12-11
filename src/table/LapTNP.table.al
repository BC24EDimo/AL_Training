table 50106 "LapTNP"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; LapID; Integer)
        {

        }
        field(2; "Lap No."; Integer)
        {
            Caption = 'Lap No.';
            AutoIncrement = true;
            //DataClassification = ToBeClassified;
        }
        field(3; "Time"; Text[50])
        {
            caption = 'Time';
            //DataClassification = ToBeClassified;
        }

        field(4; "Best Time"; Boolean)
        {
            Caption = 'Best Time';
        }

    }

    keys
    {
        key(PK; "Lap No.")
        {
            Clustered = true;
        }
    }

}