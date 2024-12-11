tableextension 50101 "Company CarTNP" extends Resource
{
    fields
    {
        field(50100; "Company Car VINTNP"; Code[20])
        {
            Caption = 'Company Car Vin. No.';
            DataClassification = ToBeClassified;
            TableRelation = carTNP.VIN;

            trigger OnValidate()
            var
                CarRec: Record CarTNP;

            begin
                CarRec.Reset();
                CarRec.SetRange(VIN, Rec."Company Car VINTNP");
                If CarRec.FindFirst() then
                    if CarRec."Allocated to Resources".Contains(Rec.Name) then
                        exit
                    else
                        CarRec.Validate("Allocated to Resources", Rec.Name);
                //if CarRec."Allocated to Resources" = xRec.Name then 

                CarRec.Modify(true);


            end;

        }
        field(50101; "Company Car Reg. No.TNP"; Code[20])
        {
            Caption = 'Company car Reg.No.';
            fieldclass = Flowfield;
            calcFormula = lookup(carTNP."Registration No" where(VIN = field("Company Car VINTNP")));
        }
        field(50102; "Company Car BrandTNP"; Code[20])
        {
            Caption = 'Company car Brand';
            fieldclass = Flowfield;
            calcFormula = lookup(carTNP.Brand where(VIN = field("Company Car VINTNP")));
        }
        field(50103; "Company Car ModelTNP"; Code[20])
        {
            Caption = 'Company car Model';
            fieldclass = Flowfield;
            calcFormula = lookup(carTNP.Model where(VIN = field("Company Car VINTNP")));
        }
    }

    // procedure AllocateCompanyCar( pCompCar: Record CarTNP)
    // begin 

    // end;
}
