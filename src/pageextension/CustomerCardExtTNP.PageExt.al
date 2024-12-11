pageextension 50102 CustomerCardExtTNP extends "Customer Card"
{
    layout
    {
        addlast(content)
        {

            group("Additional InformationTNP")
            {
                Caption = 'Additional Information';

            }
        }
        movefirst("Additional InformationTNP"; "Balance (LCY)")


    }
}