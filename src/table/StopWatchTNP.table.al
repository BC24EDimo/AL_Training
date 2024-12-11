table 50105 StopWatchTNP
{
    Caption = 'Stop Watch';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; EntryID; Integer)
        {

        }
        field(2; "Start Time"; datetime)
        {
            Caption = 'Start Time';
            //DataClassification = ToBeClassified;
        }

        field(3; "End Time"; DateTime)
        {
            Caption = 'End Time';

        }

        field(4; "Elapsed Time"; Text[50])
        {
            Caption = 'Elapsed Time';
        }
    }

    keys
    {
        key(PK; EntryID)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }




}